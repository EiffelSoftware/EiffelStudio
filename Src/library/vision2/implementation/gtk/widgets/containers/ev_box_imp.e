indexing
	description: 
		"EiffelVision box. GTK+ implementation."
	status: "See notice at end of class"
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
			-- Are all children restriced to be the same size.
		do
			Result := feature {EV_GTK_EXTERNALS}.gtk_box_struct_homogeneous (container_widget) /= 0
		end

	border_width: INTEGER is
			-- Width of border around container in pixels.
		do
			Result := feature {EV_GTK_EXTERNALS}.gtk_container_struct_border_width (
					feature {EV_GTK_EXTERNALS}.gtk_box_struct_container (container_widget)
				)
		end

	padding: INTEGER is
			-- Space between children in pixels.		
		do
			Result := feature {EV_GTK_EXTERNALS}.gtk_box_struct_spacing (container_widget)
		end
	
feature -- Status report

	is_item_expanded (child: EV_WIDGET): BOOLEAN is
			-- Is `child' expanded to occupy avalible spare space.
		local
			fill: INTEGER
			expand, pad, pack_type: INTEGER
			wid_imp: EV_WIDGET_IMP
		do
			wid_imp ?= child.implementation
			feature {EV_GTK_EXTERNALS}.gtk_box_query_child_packing (
				container_widget,
				wid_imp.c_object,
				$expand,
				$fill,
				$pad,
				$pack_type
			)
			Result := expand.to_boolean
		end
	
feature -- Status settings
	
	set_homogeneous (flag: BOOLEAN) is
			-- Set whether every child is the same size.
		do
			feature {EV_GTK_EXTERNALS}.gtk_box_set_homogeneous (container_widget, flag)
		end

	set_border_width (value: INTEGER) is
			 -- Assign `value' to `border_width'.
		do
			feature {EV_GTK_EXTERNALS}.gtk_container_set_border_width (container_widget, value)
		end	
	
	set_padding (value: INTEGER) is
			-- Assign `value' to `padding'.
		do
			feature {EV_GTK_EXTERNALS}.gtk_box_set_spacing (container_widget, value)
		end	

	set_child_expandable (child: EV_WIDGET; flag: BOOLEAN) is
			-- Set whether `child' expands to fill available spare space.
		local
			old_expand, fill, pad, pack_type: INTEGER
			wid_imp: EV_WIDGET_IMP
		do
			wid_imp ?= child.implementation
			feature {EV_GTK_EXTERNALS}.gtk_box_query_child_packing (
				container_widget,
				wid_imp.c_object,
				$old_expand,
				$fill,
				$pad,
				$pack_type
			)
			feature {EV_GTK_EXTERNALS}.gtk_box_set_child_packing (
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
			feature {EV_GTK_EXTERNALS}.gtk_box_reorder_child (a_container, a_child, a_position)
		end

	interface: EV_BOX
			-- Provides a common user interface to platform dependent
			-- functionality implemented by `Current'

end -- class EV_BOX_IMP

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

