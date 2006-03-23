indexing
	description: "EiffelVision print dialog, mswindows implementation."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_PRINT_DIALOG_IMP

inherit
	EV_PRINT_DIALOG_I
		undefine
			copy, is_equal
		redefine
			print_context
		end

	EV_STANDARD_DIALOG_IMP
		undefine
			internal_accept,
			copy, is_equal
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

	WEL_CAPABILITIES_CONSTANTS
		export
			{NONE} all
		undefine
			copy, is_equal
		end

create
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
			Precursor {WEL_PRINT_DIALOG}
			enable_page_numbers
			set_maximum_range (1)
		end

	initialize is
			-- Initialize `Current'
			--| Currently no need to do anything here.
		do
			set_is_initialized (True)
		end

feature -- Access

	print_context: EV_PRINT_CONTEXT is
			-- Return a print context for the dialog box.
		do
			Result := Precursor {EV_PRINT_DIALOG_I}
			if private_dc /= Void then
				private_dc.set_shared
				Result.set_printer_context (private_dc.item)
				Result.set_horizontal_resolution (((dc.width / dc.device_caps (logical_pixels_x)) * 72).rounded - 1)
				Result.set_vertical_resolution (((dc.height / dc.device_caps (logical_pixels_y)) * 72).rounded - 1)
					-- Subtract the -1 as print projector coordinates are 0 based.
					-- 72 is fixed in the implementation as the DPI.
			end
		end

	title: STRING_32 is
			-- Title of `Current'.
		do
			Result := "Print"
		end

feature -- Element change

	set_title (new_title: STRING_GENERAL) is
			-- Assign `new_title' to `title'.
		do
			--| FIXME IS it possible in windows to change
			--| the title of this dialog?
		end

	destroy is
			-- Destroy `Current'.
		do
			destroy_item
			set_is_destroyed (True)
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

	output_file_name: STRING_32 is
		do
			--| FIXME it appears that to implement this, you
			--| need to handle WIN32 StartDoc and DOCINFO
			Result:="Not yet implemented."
		end

	printer_name: STRING_32 is
		do
			--| FIXME Need to add WEL support for DEVNAMES
			--| structure, to implement this feature.
			Result:="Not yet implemented"
		end

feature -- Element change

	set_maximum_to_page (value: INTEGER) is
			-- Make 'value' the new maximum 'to_page' value.
		do
			maximum_to_page := value
			set_maximum_range (maximum_to_page)
		end

	set_minimum_from_page (value: INTEGER) is
			-- Make 'value' the new minimum 'to_page' value.
		do
			minimum_from_page := value
			set_minimum_page (minimum_from_page)
		end

feature -- Status_report

	landscape_checked: BOOLEAN is
		do
			--| FIXME Appears to be no easy way to find this from
			--| the dialog.
		end

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




end -- class EV_PRINT_DIALOG_IMP

