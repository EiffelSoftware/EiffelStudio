indexing
	description: "Objects that allow access to the operating %N%
	%system clipboard."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_CLIPBOARD_IMP

inherit
	EV_CLIPBOARD_I
		redefine
			interface
		end

	EV_ANY_I
		redefine
			interface
		end

create
	make

feature {NONE}-- Initialization

	make (an_interface: like interface) is
			-- Create `Current' with interface `an_interface'.
		do
			base_make (an_interface)
		end

	initialize is
			-- initialize `Current'.
		local
			cs: EV_GTK_C_STRING
		do
			cs := "CLIPBOARD"
			clipboard := {EV_GTK_DEPENDENT_EXTERNALS}.gtk_clipboard_get (
							{EV_GTK_EXTERNALS}.gdk_atom_intern (cs.item, 1)
			)
			cs := "PRIMARY"
			primary := {EV_GTK_DEPENDENT_EXTERNALS}.gtk_clipboard_get (
							{EV_GTK_EXTERNALS}.gdk_atom_intern (cs.item, 1)
			)
			is_initialized := True
		end

feature -- Access

	has_text: BOOLEAN is
			-- Does the clipboard currently contain text?
		do
			Result := {EV_GTK_DEPENDENT_EXTERNALS}.gtk_clipboard_wait_is_text_available (clipboard)
		end

	text: STRING is
			-- `Result' is current clipboard content.
		local
			utf8_string: EV_GTK_C_STRING
			text_ptr: POINTER
		do			
			text_ptr := {EV_GTK_DEPENDENT_EXTERNALS}.gtk_clipboard_wait_for_text (clipboard)
			if text_ptr /= Default_pointer then
				create utf8_string.make_from_pointer (text_ptr)
				{EV_GTK_EXTERNALS}.g_free (text_ptr)
				Result := utf8_string.string
			else
				Result := ""
					-- We return an empty string if there is nothing present in the clipboard.
			end
		end

feature -- Status Setting

	set_text (a_text: STRING) is
			-- Assign `a_text' to clipboard.
		local
			a_cs: EV_GTK_C_STRING
		do
			create a_cs.make (a_text)
			{EV_GTK_DEPENDENT_EXTERNALS}.gtk_clipboard_set_text (clipboard, a_cs.item, a_cs.string_length)
			{EV_GTK_DEPENDENT_EXTERNALS}.gtk_clipboard_set_text (primary, a_cs.item, a_cs.string_length)
				-- We also set the primary selection as there is no windows equivalent.
		end
		
feature {EV_TEXT_COMPONENT_IMP} -- Implementation

	clipboard: POINTER
			-- Pointer to the CLIPBOARD Gtk clipboard
	
feature {NONE} -- Implementation

	primary: POINTER
			-- Pointer to the PRIMARY Gtk clipboard

feature {EV_ANY_I}

	destroy is
			-- Destroy `Current'
		do
			is_destroyed := True
		end

	interface: EV_CLIPBOARD
		-- Interface of `Current'

end -- class EV_CLIPBOARD_IMP

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

