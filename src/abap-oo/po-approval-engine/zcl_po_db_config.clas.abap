CLASS zcl_po_db_config DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC.

  PUBLIC SECTION.
    INTERFACES zif_po_config_provider.
ENDCLASS.

CLASS zcl_po_db_config IMPLEMENTATION.
  METHOD zif_po_config_provider~get_threshold.
    SELECT SINGLE threshold
      FROM zpo_appr_config
      WHERE bukrs = @iv_company_code
        AND waers = @iv_currency
      INTO @rv_threshold.

    IF sy-subrc <> 0.
      RAISE EXCEPTION TYPE zcx_po_approval_config
        EXPORTING
          iv_company_code = iv_company_code
          iv_currency     = iv_currency.
    ENDIF.
  ENDMETHOD.
ENDCLASS.
