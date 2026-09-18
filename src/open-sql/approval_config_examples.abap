" Modern Open SQL examples for the Approval Engine.
" ZAPPROVAL_CONFIG is a generic example table with BUKRS, THRESHOLD and APPROVAL_LEVEL.

" 1) Code pushdown: retrieve only the best matching rule.
SELECT FROM zapproval_config
  FIELDS threshold,
         approval_level
  WHERE bukrs     = @lv_bukrs
    AND threshold <= @lv_po_value
  ORDER BY threshold DESCENDING
  INTO @DATA(ls_config)
  UP TO 1 ROWS.
ENDSELECT.

" 2) Cache a small configuration table once instead of SELECT inside LOOP.
SELECT FROM zapproval_config
  FIELDS bukrs,
         threshold,
         approval_level
  INTO TABLE @DATA(lt_config_cache).

" 3) FOR ALL ENTRIES when the driving PO set should restrict DB access.
" Always protect FAE against an empty driving table.
IF lt_purchase_orders IS NOT INITIAL.
  SELECT FROM zapproval_config
    FIELDS bukrs,
           threshold,
           approval_level
    FOR ALL ENTRIES IN @lt_purchase_orders
    WHERE bukrs = @lt_purchase_orders-bukrs
    INTO TABLE @DATA(lt_relevant_config).
ENDIF.

" Avoid this anti-pattern for mass processing:
" LOOP AT lt_purchase_orders ... SELECT ... ENDSELECT. ENDLOOP.
" It can turn 50,000 POs into 50,000 database round trips.
