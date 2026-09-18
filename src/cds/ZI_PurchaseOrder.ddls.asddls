@EndUserText.label: 'Purchase Order Header'
@AccessControl.authorizationCheck: #NOT_REQUIRED
define view entity ZI_PurchaseOrder
  as select from ekko
{
  key ebeln as PurchaseOrder,
      bukrs as CompanyCode,
      waers as Currency
}
