note
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
			make,
			file_name
		end

create
	make

feature {NONE} -- Initialization

	make
		do
			Precursor
			set_title ("Open")
		end

feature {NONE} -- Access

	multiple_selection_enabled: BOOLEAN
		-- Is dialog enabled to select multiple files.

	file_name: STRING_32
			-- Retrieve file name selected by user.
		local
			l_file_names: like file_names
			l_result: detachable STRING_32
		do
			l_file_names := file_names
			if not l_file_names.is_empty then
				l_result := l_file_names.first
			end
			if l_result = Void then
				l_result := Precursor {EV_FILE_DIALOG_IMP}
			end
			check l_result /= Void end
			Result := l_result
		end

	file_names: ARRAYED_LIST [STRING_32]
			-- List of filenames selected by user
		local
			fnlist: POINTER
			fname: POINTER
			a_cs: EV_GTK_C_STRING
		do
			create Result.make (1)
			if attached selected_button as l_selected_button and then l_selected_button.is_equal (internal_accept) then
					fnlist := {EV_GTK_DEPENDENT_EXTERNALS}.gtk_file_chooser_get_filenames (c_object)
			end
			if fnlist /= Default_pointer then
				from
					create a_cs.set_with_eiffel_string ("")
				until
					fnlist = default_pointer
				loop
					fname := {EV_GTK_EXTERNALS}.gslist_struct_data (fnlist)
					a_cs.share_from_pointer (fname)
					Result.extend (a_cs.string)
					{EV_GTK_EXTERNALS}.g_free (fname)
					fnlist := {EV_GTK_EXTERNALS}.gslist_struct_next (fnlist)
				end
				{EV_GTK_EXTERNALS}.g_slist_free (fnlist)
			end
		end

feature {NONE} -- Setting

	enable_multiple_selection
			-- Enable multiple file selection
		do
			{EV_GTK_DEPENDENT_EXTERNALS}.gtk_file_chooser_set_select_multiple (c_object, True)
			multiple_selection_enabled := True
		end

	disable_multiple_selection
			-- Disable multiple file selection
		do
			{EV_GTK_DEPENDENT_EXTERNALS}.gtk_file_chooser_set_select_multiple (c_object, False)
			multiple_selection_enabled := False
		end

feature {NONE} -- Implementation

	file_chooser_action: INTEGER
			-- Action constant of the file chooser, ie: to open or save files, etc.
		do
			Result := {EV_GTK_DEPENDENT_EXTERNALS}.gtk_file_chooser_action_open_enum
		end

feature {EV_ANY, EV_ANY_I} -- Implementation

	interface: detachable EV_FILE_OPEN_DIALOG note option: stable attribute end;

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

end -- class EV_FILE_OPEN_DIALOG_IMP
