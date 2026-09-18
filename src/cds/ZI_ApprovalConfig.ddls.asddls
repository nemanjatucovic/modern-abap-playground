@EndUserText.label: 'Approval Configuration'
@AccessControl.authorizationCheck: #NOT_REQUIRED
define view entity ZI_ApprovalConfig
  as select from zapproval_config
{
  key bukrs          as CompanyCode,
  key threshold      as Threshold,
      approval_level as ApprovalLevel
}
