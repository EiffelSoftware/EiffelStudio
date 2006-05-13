indexing
	description: "Object that represents a searchable grid with quick search bar"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EVS_SEARCHABLE_COMPONENT

inherit
	EVS_GRID_WRAPPER
			export
				{EVS_GRID_SEARCH_TOOL}grid
			end

feature -- Setting

	enable_search is
			-- Enable search ability.
		do
			is_search_enabled := True
		ensure
			search_enabled: is_search_enabled
		end

	disable_search is
			-- Disable search ability.
		do
			is_search_enabled := False
		ensure
			search_disabled: not is_search_enabled
		end

	enable_replace is
			-- Enable replace ability.
		do
			is_replace_enabled := True
		ensure
			replace_enabled: is_replace_enabled
		end

	disable_replace is
			-- Disable replace ability.
		do
			is_replace_enabled := False
		ensure
			replace_disabled: not is_replace_enabled
		end

feature -- Status report

	is_search_enabled: BOOLEAN
			-- Is search through quick search bar and through accelerate keys enabled?

	is_replace_enabled: BOOLEAN
			-- Is replacement through advanced search panel enabled?

feature -- Access

	component_widget: EV_WIDGET is
			-- Widget of current component
		local
			l_main_container: EV_VERTICAL_BOX
		do
			if component_widget_internal = Void then
				create l_main_container
				l_main_container.extend (grid_top_container)
				l_main_container.extend (grid)
				l_main_container.extend (grid_bottom_container)
				l_main_container.disable_item_expand (grid_top_container)
				l_main_container.disable_item_expand (grid_bottom_container)
				component_widget_internal := l_main_container
			end
			Result := component_widget_internal
		ensure
			result_attached: Result /= Void
		end

	grid_top_container: EV_VERTICAL_BOX is
			-- Top container for quick search bar
		do
			if grid_top_container_internal = Void then
				create grid_top_container_internal
			end
			Result := grid_top_container_internal
		ensure
			result_attached: Result /= Void
		end

	grid_bottom_container: EV_VERTICAL_BOX is
			-- Bottom container for quick search bar
		do
			if grid_bottom_container_internal = Void then
				create grid_bottom_container_internal
			end
			Result := grid_bottom_container_internal
		ensure
			result_attached: Result /= Void
		end

feature -- Search tool

	registered_search_tool: LINKED_LIST [EVS_GRID_SEARCH_TOOL] is
			-- List of registered search tool
		do
			if registered_search_tool_internal = Void then
				create registered_search_tool_internal.make
			end
			Result := registered_search_tool_internal
		ensure
			result_attached: Result /= Void
		end

	register_search_tool (a_tool: EVS_GRID_SEARCH_TOOL) is
			-- Register `a_tool' into Current
		require
			a_tool_attached: a_tool /= Void
		do
			if not registered_search_tool.has (a_tool) then
				registered_search_tool.extend (a_tool)
			end
		ensure
			a_tool_registered: registered_search_tool.has (a_tool)
		end

	remove_search_tool (a_tool: EVS_GRID_SEARCH_TOOL) is
			-- Remove `a_tool' from Current.
		require
			a_tool_attached: a_tool /= Void
		do
			registered_search_tool.search (a_tool)
			if not registered_search_tool.exhausted then
				registered_search_tool.remove
			end
		ensure
			a_tool_removed: not registered_search_tool.has (a_tool)
		end

feature{NONE} -- Implementation

	component_widget_internal: like component_widget
			-- Internal `component_widget'

	grid_top_container_internal: like grid_top_container
			-- Internal `grid_top_container'

	grid_bottom_container_internal: like grid_bottom_container
			-- Internal `grid_bottom_container'

	registered_search_tool_internal: like registered_search_tool
			-- Internal `registered_search_tool'

invariant
	component_widget_attached: component_widget /= Void

indexing
        copyright:	"Copyright (c) 1984-2006, Eiffel Software"
        license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
        licensing_options:	"http://www.eiffel.com/licensing"
        copying: "[
                        This file is part of Eiffel Software's Eiffel Development Environment.
                        
                        Eiffel Software's Eiffel Development Environment is free
                        software; you can redistribute it and/or modify it under
                        the terms of the GNU General Public License as published
                        by the Free Software Foundation, version 2 of the License
                        (available at the URL listed under "license" above).
                        
                        Eiffel Software's Eiffel Development Environment is
                        distributed in the hope that it will be useful,	but
                        WITHOUT ANY WARRANTY; without even the implied warranty
                        of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
                        See the	GNU General Public License for more details.
                        
                        You should have received a copy of the GNU General Public
                        License along with Eiffel Software's Eiffel Development
                        Environment; if not, write to the Free Software Foundation,
                        Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
                ]"
        source: "[
                         Eiffel Software
                         356 Storke Road, Goleta, CA 93117 USA
                         Telephone 805-685-1006, Fax 805-685-6869
                         Website http://www.eiffel.com
                         Customer support http://support.eiffel.com
                ]"


end
