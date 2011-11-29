note
	description: "Object that represents a searchable grid with quick search bar"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EVS_SEARCHABLE_COMPONENT [G]

inherit
	EVS_GRID_WRAPPER [G]
			export
				{EVS_GRID_SEARCH_TOOL}grid
			end

create
	make

feature -- Setting

	enable_search
			-- Enable search ability.
		do
			is_search_enabled := True
		ensure
			search_enabled: is_search_enabled
		end

	disable_search
			-- Disable search ability.
		do
			is_search_enabled := False
		ensure
			search_disabled: not is_search_enabled
		end

	enable_replace
			-- Enable replace ability.
		do
			is_replace_enabled := True
		ensure
			replace_enabled: is_replace_enabled
		end

	disable_replace
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

	is_direct_start_search_enabled: BOOLEAN
			-- Is direct start search mode enabled?
			-- Direct start search mode means that if a key is pressed in `searchable_component'.`grid',
			-- Current quick search bar will be prompted automatically
			-- Default: False

feature -- Access

	component_widget: EV_WIDGET
			-- Widget of current component
		local
			l_main_container: EV_VERTICAL_BOX
			v: like component_widget_internal
		do
			v := component_widget_internal
			if v = Void then
				create l_main_container
				l_main_container.extend (grid_top_container)
				l_main_container.extend (grid)
				l_main_container.extend (grid_bottom_container)
				l_main_container.disable_item_expand (grid_top_container)
				l_main_container.disable_item_expand (grid_bottom_container)
				v := l_main_container
				component_widget_internal := v
			end
			Result := v
		ensure
			result_attached: Result /= Void
		end

	grid_top_container: EV_VERTICAL_BOX
			-- Top container for quick search bar
		local
			v: like grid_top_container_internal
		do
			v := grid_top_container_internal
			if v = Void then
				create v
				grid_top_container_internal := v
			end
			Result := v
		ensure
			result_attached: Result /= Void
		end

	grid_bottom_container: EV_VERTICAL_BOX
			-- Bottom container for quick search bar
		local
			v: like grid_bottom_container_internal
		do
			v := grid_bottom_container_internal
			if v = Void then
				create v
				grid_bottom_container_internal := v
			end
			Result := v
		ensure
			result_attached: Result /= Void
		end

feature -- Search tool

	registered_search_tool: LINKED_LIST [EVS_GRID_SEARCH_TOOL]
			-- List of registered search tool
		local
			v: like registered_search_tool_internal
		do
			v := registered_search_tool_internal
			if v = Void then
				create v.make
				registered_search_tool_internal := v
			end
			Result := v
		ensure
			result_attached: Result /= Void
		end

	register_search_tool (a_tool: EVS_GRID_SEARCH_TOOL)
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

	remove_search_tool (a_tool: EVS_GRID_SEARCH_TOOL)
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

	enable_direct_start_search
			-- Enable direct start search mode.
			-- For more information of direct start search mode, see `is_direct_start_search_enabled'.			
		do
			is_direct_start_search_enabled := True
		ensure
			direct_start_search_mode_enabled: is_direct_start_search_enabled
		end

	disable_direct_start_search
			-- Disable direct start search mode.
			-- For more information of direct start search mode, see `is_direct_start_search_enabled'.			
		do
			is_direct_start_search_enabled := False
		ensure
			direct_start_search_mode_disabled: not is_direct_start_search_enabled
		end

feature{NONE} -- Implementation

	component_widget_internal: detachable like component_widget
			-- Internal `component_widget'

	grid_top_container_internal: detachable like grid_top_container
			-- Internal `grid_top_container'

	grid_bottom_container_internal: detachable like grid_bottom_container
			-- Internal `grid_bottom_container'

	registered_search_tool_internal: detachable like registered_search_tool
			-- Internal `registered_search_tool'

invariant
	component_widget_attached: component_widget /= Void

note
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
