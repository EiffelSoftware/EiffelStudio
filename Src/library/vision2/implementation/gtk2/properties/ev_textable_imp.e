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
		do
			if real_text /= Void then
				Result := real_text.twin
			else
				Result := ""
			end
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
			real_text := a_text.twin
			if accelerators_enabled then
				create a_cs.make (u_lined_filter (a_text))
				{EV_GTK_DEPENDENT_EXTERNALS}.gtk_label_set_text_with_mnemonic (text_label, a_cs.item)
			else
				create a_cs.make (a_text)
				{EV_GTK_EXTERNALS}.gtk_label_set_text (text_label, a_cs.item)
			end
		end
	
feature {EV_ANY_IMP} -- Implementation
	
	text_label: POINTER
			-- GtkLabel containing `text'.

	accelerators_enabled: BOOLEAN is
			-- Does `Current' have keyboard accelerators enabled?
		do
			Result := False
		end

	real_text: STRING
			-- Internal `text'. (with ampersands)

	filter_ampersand (s: STRING; char: CHARACTER) is
			-- Replace occurrences of '&' from `s'  by `char' and
			-- replace occurrences of "&&" with '&'.
		require
			s_not_void: s /= Void
			s_has_at_least_one_ampersand: s.occurrences ('&') > 0
		local
			i: INTEGER
		do
			from
				i := 1
			until
				i > s.count
			loop
				if s.item (i) = '&' then
					if s.item (i + 1) /= '&' then
						s.put (char, i)
					else
						i := i + 1
					end
				end					
				i := i + 1
			end
			s.replace_substring_all ("&&", "&")
		end

	u_lined_filter (s: STRING): STRING is
			-- Copy of `s' with underscores instead of ampersands.
			-- (If `s' does not contain ampersands, return `s'.)
		require
			s_not_void: s /= Void
		do
			Result := s.twin
			Result.replace_substring_all ("_", "__")
			if s.has ('&') then
				filter_ampersand (Result, '_')
			end
		end

feature {EV_ANY_I} -- Implementation

	interface: EV_TEXTABLE

invariant
	text_label_not_void: is_usable implies text_label /= NULL

end -- class EV_TEXTABLE_IMP

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

