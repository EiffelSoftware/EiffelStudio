note
	description: "Class browser filter which used an agent to perform its filtering ability"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	EB_CLASS_BROWSER_AGENT_FILTER [G]

inherit
	EB_CLASS_BROWSER_FILTER [G]

create
	make

feature{NONE} -- Initialization

	make (a_function: like selection_function)
			-- Initialized `selection_function' with `a_function'.
		do
			set_selection_function (a_function)
		end

feature -- Access

	selection_function: FUNCTION [ANY, TUPLE [a_data: G; a_context: EB_CLASS_BROWSER_FILTER_CONTEXT [G]; a_viewer: EB_CLASS_BROWSER_GRID_VIEW [ANY]], BOOLEAN]
			-- Function used to decide if `a_data' can come through Current filter and to be displayed in `a_viewer'.
			-- `a_context' is the context to help to decide the filtered result.

feature -- Status report

	is_selected (a_data: G; a_context: EB_CLASS_BROWSER_FILTER_CONTEXT [G]; a_viewer: EB_CLASS_BROWSER_GRID_VIEW [ANY]): BOOLEAN
			-- Can `a_data' come through Current filter?
			-- True means that `a_data' can be displayed in `a_viewer', False means it should be appressed.
			-- `a_viewer' is the view to from which Current filter is used.
			-- `a_context' is possible context to help to decide if `a_data' is filtered out.
		do
			Result := selection_function.item ([a_data, a_context, a_viewer])
		end

feature -- Setting

	set_selection_function (a_function: like selection_function )
			-- Set `selection_function' with `a_function'.
		require
			a_function_attached: a_function /= Void
		do
			selection_function := a_function
		ensure
			selection_function_set: selection_function = a_function
		end

invariant
	selection_function_attached: selection_function /= Void

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
