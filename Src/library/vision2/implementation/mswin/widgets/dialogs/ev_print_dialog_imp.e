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
		undefine
			internal_accept
		end

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
--| EiffelVision2: library of reusable components for ISE Eiffel.
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

