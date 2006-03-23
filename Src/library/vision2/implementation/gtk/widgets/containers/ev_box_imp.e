indexing
	description:
		"EiffelVision box. GTK+ implementation."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	id: "$Id$"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_BOX_IMP

inherit
	EV_BOX_I
		undefine
			propagate_foreground_color,
			propagate_background_color
		redefine
			interface
		end

	EV_WIDGET_LIST_IMP
		redefine
			interface,
			needs_event_box
		end

feature -- Access

	is_homogeneous: BOOLEAN is
			-- Are all children restricted to be the same size?
		do
			Result := {EV_GTK_EXTERNALS}.gtk_box_struct_homogeneous (container_widget) /= 0
		end

	border_width: INTEGER is
			-- Width of border around container in pixels.
		do
			Result := {EV_GTK_EXTERNALS}.gtk_container_struct_border_width (
					{EV_GTK_EXTERNALS}.gtk_box_struct_container (container_widget)
				)
		end

	padding: INTEGER is
			-- Space between children in pixels.		
		do
			Result := {EV_GTK_EXTERNALS}.gtk_box_struct_spacing (container_widget)
		end

feature {EV_ANY, EV_ANY_I} -- Status report

	is_item_expanded (child: EV_WIDGET): BOOLEAN is
			-- Is `child' expanded to occupy available spare space?
		local
			fill: INTEGER
			expand, pad, pack_type: INTEGER
			wid_imp: EV_WIDGET_IMP
		do
			wid_imp ?= child.implementation
			{EV_GTK_EXTERNALS}.gtk_box_query_child_packing (
				container_widget,
				wid_imp.c_object,
				$expand,
				$fill,
				$pad,
				$pack_type
			)
			Result := expand.to_boolean
		end

feature {EV_ANY, EV_ANY_I} -- Status settings

	set_homogeneous (flag: BOOLEAN) is
			-- Set whether every child is the same size.
		do
			{EV_GTK_EXTERNALS}.gtk_box_set_homogeneous (container_widget, flag)
		end

	set_border_width (value: INTEGER) is
			 -- Assign `value' to `border_width'.
		do
			{EV_GTK_EXTERNALS}.gtk_container_set_border_width (container_widget, value)
		end

	set_padding (value: INTEGER) is
			-- Assign `value' to `padding'.
		do
			{EV_GTK_EXTERNALS}.gtk_box_set_spacing (container_widget, value)
		end

	set_child_expandable (child: EV_WIDGET; flag: BOOLEAN) is
			-- Set whether `child' expands to fill available spare space.
		local
			old_expand, fill, pad, pack_type: INTEGER
			wid_imp: EV_WIDGET_IMP
		do
			wid_imp ?= child.implementation
			{EV_GTK_EXTERNALS}.gtk_box_query_child_packing (
				container_widget,
				wid_imp.c_object,
				$old_expand,
				$fill,
				$pad,
				$pack_type
			)
			{EV_GTK_EXTERNALS}.gtk_box_set_child_packing (
				container_widget,
				wid_imp.c_object,
				flag,
				fill.to_boolean,
				pad,
				pack_type
			)
		end

feature {EV_ANY_I} -- Implementation

	needs_event_box: BOOLEAN is True

	gtk_reorder_child (a_container, a_child: POINTER; a_position: INTEGER) is
			-- Move `a_child' to `a_position' in `a_container'.
		do
			{EV_GTK_EXTERNALS}.gtk_box_reorder_child (a_container, a_child, a_position)
		end

feature {EV_ANY_I, EV_ANY} -- Implementation

	interface: EV_BOX;
			-- Provides a common user interface to platform dependent
			-- functionality implemented by `Current'

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




end -- class EV_BOX_IMP

