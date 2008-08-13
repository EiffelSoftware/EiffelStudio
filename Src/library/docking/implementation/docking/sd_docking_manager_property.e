indexing
	description: "Docking manager properties."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	SD_DOCKING_MANAGER_PROPERTY

inherit
	SD_ACCESS

create
	make

feature {NONE}  -- Initlization

	make (a_docking_manager: SD_DOCKING_MANAGER) is
			-- Creation method.
		require
			a_docking_manager_not_void: a_docking_manager /= Void
		do
			internal_docking_manager := a_docking_manager
			create internal_clicked_list.make
		ensure
			set: internal_docking_manager = a_docking_manager
		end

feature -- Properties

	last_focus_content: SD_CONTENT
			-- Last focused zone.

	set_last_focus_content (a_content: SD_CONTENT) is
			-- Set `last_focus_content'.
		require
			not_destroyed: not is_destroyed
		do
			last_focus_content := a_content
			if a_content /= Void then
				set_content_first (a_content)
			end
		ensure
			set: last_focus_content = a_content
		end

	contents_by_click_order: ARRAYED_LIST [SD_CONTENT] is
			-- All contents by user click order.
		require
			not_destroyed: not is_destroyed
		local
			l_current_list, l_orignal_list: ARRAYED_LIST [SD_CONTENT]
			l_order_list: like internal_clicked_list
		do

			-- We don't copy add/prune actions in ACTIVE_LIST
			from
				l_orignal_list := internal_docking_manager.contents
				l_orignal_list.start
				create l_current_list.make (l_orignal_list.count)
			until
				l_orignal_list.after
			loop
				l_current_list.extend (l_orignal_list.item)
				l_orignal_list.forth
			end

			l_order_list := internal_clicked_list
			from
				create Result.make (1)
				l_order_list.start
			until
				l_order_list.after
			loop
				if l_current_list.has (l_order_list.item) then
					Result.extend (l_order_list.item)
					l_current_list.start
					l_current_list.prune (l_order_list.item)
				end
				l_order_list.forth
			end
			-- Then added SD_CONTENT which user never clicked.
			Result.append (l_current_list)
		end

	main_area_drop_actions: EV_PND_ACTION_SEQUENCE is
			-- Main area (editor area) drop acitons.
			-- This actions will be called if there is no editor zone and end user drop a stone to the void editor area.
		require
			not_destroyed: not is_destroyed
		do
			Result := internal_docking_manager.zones.place_holder_widget.drop_actions
		ensure
			not_void: Result /= Void
		end

	is_opening_config: BOOLEAN
			-- If current is opening layout config?

	docker_mediator: SD_DOCKER_MEDIATOR
			-- Manager for user dragging events.
			-- Maybe Void if user is not dragging.

	set_docker_mediator (a_mediator: SD_DOCKER_MEDIATOR) is
			-- Set `docker_mediator' with `a_mediator'.
		require
			not_destroyed: not is_destroyed
		do
			docker_mediator := a_mediator
		ensure
			set: docker_mediator = a_mediator
		end

	resizable_items_data: ARRAYED_LIST [TUPLE [name: STRING_GENERAL; width: INTEGER]] is
			-- SD_TOOL_BAR_RESIABLE_ITEM data.
		require
			not_destroyed: not is_destroyed
		local
			l_contents: ARRAYED_LIST [SD_TOOL_BAR_CONTENT]
			l_item: SD_TOOL_BAR_RESIZABLE_ITEM
			l_items: ARRAYED_LIST [SD_TOOL_BAR_ITEM]
		do
			from
				create Result.make (5)
				l_contents := internal_docking_manager.tool_bar_manager.contents
				l_contents.start
			until
				l_contents.after
			loop
				from
					l_items := l_contents.item.items
					l_items.start
				until
					l_items.after
				loop
					l_item ?= l_items.item
					if l_item /= Void then
						Result.extend ([l_item.name, l_item.widget.width])
					end
					l_items.forth
				end
				l_contents.forth
			end
		ensure
			not_void: Result /= Void
		end

feature {SD_OPEN_CONFIG_MEDIATOR} -- Setting

	set_is_opening_config (a_bool: BOOLEAN) is
			-- Set `is_opening_config' to `a_bool'
		require
			not_destroyed: not is_destroyed
		do
			is_opening_config := a_bool
		ensure
			set: is_opening_config = a_bool
		end

feature -- Contract support

	has (a_content: SD_CONTENT): BOOLEAN is
			-- Dose docking manager has a_content?
		require
			not_destroyed: not is_destroyed
		do
			Result := internal_docking_manager.contents.has (a_content)
		end

	is_destroyed: BOOLEAN
			-- If Current destroyed?

feature {NONE}  -- Implementation

	set_content_first (a_content: SD_CONTENT) is
			-- Set a_content which is just clicked by user to first of `contents_by_click_order'.
		require
			has: has (a_content)
		do
			-- LINKED_SET put_left is from LINKED_LIST, so it can't make sure one item per object instance in the set.
			internal_clicked_list.prune_all (a_content)

			internal_clicked_list.start
			internal_clicked_list.put_left (a_content)
		end

	internal_clicked_list: LINKED_SET [SD_CONTENT]
			-- User clicked SD_CONTENT order.

	internal_docking_manager: SD_DOCKING_MANAGER
			-- Docking manager which Current belong to.

feature -- Command

	destroy is
			-- Destory all underline objects
		do
			main_area_drop_actions.wipe_out
			internal_docking_manager := Void

			is_destroyed := True
		ensure
			destroyed: is_destroyed
		end

	remove_from_clicked_list (a_content: SD_CONTENT) is
			-- Remove `a_content' from `internal_clicked_list'
		require
			not_destroyed: not is_destroyed
		do
			internal_clicked_list.prune_all (a_content)
		end

invariant
	internal_clicked_list_not_void: internal_clicked_list /= Void

indexing
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






end
