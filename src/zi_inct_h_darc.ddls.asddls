@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'CDS - History Incidents'
@Metadata.ignorePropagatedAnnotations: true
define view entity zi_inct_h_darc
  as select from zdt_inct_h_darc

  association to parent z_r_inct_darc as _Incident on $projection.IncUuid = _Incident.IncUuid

{
  key his_uuid              as HisUuid,
  key inc_uuid              as IncUuid,
      his_id                as HisId,
      previous_status       as PreviousStatus,
      new_status            as NewStatus,
      text                  as Text,
      @Semantics.user.createdBy: true
      local_created_by      as LocalCreatedBy,
      @Semantics.systemDateTime.createdAt: true
      local_created_at      as LocalCreatedAt,
      @Semantics.user.lastChangedBy: true
      local_last_changed_by as LocalLastChangedBy,
      //Etag

      @Semantics.systemDateTime.localInstanceLastChangedAt: true
      local_last_changed_at as LocalLastChangedAt,
      @Semantics.systemDateTime.lastChangedAt: true
      last_changed_at       as LastChangedAt,
      // Associations

      _Incident

}
