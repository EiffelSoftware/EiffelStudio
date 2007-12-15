indexing
	description: "[
		The built-in help provider types ("kinds") retrievable through a help providers service interface {HELP_PROVIDERS_S}.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision $"

class
	HELP_PROVIDER_KINDS

feature -- Access

	frozen default_help: !UUID
			-- Default help system.
		once
				-- Compiled HTML help system is the default help for now.
			Result := wiki
		end

	frozen chm: !UUID
			-- Compiled HTML help system.
		once
			create Result.make_from_string (chm_uuid_string)
		end

	frozen wiki: !UUID
			-- Public Eiffel Wiki help system.
		once
			create Result.make_from_string (wiki_uuid_string)
		end

feature -- Constants

	chm_uuid_string: !STRING_8     = "E1FFE14E-B816-4675-B15D-087E948DA79A"
	wiki_uuid_string: !STRING_8    = "E1FFE14E-64D2-4F19-B2E5-BC121E228FE4"

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
