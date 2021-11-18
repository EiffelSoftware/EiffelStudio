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
			{GTK}.gtk_label_set_xalign(text_label, {REAL_32} 0.0)
			{GTK}.gtk_label_set_yalign(text_label, {REAL_32} 0.5)
			{GTK3}.gtk_widget_set_margin_start (text_label, 2)
			{GTK3}.gtk_widget_set_margin_end (text_label, 2)
			--{GTK3}.gtk_widget_set_halign (text_label, {GTK}.gtk_justify_left_enum)
		end

feature -- Access

	text: STRING_32
			-- Text of the label.
		local
			a_str: POINTER
		do
			if attached real_text as l_real_text then
				Result := l_real_text.as_string_32.twin
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
			an_alignment_code := {GTK}.gtk_label_get_justify (text_label)
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
			{GTK}.gtk_label_set_xalign(text_label, {REAL_32} 0.5)
			{GTK}.gtk_label_set_yalign(text_label, {REAL_32} 0.5)
			{GTK}.gtk_label_set_justify (text_label, {GTK}.gtk_justify_center_enum)
		end

	align_text_left
			-- Display `text' left aligned.
		do
			{GTK}.gtk_label_set_xalign(text_label, {REAL_32} 0.0)
			{GTK}.gtk_label_set_yalign(text_label, {REAL_32} 0.5)
			{GTK}.gtk_label_set_justify (text_label, {GTK}.gtk_justify_left_enum)
		end

	align_text_right
			-- Display `text' right aligned.
		do
			{GTK}.gtk_label_set_xalign(text_label, {REAL_32} 1.0)
			{GTK}.gtk_label_set_yalign(text_label, {REAL_32} 0.5)
			{GTK}.gtk_label_set_justify (text_label, {GTK}.gtk_justify_right_enum)
		end

feature -- Element change	

	set_text (a_text: READABLE_STRING_GENERAL)
			-- Assign `a_text' to `text'.
		local
			a_cs: EV_GTK_C_STRING
			l_txt: STRING_32
		do
			if accelerators_enabled then
					-- Make a STRING_32 version of `a_text'. If input
					-- is already a STRING_32, we make a copy of it.
				l_txt := a_text.as_string_32
				if l_txt = a_text then
					real_text := l_txt.twin
				else
					real_text := l_txt
				end
				a_cs := App_implementation.c_string_from_eiffel_string (u_lined_filter (a_text))
				{GTK2}.gtk_label_set_text_with_mnemonic (text_label, a_cs.item)
			else
				a_cs := App_implementation.c_string_from_eiffel_string (a_text)
				real_text := Void
				{GTK}.gtk_label_set_text (text_label, a_cs.item)
			end
				-- Hide label if there is no text to display so it doesn't interfere with sizing calculations as happens to be the case with pixmap only buttons.
			if a_cs.string_length = 0 then
				{GTK}.gtk_widget_hide (text_label)
			else
				{GTK}.gtk_widget_show (text_label)
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

	real_text: detachable STRING_32
			-- Internal `text'. (with ampersands)

	u_lined_filter (s: READABLE_STRING_GENERAL): STRING_32
			-- Adapt `s' to the GTK conventions for shortcuts, that is to say:
			-- 1 - Replace && with &
			-- 2 - Replace & with _
			-- 3 - Replace _ with __
		require
			s_not_void: s /= Void
		local
			i: INTEGER
			c: CHARACTER_32
		do
			Result := s.as_string_32
			from
				i := Result.count
			until
				i = 0
			loop
				c := Result.item (i)
				if c = '&' then
					if Result = s then
							-- Duplicate string since we are modifying it.
						Result := Result.twin
					end

					if i > 1 then
						c := Result.item (i - 1)
						if c = '&' then
								-- Two ampersand in a row, we replace it by just one.
							Result.remove (i)
							i := i - 1
						else
								-- Replace & with _.
							Result.put ('_', i)
						end
					else
							-- First charater of the string is &, we replace it by _.
						Result.put ('_', i)
					end
				elseif c = '_' then
					if Result = s then
							-- Duplicate string since we are modifying it.
						Result := Result.twin
					end
						-- We escape the _ with two _.
					Result.insert_character ('_', i)

				end
				i := i - 1
			end
		end

feature {EV_ANY, EV_ANY_I} -- Implementation

	interface: detachable EV_TEXTABLE note option: stable attribute end;

invariant
	text_label_not_void: is_usable implies text_label /= default_pointer

note
	copyright:	"Copyright (c) 1984-2021, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end -- class EV_TEXTABLE_IMP
