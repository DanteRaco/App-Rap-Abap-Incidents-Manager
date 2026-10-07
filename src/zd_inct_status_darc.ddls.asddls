@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Status ValueHelp'
@Search.searchable: true

define view entity zd_inct_status_darc
  as select from zi_inct_status
{
      @Search.defaultSearchElement: true
      @ObjectModel.text.element: [ 'StatusDescription' ]
      @UI.textArrangement: #TEXT_SEPARATE
      @UI.lineItem: [{ position: 10, label: 'Status Code', importance: #HIGH }]
  key StatusCode,

      @Search.defaultSearchElement: true
      @Search.fuzzinessThreshold: 0.8
      @Semantics.text: true
      @UI.lineItem: [{ position: 20, label: 'Description', importance: #HIGH }]
      StatusDescription
}
