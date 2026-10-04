@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Consumption History Incidents'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true


define view entity zc_hist_inct_darc
  as projection on zi_inct_h_darc

{
  key HisUuid,
  key IncUuid,
      HisId,
      PreviousStatus,
      NewStatus,
      Text,

      //Etag
      @Semantics.systemDateTime.localInstanceLastChangedAt: true
      LocalLastChangedAt,
      @Semantics.systemDateTime.lastChangedAt: true
      LastChangedAt,
      /* Associations */
      _Incident : redirected to parent zc_inct_darc

}
