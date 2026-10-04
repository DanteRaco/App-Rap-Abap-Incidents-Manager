@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Status ValueHelp'
@Search.searchable: true

define view entity zd_inct_status_darc
  as select from zdt_status_darc
{
      @Search.defaultSearchElement: true
      @ObjectModel.text.element: [ 'status_description' ]
      @UI.textArrangement: #TEXT_SEPARATE
      @UI.lineItem: [{ position: 10, importance: #HIGH  }]
  key status_code,

      @Search.defaultSearchElement: true
      @Search.fuzzinessThreshold: 0.8
      @Semantics.text: true
      @UI.lineItem: [{ position: 20, importance: #HIGH }]
      status_description
}
