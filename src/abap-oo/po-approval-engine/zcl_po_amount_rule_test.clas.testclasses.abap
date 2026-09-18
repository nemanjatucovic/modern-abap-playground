CLASS lcl_fake_config_provider DEFINITION FINAL.
  PUBLIC SECTION.
    INTERFACES zif_po_config_provider.
    METHODS constructor IMPORTING iv_threshold TYPE decfloat34.
  PRIVATE SECTION.
    DATA mv_threshold TYPE decfloat34.
ENDCLASS.

CLASS lcl_fake_config_provider IMPLEMENTATION.
  METHOD constructor.
    mv_threshold = iv_threshold.
  ENDMETHOD.

  METHOD zif_po_config_provider~get_threshold.
    rv_threshold = mv_threshold.
  ENDMETHOD.
ENDCLASS.

CLASS ltc_po_amount_rule DEFINITION
  FINAL
  FOR TESTING
  RISK LEVEL HARMLESS
  DURATION SHORT.

  PRIVATE SECTION.
    METHODS requires_approval_above_limit FOR TESTING.
    METHODS no_approval_at_limit         FOR TESTING.
ENDCLASS.

CLASS ltc_po_amount_rule IMPLEMENTATION.
  METHOD requires_approval_above_limit.
    DATA(lo_config) = NEW lcl_fake_config_provider( iv_threshold = '10000' ).
    DATA(lo_rule)   = NEW zcl_po_amount_rule( io_config_provider = lo_config ).

    DATA(ls_po) = VALUE zif_po_approval_rule=>ty_purchase_order(
      company_code = '1000'
      currency     = 'EUR'
      amount       = '12500' ).

    cl_abap_unit_assert=>assert_true(
      act = lo_rule->is_approval_required( ls_po ) ).
  ENDMETHOD.

  METHOD no_approval_at_limit.
    DATA(lo_config) = NEW lcl_fake_config_provider( iv_threshold = '10000' ).
    DATA(lo_rule)   = NEW zcl_po_amount_rule( io_config_provider = lo_config ).

    DATA(ls_po) = VALUE zif_po_approval_rule=>ty_purchase_order(
      company_code = '1000'
      currency     = 'EUR'
      amount       = '10000' ).

    cl_abap_unit_assert=>assert_false(
      act = lo_rule->is_approval_required( ls_po ) ).
  ENDMETHOD.
ENDCLASS.
