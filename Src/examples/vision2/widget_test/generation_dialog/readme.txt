The generation dialog is a standard Build generated window. At the time of writing this (02/12/03), Build does not explicitly support the generation of dialogs. Therefore after you have made any modifications, and re-generated the code, you will need to perform the following three steps:

1. Change inheritance in GENERATION_DIALOG to EV_DIALOG instead of EV_TITLED_WINDOW.

2. Change Precursor statmement in GENERATION_DIALOG to call Precursor {EV_DIALOG}.

3. Remove the line generated in `initialize' of GENERATION_DIALOG which destroys the application when the cross is clicked.