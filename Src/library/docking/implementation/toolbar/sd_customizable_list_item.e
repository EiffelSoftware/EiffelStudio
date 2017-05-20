note
	description: "Used to store EB_TOOLBARABLE's in an EV_ITEM_LIST"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: "Xavier Rousselot"
	date: "$Date$"
	revision: "$Revision$"

class
	SD_CUSTOMIZABLE_LIST_ITEM

inherit
	EV_LIST_ITEM
		redefine
			data
		end

create
	make

feature {NONE} -- Initialization

	make (a_dlg: SD_TOOL_BAR_CUSTOMIZE_DIALOG; v: SD_TOOL_BAR_ITEM)
			-- Creation method
		require
			not_void: v /= Void
			not_void: a_dlg /= Void
		do
			dialog := a_dlg
			data := v

			make_with_text (v.description)
			if attached v.pixmap as l_pixmap then
				set_pixmap (l_pixmap)
			end

			is_separator := attached {SD_TOOL_BAR_SEPARATOR} v
			set_pebble (Current)
			drop_actions.extend (agent add_to_parent_list)
			drop_actions.set_veto_pebble_function (agent a_dlg.veto_pebble_function)
		ensure
			v_either_separator_or_command: data /= Void
			set: dialog = a_dlg
		end

feature -- Interactivity

	add_to_parent_list (an_item: SD_CUSTOMIZABLE_LIST_ITEM)
			-- Add `an_item' to `parent'
			-- `from_pool' and `to_pool' determine the behavior of separators
		local
			from_pool, to_pool: BOOLEAN
		do
			from_pool := attached an_item.custom_parent as l_item_custom_parent and then l_item_custom_parent.is_a_pool_list -- Picking from a pool list?
			to_pool := attached custom_parent as l_custom_parent and then l_custom_parent.is_a_pool_list -- Dropping into a pool list?
			if an_item /= Current and attached an_item.parent as l_item_parent and attached parent as l_parent then
				if not an_item.is_separator then
					l_item_parent.start
					l_item_parent.prune (an_item)
					l_parent.start
					l_parent.search (Current)
					l_parent.put_right (an_item)
				elseif from_pool and then (not to_pool) then
					l_parent.start
					l_parent.search (Current)
					l_parent.put_right (create {SD_CUSTOMIZABLE_LIST_ITEM}.make (dialog, create {SD_TOOL_BAR_SEPARATOR}.make))
				elseif (not from_pool) and then to_pool then
					l_item_parent.start
					l_item_parent.prune (an_item)
				elseif (not from_pool) and then (not to_pool) then
					l_item_parent.start
					l_item_parent.prune (an_item)
					l_parent.start
					l_parent.search (Current)
					l_parent.put_right (an_item)
				end
			end
		end

feature -- Access

	data: SD_TOOL_BAR_ITEM
			-- the corresponding button

	custom_parent: detachable SD_CUSTOM_TOOLBAR_LIST
			-- Convert `parent' into a EB_CUSTOM_TOOLBAR_LIST
		require
			parent_attached: parent /= Void
		do
			if attached {like custom_parent} parent as l_result then
				Result := l_result
			end
		end

	dialog: SD_TOOL_BAR_CUSTOMIZE_DIALOG
			-- Dialog which current belong to.

feature -- Status report

	is_separator: BOOLEAN;
			-- Is button a separator?

note
	library:	"SmartDocking: Library of reusable components for Eiffel."
	copyright:	"Copyright (c) 1984-2017, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"



end -- class EB_CUSTOMIZABLE_LIST_ITEM
