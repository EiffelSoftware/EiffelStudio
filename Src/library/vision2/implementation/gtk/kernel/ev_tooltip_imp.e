indexing
	description:
		" EiffelVision Tooltip, implementation."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_TOOLTIP_IMP

inherit
	EV_TOOLTIP_I

	EV_GTK_EXTERNALS

	EV_ANY_I

Creation
	make

feature -- Initialization

	make is
			-- Create the tooltip.
		do
			widget := gtk_tooltips_new
			gtk_object_ref (widget)
		end

feature -- Access

	delay: INTEGER is
			-- Delay im milliseconds the user has to hold the pointer over
			-- the widget before the tooltip pop up.
		do
			Result := c_gtk_tooltips_delay (widget)
		end

feature -- Status report

	background_color: EV_COLOR is
			-- Color used for the background of the widget
		local
			r, g, b: INTEGER
		do
			c_gtk_tooltips_get_bg_color (widget, $r, $g, $b)
			!!Result.make_rgb (r, g, b)
		end

	foreground_color: EV_COLOR is
			-- Color used for the foreground of the widget
			-- usually the text.
		local
			r, g, b: INTEGER
		do
			c_gtk_tooltips_get_fg_color (widget, $r, $g, $b)
			!!Result.make_rgb (r, g, b)
		end

	destroyed: BOOLEAN is
			-- Is Current object destroyed?
		do
		end

feature -- Status setting

	destroy is
			-- Destroy actual object.
		do
		end

	activate is
			-- Enable the tooltip control.
		do
			gtk_tooltips_enable (widget)
		end

	deactivate is
			-- Disable the tooltip control.
		do
			gtk_tooltips_disable (widget)
		end

	set_background_color (color: EV_COLOR) is
			-- Make `color' the new `background_color'
		do
			c_gtk_tooltips_set_bg_color (widget, color.red, color.green, color.blue)
		end

	set_foreground_color (color: EV_COLOR) is
			-- Make `color' the new `foreground_color'
		do
			c_gtk_tooltips_set_fg_color (widget, color.red, color.green, color.blue)
		end

feature -- Element change

	set_delay (value: INTEGER) is
			-- Make `value' the new delay.
		do
			gtk_tooltips_set_delay (widget, value)
		end

	add_tip (wid: EV_WIDGET; txt: STRING) is
			-- Make `txt' the tip that is displayed when the
			-- user stays on `wid'.
		local
			a: ANY
			wid_imp: EV_WIDGET_IMP
		do
			a := txt.to_c
			wid_imp ?= wid.implementation

			-- The last parameter is a text that may be helpful if
			-- the user gets stop. For now, as Windows does not
			-- have this options, we set it to `NULL'.
			gtk_tooltips_set_tip (widget, wid_imp.widget, $a, default_pointer)
		end

feature -- Implementation

	widget: POINTER
			-- Pointer to the GtkTooltips object.

end -- class EV_TOOLTIP_IMP

--|----------------------------------------------------------------
--| EiffelVision: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-1998 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 2nd floor
--| 270 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|---------------------------------------------------------------
