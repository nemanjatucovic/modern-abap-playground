# Purchase Order Approval Engine

A small ABAP OO example demonstrating configuration-driven business rules, dependency injection, polymorphism, exception handling, separation of concerns, and ABAP Unit.

## Business Rule

A purchase order requires additional approval when its amount is greater than the configured threshold for its company code and currency.

Example:

```text
Company code: 1000
Currency: EUR
PO amount: 12,500
Configured threshold: 10,000
Result: Approval required
```

If no configuration exists for the company-code/currency combination, the provider raises `ZCX_PO_APPROVAL_CONFIG`. The example deliberately fails safely instead of silently applying an unintended default.

## Design

```text
ZCL_PO_APPROVAL_SERVICE
          |
          v
ZIF_PO_APPROVAL_RULE
          ^
          |
ZCL_PO_AMOUNT_RULE
          |
          v
ZIF_PO_CONFIG_PROVIDER
          ^
          |
ZCL_PO_DB_CONFIG
          |
          v
ZPO_APPR_CONFIG
```

`ZCL_PO_APPROVAL_SERVICE` orchestrates the decision and depends only on the approval-rule interface.

`ZCL_PO_AMOUNT_RULE` implements the amount-based rule. It receives its configuration provider through constructor injection and therefore does not depend directly on database access.

`ZCL_PO_DB_CONFIG` is the production-style provider responsible for reading the threshold from the example configuration table.

`ZCX_PO_APPROVAL_CONFIG` represents missing or invalid approval configuration.

## Example Configuration

The illustrative custom table `ZPO_APPR_CONFIG` is assumed to contain at least:

| BUKRS | WAERS | THRESHOLD |
|---|---|---:|
| 1000 | EUR | 10000 |
| 2000 | EUR | 25000 |
| 3000 | GBP | 15000 |

The table is intentionally illustrative and is not copied from a customer system.

## Testing

The ABAP Unit example replaces database access with `LCL_FAKE_CONFIG_PROVIDER`. This allows the amount rule to be tested in isolation and demonstrates the practical benefit of dependency injection.

Covered cases:

- PO amount above threshold -> approval required
- PO amount equal to threshold -> no additional approval

Additional cases can later cover values below the threshold and missing configuration.

## Notes

These source files are portfolio examples. They are designed to communicate architecture and ABAP syntax; importing them into an SAP system also requires creation of the illustrative DDIC table and any message-class/T100 configuration chosen for productive exception texts.
