note
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

	is_selectable: BOOLEAN
			-- May the tree item be selected.
		do
			Result := parent /= Void
		end

feature -- Element Change

	pixmap: detachable EV_PIXMAP
			-- `Result' is pixmap displayed in `Current'.
			-- We do not simply return `internal_pixmap' as
			-- the image must be stretched to fit the size allocated
			-- by `parent'.
		do
			if attached internal_pixmap as l_internal_pixmap then
				Result := l_internal_pixmap.twin
				if attached parent_imp as l_parent_imp and then l_internal_pixmap.width /= l_parent_imp.pixmaps_width and then l_internal_pixmap.height /= l_parent_imp.pixmaps_height then
					Result.stretch (l_parent_imp.pixmaps_width, l_parent_imp.pixmaps_height)
				end
			end
		end

	internal_pixmap: detachable EV_PIXMAP
			-- Pixmap used at the start of the row.

	parent_imp: detachable EV_MULTI_COLUMN_LIST_IMP
			-- Parent implementation of `Current'.
		deferred
		end

	tooltip: STRING_32
			-- Tooltip displayed on `Current'.
		deferred
		end

feature -- Element change

	set_tooltip (a_tooltip: STRING_GENERAL)
			-- Assign `a_tooltip' to `tooltip'.
		require
			a_tooltip_not_void: a_tooltip /= Void
		deferred
		end

	remove_tooltip
			-- Make `tooltip' empty.
		do
			set_tooltip ("")
		ensure
			tooltip_removed: tooltip.is_empty
		end

feature -- Contract support

	pixmap_equal_to (a_pixmap: EV_PIXMAP): BOOLEAN
			-- Is `a_pixmap' equal to `pixmap'?
		local
			scaled_pixmap: EV_PIXMAP
			multi_column_list: detachable EV_MULTI_COLUMN_LIST
		do
			if parent /= Void then
				scaled_pixmap := a_pixmap.twin
				multi_column_list ?= parent
				check multi_column_list /= Void end
				scaled_pixmap.stretch (multi_column_list.pixmaps_width, multi_column_list.pixmaps_height)
			else
				scaled_pixmap := a_pixmap
			end
			Result := attached pixmap as l_pixmap and then scaled_pixmap.is_equal (l_pixmap)
		end

feature {EV_MULTI_COLUMN_LIST_ROW} -- Implementation

	on_item_added_at (an_item: STRING_GENERAL; item_index: INTEGER)
			-- `an_item' has been added to index `item_index'.
		deferred
		end

	on_item_removed_at (an_item: STRING_GENERAL; item_index: INTEGER)
			-- `an_item' has been removed from index `item_index'.
		deferred
		end

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




end -- class EV_MULTI_COLUMN_LIST_ROW_I











