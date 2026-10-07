CLASS lhc_incident DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS get_instance_features FOR INSTANCE FEATURES
      keys REQUEST requested_features FOR incident RESULT result.

    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      keys REQUEST requested_authorizations FOR incident RESULT result.

    METHODS get_global_authorizations FOR GLOBAL AUTHORIZATION
      REQUEST requested_authorizations FOR incident RESULT result.

    METHODS changeStatus FOR MODIFY
       keys FOR ACTION incident~changeStatus RESULT result.

    METHODS setInitialValues FOR DETERMINE ON MODIFY
       keys FOR incident~setInitialValues.

    METHODS initialHistory FOR DETERMINE ON SAVE
       keys FOR incident~initialHistory.

    METHODS validateDateRange FOR VALIDATE ON SAVE
       keys FOR incident~validateDateRange.

    METHODS validateRequiredFields FOR VALIDATE ON SAVE
       keys FOR incident~validateRequiredFields.

ENDCLASS.

CLASS lhc_incident IMPLEMENTATION.

  METHOD get_instance_features.


    READ ENTITIES OF z_r_inct_darc IN LOCAL MODE
      ENTITY incident
        FIELDS ( Status )
        WITH CORRESPONDING #( keys )
      RESULT DATA(lt_incidents)
      FAILED failed.

    result = VALUE #( FOR ls_incident IN lt_incidents

      ( %tky = ls_incident-%tky

        %action-changeStatus = COND #(
          WHEN ls_incident-Status = 'CLOSED'
            THEN if_abap_behv=>fc-o-disabled
          ELSE if_abap_behv=>fc-o-enabled  )
        %assoc-_IHistory = COND #(
          WHEN ls_incident-Status = 'CLOSED'
            THEN if_abap_behv=>fc-o-disabled
          ELSE if_abap_behv=>fc-o-enabled ) ) ).


  ENDMETHOD.

  METHOD get_instance_authorizations.

  ENDMETHOD.

  METHOD get_global_authorizations.

  ENDMETHOD.

  METHOD changeStatus.

    DATA: lt_history_create TYPE TABLE FOR CREATE z_r_inct_darc\_IHistory.

    READ ENTITIES OF z_r_inct_darc IN LOCAL MODE
      ENTITY incident
        FIELDS ( Status IncidentId )
        WITH CORRESPONDING #( keys )
      RESULT DATA(lt_incidents).

    LOOP AT keys ASSIGNING FIELD-SYMBOL(<key>).
      ASSIGN lt_incidents[ %tky = <key>-%tky ] TO FIELD-SYMBOL(<inc>).
      IF sy-subrc <> 0 OR <key>-%param-new_status IS INITIAL. CONTINUE. ENDIF.


      READ ENTITIES OF z_r_inct_darc IN LOCAL MODE
        ENTITY incident BY \_IHistory
        FIELDS ( HisId )
        WITH VALUE #( ( %tky = <key>-%tky ) )
        RESULT DATA(lt_existing_history).

      DATA(lv_next_his_num) = lines( lt_existing_history ) + 1.


      MODIFY ENTITIES OF z_r_inct_darc IN LOCAL MODE
        ENTITY incident
          UPDATE FIELDS ( Status ChangedDate )
          WITH VALUE #( ( %tky        = <key>-%tky
                          Status      = <key>-%param-new_status
                          ChangedDate = cl_abap_context_info=>get_system_date( ) ) ).

      lt_history_create = VALUE #( (
        %tky = <key>-%tky
        %target = VALUE #( (
          %cid           = 'CID_HIST_' && <key>-%tky-IncUuid
          HisId          = lv_next_his_num
          PreviousStatus = <inc>-Status
          NewStatus      = <key>-%param-new_status
          Text           = <key>-%param-observation
          %control       = VALUE #(
            HisId          = if_abap_behv=>mk-on
            PreviousStatus = if_abap_behv=>mk-on
            NewStatus      = if_abap_behv=>mk-on
            Text           = if_abap_behv=>mk-on
          )
        ) )
      ) ).

      MODIFY ENTITIES OF z_r_inct_darc IN LOCAL MODE
        ENTITY incident
          CREATE BY \_IHistory
          FROM lt_history_create.

      APPEND VALUE #( %tky = <key>-%tky %param = CORRESPONDING #( <inc> ) ) TO result.
    ENDLOOP.

  ENDMETHOD.

  METHOD setInitialValues.

    READ ENTITIES OF z_r_inct_darc IN LOCAL MODE
      ENTITY incident
        FIELDS ( IncidentId Status CreationDate )
        WITH CORRESPONDING #( keys )
      RESULT DATA(lt_incidents).

    SELECT MAX( incident_id ) FROM zdt_inct_darc01 INTO @DATA(lv_max_id).

    LOOP AT lt_incidents ASSIGNING FIELD-SYMBOL(<inc>).
      IF <inc>-IncidentId IS INITIAL.
        lv_max_id += 1.

        MODIFY ENTITIES OF z_r_inct_darc IN LOCAL MODE
          ENTITY incident
            UPDATE FIELDS ( IncidentId Status CreationDate )
            WITH VALUE #( (
              %tky         = <inc>-%tky
              IncidentId   = lv_max_id
              Status       = 'OP'
              CreationDate = cl_abap_context_info=>get_system_date( )
            ) ).
      ENDIF.
    ENDLOOP.



  ENDMETHOD.

  METHOD initialHistory.

    READ ENTITIES OF z_r_inct_darc IN LOCAL MODE
        ENTITY incident
          FIELDS ( Status )
          WITH CORRESPONDING #( keys )
        RESULT DATA(lt_incidents).

    DATA: lt_history_create TYPE TABLE FOR CREATE z_r_inct_darc\_IHistory.

    LOOP AT lt_incidents ASSIGNING FIELD-SYMBOL(<inc>).

      lt_history_create = VALUE #( (
        %tky = <inc>-%tky
        %target = VALUE #( (
          %cid           = 'CID_INIT_' && <inc>-IncUuid
          NewStatus      = 'OP'
          Text           = 'First Incident'
          %control       = VALUE #(
            HisId     = if_abap_behv=>mk-on
            NewStatus = if_abap_behv=>mk-on
            Text      = if_abap_behv=>mk-on
          )
        ) )
      ) ).

      MODIFY ENTITIES OF z_r_inct_darc IN LOCAL MODE
        ENTITY incident
          CREATE BY \_IHistory
          FROM lt_history_create.
    ENDLOOP.

  ENDMETHOD.

  METHOD validateDateRange.

    READ ENTITIES OF z_r_inct_darc IN LOCAL MODE
        ENTITY incident
          FIELDS ( CreationDate ChangedDate )
          WITH CORRESPONDING #( keys )
        RESULT DATA(lt_incidents).

    DATA(lv_today) = cl_abap_context_info=>get_system_date( ).

    LOOP AT lt_incidents ASSIGNING FIELD-SYMBOL(<inc>).

      IF <inc>-CreationDate > lv_today.
        APPEND VALUE #( %tky = <inc>-%tky ) TO failed-incident.
        APPEND VALUE #(
          %tky = <inc>-%tky
          %msg = new_message_with_text(
                   severity = if_abap_behv_message=>severity-error
                   text     = 'Can not use a Future Date'
                 )
        ) TO reported-incident.
      ENDIF.

      IF <inc>-ChangedDate IS NOT INITIAL AND <inc>-ChangedDate < <inc>-CreationDate.
        APPEND VALUE #( %tky = <inc>-%tky ) TO failed-incident.
        APPEND VALUE #(
          %tky = <inc>-%tky
          %msg = new_message_with_text(
                   severity = if_abap_behv_message=>severity-error
                   text     = 'The modified Date can not be earlier than Creation Date'
                 )
        ) TO reported-incident.
      ENDIF.
    ENDLOOP.

  ENDMETHOD.

  METHOD validateRequiredFields.

    READ ENTITIES OF z_r_inct_darc IN LOCAL MODE
      ENTITY incident
        FIELDS ( Title Description Priority Status CreationDate )
        WITH CORRESPONDING #( keys )
      RESULT DATA(lt_incidents).

    LOOP AT lt_incidents ASSIGNING FIELD-SYMBOL(<inc>).
      IF <inc>-Title IS INITIAL OR <inc>-Description IS INITIAL OR <inc>-Priority IS INITIAL.
        APPEND VALUE #( %tky = <inc>-%tky ) TO failed-incident.
        APPEND VALUE #(
          %tky = <inc>-%tky
          %msg = new_message_with_text(
                   severity = if_abap_behv_message=>severity-error
                   text     = 'Complete Mandatory Fields'
                 )
        ) TO reported-incident.
      ENDIF.
    ENDLOOP.

  ENDMETHOD.

ENDCLASS.




