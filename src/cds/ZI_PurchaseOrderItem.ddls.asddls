@EndUserText.label: 'Purchase Order Item'
@AccessControl.authorizationCheck: #NOT_REQUIRED
define view entity ZI_PurchaseOrderItem
  as select from ekpo
{
  key ebeln as PurchaseOrder,
  key ebelp as PurchaseOrderItem,
      matnr as Material,
      menge as Quantity,
      netpr as NetPrice,
      peinh as PriceUnit
}
