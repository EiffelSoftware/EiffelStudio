note
	description: "List Item Carbon Implementation"
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

	EV_CARBON_DATABROWSER_ITEM
		undefine
			text
		redefine
			interface
		end


create
	make

feature {NONE} -- Initialization

	make (an_interface: like interface)
			-- Create a list item with an empty name.
		do
			base_make (an_interface)
		end

	initialize
			-- Initialize `Current'
		do
			internal_text := once ""
			set_is_initialized (True)
		end

feature -- PND

	enable_transport
		do
			is_transport_enabled := True
			if parent_imp /= Void then
				parent_imp.update_pnd_connection (True)
			end
		end

	disable_transport
		do
			is_transport_enabled := False
			if parent_imp /= Void then
				parent_imp.update_pnd_status
			end
		end

	able_to_transport (a_button: INTEGER): BOOLEAN
			-- Is the row able to transport data with `a_button' click.
			-- (export status {EV_MULTI_COLUMN_LIST_IMP})
		do
			Result := is_transport_enabled and ((a_button = 1 and mode_is_drag_and_drop) or (a_button = 3 and (mode_is_pick_and_drop or mode_is_target_menu)))
		end

	draw_rubber_band
		do
			check
				do_not_call: False
			end
		end

	erase_rubber_band
		do
			check
				do_not_call: False
			end
		end

	enable_capture
		do
			check
				do_not_call: False
			end
		end

	disable_capture
		do
			check
				do_not_call: False
			end
		end

	start_transport (
        	a_x, a_y, a_button: INTEGER; a_press: BOOLEAN
        	a_x_tilt, a_y_tilt, a_pressure: DOUBLE;
        	a_screen_x, a_screen_y: INTEGER; a_menu_only: BOOLEAN)
		do
			check
				do_not_call: False
			end
		end

	end_transport (a_x, a_y, a_button: INTEGER;
		a_x_tilt, a_y_tilt, a_pressure: DOUBLE;
		a_screen_x, a_screen_y: INTEGER)
		do
			check
				do_not_call: False
			end
		end

	set_pointer_style, internal_set_pointer_style (curs: EV_POINTER_STYLE)
		do
			check
				do_not_call: False
			end
		end

	real_pointed_target: EV_PICK_AND_DROPABLE
		do
			check do_not_call: False end
		end

feature -- Status report

	is_selected: BOOLEAN
			-- Is the item selected.
		do
			if parent_imp /= Void then
				Result := parent_imp.selected_items.has (interface)
			end
		end

feature -- Status setting

	enable_select
			-- Select the item.
		do
			parent_imp.select_item (parent_imp.index_of (interface, 1))
		end

	disable_select
			-- Deselect the item.
		do
			parent_imp.deselect_item (parent_imp.index_of (interface, 1))
		end

	text: STRING_32
			--
		do
			Result := internal_text.twin
		end

feature -- Element change

	set_tooltip (a_tooltip: STRING_GENERAL)
			-- Assign `a_tooltip' to `tooltip'.
		do
			internal_tooltip := a_tooltip.twin
		end

	tooltip: STRING_32
			-- Tooltip displayed on `Current'.
		do
			if internal_tooltip /= Void then
				Result := internal_tooltip.twin
			else
				Result := ""
			end
		end

	set_text (txt: STRING_GENERAL)
			-- Set current button text to `txt'.
		do
			internal_text := txt.twin
			if parent_imp /= Void then
				parent_imp.set_text_on_position (parent_imp.index_of (interface, 1) , txt)
			end
		end

	set_pixmap (a_pix: EV_PIXMAP)
			-- Set the rows `pixmap' to `a_pix'.
		do
			pixmap := a_pix.twin
			if parent_imp /= Void then
				parent_imp.set_row_pixmap (parent_imp.index_of (interface, 1), pixmap)
			end
		end

	remove_pixmap
			-- Remove the rows pixmap.
		do
			pixmap := Void
			if parent_imp /= Void then
				parent_imp.remove_row_pixmap (parent_imp.index_of (interface, 1))
			end
		end

	pixmap: EV_PIXMAP

feature -- Measurement

	x_position: INTEGER
			-- Horizontal offset relative to parent `x_position' in pixels.
		do
		end

	y_position: INTEGER
			-- Vertical offset relative to parent `y_position' in pixels.
		do
		end

	screen_x: INTEGER
			-- Horizontal offset relative to screen.
		local
			l_parent_imp: like parent_imp
		do
			l_parent_imp := parent_imp
			if l_parent_imp /= Void then
				Result := l_parent_imp.screen_x + x_position
			end
		end

	screen_y: INTEGER
			-- Vertical offset relative to screen.
		local
			l_parent_imp: like parent_imp
		do
			l_parent_imp := parent_imp
			if l_parent_imp /= Void then
				Result := l_parent_imp.screen_y + y_position
			end
		end

	width: INTEGER
			-- Horizontal size in pixels.
		local
			l_parent_imp: like parent_imp
		do
			l_parent_imp := parent_imp
			if l_parent_imp /= Void then
				Result := l_parent_imp.width
			end
		end

	height: INTEGER
			-- Vertical size in pixels.
		local
			l_parent_imp: like parent_imp
		do
			l_parent_imp := parent_imp
			if l_parent_imp /= Void then
				Result := l_parent_imp.height
			end
		end

	minimum_width: INTEGER
			-- Minimum horizontal size in pixels.
		local
			l_parent_imp: like parent_imp
		do
			l_parent_imp := parent_imp
			if l_parent_imp /= Void then
				Result := l_parent_imp.minimum_width
			end
		end

	minimum_height: INTEGER
			-- Minimum vertical size in pixels.
		local
			l_parent_imp: like parent_imp
		do
			l_parent_imp := parent_imp
			if l_parent_imp /= Void then
				Result := l_parent_imp.row_height
			end
		end

feature {NONE} -- Implementation

	internal_text: STRING_32
		-- Text displayed in `Current'

	destroy
			-- Clean up `Current'
		do
			if parent_imp /= Void then
				parent_imp.interface.prune_all (interface)
			end
			set_is_destroyed (True)
			pixmap := Void
		end

feature {EV_LIST_ITEM_LIST_IMP} -- Implementation

	update_for_pick_and_drop (starting: BOOLEAN)
			-- Pick and drop status has changed so update appearance of
			-- `Current' to reflect available targets.
		do
			-- Do nothing
		end

	internal_tooltip: STRING_32
		-- Tooltip used for `Current'.

	set_list_iter (a_iter: POINTER)
			-- Set `list_iter' to `a_iter'
		do
			list_iter := a_iter
		end

	list_iter: POINTER
		-- Object representing position of `Current' in parent tree model

	parent_imp: EV_LIST_ITEM_LIST_IMP

	set_parent_imp (a_parent_imp: EV_LIST_ITEM_LIST_IMP)
			--
		do
			parent_imp := a_parent_imp
		end

feature {EV_LIST_ITEM_LIST_IMP, EV_LIST_ITEM_LIST_I} -- Implementation

	interface: EV_LIST_ITEM;

note
	copyright:	"Copyright (c) 2007, The Eiffel.Mac Team"
end -- class EV_LIST_ITEM_IMP

