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
			create a_cs.make ("")
			text_label := feature {EV_GTK_EXTERNALS}.gtk_label_new (a_cs.item)
			feature {EV_GTK_EXTERNALS}.gtk_widget_show (text_label)
			feature {EV_GTK_EXTERNALS}.gtk_misc_set_alignment (text_label, 0.0, 0.5)
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
			a_cs: EV_GTK_C_STRING
		do
			real_text := a_text.twin
			if accelerators_enabled then
				create a_cs.make (u_lined_filter (a_text))
				feature {EV_GTK_DEPENDENT_EXTERNALS}.gtk_label_set_text_with_mnemonic (text_label, a_cs.item)
			else
				create a_cs.make (a_text)
				feature {EV_GTK_EXTERNALS}.gtk_label_set_text (text_label, a_cs.item)
			end			
			feature {EV_GTK_EXTERNALS}.gtk_widget_show (text_label)
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
				Result := s.twin
				filter_ampersand (Result, '_')
			else
				Result := s
			end
		ensure
			copied_only_if_s_had_ampersand:
				((old s.twin).has ('&')) = (s /= Result)
			s_not_changed: (old s.twin).is_equal (s) 
		end

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

