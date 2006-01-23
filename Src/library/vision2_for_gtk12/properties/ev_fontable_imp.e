indexing
	description: "EiffelVision fontable, gtk implementation."
	legal: "See notice at end of class.";
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"
	
deferred class
	EV_FONTABLE_IMP
	
inherit
	EV_FONTABLE_I
		redefine
			interface
		end

	EV_ANY_IMP
		undefine
			needs_event_box,
			destroy
		redefine
			interface
		end
	
feature -- Access

	font: EV_FONT is
			-- Character appearance for `Current'.
		do
			if private_font = void then
				create Result
				-- Default create is standard gtk font
			else
				Result := private_font.twin
			end
		end

feature -- Status setting

	set_font (a_font: EV_FONT) is
			-- Assign `a_font' to `font'.
		local
			a_style: POINTER
			font_imp: EV_FONT_IMP
			font_ptr: POINTER
		do
			private_font := a_font.twin
			font_imp ?= private_font.implementation
			a_style := {EV_GTK_EXTERNALS}.gtk_style_copy ({EV_GTK_EXTERNALS}.gtk_widget_struct_style (fontable_widget))
			font_ptr := {EV_GTK_EXTERNALS}.gdk_font_ref (font_imp.c_object)
			font_imp.set_font_object (font_ptr)
			{EV_GTK_EXTERNALS}.gtk_style_set_font (a_style, font_ptr)
			{EV_GTK_EXTERNALS}.gtk_widget_set_style (fontable_widget, a_style)
			{EV_GTK_EXTERNALS}.gtk_style_unref (a_style)
		end

feature {NONE} -- Implementation

	fontable_widget: POINTER is
			-- Pointer to the widget that is fontable.
		do
			Result := visual_widget
		end

	private_font: EV_FONT

	interface: EV_FONTABLE;

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




end -- class EV_FONTABLE_IMP

