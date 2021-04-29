note
	description:
		"EiffelVision Split Area. GTK+ implementation."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	id: "$Id$"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_SPLIT_AREA_IMP

inherit
	EV_SPLIT_AREA_I
		undefine
			propagate_foreground_color,
			propagate_background_color
		redefine
			interface
		end

	EV_CONTAINER_IMP
		undefine
			replace
		redefine
			interface,
			make,
			container_widget,
			needs_event_box
		end

feature {NONE} -- Initialization

	make
		do
			Precursor {EV_CONTAINER_IMP}
			{GTK}.gtk_widget_show (container_widget)
			second_expandable := True
			{GTK}.gtk_container_set_border_width (container_widget, 0)
			{GTK2}.gtk_widget_set_redraw_on_allocate (container_widget, False)
		end

feature -- Access

	split_position: INTEGER
			-- Position from the left/top of the splitter from `Current'.
		do
			Result := {GTK}.gtk_paned_get_position (container_widget).max (minimum_split_position).min (maximum_split_position)
		end

	set_first (an_item: attached like item)
			-- Make `an_item' `first'.
		local
			item_imp: detachable EV_WIDGET_IMP
		do
			item_imp ?= an_item.implementation
			check item_imp /= Void then end
			item_imp.set_parent_imp (Current)
			{GTK}.gtk_paned_pack1 (container_widget, item_imp.c_object, False, False)
			first := an_item
			set_item_resize (an_item, False)
		end

	set_second (an_item: attached like item)
			-- Make `an_item' `second'.
		local
			item_imp: detachable EV_WIDGET_IMP
		do
			item_imp ?= an_item.implementation
			check item_imp /= Void then end
			item_imp.set_parent_imp (Current)
			{GTK}.gtk_paned_pack2 (container_widget, item_imp.c_object, True, False)
			second := an_item
			set_item_resize (an_item, True)
		end

	prune (an_item: like item)
			-- Remove `an_item' if present from `Current'.
		local
			item_imp: detachable EV_WIDGET_IMP
		do
			if has (an_item) and then an_item /= Void then
				item_imp ?= an_item.implementation
				check item_imp /= Void then end
				item_imp.set_parent_imp (Void)
				{GTK}.gtk_container_remove ({GTK}.gtk_widget_get_parent (item_imp.c_object), item_imp.c_object)
				if an_item = first then
					first_expandable := False
					first := Void
					set_split_position (0)
					if attached second as l_second then
						set_item_resize (l_second, True)
					end
				else
					second := Void
					second_expandable := True
					if attached first as l_first then
						set_item_resize (l_first, True)
					end
				end
			end
		end

	enable_item_expand (an_item: attached like item)
			-- Let `an_item' expand when `Current' is resized.
		do
			set_item_resize (an_item, True)
		end

	disable_item_expand (an_item: attached like item)
			-- Make `an_item' non-expandable on `Current' resize.
		do
			set_item_resize (an_item, False)
		end

	set_split_position (a_split_position: INTEGER)
			-- Set the position of the splitter.
		do
			{GTK}.gtk_paned_set_position (container_widget, a_split_position)
				-- Force child allocation to update immediately.
			{GTK}.gtk_container_check_resize (container_widget)
		end

feature {NONE} -- Implementation

	needs_event_box: BOOLEAN = True

	container_widget: POINTER
		-- Pointer to the GtkPaned widget.

	splitter_width: INTEGER
			-- Width of splitter.
		local
			a_cs: EV_GTK_C_STRING
		do
			a_cs := "handle-size"
			{GTK2}.gtk_widget_style_get_integer (container_widget, a_cs.item, $Result)
		end

	set_item_resize (an_item: attached like item; a_resizable: BOOLEAN)
			-- Set whether `an_item' is `a_resizable' when `Current' resizes.
		local
			l_parent: POINTER
		do
			if attached {EV_WIDGET_IMP} an_item.implementation as l_item_imp then
				l_parent := {GTK}.gtk_widget_get_parent (l_item_imp.c_object)
				if l_parent /= default_pointer then
					{GTK}.gtk_container_remove (l_parent, l_item_imp.c_object)
				end
				if an_item = first then
					first_expandable := a_resizable
					{GTK}.gtk_paned_pack1 (container_widget, l_item_imp.c_object, a_resizable, False)
				else
					second_expandable := a_resizable
					{GTK}.gtk_paned_pack2 (container_widget, l_item_imp.c_object, a_resizable, False)
				end
			end
		end

feature {EV_ANY, EV_ANY_I} -- Implementation

	interface: detachable EV_SPLIT_AREA note option: stable attribute end;

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

end -- class EV_SPLIT_AREA_IMP
