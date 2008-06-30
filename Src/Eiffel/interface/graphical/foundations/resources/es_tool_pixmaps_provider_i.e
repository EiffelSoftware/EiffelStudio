indexing
	description: "[
		A provider interface for accessing tool specific icon resources.
		
		Note: If implemented on a tool ({ES_TOOL}), nothing needs implementing. However, for peripheral objects
		      use {ES_TOOL_PIXMAPS_PROVIDER} then either use {ES_TOOL_PIXMAPS_PROVIDER} or use inherit Current
		      and implement {ES_TOOL_PROVIDER_I}'s small interface.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

deferred class
	ES_TOOL_PIXMAPS_PROVIDER_I [G -> ES_TOOL_PIXMAPS create make end, T -> ES_TOOL [EB_TOOL]]

inherit
	ES_TOOL_PROVIDER_I [T]

feature {NONE} -- Access

	frozen tool_pixmaps: !G
			-- Access to the tool pixmaps
		obsolete
			"Use tool_icons instead"
		require
			is_interface_usable: is_interface_usable
		do
			Result ?= tool_icons
		end

	frozen tool_icons: !G
			-- Access to the tool icons
		require
			is_interface_usable: is_interface_usable
		do
			if {l_icons: G} internal_new_tool_icons then
				Result := l_icons
			else
				Result ?= new_tool_icons
				internal_new_tool_icons := Result
			end
		end

feature {NONE} -- Factory

	new_tool_icons: !G
			-- Factory to create a new tool icon object.
		require
			is_interface_usable: is_interface_usable
		do
			create Result.make (({!ES_TOOL [EB_TOOL]}) #? tool, once "icons")
		end

feature {NONE} -- Implementation: Internal cache

	internal_new_tool_icons: ?G
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
