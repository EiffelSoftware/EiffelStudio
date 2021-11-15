note

	description:
		"EiffelVision label, gtk implementation."
	legal: "See notice at end of class."
	status: "See notice at end of class."
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
			needs_event_box,
			make,
			style_element_name
		end

	EV_TEXTABLE_IMP
		redefine
			interface
		end

	EV_FONTABLE_IMP
		redefine
			interface
		end

create
	make

feature {NONE} -- Initialization

	old_make (an_interface: attached like interface)
			-- Create a gtk label.
		do
			assign_interface (an_interface)
		end

	make
			-- Create and initialize label.
		local
			int_value: INTEGER
		do
			textable_imp_initialize
			set_c_object (text_label)
			align_text_center
			int_value := {GTK2}.g_object_get_integer (text_label, {GTK_PROPERTIES}.justify)
			Precursor
			set_is_initialized (True)
		end

feature -- Access

	angle: REAL
		-- Amount text is rotated counter-clockwise from horizontal plane in radians.

	set_angle (a_angle: REAL)
			--
		do
			{GTK2}.gtk_label_set_angle (text_label, a_angle / {REAL_32} 3.14 * {REAL_32} 180.0)
			angle := a_angle
		end

feature -- Status Setting

	align_text_top
			-- Set vertical text alignment of current label to top.
		do
			{GTK}.gtk_label_set_xalign (text_label, 0)
			{GTK}.gtk_label_set_yalign (text_label, 0.5)
		end

	align_text_vertical_center
			-- Set text alignment of current label to be in the center vertically.
		do
			{GTK}.gtk_label_set_xalign (text_label, 0.5)
			{GTK}.gtk_label_set_yalign (text_label, 0.5)
		end

	align_text_bottom
			-- Set vertical text alignment of current label to bottom.
		do
			{GTK}.gtk_label_set_xalign (text_label, 0.5)
			{GTK}.gtk_label_set_yalign (text_label, 0.5)
		end

feature {NONE} -- GTK3 css style

	style_element_name: STRING
			-- CSS style name for Current GTK3 widget.
		do
			Result := "label"
		end

feature {NONE} -- Implementation

	needs_event_box: BOOLEAN = True
			-- Does `a_widget' need an event box?

feature {EV_ANY, EV_ANY_I} -- Implementation

	interface: detachable EV_LABEL note option: stable attribute end;

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

end --class LABEL_IMP
