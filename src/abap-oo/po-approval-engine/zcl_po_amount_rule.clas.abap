CLASS zcl_po_amount_rule DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC.

  PUBLIC SECTION.
    INTERFACES zif_po_approval_rule.

    METHODS constructor
      IMPORTING
        io_config_provider TYPE REF TO zif_po_config_provider.

  PRIVATE SECTION.
    DATA mo_config_provider TYPE REF TO zif_po_config_provider.
ENDCLASS.

CLASS zcl_po_amount_rule IMPLEMENTATION.
  METHOD constructor.
    mo_config_provider = io_config_provider.
  ENDMETHOD.

  METHOD zif_po_approval_rule~is_approval_required.
    DATA(lv_threshold) = mo_config_provider->get_threshold(
      iv_company_code = is_purchase_order-company_code
      iv_currency     = is_purchase_order-currency ).

    rv_required = xsdbool( is_purchase_order-amount > lv_threshold ).
  ENDMETHOD.
ENDCLASS.
