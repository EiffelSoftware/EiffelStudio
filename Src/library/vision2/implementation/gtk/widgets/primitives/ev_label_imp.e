indexing

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
			needs_event_box
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

	needs_event_box: BOOLEAN is True

	make (an_interface: like interface) is
			-- Create a gtk label.
		local
			a_cs: EV_GTK_C_STRING
			int_value: INTEGER
		do
			base_make (an_interface)
			textable_imp_initialize
			set_c_object (text_label)

			{EV_GTK_DEPENDENT_EXTERNALS}.gtk_event_box_set_visible_window (c_object, False)
			align_text_center

			a_cs := "justify"
			{EV_GTK_EXTERNALS}.g_object_get_integer (text_label, a_cs.item, $int_value)

		end

feature -- Access

	angle: REAL
		-- Amount text is rotated counter-clockwise from horizontal plane in radians.

	set_angle (a_angle: REAL) is
			--
		do
--			{EV_GTK_EXTERNALS}.gtk_label_set_angle (text_label, a_angle / 3.14 * 180)
			angle := a_angle
		end

feature {EV_ANY_I} -- Implementation

	interface: EV_LABEL;

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




end --class LABEL_IMP

