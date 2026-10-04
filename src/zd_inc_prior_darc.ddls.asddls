@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Status ValueHelp'
@Search.searchable: true

define view entity zd_inc_prior_darc
  as select from zdt_prior_darc
{
      @Search.defaultSearchElement: true
      @ObjectModel.text.element: [ 'priority_description' ]
      @UI.textArrangement: #TEXT_SEPARATE
      @UI.lineItem: [{ position: 10, importance: #HIGH  }]
  key priority_code,

      @Search.defaultSearchElement: true
      @Search.fuzzinessThreshold: 0.8
      @Semantics.text: true
      @UI.lineItem: [{ position: 20, importance: #HIGH }]
      priority_description
}
