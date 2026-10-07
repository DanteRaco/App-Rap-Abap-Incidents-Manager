@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Consumption Incidents'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
@Search.searchable: true

define root view entity zc_inct_darc
  provider contract transactional_query
  as projection on z_r_inct_darc

{
  key IncUuid,

      @Search.defaultSearchElement: true
      @Search.ranking: #MEDIUM
      @Search.fuzzinessThreshold: 0.8
      IncidentId,
      @Search.defaultSearchElement: true
      @Search.ranking: #MEDIUM
      @Search.fuzzinessThreshold: 0.8
      Title,
      @Search.defaultSearchElement: true
      @Search.ranking: #MEDIUM
      @Search.fuzzinessThreshold: 0.4
      Description,

      @Consumption.valueHelpDefinition: [{ entity: { name: 'zd_inct_status_darc',
                                               element: 'StatusCode'},
                                               useForValidation: true }]
                                             
      Status,
      @Consumption.valueHelpDefinition: [{ entity: { name: 'zd_inc_prior_darc',
                                               element: 'PriorityCode'},
                                               useForValidation: true }]
                                      
      Priority,
      CreationDate,
      ChangedDate,

      //Etag
      @Semantics.systemDateTime.localInstanceLastChangedAt: true
      LocalLastChangedAt,
      @Semantics.systemDateTime.lastChangedAt: true
      LastChangedAt,

      /* Associations */
      _IHistory : redirected to composition child zc_hist_inct_darc,
      _Priority,
      _Status
}
