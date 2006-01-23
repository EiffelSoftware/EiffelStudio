indexing
	description: 
		"Eiffel Vision textable. GTK+ implementation."
	legal: "See notice at end of class."
	status: "See notice at end of class."
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
		undefine
			needs_event_box,
			destroy
		redefine
			interface
		end
	
feature {NONE} -- Initialization
	
	textable_imp_initialize is
			-- Create a GtkLabel to display the text.
		local
			a_cs: EV_GTK_C_STRING
		do
			a_cs := ""
			text_label := {EV_GTK_EXTERNALS}.gtk_label_new (a_cs.item)
			{EV_GTK_EXTERNALS}.gtk_widget_show (text_label)
			{EV_GTK_EXTERNALS}.gtk_misc_set_alignment (text_label, 0.0, 0.5)
		end

feature -- Access

	text: STRING is
			-- Text of the label
		local
			p: POINTER
		do
			{EV_GTK_EXTERNALS}.gtk_label_get (text_label, $p)
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
			an_alignment_code := {EV_GTK_EXTERNALS}.gtk_label_struct_jtype (text_label)
			if an_alignment_code = {EV_GTK_EXTERNALS}.gtk_justify_center_enum then
				Result := {EV_TEXT_ALIGNMENT_CONSTANTS}.Ev_text_alignment_center
			elseif an_alignment_code = {EV_GTK_EXTERNALS}.gtk_justify_left_enum then
				Result := {EV_TEXT_ALIGNMENT_CONSTANTS}.Ev_text_alignment_left
			elseif an_alignment_code = {EV_GTK_EXTERNALS}.gtk_justify_right_enum then
				Result := {EV_TEXT_ALIGNMENT_CONSTANTS}.Ev_text_alignment_right
			else
				check alignment_code_not_set: False end
			end
		end
	
feature -- Status setting

	align_text_center is
			-- Display `text' centered.
		do
			{EV_GTK_EXTERNALS}.gtk_misc_set_alignment (text_label, 0.5, 0.5)
			{EV_GTK_EXTERNALS}.gtk_label_set_justify (text_label, {EV_GTK_EXTERNALS}.gtk_justify_center_enum)
		end

	align_text_left is
			-- Display `text' left aligned.
		do
			{EV_GTK_EXTERNALS}.gtk_misc_set_alignment (text_label, 0, 0.5)
			{EV_GTK_EXTERNALS}.gtk_label_set_justify (text_label, {EV_GTK_EXTERNALS}.gtk_justify_left_enum)
		end

	align_text_right is
			-- Display `text' right aligned.
		do
			{EV_GTK_EXTERNALS}.gtk_misc_set_alignment (text_label, 1, 0.5)
			{EV_GTK_EXTERNALS}.gtk_label_set_justify (text_label, {EV_GTK_EXTERNALS}.gtk_justify_right_enum)
		end
	
feature -- Element change	
	
	set_text (a_text: STRING) is
			-- Assign `a_text' to `text'.
		local
			a_cs: EV_GTK_C_STRING
		do
			a_cs := a_text
			{EV_GTK_EXTERNALS}.gtk_label_set_text (text_label, a_cs.item)
			{EV_GTK_EXTERNALS}.gtk_widget_show (text_label)
		end
	
feature {EV_ANY_IMP} -- Implementation
	
	text_label: POINTER
			-- GtkLabel containing `text'.

feature {EV_ANY_I} -- Implementation

	interface: EV_TEXTABLE

invariant
	text_label_not_void: is_usable implies text_label /= NULL

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




end -- class EV_TEXTABLE_IMP

