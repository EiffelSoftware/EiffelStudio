note
	description: "Cleaner to reset widgets, then the widgets will be useable again."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	SD_WIDGET_CLEANER

inherit
	SD_ACCESS

create
	make

feature {NONE} -- Initialization

	make (a_docking_manager: SD_DOCKING_MANAGER)
			-- Creation method
		require
			a_docking_manager_not_void: a_docking_manager /= Void
		do
			internal_docking_manager := a_docking_manager
		ensure
			set: internal_docking_manager = a_docking_manager
		end

feature -- General command

	reset_all_to_default (a_tool_only: BOOLEAN)
			-- After `clean_up_for_open_all_config', this feature will insert editor place holder
		local
			l_place_holder_content: SD_CONTENT
		do
			clean_up_for_open_all_config (a_tool_only)

			internal_docking_manager.unlock
			internal_docking_manager.tool_bar_manager.unlock
			l_place_holder_content := internal_docking_manager.zones.place_holder_content
			if not internal_docking_manager.has_content (l_place_holder_content) then
				internal_docking_manager.contents.extend (l_place_holder_content)
			end
			l_place_holder_content.set_top ({SD_ENUMERATION}.top)

			if attached {SD_PLACE_HOLDER_ZONE} l_place_holder_content.state.zone as lt_zone then
				-- Maybe `user_widget' is cleared
				if not lt_zone.has_recursive (l_place_holder_content.user_widget) then
					lt_zone.extend (l_place_holder_content)
				end
			end

		end

	clean_up_for_open_all_config (a_tool_only: BOOLEAN)
			-- Clear all widgets
		do
			clean_up_mini_tool_bar
			clean_up_tool_bars
			clear_up_containers (a_tool_only)
			clear_up_floating_zones
		end

