indexing
	description: "[
		Abstract inferface for tools/UI where stones can set and synchronized.
		
		This class is designed to be inherited from {ES_TOOL} or {ES_DOCKABLE_TOOL_PANEL}
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

deferred class
	ES_TOOL_PIXMAPS_PROVIDER [G -> ES_TOOL_PIXMAPS create make end]

inherit
	USABLE_I
		undefine
			copy,
			is_equal,
			out
		end

feature -- Access

	tool_pixmaps: !G
			-- Access to the tool pixmaps
		require
			is_interface_usable: is_interface_usable
		do
			if {l_pixmaps: G} internal_tool_pixmaps then
				Result := l_pixmaps
			else
				Result ?= new_tool_pixmaps
				internal_tool_pixmaps := Result
			end
		end

feature {NONE} -- Access

	tool: !ES_TOOL [EB_TOOL]
			-- The associated tool to provide the pixmaps for.
		require
			is_interface_usable: is_interface_usable
		deferred
		ensure
			result_is_interface_usable: Result.is_interface_usable
		end

feature {NONE} -- Factory

	new_tool_pixmaps: !G
			-- Factory to create a new tool icon object.
		require
			is_interface_usable: is_interface_usable
		do
			create Result.make (tool, once "icons")
		end

feature {NONE} -- Implementation: Internal cache

	internal_tool_pixmaps: ?G
			-- Cached version of `tool_pixmaps'.
			-- Note: Do not use directly!

;indexing
	copyright:	"Copyright (c) 1984-2007, Eiffel Software"
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
