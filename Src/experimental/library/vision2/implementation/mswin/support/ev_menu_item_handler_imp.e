--| FIXME Not for release
--| FIXME NOT_REVIEWED this file has not been reviewed
note
	description:
		" A class that handle the menu items inside a%
		% container. Ancestor of EV_CONTAINER_IMP."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EV_MENU_ITEM_HANDLER_IMP

feature {NONE} -- Initialization

	initialize_handler
			-- Create the hash-table.
		do
			create menu_items.make (1)
		end

feature -- Access

	menu_items: HASH_TABLE [EV_MENU_ITEM_IMP, INTEGER]
			-- List of all the children

feature -- Basic operations

	update_menu
			-- Graphical update of the menu
		local
			window: EV_WINDOW_IMP
		do
			window := top_level_window_imp
			if window /= Void then
				window.draw_menu
			end
		end

	register_item (item_imp: EV_MENU_ITEM_IMP)
			-- Register the given item and sub-items in the
			-- general list
		local
			ht: HASH_TABLE [EV_MENU_ITEM_IMP, INTEGER]
			cc: ARRAYED_LIST [EV_ITEM_IMP]
			it: EV_MENU_ITEM_IMP
		do
			-- Initializations
			--| FIXME cc := item_imp.ev_children
			if menu_items = Void then
				initialize_handler
			end
			ht := menu_items

			-- Then, we register the item.
			ht.put (item_imp, item_imp.id)
			if cc /= Void then
				from
					cc.start
				until
					cc.after
				loop
					it ?= cc.item
					if it /= Void then
						ht.put (it, it.id)
					end
					cc.forth
				end
			end
		end

	unregister_item (item_imp: EV_MENU_ITEM_IMP)
			-- Register the given item and sub-items in the
			-- general list
		local
			ht: HASH_TABLE [EV_MENU_ITEM_IMP, INTEGER]
			cc: ARRAYED_LIST [EV_ITEM_IMP]
			it: EV_MENU_ITEM_IMP
		do
			-- Initializations
			ht := menu_items
			--| FIXME cc := item_imp.ev_children

			-- Remove the item ans sub-items.
			ht.remove (item_imp.id)
			if cc /= Void then
				from
					cc.start
				until
					cc.after
				loop
					it ?= cc.item
					if it /= Void then
						ht.remove (it.id)
					end
					cc.forth
				end
			end

			-- If the hash-table is empty, we destroy it.
			if ht.is_empty then
				ht := Void
			end
		end

feature {NONE} -- Deferred features

	top_level_window_imp: EV_WINDOW_IMP
			-- Top level window that contains the current widget.
		deferred
		end

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




end -- class EV_MENU_ITEM_HANDLER_IMP

