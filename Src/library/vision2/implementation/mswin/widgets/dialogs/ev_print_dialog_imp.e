indexing 
	description: "EiffelVision print dialog, mswindows implementation."
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class
	EV_PRINT_DIALOG_IMP

inherit
	EV_PRINT_DIALOG_I
		redefine
			print_context
		end

	EV_STANDARD_DIALOG_IMP

	WEL_PRINT_DIALOG
		rename
			make as wel_make,
			maximum_page as maximum_range,
			set_maximum_page as set_maximum_range,
			set_parent as wel_set_parent
		redefine
			wel_make
		end

creation
	make

feature {NONE} -- Initialization

	make (an_interface: like interface) is
			-- Create `Current' with interface `an_interface'.
		do
			base_make (an_interface)
			wel_make
		end

	wel_make is
			-- Make and setup the structure.
		do
			{WEL_PRINT_DIALOG} Precursor
			enable_page_numbers
			set_maximum_range (1)
		end

	initialize is
			-- Initialize `Current'
			--| Currently no need to do anything here.
		do
			is_initialized := True
		end

feature -- Access

	print_context: EV_PRINT_CONTEXT is
			-- Return a print context for the dialog box.
		do
			Result := Precursor {EV_PRINT_DIALOG_I}
			if private_dc /= Void then
				private_dc.set_shared
				Result.set_printer_context (private_dc.item)
			end
		end

	title: STRING is "Print"
			-- Title of `Current'.

feature -- Element change

	set_title (new_title: STRING) is
			-- Assign `new_title' to `title'.
		do
			--| FIXME IS it possible in windows to change
			--| the title of this dialog?
		end

	destroy is
			-- Destroy `Current'.
		do
			destroy_item
		end

feature {EV_ANY_I}

	--| FIXME These features are all required by EV_POSITIONED and
	--| EV_POSITIONABLE. Is there a way to implement these?

	set_x_position (a: INTEGER) is
		do
			check
				to_be_implemented: FALSE
			end
		end

	set_y_position (a: INTEGER) is
		do
			check
				to_be_implemented: FALSE
			end
		end

	set_height (a: INTEGER) is
		do
			check
				to_be_implemented: FALSE
			end
		end

	set_width (a: INTEGER) is
		do
			check
				to_be_implemented: FALSE
			end
		end

	set_size (a, b: INTEGER) is
		do
			check
				to_be_implemented: FALSE
			end
		end

	x_position: INTEGER is
		do
			check
				to_be_implemented: FALSE
			end
		end

	y_position: INTEGER is
		do
			check
				to_be_implemented: FALSE
			end
		end

	screen_x: INTEGER is
		do
			check
				to_be_implemented: FALSE
			end
		end

	screen_y: INTEGER is
		do
			check
				to_be_implemented: FALSE
			end
		end

	width: INTEGER is
		do
			check
				to_be_implemented: FALSE
			end
		end

	set_position (a, b: INTEGER) is
		do
			check
				to_be_implemented: FALSE
			end
		end

	height: INTEGER is
		do
			check
				to_be_implemented: FALSE
			end
		end

	minimum_width: INTEGER is
		do
			check
				to_be_implemented: FALSE
			end
		end

	minimum_height: INTEGER is
		do	
			check
				to_be_implemented: FALSE
			end
		end

feature -- Access

	output_file_name: STRING is
		do
			Result:="a_file"
		end

	printer_name: STRING is
		do
			Result:="a printer"
		end

feature -- Element change

	set_maximum_to_page (value: INTEGER) is
			-- Make 'value' the new maximum 'to_page' value.
		do
			maximum_to_page := value
		end

	set_minimum_from_page (value: INTEGER) is
			-- Make 'value' the new minimum 'to_page' value.
		do
			minimum_from_page := value
		end

feature -- Status_report

	landscape_checked: BOOLEAN is
		do
		end

feature {NONE} -- Implementation

	dispatch_events is
		do
		end

end -- class EV_PRINT_DIALOG_IMP

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
--|----------------------------------------------------------------

--|-----------------------------------------------------------------------------
--| CVS log
--|-----------------------------------------------------------------------------
--|
--| $Log$
--| Revision 1.4  2001/06/07 23:08:14  rogers
--| Merged DEVEL branch into Main trunc.
--|
--| Revision 1.2.8.8  2001/04/26 19:21:20  king
--| Made releaseable
--|
--| Revision 1.2.8.7  2001/04/26 19:15:32  king
--| Cosmetics
--|
--| Revision 1.2.8.6  2000/12/13 23:36:01  king
--| Altered print_context to set pointer of printer dc
--|
--| Revision 1.2.8.5  2000/11/11 02:10:03  andrew
--| Made Compilable
--|
--| Revision 1.2.8.4  2000/10/13 21:38:24  andrew
--| Removed landscape_checked: BOOLEAN and portrait_checked: BOOLEAN
--|
--| Revision 1.2.8.3  2000/10/12 22:10:11  andrew
--| Made compilable
--|
--| Revision 1.2.8.2  2000/10/06 18:51:05  king
--| Made compilable
--|
--| Revision 1.2.8.1  2000/05/03 19:09:23  oconnor
--| mergred from HEAD
--|
--| Revision 1.3  2000/02/14 11:40:42  oconnor
--| merged changes from prerelease_20000214
--|
--| Revision 1.2.10.2  2000/01/27 19:30:19  oconnor
--| added --| FIXME Not for release
--|
--| Revision 1.2.10.1  1999/11/24 17:30:25  oconnor
--| merged with DEVEL branch
--|
--| Revision 1.2.6.2  1999/11/02 17:20:09  oconnor
--| Added CVS log, redoing creation sequence
--|
--|
--|-----------------------------------------------------------------------------
--| End of CVS log
--|-----------------------------------------------------------------------------
