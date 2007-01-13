indexing
	description: "EiffelVision color selection dialog.%
		%Mswindows implementation."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_COLOR_DIALOG_IMP

inherit
	EV_COLOR_DIALOG_I
		undefine
			copy, is_equal
		redefine
			interface
		end

	EV_STANDARD_DIALOG_IMP
		undefine
			copy, is_equal
		redefine
			interface
		end

	WEL_CHOOSE_COLOR_DIALOG
		rename
			make as wel_make,
			set_parent as wel_set_parent
		redefine
			activate
		end

	WEL_STANDARD_DIALOG_DISPATCHER
		rename
			standard_dialog_procedure as color_dialog_procedure
		undefine
			copy, is_equal
		end

create
	make

feature {NONE} -- Implementation

	make (an_interface: like interface) is
			-- Create `Current' with interface `an_interface'.
		do
			base_make (an_interface)
			wel_make
		end

	initialize is
			-- Initialize `Current'
			--| Currently no need to do anything here.
		do
			add_flag (Cc_fullopen)
			add_flag (Cc_anycolor)
			add_flag (cc_enablehook)
			cwel_choose_color_set_lpfnhook (item, wel_standard_dialog_procedure)
			set_is_initialized (True)
		end

feature -- Access

	color: EV_COLOR is
			-- `Result' is color selected in `Current'.
		local
			col: WEL_COLOR_REF
		do
			if selected then
				col := rgb_result
				create Result.make_with_8_bit_rgb (col.red, col.green, col.blue)
			else
				Result := stored_color
				if Result = Void then
						--| FIXME, this is always returned as black.
						--| There appears to be no solution to this in the API.
						--| It is due to the fact that `Current' will return only the
						--| initially selected color which in this case is black.
					create col.make_by_color (cwel_choose_color_get_rgbresult (item))
					create Result.make_with_8_bit_rgb (col.red, col.green, col.blue)
				end
			end
		end

	title: STRING_32 is
			-- Title of `Current'.
		do
			Result := internal_title
			if Result = Void then
				Result := "Color"
			end
		end

feature -- Element change

	set_title (new_title: STRING_GENERAL) is
			-- Assign `new_title' to `title'.
		do
			internal_title := new_title.twin
		ensure then
			title_set: title.is_equal (new_title)
		end

	set_color (a_color: EV_COLOR) is
			-- Select `a_color' in `Current'.
		local
			w: WEL_COLOR_REF
		do
			stored_color := a_color
			create w.make_rgb (a_color.red_8_bit, a_color.green_8_bit,
				a_color.blue_8_bit)
			set_rgb_result (w)
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

feature {NONE} -- Implementation

	stored_color: EV_COLOR
			-- Kept reference in case the user cancelled the color selection.

	internal_title: STRING_32
			-- Storage for `title'.

	activate (a_parent: WEL_COMPOSITE_WINDOW) is
			-- Activate current dialog
		do
			begin_activate
			Precursor {WEL_CHOOSE_COLOR_DIALOG} (a_parent)
			end_activate
		end

	color_dialog_procedure (hdlg: POINTER; msg: INTEGER_32; wparam, lparam: POINTER): POINTER is
			-- Hook for handling messages of the font dialog.
		local
			l_str: WEL_STRING
		do
			inspect msg
			when {WEL_WM_CONSTANTS}.wm_initdialog then
					-- Initialize the title of dialog properly.
				if internal_title /= Void then
					create l_str.make (internal_title)
					{WEL_API}.set_window_text (hdlg, l_str.item)
				end
			else
			end
		end

feature {EV_ANY_I}

	interface: EV_COLOR_DIALOG;

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




end -- class EV_COLOR_DIALOG_IMP

