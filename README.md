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

## Planned Examples

### ABAP OO
- Interfaces and polymorphism
- Dependency injection
- Factory pattern
- Singleton pattern
- Exception handling

### Data & Performance
- Standard vs sorted vs hashed internal tables
- Binary search
- Efficient table expressions
- Modern Open SQL
- Code pushdown concepts

### CDS & RAP
- CDS associations and cardinality
- CDS annotations
- CDS table functions and AMDP concepts
- RAP business objects
- OData exposure

### Testing
- ABAP Unit
- Testable class design
- Test doubles and dependency isolation

## First Scenario — Purchase Order Approval Engine

The first example will model a generic purchase-order approval service. It will be used to demonstrate interfaces, implementation classes, dependency injection, exception handling, and ABAP Unit.

```text
Purchase Order
      |
      v
Approval Service
      |
      +--> Approval Rules
      |
      v
Approval Decision
```

## About

This is a personal learning and portfolio project. It does not contain proprietary source code, customer data, internal SAP system details, or code copied from previous employers or clients.

---

Maintained by [Nemanja Tucovic](https://github.com/nemanjatucovic)
