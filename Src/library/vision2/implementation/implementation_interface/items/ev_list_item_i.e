indexing
	description: "Eiffel Vision list item. Implementation interface."
	status: "See notice at end of class"
	keywords: "list, item"
	date: "$Date$"
	revision: "$Revision$"
	
deferred class
	EV_LIST_ITEM_I
	
inherit
	EV_ITEM_I
		redefine
			interface,
			parent,
			pixmap_equal_to
		end

	EV_TEXTABLE_I
		redefine
			interface
		end

	EV_DESELECTABLE_I
		redefine
			interface,
			is_selectable
		end

	EV_TOOLTIPABLE_I
		redefine
			interface
		end

	EV_LIST_ITEM_ACTION_SEQUENCES_I

feature -- Status report

	is_selectable: BOOLEAN is
			-- May `Current' be selected?
		do
				--| FIXME We check that `parent.is_sensitive' due to
				--| implementation issues. If we find a way to
				--| implement this correctly on both platforms then
				--| this limitation can be removed.
			Result := parent /= Void and then parent.is_sensitive
		end

feature -- Access

	parent: EV_LIST_ITEM_LIST is
			-- List containing `interface'.
		do
			Result ?= Precursor
		end
		
feature {NONE} -- Contract support

	pixmap_equal_to (a_pixmap: EV_PIXMAP): BOOLEAN is
			-- Is `a_pixmap' equal to `pixmap'?
		local
			scaled_pixmap: EV_PIXMAP
			list_parent: EV_LIST
			combo_parent: EV_COMBO_BOX
		do
			if parent /= Void then
				scaled_pixmap := clone (a_pixmap)
				list_parent ?= parent
				if list_parent /= Void then
					scaled_pixmap.stretch (list_parent.pixmaps_width, list_parent.pixmaps_height)
				else
					combo_parent ?= parent
					check
						has_combo_parent: combo_parent /= Void
					end
					scaled_pixmap.stretch (combo_parent.pixmaps_width, combo_parent.pixmaps_height)
				end
				
			else
				scaled_pixmap := a_pixmap	
			end
			Result := scaled_pixmap.is_equal (pixmap)
		end

feature {EV_LIST_ITEM_I} -- Implementation

	interface: EV_LIST_ITEM
			-- Provides a common user interface to platform dependent
			-- functionality implemented by `Current'
	
end -- class EV_LIST_ITEM_I

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

