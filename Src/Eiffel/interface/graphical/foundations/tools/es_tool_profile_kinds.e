indexing
	description: "[
		Tool profile kind types for determining applicablity of presence within the EiffelStudio UI for
		different profile configurations.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision $"

class
	ES_TOOL_PROFILE_KINDS

inherit
	ANY
		export
			{NONE} all
		end

feature -- Access

	frozen generic: !UUID
			-- Generic tool profile kind.
		once
			create Result.make_from_string (generic_uuid_string)
		end

	frozen eiffel: !UUID
			-- Eiffel specific tool profile kind.
		once
			create Result.make_from_string (eiffel_uuid_string)
		end

	frozen debugger: !UUID
			-- Debugger tool profile kind.
		once
			create Result.make_from_string (debugger_uuid_string)
		end

feature -- Constants

	generic_uuid_string: STRING = "00000000-0000-0000-0000-000000000000"
			-- Generic tool string UUID.

	eiffel_uuid_string: STRING = "E1FFE100-BA42-4E7A-803B-1A1235EA88C8"
			-- Eiffel specific tool string UUID.

	debugger_uuid_string: STRING = "E1FFE101-BA42-4E7A-803B-1A1235EA88C8"
			-- Debugger tool string UUID.

;indexing
	copyright:	"Copyright (c) 1984-2008, Eiffel Software"
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
