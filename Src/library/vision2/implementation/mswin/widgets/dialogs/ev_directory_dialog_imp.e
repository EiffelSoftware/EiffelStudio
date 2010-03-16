note
	description: "Eiffel Vision directory dialog."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_DIRECTORY_DIALOG_IMP

	--| FIXME if you show the dialog, and click OK without
	--| selecting something, the last selected button is
	--| equal to "Cancel" as nothing was selected.
	--| Not sure how to fix this nicely, as the `selected'
	--| mechanism we are using seems to be limited in this case.

inherit
	EV_DIRECTORY_DIALOG_I
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

	WEL_CHOOSE_FOLDER_DIALOG
		rename
			make as wel_make,
			dispose as destroy
		end

	WEL_WINDOWS_VERSION
		export
			{NONE} all
		undefine
			copy, is_equal
		end

create
	make

feature {NONE} -- Initialization

	old_make (an_interface: like interface)
			-- Initialize.
		do
			assign_interface (an_interface)
		end

	make
			-- Set new UI style for dialog if supported.
		do
			wel_make
			if shell32_version >= version_500 then
				-- See header comment of {WEL_BIF_CONSTANTS}.Bif_usenewui
				add_flag (Bif_usenewui)
			end
			set_is_initialized (True)
		end

feature -- Access

	directory: STRING_32
			-- Path of the current selected file
		do
			Result := folder_name
		end

	start_directory: STRING_32
			-- Base directory where browsing will start.
		do
			Result := starting_folder
		end

feature -- Element change

	set_start_directory (a_path: STRING_GENERAL)
			-- Make `a_path' the base directory.
		do
			set_starting_folder (a_path)
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

feature {EV_ANY, EV_ANY_I} -- Implementation

	interface: detachable EV_DIRECTORY_DIALOG note option: stable attribute end;

note
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class EV_DIRECTORY_DIALOG_IMP





