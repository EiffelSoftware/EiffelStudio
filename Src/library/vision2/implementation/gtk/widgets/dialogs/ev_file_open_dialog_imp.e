indexing 
	description: "Eiffel Vision file open dialog."
	status: "See notice at end of class"
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
			initialize,
			file_name
		end

create
	make

feature {NONE} -- Initialization

	initialize is
		do
			Precursor
			set_title ("Open")
		end

feature {NONE} -- Access

	multiple_selection_enabled: BOOLEAN
		-- Is dialog enabled to select multiple files.

	file_name: STRING is
			-- Retrieve file name selected by user
		do
			Result := file_names.first
			if Result = Void then
				Result := Precursor {EV_FILE_DIALOG_IMP}
			end
		end

	file_names: ARRAYED_LIST [STRING] is
			-- List of filenames selected by user
		local
			fnlist: POINTER
			fname: POINTER
			fnstring: STRING
		do
			create Result.make (1)
			if selected_button /= Void and then selected_button.is_equal (internal_accept) then
					fnlist := {EV_GTK_DEPENDENT_EXTERNALS}.gtk_file_chooser_get_filenames (c_object)
			end
			if fnlist /= Default_pointer then
				from
				until
					fnlist = default_pointer
				loop
					fname := {EV_GTK_EXTERNALS}.gslist_struct_data (fnlist)
					create fnstring.make_from_c (fname)
					Result.extend (fnstring)
					{EV_GTK_EXTERNALS}.g_free (fname)
					fnlist := {EV_GTK_EXTERNALS}.gslist_struct_next (fnlist)
				end
				{EV_GTK_EXTERNALS}.g_slist_free (fnlist)
			end
		end

feature {NONE} -- Setting

	enable_multiple_selection is
			-- Enable multiple file selection
		do
			{EV_GTK_DEPENDENT_EXTERNALS}.gtk_file_chooser_set_select_multiple (c_object, True)
			multiple_selection_enabled := True 
		end

	disable_multiple_selection is
			-- Disable multiple file selection
		do
			{EV_GTK_DEPENDENT_EXTERNALS}.gtk_file_chooser_set_select_multiple (c_object, False)
			multiple_selection_enabled := False
		end

feature {NONE} -- Implementation

	file_chooser_action: INTEGER is
			-- Action constant of the file chooser, ie: to open or save files, etc.
		do
			Result := {EV_GTK_DEPENDENT_EXTERNALS}.gtk_file_chooser_action_open_enum
		end

	interface: EV_FILE_OPEN_DIALOG

end -- class EV_FILE_OPEN_DIALOG_IMP

--|----------------------------------------------------------------
--| EiffelVision2: library of reusable components for ISE Eiffel.
--| Copyright (C) 1985-2004 Eiffel Software. All rights reserved.
--| Duplication and distribution prohibited.  May be used only with
--| ISE Eiffel, under terms of user license.
--| Contact Eiffel Software for any other use.
--|
--| Interactive Software Engineering Inc.
--| dba Eiffel Software
--| 356 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Contact us at: http://www.eiffel.com/general/email.html
--| Customer support: http://support.eiffel.com
--| For latest info on our award winning products, visit:
--|	http://www.eiffel.com
--|----------------------------------------------------------------

