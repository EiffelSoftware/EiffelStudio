note
	description:
		"Eiffel Vision textable. Carbon implementation."
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
			destroy
		redefine
			interface
		end

	HIVIEW_FUNCTIONS_EXTERNAL
		export
			{NONE} all
		end

	CONTROLS_FUNCTIONS_EXTERNAL
		export
			{NONE} all
		end

feature {NONE} -- Initialization


feature -- Access

	text: STRING_32
			-- Text of the label.
		do
			if real_text /= Void then
				Result := real_text.string
			else
				create Result.make_empty
			end
		end

	text_alignment: INTEGER
			-- Alignment of the text in the label.
		do
			Result := is_aligned
		--	an_alignment_code := {EV_GTK_EXTERNALS}.gtk_label_struct_jtype (text_label)
		--	if an_alignment_code = {EV_GTK_EXTERNALS}.gtk_justify_center_enum then
		--		Result := {EV_TEXT_ALIGNMENT_CONSTANTS}.Ev_text_alignment_center
		--	elseif an_alignment_code = {EV_GTK_EXTERNALS}.gtk_justify_left_enum then
		--		Result := {EV_TEXT_ALIGNMENT_CONSTANTS}.Ev_text_alignment_left
		--	elseif an_alignment_code = {EV_GTK_EXTERNALS}.gtk_justify_right_enum then
		--		Result := {EV_TEXT_ALIGNMENT_CONSTANTS}.Ev_text_alignment_right
		--	else
		--		check alignment_code_not_set: False end
		--	end
		end

feature -- Status setting

	align_text_center
			-- Display `text' centered.
		local
			ret: INTEGER
			cfs: CONTROL_FONT_STYLE_REC_STRUCT
		do
			create cfs.make_new_unshared
			cfs.set_flags (64)
			cfs.set_just (1)
			ret := set_control_font_style_external (c_object, cfs.item)
			is_aligned := {EV_TEXT_ALIGNMENT_CONSTANTS}.ev_text_alignment_center
			ret := hiview_set_needs_display_external (c_object, 1)
		end

	align_text_left
			-- Display `text' left aligned.
		local
			ret: INTEGER
			cfs: CONTROL_FONT_STYLE_REC_STRUCT
		do
			create cfs.make_new_unshared
			cfs.set_flags (64)
			cfs.set_just (-2)
			ret := set_control_font_style_external (c_object, cfs.item)
			is_aligned := {EV_TEXT_ALIGNMENT_CONSTANTS}.ev_text_alignment_center
			ret := hiview_set_needs_display_external (c_object, 1)
		end

	align_text_right
			-- Display `text' right aligned.
				local
			ret: INTEGER
			cfs: CONTROL_FONT_STYLE_REC_STRUCT
		do
			create cfs.make_new_unshared
			cfs.set_flags (64)
			cfs.set_just (-1)
			ret := set_control_font_style_external (c_object, cfs.item)
			is_aligned := {EV_TEXT_ALIGNMENT_CONSTANTS}.ev_text_alignment_center
			ret := hiview_set_needs_display_external (c_object, 1)
		end

feature -- Element change	

	set_text (a_text: STRING_GENERAL)
			-- Assign `a_text' to `text'.
		local
			ret: INTEGER
		do
			if accelerators_enabled then
				create real_text.make_unshared_with_eiffel_string (u_lined_filter (a_text))
			else
				create real_text.make_unshared_with_eiffel_string (a_text)
			end
			ret := hiview_set_text_external (c_object, real_text.item)
		end

feature {EV_ANY_IMP} -- Implementation

	text_label: POINTER
			-- GtkLabel containing `text'.

	accelerators_enabled: BOOLEAN
			-- Does `Current' have keyboard accelerators enabled?
		do
			Result := False
		end

	real_text: EV_CARBON_CF_STRING
			-- Internal `text'. (with ampersands)

	is_aligned: INTEGER --the alignement

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

	u_lined_filter (s: STRING_GENERAL): STRING_32
			-- Copy of `s' with underscores instead of ampersands.
			-- (If `s' does not contain ampersands, return `s'.)
		require
			s_not_void: s /= Void
		do
			Result := s.twin
			Result.replace_substring_all (once  "_", once  "__")
			if s.has_code (('&').natural_32_code) then
				filter_ampersand (Result, '_')
			end
		end

feature {EV_ANY_I} -- Implementation

	interface: EV_TEXTABLE;

note
	copyright:	"Copyright (c) 2006, The Eiffel.Mac Team"
end -- class EV_TEXTABLE_IMP
