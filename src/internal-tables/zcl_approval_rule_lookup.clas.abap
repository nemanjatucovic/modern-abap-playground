CLASS zcl_approval_rule_lookup DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC.

  PUBLIC SECTION.
    TYPES:
      BEGIN OF ty_config,
        bukrs          TYPE bukrs,
        threshold      TYPE wrbtr,
        approval_level TYPE i,
      END OF ty_config,
      tt_config TYPE SORTED TABLE OF ty_config
        WITH UNIQUE KEY bukrs threshold.

    CLASS-METHODS find_level
      IMPORTING
        iv_bukrs    TYPE bukrs
        iv_po_value TYPE wrbtr
        it_config   TYPE tt_config
      RETURNING VALUE(rv_level) TYPE i.
ENDCLASS.

CLASS zcl_approval_rule_lookup IMPLEMENTATION.
  METHOD find_level.
    " The sorted key groups rules by company code and threshold.
    " Keep the last qualifying level and stop once the threshold is too high.
    LOOP AT it_config INTO DATA(ls_config)
      WHERE bukrs = iv_bukrs.
      IF ls_config-threshold > iv_po_value.
        EXIT.
      ENDIF.
      rv_level = ls_config-approval_level.
    ENDLOOP.
  ENDMETHOD.
ENDCLASS.
