indexing
	description:
		"Eiffel Vision multi column list row. Implementation interface."
	status: "See notice at end of class"
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

	set_pixmap (a_pix: EV_PIXMAP) is
			-- Set the rows `pixmap' to `a_pix'.
		do
			internal_pixmap := clone (a_pix)
			update
		end
		
	pixmap: EV_PIXMAP is
			-- `Result' is pixmap displayed in `Current'.
			-- We do not simply return `internal_pixmap' as
			-- the image must be stretched to fit the size allocated
			-- by `parent'.
		do
			Result := clone (internal_pixmap)
			if internal_pixmap /= Void and parent /= Void then
				Result.stretch (parent_imp.pixmaps_width, parent_imp.pixmaps_height)
			end
		end
		

	internal_pixmap: EV_PIXMAP
			-- Pixmap used at the start of the row.

	remove_pixmap is
			-- Remove the rows pixmap.
		do
			internal_pixmap := Void
			update
		end

feature -- Basic operations

	update is
			-- Layout of row has been changed.
		local
			app: EV_APPLICATION_I
		do
			if parent_imp /= Void then
				update_needed := True
				app := (create {EV_ENVIRONMENT}).application.implementation
				if interface.count > parent_imp.count then
					parent_imp.update_children_agent.call ([])
					app.once_idle_actions.prune (parent_imp.update_children_agent)
				elseif not app.once_idle_actions.has (
						parent_imp.update_children_agent) then
					app.do_once_on_idle (
						parent_imp.update_children_agent)
				end
			end
		end

feature {EV_ANY_I} -- Implementation

	parent_imp: EV_MULTI_COLUMN_LIST_IMP is
		deferred
		end

	dirty_child is
			-- Mark `Current' as dirty.
		do
			update_needed := True
		end

	update_needed: BOOLEAN
			-- Is the child dirty.

	update_performed is
			-- Mark `Current' as up to date.
		do
			update_needed := False
		end
		
feature {NONE} -- Contract support

	pixmap_equal_to (a_pixmap: EV_PIXMAP): BOOLEAN is
			-- Is `a_pixmap' equal to `pixmap'?
		local
			scaled_pixmap: EV_PIXMAP
			multi_column_list: EV_MULTI_COLUMN_LIST
		do
			if parent /= Void then
				scaled_pixmap := clone (a_pixmap)
				multi_column_list ?= parent
				scaled_pixmap.stretch (multi_column_list.pixmaps_width, multi_column_list.pixmaps_height)
			else
				scaled_pixmap := a_pixmap		
			end
			Result := scaled_pixmap.is_equal (pixmap)
		end
		
feature {EV_ANY_I} -- Implementation

	interface: EV_MULTI_COLUMN_LIST_ROW

end -- class EV_MULTI_COLUMN_LIST_ROW_I

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

