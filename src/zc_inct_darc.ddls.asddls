@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Consumption Incidents'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true

define root view entity zc_inct_darc
  provider contract transactional_query
  as projection on z_r_inct_darc

{
  key IncUuid,
      IncidentId,
      Title,
      Description,
      Status,
      Priority,
      CreationDate,
      ChangedDate,

      //Etag
      @Semantics.systemDateTime.localInstanceLastChangedAt: true
      LocalLastChangedAt,
      @Semantics.systemDateTime.lastChangedAt: true
      LastChangedAt,

      /* Associations */
      _IHistory,
      _Priority,
      _Status
}
