indexing
	description:
		"Eiffel Vision frame. GTK+ implementation"
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
			make
		redefine
			interface,
			needs_event_box
		end
		
	EV_FONTABLE_IMP
		redefine
			interface
		end

create
	make

feature {NONE} -- Initialization

	needs_event_box: BOOLEAN is True

	make (an_interface: like interface) is
			-- Create frame.
		do
			base_make (an_interface)
			set_c_object ({EV_GTK_EXTERNALS}.gtk_frame_new (NULL))
			{EV_GTK_EXTERNALS}.gtk_frame_set_label (container_widget, NULL)
			internal_alignment_code := {EV_GTK_EXTERNALS}.gtk_justify_left_enum
		end

feature -- Access

	style: INTEGER is
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

	set_style (a_style: INTEGER) is
			-- Assign `a_style' to `style'.
		local
			gtk_style: INTEGER
			border_width: INTEGER
		do
			inspect a_style
				when Ev_frame_lowered then
					gtk_style := {EV_GTK_EXTERNALS}.gtk_shadow_in_enum
					border_width := 1
				when Ev_frame_raised then
					gtk_style := {EV_GTK_EXTERNALS}.gtk_shadow_out_enum
					border_width := 1
				when Ev_frame_etched_in then
					gtk_style := {EV_GTK_EXTERNALS}.gtk_shadow_etched_in_enum
					border_width := 2
				when Ev_frame_etched_out then
					gtk_style := {EV_GTK_EXTERNALS}.gtk_shadow_etched_out_enum
					border_width := 2
			else
				check
					valid_value: False
				end
			end
			--| FIXME incorporate border_width.
			--| NB This is not gtk_container_set_border_width!
			--| Maybe we have to draw the frame ourselves.
			{EV_GTK_EXTERNALS}.gtk_frame_set_shadow_type (container_widget, gtk_style)
		end

feature -- Status setting

	align_text_left is
			-- Display `text' left aligned.
		do
			{EV_GTK_EXTERNALS}.gtk_frame_set_label_align (container_widget, 0, 0)
			internal_alignment_code := {EV_GTK_EXTERNALS}.gtk_justify_left_enum
		end

	align_text_right is
			-- Display `text' right aligned.
		do
			{EV_GTK_EXTERNALS}.gtk_frame_set_label_align (container_widget, 1, 0)
			internal_alignment_code := {EV_GTK_EXTERNALS}.gtk_justify_right_enum
		end
        
	align_text_center is
			-- Display `text' centered.
		do
			{EV_GTK_EXTERNALS}.gtk_frame_set_label_align (container_widget, 0.5, 0)
			internal_alignment_code := {EV_GTK_EXTERNALS}.gtk_justify_center_enum
		end

feature -- Access

	text_alignment: INTEGER is
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

	text: STRING is
			-- Text of the frame
		do
			if internal_text = Void then
				internal_text := ""
			end
			Result := internal_text.twin
		end

feature -- Element change

	set_text (a_text: STRING) is
			-- set the `text' of the frame
		local
			a_cs: EV_GTK_C_STRING
		do
			internal_text := a_text.twin
			a_cs := a_text
			{EV_GTK_EXTERNALS}.gtk_frame_set_label (container_widget, a_cs.item)
		end

feature {NONE} -- Implementation

	internal_text: STRING
		-- Text used to represent frame's label text

	internal_alignment_code: INTEGER
		-- Code used to represent label alignment

feature {EV_ANY_I} -- Implementation

	interface: EV_FRAME
			-- Provides a common user interface to possibly platform
			-- dependent functionality implemented by `Current'

end -- class EV_FRAME_IMP

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

