New functionality in Eiffel Vision Library:
-------------------------------------------

New classes allow to show explanation for widgets (usually buttons) after mouse
cursor is possitioned above the widget for a certain period of time. It is
implemented using platform specific features in order to improve
performance and to allow creation of the standard interfaces for every
platform. 

NEW EXAMPLE:
------------
Together with these classes there is an example to demostrate their usage.


############################################################################

NEW CLASSES:
------------

in cluster: $ISE_EIFFEL/library/vision/oui/kernel

	class FOCUSABLE
	
	class TOOLTIP_INITIALIZER
	
in cluster: $ISE_EIFFEL/library/vision/implement/toolkit

	class FOCUS_LABEL_I
	
in cluster: $ISE_EIFFEL/library/vision/implement/mswin/commands

	class FOCUS_LABEL
	
in cluster: $ISE_EIFFEL/library/vision/implement/motif

	class FOCUS_LABEL

	class FOCUS_COMMAND 

	class DELAYED_FOCUS_COMMAND
	
############################################################################

NEW EXAMPLE :  $ISE_EIFFEL/examples/vision/explanation_label
-------------

Ace file: Ace.ace 

class DEMO
	-- Root class of the example

class WINDOWS
	-- Example windows and once routines

class MAIN_WINDOW
	-- Main window of the example

class MY_TOP
	-- Second window of the example

class FOCUSABLE_B
	-- Push button widget with focusable behavior




