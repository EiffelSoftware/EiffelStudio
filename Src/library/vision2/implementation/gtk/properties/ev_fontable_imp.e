indexing
	description: "EiffelVision fontable, gtk implementation.";
	status: "See notice at end of class";
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
			a_style := feature {EV_GTK_EXTERNALS}.gtk_style_copy (feature {EV_GTK_EXTERNALS}.gtk_widget_struct_style (fontable_widget))
			font_ptr := feature {EV_GTK_EXTERNALS}.gdk_font_ref (font_imp.c_object)
			font_imp.set_font_object (font_ptr)
			feature {EV_GTK_EXTERNALS}.gtk_style_set_font (a_style, font_ptr)
			feature {EV_GTK_EXTERNALS}.gtk_widget_set_style (fontable_widget, a_style)
			feature {EV_GTK_EXTERNALS}.gtk_style_unref (a_style)
		end

feature {NONE} -- Implementation

	fontable_widget: POINTER is
			-- Pointer to the widget that is fontable.
		do
			Result := visual_widget
		end

	private_font: EV_FONT

	interface: EV_FONTABLE

end -- class EV_FONTABLE_IMP

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

