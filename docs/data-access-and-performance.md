# Approval Engine — Data Access and Performance

This extension uses the Purchase Order Approval Engine to demonstrate internal-table selection, modern Open SQL, code pushdown, and CDS modelling.

## Internal tables

A hashed table is ideal for repeated exact lookups using a complete unique key. It is not the best fit when one company code can have several approval thresholds and the application needs a range/partial-key lookup.

For approval rules we therefore use a sorted table with the unique key `(BUKRS, THRESHOLD)`. Entries for a company code remain ordered by threshold, allowing the engine to keep the highest qualifying rule and exit when the next threshold exceeds the PO value.

Example: thresholds 10,000 / 50,000 / 100,000 and PO value 72,000 result in level 2.

## Modern Open SQL and code pushdown

For a single PO, ask the database for the best rule instead of loading all rules into ABAP:

- filter by company code
- filter `THRESHOLD <= PO_VALUE`
- order threshold descending
- retrieve one row

This is a simple example of code pushdown: filtering and candidate selection happen in the database.

## Mass processing

A SELECT inside a LOOP is intentionally avoided. With 50,000 purchase orders it could produce 50,000 database round trips.

Possible strategies depend on the data shape:

1. Load a small configuration table once and use it as an in-memory cache.
2. Use `FOR ALL ENTRIES` to load only configuration for relevant company codes. The driving table must be checked for `IS NOT INITIAL`.
3. Use a JOIN/CDS model when the relationship and filtering can be efficiently pushed down to the database.

## CDS model

The repository contains basic interface view entities for purchase-order headers, items, and approval configuration.

A simple join from PO to configuration on company code is intentionally not presented as the final approval decision: a company code can have multiple thresholds, so such a join produces multiple candidate rows per PO.

Selecting exactly the highest threshold that does not exceed the calculated PO value requires an additional modelling step (aggregation/ranking, or a table-function/AMDP approach when appropriate). This limitation is documented deliberately because choosing the correct modelling technique is part of the exercise.

## Interview takeaways

- HASHED is not automatically the fastest/best choice; access pattern determines the table type.
- SORTED tables support ordered and partial-key/range-oriented access patterns.
- Avoid unnecessary DB-to-application data transfer.
- Avoid SELECT inside LOOP for mass processing.
- Prefer database-side filtering when only a small result is needed.
- `FOR ALL ENTRIES` requires careful handling of an empty driving table.
- A CDS JOIN can multiply rows; cardinality and business semantics must be understood before exposing the result.
