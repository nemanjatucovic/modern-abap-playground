CLASS zcl_po_approval_service DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC.

  PUBLIC SECTION.
    METHODS constructor
      IMPORTING
        io_rule TYPE REF TO zif_po_approval_rule.

    METHODS requires_approval
      IMPORTING
        is_purchase_order TYPE zif_po_approval_rule=>ty_purchase_order
      RETURNING
        VALUE(rv_required) TYPE abap_bool
      RAISING
        zcx_po_approval_config.

  PRIVATE SECTION.
    DATA mo_rule TYPE REF TO zif_po_approval_rule.
ENDCLASS.

CLASS zcl_po_approval_service IMPLEMENTATION.
  METHOD constructor.
    mo_rule = io_rule.
  ENDMETHOD.

  METHOD requires_approval.
    rv_required = mo_rule->is_approval_required( is_purchase_order ).
  ENDMETHOD.
ENDCLASS.
