indexing
	description: 
		"Eiffel Vision textable. GTK+ implementation."
	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"
	
deferred class
	EV_TEXTABLE_IMP
	
inherit
	EV_TEXTABLE_I
		redefine
			interface
		end

	EV_ANY_IMP
		redefine
			interface
		end
	
feature {NONE} -- Initialization
	
	textable_imp_initialize is
			-- Create a GtkLabel to display the text.
		local
			a_cs: C_STRING
		do
			create a_cs.make ("")
			text_label := feature {EV_GTK_EXTERNALS}.gtk_label_new (a_cs.item)
			feature {EV_GTK_EXTERNALS}.gtk_widget_show (text_label)
			feature {EV_GTK_EXTERNALS}.gtk_misc_set_alignment (text_label, 0.0, 0.5)
		end

feature -- Access

	text: STRING is
			-- Text of the label
		local
			p: POINTER
		do
			feature {EV_GTK_EXTERNALS}.gtk_label_get (text_label, $p)
			check
				p_not_null: p /= NULL
			end
			create Result.make_from_c (p)
		end

	text_alignment: INTEGER is
			-- Alignment of the text in the label.
		local
			an_alignment_code: INTEGER
		do
			an_alignment_code := feature {EV_GTK_EXTERNALS}.gtk_label_struct_jtype (text_label)
			if an_alignment_code = feature {EV_GTK_EXTERNALS}.gtk_justify_center_enum then
				Result := feature {EV_TEXT_ALIGNMENT_CONSTANTS}.Ev_text_alignment_center
			elseif an_alignment_code = feature {EV_GTK_EXTERNALS}.gtk_justify_left_enum then
				Result := feature {EV_TEXT_ALIGNMENT_CONSTANTS}.Ev_text_alignment_left
			elseif an_alignment_code = feature {EV_GTK_EXTERNALS}.gtk_justify_right_enum then
				Result := feature {EV_TEXT_ALIGNMENT_CONSTANTS}.Ev_text_alignment_right
			else
				check alignment_code_not_set: False end
			end
		end
	
feature -- Status setting

	align_text_center is
			-- Display `text' centered.
		do
			feature {EV_GTK_EXTERNALS}.gtk_misc_set_alignment (text_label, 0.5, 0.5)
			feature {EV_GTK_EXTERNALS}.gtk_label_set_justify (text_label, feature {EV_GTK_EXTERNALS}.gtk_justify_center_enum)
		end

	align_text_left is
			-- Display `text' left aligned.
		do
			feature {EV_GTK_EXTERNALS}.gtk_misc_set_alignment (text_label, 0, 0.5)
			feature {EV_GTK_EXTERNALS}.gtk_label_set_justify (text_label, feature {EV_GTK_EXTERNALS}.gtk_justify_left_enum)
		end

	align_text_right is
			-- Display `text' right aligned.
		do
			feature {EV_GTK_EXTERNALS}.gtk_misc_set_alignment (text_label, 1, 0.5)
			feature {EV_GTK_EXTERNALS}.gtk_label_set_justify (text_label, feature {EV_GTK_EXTERNALS}.gtk_justify_right_enum)
		end
	
feature -- Element change	
	
	set_text (a_text: STRING) is
			-- Assign `a_text' to `text'.
		local
			a_cs: C_STRING
		do
			create a_cs.make (a_text)
			feature {EV_GTK_EXTERNALS}.gtk_label_set_text (text_label, a_cs.item)
			feature {EV_GTK_EXTERNALS}.gtk_widget_show (text_label)
		end
	
feature {EV_ANY_IMP} -- Implementation
	
	text_label: POINTER
			-- GtkLabel containing `text'.

feature {EV_ANY_I} -- Implementation

	interface: EV_TEXTABLE

invariant
	text_label_not_void: is_usable implies text_label /= NULL

end -- class EV_TEXTABLE_IMP

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

