note
	description:
		"Eiffel Vision frame. GTK+ implementation"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_FRAME_IMP

inherit
	EV_FRAME_I
		undefine
			propagate_foreground_color,
			propagate_background_color
		redefine
			interface
		end

	EV_CELL_IMP
		undefine
			old_make
		redefine
			interface,
			needs_event_box,
			make
		end

	EV_FONTABLE_IMP
		redefine
			interface,
			make
		end

create
	make

feature {NONE} -- Initialization

	needs_event_box: BOOLEAN
			-- Does `a_widget' need an event box?
		do
			Result := True
		end

	old_make (an_interface: like interface)
			-- Create frame.
		do
			assign_interface (an_interface)
		end

	make
			-- Initialize `Current'.
		do
			set_c_object ({EV_GTK_EXTERNALS}.gtk_frame_new (NULL))
			{EV_GTK_EXTERNALS}.gtk_frame_set_label (container_widget, NULL)
			set_style (Ev_frame_etched_in)
			align_text_left
			Precursor {EV_CELL_IMP}
		end

feature -- Access

	style: INTEGER
			-- Visual appearance. See: EV_FRAME_CONSTANTS.
		local
			gtk_style: INTEGER
		do
			gtk_style := {EV_GTK_EXTERNALS}.gtk_frame_struct_shadow_type (container_widget)
			if gtk_style = {EV_GTK_EXTERNALS}.gtk_shadow_in_enum then
				Result := Ev_frame_lowered
			elseif gtk_style = {EV_GTK_EXTERNALS}.gtk_shadow_out_enum then
				Result := Ev_frame_raised
			elseif gtk_style = {EV_GTK_EXTERNALS}.gtk_shadow_etched_in_enum then
				Result := Ev_frame_etched_in
			elseif gtk_style = {EV_GTK_EXTERNALS}.gtk_shadow_etched_out_enum then
				Result := Ev_frame_etched_out
			else
				check
					valid_value: False
				end
			end
		end

feature -- Element change

	set_style (a_style: INTEGER)
			-- Assign `a_style' to `style'.
		local
			gtk_style: INTEGER
		do
			inspect a_style
				when Ev_frame_lowered then
					gtk_style := {EV_GTK_EXTERNALS}.gtk_shadow_in_enum
				when Ev_frame_raised then
					gtk_style := {EV_GTK_EXTERNALS}.gtk_shadow_out_enum
				when Ev_frame_etched_in then
					gtk_style := {EV_GTK_EXTERNALS}.gtk_shadow_etched_in_enum
				when Ev_frame_etched_out then
					gtk_style := {EV_GTK_EXTERNALS}.gtk_shadow_etched_out_enum
			else
				check
					valid_value: False
				end
			end
			{EV_GTK_EXTERNALS}.gtk_frame_set_shadow_type (container_widget, gtk_style)
		end

feature -- Status setting

	align_text_left
			-- Display `text' left aligned.
		do
			{EV_GTK_EXTERNALS}.gtk_frame_set_label_align (container_widget, 0, 0.5)
			internal_alignment_code := {EV_GTK_EXTERNALS}.gtk_justify_left_enum
		end

	align_text_right
			-- Display `text' right aligned.
		do
			{EV_GTK_EXTERNALS}.gtk_frame_set_label_align (container_widget, 1, 0.5)
			internal_alignment_code := {EV_GTK_EXTERNALS}.gtk_justify_right_enum
		end

	align_text_center
			-- Display `text' centered.
		do
			{EV_GTK_EXTERNALS}.gtk_frame_set_label_align (container_widget, 0.5, 0.5)
			internal_alignment_code := {EV_GTK_EXTERNALS}.gtk_justify_center_enum
		end

feature -- Access

	text_alignment: INTEGER
			-- Alignment of the text in the label.
		do
			if internal_alignment_code = {EV_GTK_EXTERNALS}.gtk_justify_center_enum then
				Result := {EV_TEXT_ALIGNMENT_CONSTANTS}.Ev_text_alignment_center
			elseif internal_alignment_code = {EV_GTK_EXTERNALS}.gtk_justify_left_enum then
				Result := {EV_TEXT_ALIGNMENT_CONSTANTS}.Ev_text_alignment_left
			elseif internal_alignment_code = {EV_GTK_EXTERNALS}.gtk_justify_right_enum then
				Result := {EV_TEXT_ALIGNMENT_CONSTANTS}.Ev_text_alignment_right
			else
				check alignment_code_not_set: False end
			end
		end

	text: STRING_32
			-- Text of the frame
		do
			if attached internal_text as l_internal_text then
				Result := l_internal_text.twin
			else
				Result := ""
				internal_text := Result
			end
		end

feature -- Element change

	set_text (a_text: STRING_GENERAL)
			-- set the `text' of the frame
		local
			a_cs: EV_GTK_C_STRING
		do
			internal_text := a_text.twin
			a_cs := a_text
			{EV_GTK_EXTERNALS}.gtk_frame_set_label (container_widget, a_cs.item)
		end

feature {NONE} -- Implementation

	internal_text: detachable STRING_32
		-- Text used to represent frame's label text

	internal_alignment_code: INTEGER
		-- Code used to represent label alignment

feature {EV_ANY_I} -- Implementation

	interface: detachable EV_FRAME note option: stable attribute end;
			-- Provides a common user interface to possibly platform
			-- dependent functionality implemented by `Current'

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




end -- class EV_FRAME_IMP





