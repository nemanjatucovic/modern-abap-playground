CLASS zcx_po_approval_config DEFINITION
  PUBLIC
  INHERITING FROM cx_static_check
  CREATE PUBLIC.

  PUBLIC SECTION.
    INTERFACES if_t100_message.

    DATA company_code TYPE bukrs READ-ONLY.
    DATA currency     TYPE waers READ-ONLY.

    METHODS constructor
      IMPORTING
        iv_company_code TYPE bukrs
        iv_currency     TYPE waers
        previous        TYPE REF TO cx_root OPTIONAL.
ENDCLASS.

CLASS zcx_po_approval_config IMPLEMENTATION.
  METHOD constructor.
    super->constructor( previous = previous ).
    company_code = iv_company_code.
    currency     = iv_currency.
  ENDMETHOD.
ENDCLASS.
