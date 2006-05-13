indexing
	description: "Object that represents a search tool for EV_SEARCHABLE_COMPONENT"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EVS_GRID_SEARCH_TOOL

inherit
	EVS_GRID_SEARCH_TOOL_UTILITY

feature -- Registration

	attach_tool (a_component: like searchable_component) is
			-- Attach current to `a_component'.
		require
			not_attached: not is_tool_attached
		do
			searchable_component := a_component
			searchable_component.register_search_tool (Current)
			internal_attach
		ensure
			attached: is_tool_attached
		end

	detach_tool is
			-- Detach current from `a_component'.
		require
			attached: is_tool_attached
		do
			internal_detach
			searchable_component.remove_search_tool (Current)
			searchable_component := Void
		ensure
			not_attached: not is_tool_attached
		end

feature -- Display

	show_tool is
			-- Display current search tool.
		require
			attached: is_tool_attached
			tool_not_is_displayed: not is_tool_displayed
		deferred
		ensure
			tool_displayed: is_tool_displayed
		end

	hide_tool is
			-- Hide current search tool.
		require
			attached: is_tool_attached
			tool_is_displayed: is_tool_displayed
		deferred
		ensure
			tool_not_displayed: not is_tool_displayed
		end

feature -- Access

	searchable_component: EVS_SEARCHABLE_COMPONENT
			-- Searchable component object to which current is attached

feature -- Status report

	is_tool_displayed: BOOLEAN is
			-- Is current search tool displayed?
		deferred
		end

	is_tool_attached: BOOLEAN is
			-- Is current attached to a searchable component?
		do
			Result := searchable_component /= Void
		ensure
			good_result: Result implies searchable_component /= Void
		end


feature{NONE} -- Registration implementation

	internal_attach is
			-- Attach current to `a_component'.
		require
			attached: is_tool_attached
		deferred
		end

	internal_detach is
			-- Detach current to `a_componet'.
		require
			attached: is_tool_attached
		deferred
		end

invariant

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
