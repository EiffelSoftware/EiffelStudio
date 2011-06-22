note
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

feature {NONE} -- Initialization

	textable_imp_initialize
			-- Create a GtkLabel to display the text.
		do
			text_label := {GTK}.gtk_label_new (default_pointer)
			{GTK}.gtk_widget_show (text_label)
			{GTK}.gtk_misc_set_alignment (text_label, {REAL_32} 0.0, {REAL_32} 0.5)
			{GTK}.gtk_misc_set_padding (text_label, 2, 0)
		end

feature -- Access

	text: STRING_32
			-- Text of the label.
		local
			a_str: POINTER
		do
			if attached real_text as l_real_text then
				Result := l_real_text.string
			else
				a_str :={GTK2}.gtk_label_get_label (text_label)
				if a_str /= default_pointer then
					Result := (create{EV_GTK_C_STRING}.share_from_pointer (a_str)).string
				else
					Result := ""
				end
			end
		end

	text_alignment: INTEGER
			-- Alignment of the text in the label.
		local
			an_alignment_code: INTEGER
		do
			an_alignment_code := {GTK}.gtk_label_struct_jtype (text_label)
			if an_alignment_code = {GTK}.gtk_justify_center_enum then
				Result := {EV_TEXT_ALIGNMENT_CONSTANTS}.Ev_text_alignment_center
			elseif an_alignment_code = {GTK}.gtk_justify_left_enum then
				Result := {EV_TEXT_ALIGNMENT_CONSTANTS}.Ev_text_alignment_left
			elseif an_alignment_code = {GTK}.gtk_justify_right_enum then
				Result := {EV_TEXT_ALIGNMENT_CONSTANTS}.Ev_text_alignment_right
			else
				check alignment_code_not_set: False end
			end
		end

feature -- Status setting

	align_text_center
			-- Display `text' centered.
		do
			{GTK}.gtk_misc_set_alignment (text_label, {REAL_32} 0.5, {REAL_32} 0.5)
			{GTK}.gtk_label_set_justify (text_label, {GTK}.gtk_justify_center_enum)
		end

	align_text_left
			-- Display `text' left aligned.
		do
			{GTK}.gtk_misc_set_alignment (text_label, {REAL_32} 0.0, {REAL_32} 0.5)
			{GTK}.gtk_label_set_justify (text_label, {GTK}.gtk_justify_left_enum)
		end

	align_text_right
			-- Display `text' right aligned.
		do
			{GTK}.gtk_misc_set_alignment (text_label, {REAL_32} 1.0, {REAL_32} 0.5)
			{GTK}.gtk_label_set_justify (text_label, {GTK}.gtk_justify_right_enum)
		end

feature -- Element change	

	set_text (a_text: READABLE_STRING_GENERAL)
			-- Assign `a_text' to `text'.
		local
			a_cs: EV_GTK_C_STRING
		do
			if accelerators_enabled then
				real_text := a_text
				a_cs := App_implementation.c_string_from_eiffel_string (u_lined_filter (a_text))
				{GTK2}.gtk_label_set_text_with_mnemonic (text_label, a_cs.item)
			else
				a_cs := App_implementation.c_string_from_eiffel_string (a_text)
				real_text := Void
				{GTK}.gtk_label_set_text (text_label, a_cs.item)
			end
		end

feature {EV_ANY_IMP} -- Implementation

	app_implementation: EV_APPLICATION_IMP
		deferred
		end

	text_label: POINTER
			-- GtkLabel containing `text'.

	accelerators_enabled: BOOLEAN
			-- Does `Current' have keyboard accelerators enabled?
		do
			Result := False
		end

	real_text: detachable EV_GTK_C_STRING
			-- Internal `text'. (with ampersands)

	filter_ampersand (s: STRING_32; char: CHARACTER)
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
			s.replace_substring_all (once "&&", once "&")
		end

	u_lined_filter (s: READABLE_STRING_GENERAL): STRING_32
			-- Copy of `s' with underscores instead of ampersands.
			-- (If `s' does not contain ampersands, return `s'.)
		require
			s_not_void: s /= Void
		do
			Result := s.as_string_32.twin
			Result.replace_substring_all (once  "_", once  "__")
			if s.has_code (('&').natural_32_code) then
				filter_ampersand (Result, '_')
			end
		end

feature {EV_ANY, EV_ANY_I} -- Implementation

	interface: detachable EV_TEXTABLE note option: stable attribute end;

invariant
	text_label_not_void: is_usable implies text_label /= default_pointer

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

end -- class EV_TEXTABLE_IMP
