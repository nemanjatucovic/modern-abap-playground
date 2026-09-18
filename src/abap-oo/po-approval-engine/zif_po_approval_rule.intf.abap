INTERFACE zif_po_approval_rule
  PUBLIC.

  TYPES:
    BEGIN OF ty_purchase_order,
      company_code TYPE bukrs,
      currency     TYPE waers,
      amount       TYPE decfloat34,
    END OF ty_purchase_order.

  METHODS is_approval_required
    IMPORTING
      is_purchase_order TYPE ty_purchase_order
    RETURNING
      VALUE(rv_required) TYPE abap_bool
    RAISING
      zcx_po_approval_config.

ENDINTERFACE.
