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

    DATA lt_status TYPE TABLE OF zdt_status_darc.
    lt_status = VALUE #(
      ( status_code = 'OP' status_description = 'Open' )
      ( status_code = 'IP' status_description = 'In Process' )
      ( status_code = 'PE' status_description = 'Pending' )
      ( status_code = 'CO' status_description = 'Completed' )
      ( status_code = 'CL' status_description = 'Closed' )
    ).
    DELETE FROM zdt_status_darc.
    INSERT zdt_status_darc FROM TABLE @lt_status.


    DATA lt_prio TYPE TABLE OF zdt_prior_darc.
    lt_prio = VALUE #(
      ( priority_code = 'H' priority_description = 'High' )
      ( priority_code = 'M' priority_description = 'Medium' )
      ( priority_code = 'L' priority_description = 'Low' )
    ).
    DELETE FROM zdt_prior_darc.
    INSERT zdt_prior_darc FROM TABLE @lt_prio.

    out->write( 'Data Upload' ).


  ENDMETHOD.

ENDCLASS.