feature -- Command

	clear_up_floating_zones
			-- Clear up all floating zones
		local
			l_floating_zones: ARRAYED_LIST [SD_FLOATING_ZONE]
			l_item: SD_FLOATING_ZONE
		do
			l_floating_zones := internal_docking_manager.query.floating_zones
			from
				l_floating_zones.start
			until
				l_floating_zones.after
			loop
				l_item := l_floating_zones.item

				internal_docking_manager.inner_containers.start
				internal_docking_manager.inner_containers.prune (l_item.inner_container)

				if attached {EV_WIDGET} l_item as lt_widget then
					lt_widget.destroy
				else
					check not_possible: False end
				end

				l_floating_zones.forth
			end
		end

	clean_up_tool_bar_containers
			-- Wipe out all tool bar containers
		local
			l_cont: SD_TOOL_BAR_CONTAINER
		do
			l_cont := internal_docking_manager.tool_bar_container
			l_cont.top.wipe_out
			l_cont.bottom.wipe_out
			l_cont.left.wipe_out
			l_cont.right.wipe_out
		end

	clear_up_containers (a_tool_only: BOOLEAN)
			-- Wipe out all containers in docking library.
			-- `a_tool_only' means only remove tool related data (not clean editor related data)
		local
			l_all_main_containers: ARRAYED_LIST [SD_MULTI_DOCK_AREA]
			l_all_contents: ARRAYED_LIST [SD_CONTENT]
			l_content: SD_CONTENT
			l_parent: detachable EV_CONTAINER
			l_floating_tool_bars: ARRAYED_LIST [SD_FLOATING_TOOL_BAR_ZONE]
			l_zones: ARRAYED_LIST [SD_ZONE]
			l_query: SD_DOCKING_MANAGER_QUERY
		do
			internal_docking_manager.command.remove_auto_hide_zones (False)
			l_all_main_containers := internal_docking_manager.inner_containers
			from
				l_all_main_containers.start
			until
				l_all_main_containers.after
			loop
				l_all_main_containers.item.wipe_out
				l_all_main_containers.forth
			end

			-- Remove auto hide panel widgets
			l_query := internal_docking_manager.query
			l_query.auto_hide_panel ({SD_ENUMERATION}.top).tab_stubs.wipe_out
			l_query.auto_hide_panel ({SD_ENUMERATION}.top).set_minimum_height (0)

			l_query.auto_hide_panel ({SD_ENUMERATION}.bottom).tab_stubs.wipe_out
			l_query.auto_hide_panel ({SD_ENUMERATION}.bottom).set_minimum_height (0)

			l_query.auto_hide_panel ({SD_ENUMERATION}.left).tab_stubs.wipe_out
			l_query.auto_hide_panel ({SD_ENUMERATION}.left).set_minimum_width (0)

			l_query.auto_hide_panel ({SD_ENUMERATION}.right).tab_stubs.wipe_out
			l_query.auto_hide_panel ({SD_ENUMERATION}.right).set_minimum_width (0)

			l_zones := internal_docking_manager.zones.zones
			if a_tool_only then
				-- We are only restore tools data now
                from
                    l_zones.start
                until
                    l_zones.after
                loop
                    if l_zones.item.content.type /= {SD_ENUMERATION}.editor then
                    	l_zones.remove
					else
                    	l_zones.forth
                    end
                end
			else
				l_zones.wipe_out
			end

			-- Remove tool bar containers
			clean_up_tool_bar_containers

			-- Remove floating tool bar containers
			l_floating_tool_bars := internal_docking_manager.tool_bar_manager.floating_tool_bars
			from
				l_floating_tool_bars.start
			until
				l_floating_tool_bars.after
			loop
				l_floating_tool_bars.item.destroy
				l_floating_tool_bars.forth
			end
			l_floating_tool_bars.wipe_out

			l_all_contents := internal_docking_manager.contents
			from
				l_all_contents.start
			until
				l_all_contents.after
			loop
				l_content := l_all_contents.item
				l_parent := l_content.user_widget.parent
				if a_tool_only then
					-- We only restore tools config now.
					if l_content.type /= {SD_ENUMERATION}.editor then
						if l_parent /= Void then
							l_parent.prune_all (l_content.user_widget)
						end
					end
				else
					if l_parent /= Void then
						l_parent.prune_all (l_content.user_widget)
					end
				end

				l_all_contents.forth
			end
		ensure
			cleared: not internal_docking_manager.query.inner_container_main.full
		end

	clean_up_tool_bars
			-- Clean up all tool bars
		local
			l_contents: ARRAYED_LIST [SD_TOOL_BAR_CONTENT]
		do
			from
				l_contents := internal_docking_manager.tool_bar_manager.contents
				l_contents.start
			until
				l_contents.after
			loop
				l_contents.item.clear
				l_contents.item.set_visible (False)
				l_contents.forth
			end
		end

	clean_up_mini_tool_bar
			-- Clean up all mini tool bars' parents
		local
			l_contents: ARRAYED_LIST [SD_CONTENT]
			l_mini_tool_bar: detachable EV_WIDGET
			l_parent: detachable EV_CONTAINER
		do
			l_contents := internal_docking_manager.contents
			from
				l_contents.start
			until
				l_contents.after
			loop
				l_mini_tool_bar := l_contents.item.mini_toolbar
				if l_mini_tool_bar /= Void then
					l_parent := l_mini_tool_bar.parent
					if l_parent /= Void then
						l_parent.prune (l_mini_tool_bar)
						l_parent.destroy
					end
				end
				l_contents.forth
			end
		end

	clean_up_all_editors
			-- Clean up all editors
			-- Remove all parents of all editors
		local
			l_contents: ARRAYED_LIST [SD_CONTENT]
			l_content: SD_CONTENT
			l_parent: detachable EV_CONTAINER
		do
			l_contents := internal_docking_manager.contents
			from
				l_contents.start
			until
				l_contents.after
			loop
				l_content := l_contents.item
				if l_content.type = {SD_ENUMERATION}.editor then
					l_parent := l_content.user_widget.parent
					if l_parent /= Void	then
						l_parent.prune (l_content.user_widget)
					end
					-- Maybe uesr_widget is hidden because minimize
					l_content.user_widget.show
				end
				l_contents.forth
			end
			if attached {EV_WIDGET} internal_docking_manager.zones.place_holder_content.state.zone as l_place_holder_widget then
				l_parent := l_place_holder_widget.parent
				if l_parent /= Void then
					l_parent.prune (l_place_holder_widget)
				end
			end
		end

feature {NONE} -- Implementation

	internal_docking_manager: SD_DOCKING_MANAGER
			-- Docking manager which Current belong to

;note
	library:	"SmartDocking: Library of reusable components for Eiffel."
	copyright:	"Copyright (c) 1984-2016, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
