indexing

	description: 
		"Initializes focusable elements. Actually the main %
		%reason for this class is to store the attribute of type %
		%WEL_TOOLTIP so it will be collected automatically when %
		%the window is destroyed.%
		%Also it defines and initializes FOCUS_LABEL "
	legal: "See notice at end of class.";
	status: "See notice at end of class.";		
	date: "$Date$";
	revision: "$Revision$"

class TOOLTIP_INITIALIZER

create 
	tooltip_initialize

feature {NONE} -- Initialization

	tooltip_initialize (widget: COMPOSITE) is
			-- initialize tooltip
			-- argument should be current widget (one inheriting from TOOLTIP_INITIALIZER)
		require
			widget_not_void: widget /= void
		do
			tooltip_parent := widget
			create {FOCUS_LABEL} label.initialize (widget)
		end	

feature -- Actual realization
	
	tooltip_realize is
			-- realize tooltip behavior
		require
			label_not_void: label /= void
		do
			label.initialize_focusables (Current)
		end

feature -- Status report

	tooltip: ANY
			-- Stored value of tooltip

feature -- Status setting

	set_tooltip (arg: ANY) is
		do
			tooltip := arg
		end;

feature -- Properties

	tooltip_parent: COMPOSITE 
			-- Parent of the tooltip window 

	label: FOCUS_LABEL_I;
			-- Label used to show the explanation

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class TOOLTIP_INITIALIZER

