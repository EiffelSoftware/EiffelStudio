indexing
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

	EV_ANY_IMP
		rename
			c_object as clipboard_widget
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
			set_c_object (gtk_text_new (NULL, NULL))
		end

	initialize is
			-- initialize `Current'.
		do
			{EV_GTK_EXTERNALS}.gtk_container_add (App_implementation.default_window_imp.hbox, clipboard_widget)
			{EV_GTK_EXTERNALS}.gtk_widget_show (clipboard_widget)
			set_is_initialized (True)
		end

feature -- Access

	text: STRING is
			-- `Result' is current clipboard content.
		local
			a_success: INTEGER
			a_cs1, a_cs2: EV_GTK_C_STRING
			edit_chars: POINTER
		do
			{EV_GTK_EXTERNALS}.gtk_editable_delete_text (clipboard_widget, 0, -1)
			a_cs1 :=  "CLIPBOARD"
			a_cs2 := "COMPOUND_TEXT"
			a_success := {EV_GTK_EXTERNALS}.gtk_selection_convert (
				clipboard_widget,
				{EV_GTK_EXTERNALS}.gdk_atom_intern (a_cs1.item, 1),
				{EV_GTK_EXTERNALS}.gdk_atom_intern (a_cs2.item, 1),
				0
			)
			edit_chars := {EV_GTK_EXTERNALS}.gtk_editable_get_chars (clipboard_widget, 0, -1)
			create Result.make_from_c (edit_chars)
			{EV_GTK_EXTERNALS}.g_free (edit_chars)
		end

	has_text: BOOLEAN is
			-- Does clipboard contain text?
		do
			Result := not text.is_empty
		end

feature -- Status Setting

	set_text (a_text: STRING) is
			-- Assign `a_text' to clipboard.
		local
			clip_text: STRING
			a_cs: EV_GTK_C_STRING
		do
			if a_text /= Void then
				clip_text := a_text
			else
				clip_text := ""
			end
			a_cs := clip_text
			{EV_GTK_EXTERNALS}.gtk_editable_delete_text (clipboard_widget, 0, -1)
			gtk_text_insert (clipboard_widget, NULL, NULL, NULL, a_cs.item, -1)
			{EV_GTK_EXTERNALS}.gtk_editable_select_region (clipboard_widget, 0, -1)
			{EV_GTK_EXTERNALS}.gtk_editable_copy_clipboard (clipboard_widget)
		end
		
feature {NONE} -- Externals

	gtk_text_new (a_hadj: POINTER; a_vadj: POINTER): POINTER is
                        -- GtkWidget* gtk_text_new             (GtkAdjustment *hadj,
                        --                                   GtkAdjustment *vadj);
		external
			"C (GtkAdjustment*, GtkAdjustment*): GtkWidget* | <gtk/gtk.h>"
		end
		
	gtk_text_insert (a_text: POINTER; a_font: POINTER; a_fore: POINTER; a_back: POINTER; a_chars: POINTER; a_length: INTEGER) is
			-- void       gtk_text_insert          (GtkText       *text,
			-- 				     GdkFont       *font,
			-- 				     GdkColor      *fore,
			-- 				     GdkColor      *back,
			-- 				     const char    *chars,
			-- 				     gint           length);
		external
			"C (GtkText*, GdkFont*, GdkColor*, GdkColor*, char*, gint) | <gtk/gtk.h>"
		end

feature {EV_ANY_I}

	interface: EV_CLIPBOARD;
		-- Interface of `Current'

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




end -- class EV_CLIPBOARD_IMP

