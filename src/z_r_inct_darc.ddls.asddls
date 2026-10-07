@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Root Entity Incidents'
@Metadata.ignorePropagatedAnnotations: true
define root view entity z_r_inct_darc
  as select from zdt_inct_darc01

  composition [0..*] of zi_inct_h_darc   as _IHistory

  association [0..1] to zi_inct_priority as _Priority on $projection.Priority = _Priority.PriorityCode
  association [0..1] to zi_inct_status   as _Status   on $projection.Status = _Status.StatusCode

{
  key inc_uuid              as IncUuid,
      incident_id           as IncidentId,
      title                 as Title,
      description           as Description,
      status                as Status,
      priority              as Priority,
      creation_date         as CreationDate,
      changed_date          as ChangedDate,

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
      _IHistory,
      _Priority,
      _Status
}
