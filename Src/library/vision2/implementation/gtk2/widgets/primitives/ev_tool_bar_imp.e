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
			insert_i_th,
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
			list_widget := feature {EV_GTK_EXTERNALS}.gtk_toolbar_new
			set_c_object (list_widget)
		end
		
	initialize is
			-- Initialize `Current'
		do
			Precursor {EV_ITEM_LIST_IMP}
			Precursor {EV_PRIMITIVE_IMP}
			enable_vertical_button_style
			feature {EV_GTK_DEPENDENT_EXTERNALS}.gtk_toolbar_set_show_arrow (list_widget, False)
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
			feature {EV_GTK_EXTERNALS}.gtk_toolbar_set_style (visual_widget, feature {EV_GTK_EXTERNALS}.gtk_toolbar_both_enum)
		end
		
	disable_vertical_button_style is
			-- Ensure `has_vertical_button_style' is `False'.
		do
			has_vertical_button_style := False
			feature {EV_GTK_EXTERNALS}.gtk_toolbar_set_style (visual_widget, feature {EV_GTK_EXTERNALS}.gtk_toolbar_both_horiz_enum)
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

	insert_i_th (v: like item; i: INTEGER) is
			-- Insert `v' at position `i'.
		local
			v_imp: EV_ITEM_IMP
		do
			v_imp ?= v.implementation
			v_imp.set_item_parent_imp (Current)
			feature {EV_GTK_EXTERNALS}.gtk_toolbar_insert (c_object, v_imp.c_object, i - 1)
			add_radio_button (v)
			child_array.go_i_th (i)
			child_array.put_left (v)
		end

	add_to_container (v: like item; v_imp: EV_ITEM_IMP) is
			-- Add `v' to tool bar, set to non-expandable.
		do
			check
				do_not_call: False
			end
		end

	gtk_reorder_child (a_container, a_child: POINTER; a_position: INTEGER) is
			-- Move `a_child' to `a_position' in `a_container'.
		do
			check
				do_not_call: False
			end
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
				feature {EV_GTK_EXTERNALS}.gtk_radio_tool_button_set_group (r.visual_widget, radio_group)
				radio_group := r.radio_group
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
				feature {EV_GTK_EXTERNALS}.gtk_radio_tool_button_set_group (r.visual_widget, NULL)
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

