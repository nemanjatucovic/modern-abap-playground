# Modern ABAP Playground

A hands-on portfolio repository for modern SAP ABAP development, focused on clean design, maintainability, testability, and performance.

The repository is built as a collection of small, self-contained examples rather than client-specific production code. All examples use generic business scenarios and synthetic data.

## Goals

- Demonstrate modern ABAP and ABAP Objects practices
- Explore common design patterns and clean-code techniques
- Compare internal table and Open SQL approaches with a focus on performance
- Build practical CDS and RAP examples
- Practice ABAP Unit and testable design
- Document technical decisions in a way that is useful for interviews and code reviews

## Repository Structure

```text
src/
├── abap-oo/          Object-oriented ABAP and design patterns
├── internal-tables/  Sorted, hashed, and standard table examples
├── open-sql/         Modern Open SQL and performance examples
├── cds/              CDS views, associations, annotations, and modelling
├── rap/              RESTful Application Programming Model examples
└── unit-tests/       ABAP Unit and test doubles

docs/                 Supporting notes and technical explanations
```

## Purchase Order Approval Engine

The first scenario models a generic purchase-order approval service and demonstrates interfaces, dependency injection, Strategy-style approval rules, configuration access, exception handling, and ABAP Unit.

```text
Purchase Order
      |
      v
Approval Service
      |
      +--> Approval Rules
      |
      +--> Configuration Provider
      |
      v
Approval Decision
```

### Data access & performance extension

The Approval Engine is also used to demonstrate:

- `SORTED TABLE` with `(BUKRS, THRESHOLD)` for multiple ordered rules per company code
- when a `HASHED TABLE` is appropriate for complete unique-key lookups
- modern Open SQL with host variables and database-side filtering
- code pushdown by selecting only the highest qualifying threshold
- avoiding `SELECT` inside `LOOP`
- configuration caching for mass PO processing
- safe `FOR ALL ENTRIES` usage
- CDS interface view entities for PO header, PO item, and approval configuration
- the row-multiplication problem when a simple CDS join meets multiple thresholds

See [`docs/data-access-and-performance.md`](docs/data-access-and-performance.md) for the design reasoning and interview takeaways.

## Planned next steps

### CDS & HANA
- Complete the approval-decision CDS model
- Associations and cardinality
- Aggregation/ranking alternatives
- CDS table function + AMDP comparison

### RAP
- RAP business object
- Behavior definition and implementation
- OData exposure

### Testing
- Extend ABAP Unit coverage to data-access and threshold boundary cases
- Test doubles and dependency isolation

## About

This is a personal learning and portfolio project. It does not contain proprietary source code, customer data, internal SAP system details, or code copied from previous employers or clients.

---

Maintained by [Nemanja Tucovic](https://github.com/nemanjatucovic)
