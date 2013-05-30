note
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

	is_homogeneous: BOOLEAN
			-- Are all children restricted to be the same size?
		do
			Result := {GTK}.gtk_box_struct_homogeneous (container_widget) /= 0
		end

	border_width: INTEGER
			-- Width of border around container in pixels.
		do
			Result := {GTK}.gtk_container_struct_border_width (
					{GTK}.gtk_box_struct_container (container_widget)
				)
		end

	padding: INTEGER
			-- Space between children in pixels.		
		do
			Result := {GTK}.gtk_box_struct_spacing (container_widget)
		end

feature {EV_ANY, EV_ANY_I} -- Status report

	is_item_expanded (child: EV_WIDGET): BOOLEAN
			-- Is `child' expanded to occupy available spare space?
		local
			fill: INTEGER
			expand, pad, pack_type: INTEGER
			wid_imp: detachable EV_WIDGET_IMP
		do
			wid_imp ?= child.implementation
			check wid_imp /= Void end
			if wid_imp /= Void then
				{GTK}.gtk_box_query_child_packing (
					container_widget,
					wid_imp.c_object,
					$expand,
					$fill,
					$pad,
					$pack_type
				)
			end
			Result := expand.to_boolean
		end

feature {EV_ANY, EV_ANY_I} -- Status settings

	set_homogeneous (flag: BOOLEAN)
			-- Set whether every child is the same size.
		do
			{GTK}.gtk_box_set_homogeneous (container_widget, flag)
		end

	set_border_width (value: INTEGER)
			 -- Assign `value' to `border_width'.
		do
			{GTK}.gtk_container_set_border_width (container_widget, value)
		end

	set_padding (value: INTEGER)
			-- Assign `value' to `padding'.
		do
			{GTK}.gtk_box_set_spacing (container_widget, value)
		end

	set_child_expandable (child: EV_WIDGET; flag: BOOLEAN)
			-- Set whether `child' expands to fill available spare space.
		local
			old_expand, fill, pad, pack_type: INTEGER
			wid_imp: detachable EV_WIDGET_IMP
		do
			wid_imp ?= child.implementation
			check wid_imp /= Void end
			if wid_imp /= Void then
				{GTK}.gtk_box_query_child_packing (
					container_widget,
					wid_imp.c_object,
					$old_expand,
					$fill,
					$pad,
					$pack_type
				)
				{GTK}.gtk_box_set_child_packing (
					container_widget,
					wid_imp.c_object,
					flag,
					fill.to_boolean,
					pad,
					pack_type
				)
			end
		end

feature {EV_ANY_I} -- Implementation

	needs_event_box: BOOLEAN
			-- Does `a_widget' need an event box?
		do
			Result := True
		end

	gtk_insert_i_th (a_container, a_widget: POINTER; i: INTEGER)
			-- Insert `a_widget' in to `a_container' at position `i'.
		do
			{GTK}.gtk_container_add (a_container, a_widget)
			if i < count then
				{GTK}.gtk_box_reorder_child (a_container, a_widget, i)
			end
		end

feature {EV_ANY_I, EV_ANY} -- Implementation

	interface: detachable EV_BOX note option: stable attribute end;
			-- Provides a common user interface to platform dependent
			-- functionality implemented by `Current'

note
	copyright:	"Copyright (c) 1984-2013, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"




end -- class EV_BOX_IMP





