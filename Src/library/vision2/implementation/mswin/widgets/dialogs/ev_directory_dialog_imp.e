indexing 
	description: "Eiffel Vision directory dialog."
	status: "See notice at end of class"
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
		redefine
			interface
		end

	EV_STANDARD_DIALOG_IMP
		redefine
			interface
		end

	WEL_CHOOSE_FOLDER_DIALOG
		rename
			make as wel_make,
			dispose as destroy
		end

	WEL_WINDOWS_VERSION

create
	make

feature {NONE} -- Initialization

	make (an_interface: like interface) is
			-- Initialize.
		do
			base_make (an_interface)
			wel_make
		end

	initialize is
			-- Set new UI style for dialog if supported.
		do
			if shell32_version >= version_500 then
				-- See header comment of {WEL_BIF_CONSTANTS}.Bif_usenewui
				add_flag (Bif_usenewui)
			end
			is_initialized := True
		end

feature -- Access

	directory: STRING is
			-- Path of the current selected file
		do
			Result := folder_name
		end

	start_directory: STRING is
			-- Base directory where browsing will start.
		do
			Result := starting_folder
		end

feature -- Element change

	set_start_directory (a_path: STRING) is
			-- Make `a_path' the base directory.
		do
			set_starting_folder (a_path)
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

	interface: EV_DIRECTORY_DIALOG

end -- class EV_DIRECTORY_DIALOG_IMP

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

