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
			needs_event_box
		end

	EV_TEXTABLE_IMP
		redefine
			interface,
			set_text
		end

	EV_FONTABLE_IMP
		redefine
			interface,
			set_font
		end

create
	make

feature {NONE} -- Initialization

	needs_event_box: BOOLEAN is True

	make (an_interface: like interface) is
			-- Create a gtk label.
		do
			base_make (an_interface)
			textable_imp_initialize
			set_c_object (text_label)
			feature {EV_GTK_DEPENDENT_EXTERNALS}.gtk_event_box_set_visible_window (c_object, False)
			align_text_center
		end

	set_font (a_font: EV_FONT) is
			-- Assign `a_font' to `font'.
		do
			Precursor {EV_FONTABLE_IMP} (a_font)
			update_minimum_size
		end

	set_text (a_text: STRING) is
			-- Assign `a_text' to `text'.
		do
			Precursor {EV_TEXTABLE_IMP} (a_text)
			update_minimum_size
		end

	update_minimum_size is
			-- 
		local
			a_string_size: TUPLE [INTEGER, INTEGER]
		do
			if private_font /= Void then
				a_string_size := private_font.string_size (text)
				feature {EV_GTK_DEPENDENT_EXTERNALS}.gtk_widget_set_minimum_size (
					text_label,
					a_string_size.integer_32_item (1)
					- a_string_size.integer_32_item (3)
					+ a_string_size.integer_32_item (4)
					, a_string_size.integer_32_item (2)
				)
			end
		end

feature {EV_ANY_I} -- Implementation

	interface: EV_LABEL

end --class LABEL_IMP

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

