note
	description: "Eiffel Vision list item. Implementation interface."
	legal: "See notice at end of class."
	status: "See notice at end of class."
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

	is_selectable: BOOLEAN
			-- May `Current' be selected?
		do
				--| FIXME We check that `parent.is_sensitive' due to
				--| implementation issues. If we find a way to
				--| implement this correctly on both platforms then
				--| this limitation can be removed.
			Result := attached parent as l_parent and then l_parent.is_sensitive
		end

feature -- Access

	parent: detachable EV_LIST_ITEM_LIST
			-- List containing `interface'.
		do
			Result ?= Precursor
		end

feature -- Contract support

	pixmap_equal_to (a_pixmap: EV_PIXMAP): BOOLEAN
			-- Is `a_pixmap' equal to `pixmap'?
		local
			scaled_pixmap: detachable EV_PIXMAP
			list_parent: detachable EV_LIST
			combo_parent: detachable EV_COMBO_BOX
		do
			if parent /= Void then
				scaled_pixmap := a_pixmap.twin
				list_parent ?= parent
				if list_parent /= Void then
					scaled_pixmap.stretch (list_parent.pixmaps_width, list_parent.pixmaps_height)
				else
					combo_parent ?= parent
					check
						has_combo_parent: combo_parent /= Void then
					end
					scaled_pixmap.stretch (combo_parent.pixmaps_width, combo_parent.pixmaps_height)
				end

			else
				scaled_pixmap := a_pixmap
			end
			if attached pixmap as l_pixmap then
				Result := scaled_pixmap.is_equal (l_pixmap)
			end
		end

feature {EV_ANY, EV_ANY_I} -- Implementation

	interface: detachable EV_LIST_ITEM note option: stable attribute end;
			-- Provides a common user interface to platform dependent
			-- functionality implemented by `Current'

note
	copyright:	"Copyright (c) 1984-2013, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"




end -- class EV_LIST_ITEM_I










