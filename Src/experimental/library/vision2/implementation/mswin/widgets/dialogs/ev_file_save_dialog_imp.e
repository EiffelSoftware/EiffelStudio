note
	description:
		"Eiffel Vision file open dialog. Mswindows implementation."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_FILE_SAVE_DIALOG_IMP

inherit
	EV_FILE_SAVE_DIALOG_I
		undefine
			copy, is_equal
		end

	EV_FILE_DIALOG_IMP
		undefine
			internal_accept,
			copy, is_equal
		end

	WEL_SAVE_FILE_DIALOG
		rename
			make as wel_make,
			file_name as wel_file_name,
			file_path as wel_file_path,
			set_file_name as wel_set_file_name,
			set_file_path as wel_set_file_path,
			set_filter as wel_set_filter,
			set_filter_index as wel_set_filter_index,
			set_initial_path as wel_set_initial_path,
			file_title as wel_file_title
		end

create
	make

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

note
	copyright:	"Copyright (c) 1984-2012, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"




end -- class EV_SAVE_OPEN_DIALOG_IMP





