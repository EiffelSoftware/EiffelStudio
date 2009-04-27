indexing
	description: "Eiffel Vision directory dialog."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_DIRECTORY_DIALOG_IMP

inherit
	EV_DIRECTORY_DIALOG_I
		redefine
			interface
		end

	EV_STANDARD_DIALOG_IMP
		redefine
			interface,
			initialize
		end

create
	make

feature {NONE} -- Initialization

	make (an_interface: like interface)
			-- Create a window with a parent.
		do

		end

	initialize
			-- Setup action sequences.
		do

		end

feature -- Access

	directory: STRING_32
			-- Path of the current selected file
		do

		end

	start_directory: STRING_32
			-- Base directory where browsing will start.

feature -- Element change

	set_start_directory (a_path: STRING_GENERAL)
			-- Make `a_path' the base directory.
		do
		end

feature {NONE} -- Implementation

	interface: EV_DIRECTORY_DIALOG;

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




end -- class EV_DIRECTORY_DIALOG_IMP

