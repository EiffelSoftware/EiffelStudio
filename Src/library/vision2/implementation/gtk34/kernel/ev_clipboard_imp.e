note
	description: "Objects that allow access to the operating %N%
	%system clipboard."
	legal: "See notice at end of class."
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

	old_make (an_interface: attached like interface)
			-- Create `Current' with interface `an_interface'.
		do
			assign_interface (an_interface)
		end

	make
			-- initialize `Current'.
		local
			cs: EV_GTK_C_STRING
		do
			cs := once "CLIPBOARD"
			clipboard := {GTK2}.gtk_clipboard_get (
							{GTK}.gdk_atom_intern (cs.item, 1)
			)
			cs := once "PRIMARY"
			primary := {GTK2}.gtk_clipboard_get (
							{GTK}.gdk_atom_intern (cs.item, 1)
			)
			set_is_initialized (True)
		end

feature -- Access

	has_text: BOOLEAN
			-- Does the clipboard currently contain text?
		local
			b: BOOLEAN
		do
				-- The query may trigger pending signals which may cause side-effects so
				-- we disable the marshaller.
			b := {EV_GTK_CALLBACK_MARSHAL}.c_ev_gtk_callback_marshal_is_enabled
			{EV_GTK_CALLBACK_MARSHAL}.c_ev_gtk_callback_marshal_set_is_enabled (False)
			Result := {GTK2}.gtk_clipboard_wait_is_text_available (clipboard)
			{EV_GTK_CALLBACK_MARSHAL}.c_ev_gtk_callback_marshal_set_is_enabled (b)
		end

	text: STRING_32
			-- `Result' is current clipboard content.
		local
			utf8_string: EV_GTK_C_STRING
			text_ptr: POINTER
			b: BOOLEAN
		do
				-- The query may trigger pending signals which may cause side-effects so
				-- we disable the marshaller.
			b := {EV_GTK_CALLBACK_MARSHAL}.c_ev_gtk_callback_marshal_is_enabled
			{EV_GTK_CALLBACK_MARSHAL}.c_ev_gtk_callback_marshal_set_is_enabled (False)
			text_ptr := {GTK2}.gtk_clipboard_wait_for_text (clipboard)
			{EV_GTK_CALLBACK_MARSHAL}.c_ev_gtk_callback_marshal_set_is_enabled (b)
			if text_ptr /= Default_pointer then
				create utf8_string.make_from_pointer (text_ptr)
				Result := utf8_string.string
					-- Free existing text by resetting with a new string
				utf8_string.set_with_eiffel_string (once "")
			else
				Result := ""
					-- We return an empty string if there is nothing present in the clipboard.
			end
		end

feature -- Status Setting

	set_text (a_text: READABLE_STRING_GENERAL)
			-- Assign `a_text' to clipboard.
		local
			a_cs: EV_GTK_C_STRING
		do
			a_cs := a_text
			{GTK2}.gtk_clipboard_set_text (clipboard, a_cs.item, a_cs.string_length)
			{GTK2}.gtk_clipboard_set_text (primary, a_cs.item, a_cs.string_length)
				-- We also set the primary selection as there is no windows equivalent.

				-- Free existing string by resetting with a new string.
			a_cs.set_with_eiffel_string (once "")
		end

feature {EV_TEXT_COMPONENT_IMP} -- Implementation

	clipboard: POINTER
			-- Pointer to the CLIPBOARD Gtk clipboard

feature {NONE} -- Implementation

	primary: POINTER
			-- Pointer to the PRIMARY Gtk clipboard

feature {EV_ANY_I}

	destroy
			-- Destroy `Current'
		do
			set_is_destroyed (True)
		end

feature {EV_ANY, EV_ANY_I} -- Implementation

	interface: detachable EV_CLIPBOARD note option: stable attribute end;
		-- Interface of `Current'

note
	copyright:	"Copyright (c) 1984-2021, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end -- class EV_CLIPBOARD_IMP
