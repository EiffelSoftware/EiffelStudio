indexing 
	description: "EiffelVision input device selection dialog."
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_INPUT_DEVICE_DIALOG_IMP

inherit
	EV_INPUT_DEVICE_DIALOG_I
		redefine
			interface
		end

	EV_STANDARD_DIALOG_IMP
		redefine
			interface
		end

	EV_C_UTIL

create
	make

feature {NONE} -- Initialization

	make (an_interface: like interface) is
			-- Create a directory selection dialog with `par' as
			-- parent.
		do
			base_make (an_interface)

			-- Create the gtk object.
			set_c_object (
				C.gtk_input_dialog_new
			)
			C.gtk_widget_realize (c_object)	
		end

	initialize is
			-- Connect action sequences to button signals.
		do
			enable_closeable
			is_initialized := True
		end

feature {EV_ANY_I} -- Implementation

	interface: EV_INPUT_DEVICE_DIALOG

end -- class EV_INPUT_DEVICE_DIALOG_IMP

--!-----------------------------------------------------------------------------
--! EiffelVision2: library of reusable components for ISE Eiffel.
--! Copyright (C) 1986-2000 Interactive Software Engineering Inc.
--! All rights reserved. Duplication and distribution prohibited.
--! May be used only with ISE Eiffel, under terms of user license. 
--! Contact ISE for any other use.
--!
--! Interactive Software Engineering Inc.
--! ISE Building, 2nd floor
--! 270 Storke Road, Goleta, CA 93117 USA
--! Telephone 805-685-1006, Fax 805-685-6869
--! Electronic mail <info@eiffel.com>
--! Customer support e-mail <support@eiffel.com>
--! For latest info see award-winning pages: http://www.eiffel.com
--!-----------------------------------------------------------------------------

--|-----------------------------------------------------------------------------
--| CVS log
--|-----------------------------------------------------------------------------
--|
--| $Log$
--| Revision 1.2  2001/06/07 23:08:06  rogers
--| Merged DEVEL branch into Main trunc.
--|
--| Revision 1.1.2.1  2000/10/19 17:10:36  oconnor
--| initial
--|
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
