indexing
	description: "Objects that ..."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EV_HEADER_IMP

inherit

	EV_HEADER_I
		redefine
			interface
		end
		
	EV_ITEM_LIST_IMP [EV_HEADER_ITEM]
		redefine
			interface,
			initialize
		end
	
	EV_PRIMITIVE_IMP
		redefine
			interface,
			initialize,
			destroy
		end
		
	EV_FONTABLE_IMP
		redefine
			interface,
			initialize
		end

	EV_HEADER_ACTION_SEQUENCES_IMP

create
	make

feature -- Initialization

	make (an_interface: like interface) is
			-- Create an empty Header widget.
		do
			base_make (an_interface)
			set_c_object ({EV_GTK_EXTERNALS}.gtk_clist_new (10))
		end

	initialize is
			-- Initialize `Current'.
		do
			Precursor {EV_PRIMITIVE_IMP}
			Precursor {EV_ITEM_LIST_IMP}
			{EV_GTK_EXTERNALS}.gtk_clist_column_titles_show (visual_widget)
			--| FIXME Work out correct minimum height.
			set_minimum_height (22)
			
			real_signal_connect_after (
				visual_widget,
				"resize_column",
				agent column_resize_callback,
				agent (App_implementation.gtk_marshal).column_resize_callback_translate
			)
			
--			real_signal_connect_after (
--				visual_widget,
--				"click_column",
--				agent column_click_callback,
--				agent (app_implementation.gtk_marshal).gtk_value_int_to_tuple
--			)
			{EV_GTK_EXTERNALS}.gtk_widget_unset_flags (visual_widget, {EV_GTK_EXTERNALS}.gtk_can_focus_enum)
		end

feature

	column_resize_callback (a_column: INTEGER) is
			-- Column `a_column' has been resized.
		local
			a_width: INTEGER
			a_item_imp: EV_HEADER_ITEM_IMP
		do
			a_width := {EV_MULTI_COLUMN_LIST_IMP}.gtk_clist_column_width (visual_widget, a_column - 1) + column_padding
			a_item_imp ?= (child_array [a_column]).implementation
			if a_item_imp.width /= a_width then
				a_item_imp.internal_set_width (a_width)
				if item_resize_actions_internal /= Void then
					item_resize_actions_internal.call ([a_item_imp.interface])
				end
			end
		end

--	column_click_callback (a_column: INTEGER) is
--			-- 
--		local
--			a_widget: POINTER
--		do
--			a_widget := {EV_GTK_EXTERNALS}.gtk_clist_get_column_widget (visual_widget, a_column)
--		end

	frozen column_padding: INTEGER is 6
		-- Extra pixels that make up a column that are not reflected in the struct.
	
	insert_i_th (v: like item; i: INTEGER) is
			-- Insert `v' at position `i'.
		local
			item_imp: EV_HEADER_ITEM_IMP
		do
			item_imp ?= v.implementation
			child_array.go_i_th (i)
			child_array.put_left (v)
			item_imp.set_parent_imp (Current)
			update_items
		end
		
	update_items is
			-- Update `Current' to match item values
		local
			i: INTEGER
			a_cs: EV_GTK_C_STRING
		do
			from
				i := 1
				create a_cs.set_with_eiffel_string ("")
			until
				i > child_array.count
			loop
				a_cs.set_with_eiffel_string ((child_array [i]).text)
				{EV_GTK_EXTERNALS}.gtk_clist_set_column_title (visual_widget, i - 1, a_cs.item)
				{EV_GTK_EXTERNALS}.gtk_clist_column_title_passive (visual_widget, i - 1)
				i := i + 1
			end
		end
		
	remove_i_th (a_position: INTEGER) is
			-- Remove item a`a_position'
		local
			item_imp: EV_HEADER_ITEM_IMP
		do
			child_array.go_i_th (a_position)
			item_imp ?=item.implementation
			item_imp.set_parent_imp (Void)
			child_array.remove
			update_items
		end

feature {NONE} -- Implementation

	pointed_divider_index: INTEGER is
			-- Index of divider currently beneath the mouse pointer, or
			-- 0 if none.
		do
		end

	pixmaps_size_changed is
			-- The size of the displayed pixmaps has just
			-- changed.
		do
			--| FIXME IEK Implement me
		end

	destroy is
			-- Destroy `Current'.
		do
			set_is_destroyed (True)
		end

	interface: EV_HEADER;
		-- Interface object of `Current'.

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




end
