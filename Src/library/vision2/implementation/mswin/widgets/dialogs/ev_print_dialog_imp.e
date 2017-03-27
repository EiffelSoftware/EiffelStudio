note
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
			activate
		end

	WEL_CAPABILITIES_CONSTANTS
		export
			{NONE} all
		undefine
			copy, is_equal
		end

	WEL_STANDARD_DIALOG_DISPATCHER
		rename
			standard_dialog_procedure as print_dialog_procedure
		undefine
			copy, is_equal
		end

create
	make

feature -- Initialization

	old_make (an_interface: attached like interface)
			-- Create `Current' with interface `an_interface'.
		do
			assign_interface (an_interface)

		end

	make
			-- Initialize `Current'
			--| Currently no need to do anything here.
		do
			wel_make
			enable_page_numbers
			set_maximum_range (1)
			add_flag (pd_enableprinthook)
			cwel_print_dlg_set_lpfnprinthook (item, wel_standard_dialog_procedure)
			set_is_initialized (True)
		end

feature -- Access

	print_context: EV_PRINT_CONTEXT
			-- Return a print context for the dialog box.
		do
			Result := Precursor {EV_PRINT_DIALOG_I}
			if attached private_dc as l_private_dc then
				l_private_dc.set_shared
				Result.set_printer_context (l_private_dc.item)
				Result.set_horizontal_resolution (((dc.width / dc.device_caps (logical_pixels_x)) * 72).rounded - 1)
				Result.set_vertical_resolution (((dc.height / dc.device_caps (logical_pixels_y)) * 72).rounded - 1)
					-- Subtract the -1 as print projector coordinates are 0 based.
					-- 72 is fixed in the implementation as the DPI.
			end
		end

	title: STRING_32
			-- Title of `Current'.
		local
			l_result: detachable STRING_32
		do
			l_result := internal_title
			if l_result = Void then
				l_result := {STRING_32} "Print"
			end
			Result := l_result
		end

feature -- Element change

	set_title (new_title: READABLE_STRING_GENERAL)
			-- Assign `new_title' to `title'.
		do
			internal_title := new_title.as_string_32.twin
		ensure then
			title_set: title.same_string_general (new_title)
		end

feature {EV_ANY_I}

	--| FIXME These features are all required by EV_POSITIONED and
	--| EV_POSITIONABLE. Is there a way to implement these?

	set_x_position (a: INTEGER)
		do
			check
				to_be_implemented: FALSE
			end
		end

	set_y_position (a: INTEGER)
		do
			check
				to_be_implemented: FALSE
			end
		end

	set_height (a: INTEGER)
		do
			check
				to_be_implemented: FALSE
			end
		end

	set_width (a: INTEGER)
		do
			check
				to_be_implemented: FALSE
			end
		end

	set_size (a, b: INTEGER)
		do
			check
				to_be_implemented: FALSE
			end
		end

	x_position: INTEGER
		do
			check
				to_be_implemented: FALSE
			end
		end

	y_position: INTEGER
		do
			check
				to_be_implemented: FALSE
			end
		end

	screen_x: INTEGER
		do
			check
				to_be_implemented: FALSE
			end
		end

	screen_y: INTEGER
		do
			check
				to_be_implemented: FALSE
			end
		end

	width: INTEGER
		do
			check
				to_be_implemented: FALSE
			end
		end

	set_position (a, b: INTEGER)
		do
			check
				to_be_implemented: FALSE
			end
		end

	height: INTEGER
		do
			check
				to_be_implemented: FALSE
			end
		end

	minimum_width: INTEGER
		do
			check
				to_be_implemented: FALSE
			end
		end

	minimum_height: INTEGER
		do
			check
				to_be_implemented: FALSE
			end
		end

feature -- Access

	output_file_name: STRING_32
		do
			--| FIXME it appears that to implement this, you
			--| need to handle WIN32 StartDoc and DOCINFO
			Result := {STRING_32} "Not yet implemented."
		end

	printer_name: STRING_32
		do
			--| FIXME Need to add WEL support for DEVNAMES
			--| structure, to implement this feature.
			Result := {STRING_32} "Not yet implemented"
		end

feature -- Element change

	set_maximum_to_page (value: INTEGER)
			-- Make 'value' the new maximum 'to_page' value.
		do
			maximum_to_page := value
			set_maximum_range (maximum_to_page)
		end

	set_minimum_from_page (value: INTEGER)
			-- Make 'value' the new minimum 'to_page' value.
		do
			minimum_from_page := value
			set_minimum_page (minimum_from_page)
		end

feature -- Status_report

	landscape_checked: BOOLEAN
		do
			--| FIXME Appears to be no easy way to find this from
			--| the dialog.
		end

feature {NONE} -- Implementation

	internal_title: detachable STRING_32
			-- Storage for `title'.

	activate (a_parent: WEL_COMPOSITE_WINDOW)
			-- Activate current dialog
		do
			begin_activate
			Precursor {WEL_PRINT_DIALOG} (a_parent)
			end_activate
		end

	print_dialog_procedure (hdlg: POINTER; msg: INTEGER_32; wparam, lparam: POINTER): POINTER
			-- Hook for handling messages of the font dialog.
		local
			l_str: WEL_STRING
		do
			inspect msg
			when {WEL_WM_CONSTANTS}.wm_initdialog then
					-- Initialize the title of dialog properly.
				if attached internal_title as l_internal_title then
					create l_str.make (l_internal_title)
					{WEL_API}.set_window_text (hdlg, l_str.item)
				end
			else
			end
		end

note
	copyright:	"Copyright (c) 1984-2017, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"




end -- class EV_PRINT_DIALOG_IMP





