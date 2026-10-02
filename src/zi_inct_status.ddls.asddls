@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'CDS - Incidents Status'
@Metadata.ignorePropagatedAnnotations: true
define view entity zi_inct_status as select from zdt_status_darc
{
    key status_code as StatusCode,
    status_description as StatusDescription
}
