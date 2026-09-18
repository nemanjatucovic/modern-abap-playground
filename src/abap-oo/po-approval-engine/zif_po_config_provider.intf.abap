INTERFACE zif_po_config_provider
  PUBLIC.

  METHODS get_threshold
    IMPORTING
      iv_company_code TYPE bukrs
      iv_currency     TYPE waers
    RETURNING
      VALUE(rv_threshold) TYPE decfloat34
    RAISING
      zcx_po_approval_config.

ENDINTERFACE.
