indexing

	description: 
		"EiffelVision label, gtk implementation."
	status: "See notice at end of class"
	id: "$Id$"
	date: "$Date$"
	revision: "$Revision$"
	
class
	EV_LABEL_IMP
	
inherit
	EV_LABEL_I
		redefine
			interface
		end

	EV_PRIMITIVE_IMP
		redefine
			interface,
			set_foreground_color,
			foreground_color_pointer
		end

	EV_TEXTABLE_IMP
		redefine
			interface
		end

	EV_FONTABLE_IMP
		redefine
			interface,
			fontable_widget
		end

create
	make

feature {NONE} -- Initialization

	make (an_interface: like interface) is
			-- Create a gtk label.
		do
			base_make (an_interface)
			set_c_object (feature {EV_GTK_EXTERNALS}.gtk_event_box_new)
			textable_imp_initialize
			feature {EV_GTK_EXTERNALS}.gtk_container_add (c_object, text_label)
			align_text_center
		end

feature {NONE} -- Implementation

	fontable_widget: POINTER is
			-- Pointer to `text_label'
		do
			Result := text_label
		end

	foreground_color_pointer: POINTER is
			-- Color of foreground features like text.
		do
			Result := feature {EV_GTK_EXTERNALS}.gtk_style_struct_fg (
				feature {EV_GTK_EXTERNALS}.gtk_widget_struct_style (text_label)
			)
		end

feature {EV_ANY_I} -- Implementation

	set_foreground_color (a_color: EV_COLOR) is
			-- Assign `a_color' to `foreground_color'
		do
			real_set_foreground_color (text_label, a_color)
		end

	interface: EV_LABEL

end --class LABEL_IMP

--|----------------------------------------------------------------
--| EiffelVision2: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-2001 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building
--| 360 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support: http://support.eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

