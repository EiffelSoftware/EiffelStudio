note
	description: "[
		Default implementation for accessing a tool. This uses the last focused development window to query for a tool.
		
		It is not recommended to use unless you know you are working with a focused window, or need access to shared
		tool resources that do not rely on the window itself.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class
	ES_TOOL_PROVIDER [G -> ES_TOOL [EB_TOOL]]

inherit
	ES_TOOL_PROVIDER_I

	EB_SHARED_WINDOW_MANAGER
		export
			{NONE} all
		end

create
	default_create,
	make

feature {NONE} -- Initialization

	make (a_edition: like tool_edition)
			-- Initializes a tool provider with a specific edition number.
			-- Note: If no edition is required, use `default_create'.
			--
			-- `a_edition': The edition of the tool the provider should reveal.
		require
			a_edition_positive: a_edition >= 1
		do
			tool_edition := a_edition
		ensure
			tool_edition_set: tool_edition = a_edition
		end

feature -- Access

	frozen tool: attached ES_TOOL [EB_TOOL]
			-- <Precursor>
		local
			l_shell_tools: ES_SHELL_TOOLS
			l_tool_type: TYPE [ES_TOOL [EB_TOOL]]
			l_edition: like tool_edition
		do
			l_tool_type := {G}
			l_shell_tools := window.shell_tools
			if l_shell_tools.is_multiple_edition_tool (l_tool_type) then
				l_edition := tool_edition
			end
			if l_edition > 1 then
				Result := l_shell_tools.tool_edition (l_tool_type, l_edition)
			else
				Result := l_shell_tools.tool (l_tool_type)
			end
		end

feature {NONE} -- Access

	tool_edition: NATURAL_8
			-- Optional edition of a tool.
		require
			is_interface_usable: is_interface_usable
			is_multi_edition: window.shell_tools.is_multiple_edition_tool ({G})
		attribute
			Result := 1
		ensure
			result_positive: Result >= 1
		end

	window: detachable EB_DEVELOPMENT_WINDOW
			-- Access to the development window the tool is initialized for.
			--
			--| The result type is detachable because of the use of SITE with ESF.
		do
			Result ?= window_manager.last_focused_development_window
		end

feature -- Status report

	is_interface_usable: BOOLEAN
			-- <Precursor>
		do
			Result := window /= Void and then window.is_interface_usable
		ensure then
			window_attached: window /= Void
			window_is_interface_usable: window.is_interface_usable
		end

;note
	copyright: "Copyright (c) 1984-2009, Eiffel Software"
	license:   "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options: "http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful, but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
		]"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
