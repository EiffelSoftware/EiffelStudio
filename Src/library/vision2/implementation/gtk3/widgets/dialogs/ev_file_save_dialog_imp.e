note
	description: "EiffelVision file save dialog."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_FILE_SAVE_DIALOG_IMP

inherit
	EV_FILE_SAVE_DIALOG_I
		redefine
			interface
		end

	EV_FILE_DIALOG_IMP
		undefine
			internal_accept
		redefine
			interface,
			make
		end

create
	make

feature {NONE} -- Initialization

	make
		do
			Precursor {EV_FILE_DIALOG_IMP}
			set_title ("Save As")
		end

feature {EV_ANY, EV_ANY_I} -- Implementation

	interface: detachable EV_FILE_SAVE_DIALOG note option: stable attribute end

feature {NONE} -- Implementation

	file_chooser_action: INTEGER
			-- Action constant of the file chooser, ie: to open or save files, etc.
		do
			Result := {GTK2}.gtk_file_chooser_action_save_enum
		end

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

end -- class EV_FILE_SAVE_DIALOG_IMP
