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

feature -- Initialization

	make (a_dlg: SD_TOOL_BAR_CUSTOMIZE_DIALOG; v: SD_TOOL_BAR_ITEM)
			-- Creation method
		require
			not_void: v /= Void
			not_void: a_dlg /= Void
		local
			l_sep: SD_TOOL_BAR_SEPARATOR
		do
			make_with_text (v.description)
			set_pixmap (v.pixmap)
			data := v
			l_sep ?= v
			if l_sep = Void then
				is_separator := False
			else
				is_separator := True
			end -- if
			set_pebble (Current)
			drop_actions.extend (agent add_to_parent_list)
			drop_actions.set_veto_pebble_function (agent a_dlg.veto_pebble_function)
			dialog := a_dlg
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
			from_pool := an_item.custom_parent.is_a_pool_list -- Picking from a pool list?
			to_pool := custom_parent.is_a_pool_list -- Dropping into a pool list?
			if an_item /= Current then
				if (not an_item.is_separator) then
					an_item.parent.start
					an_item.parent.prune (an_item)
					parent.start
					parent.search (Current)
					parent.put_right (an_item)
				elseif from_pool and then (not to_pool) then
					parent.start
					parent.search (Current)
					parent.put_right (create {SD_CUSTOMIZABLE_LIST_ITEM}.make (dialog, create {SD_TOOL_BAR_SEPARATOR}.make))
				elseif (not from_pool) and then to_pool then
					an_item.parent.start
					an_item.parent.prune (an_item)
				elseif (not from_pool) and then (not to_pool) then
					an_item.parent.start
					an_item.parent.prune (an_item)
					parent.start
					parent.search (Current)
					parent.put_right (an_item)
				end
			end
		end

feature -- Access

	data: SD_TOOL_BAR_ITEM
			-- the corresponding button

	custom_parent: SD_CUSTOM_TOOLBAR_LIST
			-- Convert `parent' into a EB_CUSTOM_TOOLBAR_LIST
		do
			Result ?= parent
		end

	dialog: SD_TOOL_BAR_CUSTOMIZE_DIALOG
			-- Dialog which current belong to.

feature -- Status report

	is_separator: BOOLEAN;
			-- Is button a separator?

note
	library:	"SmartDocking: Library of reusable components for Eiffel."
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"



end -- class EB_CUSTOMIZABLE_LIST_ITEM
