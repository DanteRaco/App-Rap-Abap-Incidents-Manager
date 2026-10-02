@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'CDS - Incidents Priority'
@Metadata.ignorePropagatedAnnotations: true
define view entity zi_inct_priority as select from zdt_prior_darc
{
    key priority_code as PriorityCode,
    priority_description as PriorityDescription
}
