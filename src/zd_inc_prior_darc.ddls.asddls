@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Status ValueHelp'
@Search.searchable: true

define view entity zd_inc_prior_darc
  as select from zi_inct_priority
{
      @Search.defaultSearchElement: true
      @ObjectModel.text.element: [ 'PriorityDescription' ]
      @UI.textArrangement: #TEXT_SEPARATE
      @UI.lineItem: [{ position: 10, label: 'Priority Code', importance: #HIGH }]
  key PriorityCode,

      @Search.defaultSearchElement: true
      @Search.fuzzinessThreshold: 0.8
      @Semantics.text: true
      @UI.lineItem: [{ position: 20, label: 'Description', importance: #HIGH }]
      PriorityDescription
}
