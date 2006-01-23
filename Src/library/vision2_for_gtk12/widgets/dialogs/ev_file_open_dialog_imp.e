indexing 
	description: "Eiffel Vision file open dialog."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_FILE_OPEN_DIALOG_IMP

inherit
	EV_FILE_OPEN_DIALOG_I
		redefine
			interface
		end

	EV_FILE_DIALOG_IMP
		undefine
			internal_accept
		redefine
			interface,
			initialize
		end

create
	make

feature {NONE} -- Initialization

	initialize is
		do
			Precursor
			set_title ("Open")
		end

	multiple_selection_enabled: BOOLEAN
		-- Is dialog enabled to select multiple files.

	file_names: ARRAYED_LIST [STRING] is
			-- List of filenames selected by user
		do
			create Result.make (1)
			Result.extend (file_name)
		end

	enable_multiple_selection is
			-- Enable multiple file selection
		do
			check
				do_not_call: False
			end
			multiple_selection_enabled := True 
		end

	disable_multiple_selection is
			-- Disable multiple file selection
		do
			check
				do_not_call: False
			end
			multiple_selection_enabled := False
		end

feature {NONE} -- Implementation

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

