note
	description:
		"Eiffel Vision file open dialog. Mswindows implementation."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_FILE_OPEN_DIALOG_IMP

inherit
	EV_FILE_OPEN_DIALOG_I
		undefine
			copy, is_equal
		redefine
			interface
		end

	EV_FILE_DIALOG_IMP
		undefine
			internal_accept,
			copy, is_equal
		redefine
			interface,
			full_file_path
		end

	WEL_OPEN_FILE_DIALOG
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

feature -- Status report

	full_file_path: PATH
			-- Full name of currently selected file including path.
		do
			if multiple_selection_enabled and then not file_paths.is_empty then
					-- It appears that if multiple files are selected, `full_file_path'
					-- returns the path of the files. Therefore, we must retrieve the
					-- first of the file names.
				Result := file_paths.first
			else
				Result := Precursor {EV_FILE_DIALOG_IMP}
			end
		end

	multiple_selection_enabled: BOOLEAN
			-- Can more than one item be selected?
		do
			Result := has_flag ({WEL_OFN_CONSTANTS}.Ofn_allowmultiselect)
		end

	file_names: ARRAYED_LIST [STRING_32]
			-- Full names of currently selected files including path.
		obsolete
			"Use `file_paths' instead. [2017-05-31]"
		local
			l_result: detachable ARRAYED_LIST [STRING_32]
		do
			if multiple_selection_enabled then
				l_result ?= multiple_file_names
			else
					-- If there is no multiple selection, simply copy `file_name' into `Result'.
				create l_result.make (1)
				if not full_file_path.is_empty then
						-- if `file_name' is empty then cancel was selected and `Result' must be empty.
					l_result.extend (full_file_path.name.as_string_32_conversion)
				end
			end
			check l_result /= Void then end
			Result := l_result
		end

	file_paths: ARRAYED_LIST [PATH]
			-- Full names of currently selected files including path.
		local
			l_result: detachable ARRAYED_LIST [PATH]
		do
			if multiple_selection_enabled then
				l_result := multiple_file_paths
			else
					-- If there is no multiple selection, simply copy `file_name' into `Result'.
				create l_result.make (1)
				if not full_file_path.is_empty then
						-- if `file_name' is empty then cancel was selected and `Result' must be empty.
					l_result.extend (full_file_path.twin)
				end
			end
			check l_result /= Void then end
			Result := l_result
		end

feature -- Status setting

	enable_multiple_selection
			-- Allow multiple items to be selected.
		do
			set_flags (flags | {WEL_OFN_CONSTANTS}.Ofn_allowmultiselect | {WEL_OFN_CONSTANTS}.ofn_explorer)
		end

	disable_multiple_selection
			-- Allow only one item to be selected.
		do
			remove_flag ({WEL_OFN_CONSTANTS}.Ofn_allowmultiselect)
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

feature {EV_ANY, EV_ANY_I}

	interface: detachable EV_FILE_OPEN_DIALOG note option: stable attribute end;

note
	copyright:	"Copyright (c) 1984-2013, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"




end -- class EV_FILE_OPEN_DIALOG_IMP










