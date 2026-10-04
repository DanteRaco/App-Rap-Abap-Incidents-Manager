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

    DELETE FROM zdt_prior_darc.

    DATA lt_status TYPE STANDARD TABLE OF zdt_prior_darc.

    lt_status = VALUE #(
  ( priority_code = 'H' priority_description = 'High' )
  ( priority_code = 'M' priority_description = 'Medium' )
  ( priority_code = 'L' priority_description = 'Low' )
).

    INSERT zdt_prior_darc FROM TABLE @lt_status.

    IF sy-subrc = 0.

      out->write( '3 Priority codes inserted' ).

    ELSE.


      out->write( 'No codes inserted' ).

    ENDIF.


  ENDMETHOD.

ENDCLASS.
