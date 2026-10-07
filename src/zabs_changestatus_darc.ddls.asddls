@EndUserText.label: 'abstract entity change status'
define abstract entity zabs_changestatus_darc

{
  @Consumption.valueHelpDefinition: [{ entity : { name: 'zi_inct_status',
                                                  element: 'StatusCode'} }]


  @EndUserText.label: 'New Status'
  new_status  : zde_char_status;
  observation : zde_char_observation;

}
