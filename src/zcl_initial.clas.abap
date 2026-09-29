CLASS zcl_initial DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_initial IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

    DELETE FROM zdt_status_darc.

    DATA lt_status TYPE STANDARD TABLE OF zdt_status_darc.

    lt_status = VALUE #(
  ( status_code = 'OP' status_description = 'Open' )
  ( status_code = 'IP' status_description = 'In Progress' )
  ( status_code = 'PE' status_description = 'Pending' )
  ( status_code = 'CO' status_description = 'Completed' )
  ( status_code = 'CL' status_description = 'Closed' )
  ( status_code = 'CN' status_description = 'Canceled' )
).

    INSERT zdt_status_darc FROM TABLE @lt_status.

    IF sy-subrc = 0.

      out->write( '6 status codes inserted' ).

    ELSE.

      out->write( 'No codes inserted' ).

    ENDIF.


  ENDMETHOD.

ENDCLASS.
