--| FIXME NOT_REVIEWED this file has not been reviewed
indexing
	description: "EiffelVision2 toolbar, implementation interface."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_TOOL_BAR_IMP

inherit
	EV_TOOL_BAR_I
		redefine
			interface
		end

	EV_PRIMITIVE_IMP
		redefine
			interface
		end

	EV_ITEM_LIST_IMP [EV_TOOL_BAR_ITEM]
		undefine
			item_by_data
		redefine
			interface,
			add_to_container,
			list_widget
		end

create
	make

feature {NONE} -- Implementation

	make (an_interface: like interface) is
			-- Create the tool-bar.
		do
			base_make (an_interface)
			set_c_object (C.gtk_event_box_new)
			list_widget := C.gtk_hbox_new (False, 0)
			C.gtk_container_add (c_object, list_widget)
			C.gtk_widget_show (list_widget)
		end

feature -- Implementation

	add_to_container (v: like item) is
			-- Add `v' to tool bar, set to non-expandable.
		local
			old_expand, fill, pad, pack_type: INTEGER
			wid_imp: EV_WIDGET_IMP
			
		do
			Precursor (v)
			wid_imp ?= v.implementation
			C.gtk_box_query_child_packing (
				list_widget,
				wid_imp.c_object,
				$old_expand,
				$fill,
				$pad,
				$pack_type
			)
			C.gtk_box_set_child_packing (
				list_widget,
				wid_imp.c_object,
				False,
				fill.to_boolean,
				pad,
				pack_type
			)
			add_radio_button (v)
		end

	gtk_reorder_child (a_container, a_child: POINTER; a_position: INTEGER) is
			-- Move `a_child' to `a_position' in `a_container'.
		do
			C.gtk_box_reorder_child (a_container, a_child, a_position)
		end

	add_radio_button (w: like item) is
			-- Connect radio button to tool bar group.
		require
			w_not_void: w /= Void
		local
			r: EV_TOOL_BAR_RADIO_BUTTON_IMP
		do
			r ?= w.implementation
			if r /= Void then
				if radio_group /= NULL then
					r.disable_select
				end
				radio_group := C.g_slist_append (radio_group, r.c_object)
			end
		end

	remove_radio_button (w: EV_TOOL_BAR_ITEM) is
			-- Called every time a widget is removed from the container.
		require
			w_not_void: w /= Void
		local
			r: EV_TOOL_BAR_RADIO_BUTTON_IMP
		do
			--| FIXME IEK Implement removal feature to call this feature.
			r ?= w.implementation
			if r /= Void then
				if r.is_selected then
					radio_group := C.g_slist_remove (radio_group, r.c_object)
					if radio_group /= NULL then
						C.gtk_toggle_button_set_active (
							C.gslist_struct_data (radio_group), True
						)
					end
				else
					C.gtk_toggle_button_set_active (r.c_object, True)
				end
			end
		end

feature {EV_TOOL_BAR_RADIO_BUTTON_IMP} -- Implementation

	radio_group: POINTER

feature {EV_ANY_I} -- Implementation

	list_widget: POINTER
			-- Pointer to the gtkhbox (toolbar) as c_object is event box.

	interface: EV_TOOL_BAR

end -- class EV_TOOL_BAR_IMP

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

