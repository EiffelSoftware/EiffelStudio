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
			interface,
			initialize,
			visual_widget
		end

	EV_ITEM_LIST_IMP [EV_TOOL_BAR_ITEM]
		undefine
			item_by_data,
			destroy
		redefine
			interface,
			add_to_container,
			list_widget,
			initialize,
			visual_widget
		end

create
	make

feature {NONE} -- Implementation

	make (an_interface: like interface) is
			-- Create the tool-bar.
		do
			base_make (an_interface)
			set_c_object (feature {EV_GTK_EXTERNALS}.gtk_event_box_new)
			list_widget := feature {EV_GTK_EXTERNALS}.gtk_hbox_new (False, 0)
			feature {EV_GTK_EXTERNALS}.gtk_container_add (c_object, list_widget)
			feature {EV_GTK_EXTERNALS}.gtk_widget_show (list_widget)
		end
		
	initialize is
			-- 
		do
			Precursor {EV_ITEM_LIST_IMP}
			Precursor {EV_PRIMITIVE_IMP}
			enable_vertical_button_style
		end
		
	visual_widget: POINTER is
			-- 
		do
			Result := list_widget
		end
		
feature -- Status report

	has_vertical_button_style: BOOLEAN
			-- Is the `pixmap' displayed vertically above `text' for
			-- all buttons contained in `Current'? If `False', then
			-- the `pixmap' is displayed to left of `text'.
		
feature -- Status setting

	enable_vertical_button_style is
			-- Ensure `has_vertical_button_style' is `True'.
		do
			has_vertical_button_style := True
			--| FIXME IEK Implement me
		end
		
	disable_vertical_button_style is
			-- Ensure `has_vertical_button_style' is `False'.
		do
			has_vertical_button_style := False
			--| FIXME IEK Implement me
		end
		
feature {EV_DOCKABLE_SOURCE_I} -- Implementation
		
	block_selection_for_docking is
			-- 
		do
			-- For now, do nothing.
		end

feature -- Implementation

	insertion_position: INTEGER is
			-- `Result' is index - 1 of item beneath the
			-- current mouse pointer or count + 1 if over the toolbar
			-- and not over a button.
		local
			wid_imp: EV_WIDGET_IMP
			tbi: EV_TOOL_BAR_ITEM
		do
			Result := count + 1
			wid_imp := widget_imp_at_pointer_position
			if wid_imp /= Void then
				tbi ?= wid_imp.interface
				if tbi /= Void and has (tbi) then
					Result := index_of (tbi, 1) - 1
				end
			end
		end

	add_to_container (v: like item; v_imp: EV_ITEM_IMP) is
			-- Add `v' to tool bar, set to non-expandable.
		local
			old_expand, fill, pad, pack_type: INTEGER
		do
			Precursor (v, v_imp)
			feature {EV_GTK_EXTERNALS}.gtk_box_query_child_packing (
				list_widget,
				v_imp.c_object,
				$old_expand,
				$fill,
				$pad,
				$pack_type
			)
			feature {EV_GTK_EXTERNALS}.gtk_box_set_child_packing (
				list_widget,
				v_imp.c_object,
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
			feature {EV_GTK_EXTERNALS}.gtk_box_reorder_child (a_container, a_child, a_position)
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
				radio_group := feature {EV_GTK_EXTERNALS}.g_slist_append (radio_group, r.c_object)
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
					radio_group := feature {EV_GTK_EXTERNALS}.g_slist_remove (radio_group, r.c_object)
					if radio_group /= NULL then
						feature {EV_GTK_EXTERNALS}.gtk_toggle_button_set_active (
							feature {EV_GTK_EXTERNALS}.gslist_struct_data (radio_group), True
						)
					end
				else
					feature {EV_GTK_EXTERNALS}.gtk_toggle_button_set_active (r.c_object, True)
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

