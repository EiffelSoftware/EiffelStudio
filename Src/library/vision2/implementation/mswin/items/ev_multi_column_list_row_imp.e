note
	description:
		"Eiffel Vision multi column list row. Mswindows implementation."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EV_MULTI_COLUMN_LIST_ROW_IMP

inherit
	EV_MULTI_COLUMN_LIST_ROW_I
		redefine
			parent_imp,
			interface
		select
			pixmap
		end

	EV_ITEM_IMP
		rename
			pixmap as ev_item_imp_pixmap
		undefine
			parent,
			set_pixmap,
			remove_pixmap,
			pixmap_equal_to
		redefine
			parent_imp,
			interface,
			on_parented
		end

	EV_MULTI_COLUMN_LIST_ROW_ACTION_SEQUENCES_IMP

create
	make

feature -- Initialization

	old_make (an_interface: like interface)
			-- Create the row with one column by default.
			-- The sub-items start at 2. 1 is the index of
			-- the current item.
		do
			assign_interface (an_interface)
		end

	make
			-- Initialize `Current'.
		do
			set_is_initialized (True)
		end

feature -- Status report

	is_selected: BOOLEAN
			-- Is `Current' selected?
		do
			if attached parent_imp as l_parent_imp then
				Result := l_parent_imp.internal_is_selected (Current)
			end
		end

	tooltip: STRING_32
			-- Text of tooltip assigned to `Current'.
		do
			if internal_tooltip_string = Void then
				Result := ""
			else
				Result := internal_tooltip_string.twin
			end
		end

feature -- Status setting

	enable_select
			-- Select `Current'.
		do
			if attached parent_imp as l_parent_imp then
				l_parent_imp.internal_select (Current)
			end
		end

	disable_select
			-- Deselect Current.
		do
			if attached parent_imp as l_parent_imp then
				l_parent_imp.internal_deselect (Current)
			end
		end

	set_tooltip (a_tooltip: STRING_GENERAL)
			-- Assign `a_tooltip' to `internal_tooltip_string'.
		do
			internal_tooltip_string := a_tooltip.as_string_32
			if internal_tooltip_string = a_tooltip then
				internal_tooltip_string := a_tooltip.as_string_32.string
			end
		end

feature -- Measurement
	x_position: INTEGER
			-- Horizontal offset relative to parent `x_position' in pixels.
		local
			l_info: WEL_SCROLL_BAR_INFO
			l_result: INTEGER
		do
			if attached parent_imp as l_parent then
				Result := 0

				create l_info.make
				l_info.set_mask ({WEL_SCROLL_BAR_CONSTANTS}.sif_pos)
				l_result := {WEL_API}.get_scroll_info (l_parent.wel_item, {WEL_SB_CONSTANTS}.Sb_horz, l_info.item)
				Result := Result - l_info.position
			end
		end

	y_position: INTEGER
			-- Vertical offset relative to parent `y_position' in pixels.
		local
			l_info: WEL_SCROLL_BAR_INFO
			l_result: INTEGER
		do
			if attached parent_imp as l_parent then
				if attached l_parent.interface as l_interface then
					Result := (index - 1) * l_interface.row_height

					create l_info.make
					l_info.set_mask ({WEL_SCROLL_BAR_CONSTANTS}.sif_pos)
					l_result := {WEL_API}.get_scroll_info (l_parent.wel_item, {WEL_SB_CONSTANTS}.Sb_vert, l_info.item)

					Result := Result - (l_info.position * l_interface.row_height)
				end
			end
		end

	screen_x: INTEGER
			-- Horizontal offset relative to screen.
		do
			if attached parent_imp as l_parent then
				Result := l_parent.screen_x + x_position
			end
		end

	screen_y: INTEGER
			-- Vertical offset relative to screen.
		do
			if attached parent_imp as l_parent then
				Result := l_parent.screen_y + y_position
			end
		end

	width: INTEGER
			-- Horizontal size in pixels.
		do
			if attached parent_imp as l_parent then
				Result := l_parent.width
			end
		end

	height: INTEGER
			-- Vertical size in pixels.
		do
			if attached parent_imp as l_parent then
				if attached l_parent.interface as l_interface then
					Result := l_interface.row_height
				end
			end
		end

	minimum_width: INTEGER
			-- Minimum horizontal size in pixels.
		do
			if attached parent_imp as l_parent then
				Result := l_parent.minimal_width
			end
		end

	minimum_height: INTEGER
			-- Minimum vertical size in pixels.
		do
			if attached parent_imp as l_parent then
				if attached l_parent.interface as l_interface then
					Result := l_interface.row_height
				end
			end
		end

feature {EV_ANY_I} -- Access

	index: INTEGER
			-- Index of `Current' in `Parent_imp'.
		do
			if attached parent_imp as l_parent_imp then
				Result := l_parent_imp.internal_get_index (Current)
			end
		end

	parent_imp: detachable EV_MULTI_COLUMN_LIST_IMP
		-- The parent of `Current'.

	on_parented
			-- `Current' just parented.
		do
		end

	set_parent_imp (par_imp: like parent_imp)
			-- Assign `par_imp' to `parent_imp'.
			--| Make `par_imp' the new parent of `Current'.
		do
			if par_imp /= Void then
				parent_imp := par_imp
			else
				parent_imp := Void
			end
		end

	set_pixmap (a_pix: EV_PIXMAP)
			-- Set the rows `pixmap' to `a_pix'.
		do
			internal_pixmap := a_pix.twin
			if attached parent_imp as l_parent_imp then
				l_parent_imp.set_row_pixmap (l_parent_imp.ev_children.index_of (Current, 1), a_pix)
			end
		end

	remove_pixmap
			-- Set the rows `pixmap' to `a_pix'.
		do
			internal_pixmap := Void
			if attached parent_imp as l_parent_imp then
				l_parent_imp.remove_row_pixmap (l_parent_imp.ev_children.index_of (Current, 1))
			end
		end

	on_item_added_at (an_item: STRING_GENERAL; item_index: INTEGER)
			-- `an_item' has been added to index `item_index'.
		do
			if attached parent_imp as l_parent_imp then
				l_parent_imp.on_item_added_at (Current, an_item, item_index)
			end
		end

	on_item_removed_at (an_item: STRING_GENERAL; item_index: INTEGER)
			-- `an_item' has been removed from index `item_index'.
		do
			if attached parent_imp as l_parent_imp then
				l_parent_imp.on_item_removed_at (Current, an_item, item_index)
			end
		end

feature {NONE} -- Implementation

	internal_tooltip_string: detachable STRING_32 note option: stable attribute end
		-- Internal text of tooltip assigned to `Current'.

feature {EV_ANY, EV_ANY_I} -- Implementation

	interface: detachable EV_MULTI_COLUMN_LIST_ROW note option: stable attribute end;

note
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class EV_MULTI_COLUMN_LIST_ROW_IMP










