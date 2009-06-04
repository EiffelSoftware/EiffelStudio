note
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

feature -- Access

	font: EV_FONT
			-- Character appearance for `Current'.
		local
			l_private_font: like private_font
		do
			l_private_font := private_font
			if l_private_font = void then
				create Result
				-- Default create is standard gtk font
			else
				Result := l_private_font.twin
			end
		end

feature -- Status setting

	set_font (a_font: EV_FONT)
			-- Assign `a_font' to `font'.
		local
			font_imp: detachable EV_FONT_IMP
			l_private_font: detachable EV_FONT
		do
			if private_font /= a_font then
				l_private_font := a_font.twin
				private_font := l_private_font
				font_imp ?= l_private_font.implementation
				check font_imp /= Void end

				if font_imp.font_is_default then
						-- If we are setting with the default font then we set to NULL so that its size is controlled by the user
					{EV_GTK_DEPENDENT_EXTERNALS}.gtk_widget_modify_font (fontable_widget, default_pointer)
				else
					{EV_GTK_DEPENDENT_EXTERNALS}.gtk_widget_modify_font (fontable_widget, font_imp.font_description)
				end
			end
		end

feature {NONE} -- Implementation

	visual_widget: POINTER
		deferred
		end

	fontable_widget: POINTER
			-- Pointer to the widget that is fontable.
		do
			Result := visual_widget
		end

	private_font: detachable EV_FONT

	interface: detachable EV_FONTABLE note option: stable attribute end;

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




end -- class EV_FONTABLE_IMP





