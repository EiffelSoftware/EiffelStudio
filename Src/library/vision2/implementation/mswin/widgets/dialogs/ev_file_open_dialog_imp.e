indexing 
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
			file_name
		end

	WEL_OPEN_FILE_DIALOG
		rename
			make as wel_make,
			file_name as wel_file_name,
			set_file_name as wel_set_file_name,
			set_filter as wel_set_filter,
			set_filter_index as wel_set_filter_index,
			set_initial_directory as wel_set_initial_directory,
			file_title as wel_file_title,
			dispose as destroy
		end

create
	make
	
feature -- Status report

	file_name: STRING is
			-- Full name of currently selected file including path.
		do
			if multiple_selection_enabled and then not file_names.is_empty then
					-- It appears that if multiple files are selected, `file_name'
					-- returns the path of the files. Therefore, we must retrieve the
					-- first of the file names.
				Result := file_names.first
			else
				Result := Precursor {EV_FILE_DIALOG_IMP}
			end
		end

	multiple_selection_enabled: BOOLEAN is
			-- Can more than one item be selected?
		do
			Result := has_flag ({WEL_OFN_CONSTANTS}.Ofn_allowmultiselect)
		end
		
	file_names: ARRAYED_LIST [STRING] is
			-- Full names of currently selected files including path.
		local
			linked_list: LINKED_LIST [STRING]
		do
			if multiple_selection_enabled then
				linked_list := multiple_file_names
				create Result.make (linked_list.count)
				from
					linked_list.start
				until
					linked_list.off
				loop
					Result.extend (linked_list.item.twin)
					linked_list.forth
				end
			else
					-- If there is no multiple selection, simply copy `file_name' into `Result'.
				create Result.make (1)
				if not file_name.is_empty then
						-- if `file_name' is empty then cancel was selected and `Result' must be empty.
					Result.extend (file_name.twin)
				end
			end
		end

feature -- Status setting

	enable_multiple_selection is
			-- Allow multiple items to be selected.
		do
			set_flags (flags | {WEL_OFN_CONSTANTS}.Ofn_allowmultiselect | {WEL_OFN_CONSTANTS}.ofn_explorer)
		end

	disable_multiple_selection is
			-- Allow only one item to be selected.
		do
			remove_flag ({WEL_OFN_CONSTANTS}.Ofn_allowmultiselect)
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

feature {EV_ANY_I}

	interface: EV_FILE_OPEN_DIALOG;

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




end -- class EV_FILE_OPEN_DIALOG_IMP

