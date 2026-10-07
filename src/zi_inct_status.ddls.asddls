@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'CDS - Incidents Status'
@Metadata.ignorePropagatedAnnotations: true
@Search.searchable: true
define view entity zi_inct_status
  as select from zdt_status_darc
{

      @Search.defaultSearchElement: true
      @ObjectModel.text.element: [ 'StatusDescription' ]
      @UI.textArrangement: #TEXT_SEPARATE
  key status_code        as StatusCode,

      @Search.defaultSearchElement: true
      @Search.fuzzinessThreshold: 0.8
      @Semantics.text: true
      status_description as StatusDescription
}
