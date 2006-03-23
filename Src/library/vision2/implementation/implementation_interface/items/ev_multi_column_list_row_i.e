indexing
	description:
		"Eiffel Vision multi column list row. Implementation interface."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$";
	revision: "$Revision$"

deferred class
	EV_MULTI_COLUMN_LIST_ROW_I

inherit
	EV_ITEM_I
		redefine
			interface,
			parent_imp,
			pixmap_equal_to
		end

	EV_PICK_AND_DROPABLE_I
		redefine
			interface
		end

	EV_PIXMAPABLE_I
		undefine
			pixmap_equal_to
		redefine
			interface,
			pixmap_equal_to
		end

	EV_DESELECTABLE_I
		redefine
			interface,
			is_selectable
		end

	EV_MULTI_COLUMN_LIST_ROW_ACTION_SEQUENCES_I

feature -- Status report

	is_selectable: BOOLEAN is
			-- May the tree item be selected.
		do
			Result := parent /= Void
		end

feature -- Element Change

	pixmap: EV_PIXMAP is
			-- `Result' is pixmap displayed in `Current'.
			-- We do not simply return `internal_pixmap' as
			-- the image must be stretched to fit the size allocated
			-- by `parent'.
		do
			if internal_pixmap /= Void then
				Result := internal_pixmap.twin
				if parent /= Void and then internal_pixmap.width /= parent_imp.pixmaps_width and then internal_pixmap.height /= parent_imp.pixmaps_height then
					Result.stretch (parent_imp.pixmaps_width, parent_imp.pixmaps_height)
				end
			end
		end

	internal_pixmap: EV_PIXMAP
			-- Pixmap used at the start of the row.

	parent_imp: EV_MULTI_COLUMN_LIST_IMP is
			-- Parent implementation of `Current'.
		deferred
		end

	tooltip: STRING_32 is
			-- Tooltip displayed on `Current'.
		deferred
		end

feature -- Element change

	set_tooltip (a_tooltip: STRING_GENERAL) is
			-- Assign `a_tooltip' to `tooltip'.
		require
			a_tooltip_not_void: a_tooltip /= Void
		deferred
		end

	remove_tooltip is
			-- Make `tooltip' empty.
		do
			set_tooltip ("")
		ensure
			tooltip_removed: tooltip.is_empty
		end

feature -- Contract support

	pixmap_equal_to (a_pixmap: EV_PIXMAP): BOOLEAN is
			-- Is `a_pixmap' equal to `pixmap'?
		local
			scaled_pixmap: EV_PIXMAP
			multi_column_list: EV_MULTI_COLUMN_LIST
		do
			if parent /= Void then
				scaled_pixmap := a_pixmap.twin
				multi_column_list ?= parent
				scaled_pixmap.stretch (multi_column_list.pixmaps_width, multi_column_list.pixmaps_height)
			else
				scaled_pixmap := a_pixmap
			end
			Result := scaled_pixmap.is_equal (pixmap)
		end

feature {EV_MULTI_COLUMN_LIST_ROW} -- Implementation

	on_item_added_at (an_item: STRING_GENERAL; item_index: INTEGER) is
			-- `an_item' has been added to index `item_index'.
		deferred
		end

	on_item_removed_at (an_item: STRING_GENERAL; item_index: INTEGER) is
			-- `an_item' has been removed from index `item_index'.
		deferred
		end

feature {EV_ANY, EV_ANY_I} -- Implementation

	interface: EV_MULTI_COLUMN_LIST_ROW;

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




end -- class EV_MULTI_COLUMN_LIST_ROW_I

