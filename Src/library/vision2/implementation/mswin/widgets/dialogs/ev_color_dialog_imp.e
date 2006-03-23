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
			wel_make
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

	wel_make is
			-- WEL creation of the dialog
		do
			Precursor {WEL_CHOOSE_COLOR_DIALOG}
			add_flag (Cc_fullopen)
			add_flag (Cc_anycolor)
		end

	initialize is
			-- Initialize `Current'
			--| Currently no need to do anything here.
		do
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
		do
			Result := "Color"
		end
			-- Title of `Current'.

feature -- Element change

	set_title (new_title: STRING_32) is
			-- Assign `new_title' to `title'.
		do
			--| FIXME IS it possible in windows to change
			--| the title of this dialog?
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

