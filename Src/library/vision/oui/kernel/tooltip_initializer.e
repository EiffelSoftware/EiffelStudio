indexing

	description: 
		"Initializes focusable elements. Actually the main %
		%reason for this class is to store the attribute of type %
		%WEL_TOOLTIP so it will be collected automatically when %
		%the window is destroyed.%
		%Also it defines and initializes FOCUS_LABEL ";
	status: "See notice at end of class";		
	date: "$Date$";
	revision: "$Revision$"

class TOOLTIP_INITIALIZER

creation 
	tooltip_initialize

feature {NONE} -- Initialization

	tooltip_initialize (widget: COMPOSITE) is
			-- initialize tooltip
			-- argument should be current widget (one inheriting from TOOLTIP_INITIALIZER)
		require
			widget_not_void: widget /= void
		do
			tooltip_parent := widget
			!FOCUS_LABEL! label.initialize (widget)
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

	label: FOCUS_LABEL_I
			-- Label used to show the explanation

end -- class TOOLTIP_INITIALIZER


--|----------------------------------------------------------------
--| EiffelVision: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-2001 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building
--| 360 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support: http://support.eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

