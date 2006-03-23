indexing
	description: "FIXME"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_LIST_ITEM_IMP

inherit
	EV_LIST_ITEM_I
		redefine
			interface
		end

	EV_ITEM_ACTION_SEQUENCES_IMP

	EV_PICK_AND_DROPABLE_ACTION_SEQUENCES_IMP

	EV_PND_DEFERRED_ITEM
		redefine
			interface
		end

	EV_LIST_ITEM_ACTION_SEQUENCES_IMP

create
	make

feature {NONE} -- Initialization

	make (an_interface: like interface) is
			-- Create a list item with an empty name.
		do
			base_make (an_interface)
		end

	initialize is
			-- Initialize `Current'
		do
			internal_text := once ""
			set_is_initialized (True)
		end

feature -- PND

	enable_transport is
		do
			is_transport_enabled := True
			if parent_imp /= Void then
				parent_imp.update_pnd_connection (True)
			end
		end

	disable_transport is
		do
			is_transport_enabled := False
			if parent_imp /= Void then
				parent_imp.update_pnd_status
			end
		end

	able_to_transport (a_button: INTEGER): BOOLEAN is
			-- Is the row able to transport data with `a_button' click.
			-- (export status {EV_MULTI_COLUMN_LIST_IMP})
		do
			Result := is_transport_enabled and ((a_button = 1 and mode_is_drag_and_drop) or (a_button = 3 and (mode_is_pick_and_drop or mode_is_target_menu)))
		end

	draw_rubber_band is
		do
			check
				do_not_call: False
			end
		end

	erase_rubber_band is
		do
			check
				do_not_call: False
			end
		end

	enable_capture is
		do
			check
				do_not_call: False
			end
		end

	disable_capture is
		do
			check
				do_not_call: False
			end
		end

	start_transport (
        	a_x, a_y, a_button: INTEGER;
        	a_x_tilt, a_y_tilt, a_pressure: DOUBLE;
        	a_screen_x, a_screen_y: INTEGER) is
		do
			check
				do_not_call: False
			end
		end

	end_transport (a_x, a_y, a_button: INTEGER;
		a_x_tilt, a_y_tilt, a_pressure: DOUBLE;
		a_screen_x, a_screen_y: INTEGER) is
		do
			check
				do_not_call: False
			end
		end

	set_pointer_style, internal_set_pointer_style (curs: EV_CURSOR) is
		do
			check
				do_not_call: False
			end
		end

	real_pointed_target: EV_PICK_AND_DROPABLE is
		do
			check do_not_call: False end
		end

feature -- Status report

	is_selected: BOOLEAN is
			-- Is the item selected.
		do
			if parent_imp /= Void then
				Result := parent_imp.selected_items.has (interface)
			end
		end

feature -- Status setting

	enable_select is
			-- Select the item.
		do
			parent_imp.select_item (parent_imp.index_of (interface, 1))
		end

	disable_select is
			-- Deselect the item.
		do
			parent_imp.deselect_item (parent_imp.index_of (interface, 1))
		end

	text: STRING_32 is
			--
		do
			Result := internal_text.twin
		end

feature -- Element change

	set_tooltip (a_tooltip: STRING_GENERAL) is
			-- Assign `a_tooltip' to `tooltip'.
		do
			internal_tooltip := a_tooltip.twin
		end

	tooltip: STRING_32 is
			-- Tooltip displayed on `Current'.
		do
			if internal_tooltip /= Void then
				Result := internal_tooltip.twin
			else
				Result := ""
			end
		end

	set_text (txt: STRING_GENERAL) is
			-- Set current button text to `txt'.
		do
			internal_text := txt.twin
			if parent_imp /= Void then
				parent_imp.set_text_on_position (parent_imp.index_of (interface, 1) , txt)
			end
		end

	set_pixmap (a_pix: EV_PIXMAP) is
			-- Set the rows `pixmap' to `a_pix'.
		do
			pixmap := a_pix.twin
			if parent_imp /= Void then
				parent_imp.set_row_pixmap (parent_imp.index_of (interface, 1), pixmap)
			end
		end

	remove_pixmap is
			-- Remove the rows pixmap.
		do
			pixmap := Void
			if parent_imp /= Void then
				parent_imp.remove_row_pixmap (parent_imp.index_of (interface, 1))
			end
		end

	pixmap: EV_PIXMAP

feature {NONE} -- Implementation

	internal_text: STRING_32
		-- Text displayed in `Current'

	destroy is
			-- Clean up `Current'
		do
			if parent_imp /= Void then
				parent_imp.interface.prune_all (interface)
			end
			set_is_destroyed (True)
			pixmap := Void
		end

feature {EV_LIST_ITEM_LIST_IMP} -- Implementation

	internal_tooltip: STRING_32
		-- Tooltip used for `Current'.

	set_list_iter (a_iter: EV_GTK_TREE_ITER_STRUCT) is
			-- Set `list_iter' to `a_iter'
		do
			list_iter := a_iter
		end

	list_iter: EV_GTK_TREE_ITER_STRUCT
		-- Object representing position of `Current' in parent tree model

	parent_imp: EV_LIST_ITEM_LIST_IMP

	set_parent_imp (a_parent_imp: EV_LIST_ITEM_LIST_IMP) is
			--
		do
			parent_imp := a_parent_imp
		end

feature {EV_LIST_ITEM_LIST_IMP, EV_LIST_ITEM_LIST_I} -- Implementation

	interface: EV_LIST_ITEM;

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




end -- class EV_LIST_ITEM_IMP

