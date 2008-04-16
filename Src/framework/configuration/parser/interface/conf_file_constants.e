indexing
	description: "Constants for the file format."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	CONF_FILE_CONSTANTS

feature {NONE} -- Constants

	Header: STRING is "<?xml version=%"1.0%" encoding=%"ISO-8859-1%"?>"
			-- xml header

	namespace_1_0_0: STRING is "http://www.eiffel.com/developers/xml/configuration-1-0-0"
			-- Namespace of the 5.7 release

	schema_1_0_0: STRING is
			-- Schema of the 5.7 release
		once
			Result := namespace_1_0_0 +" http://www.eiffel.com/developers/xml/configuration-1-0-0.xsd"
		end

	namespace_1_2_0: STRING is "http://www.eiffel.com/developers/xml/configuration-1-2-0"
			-- Namespace of the 6.0 release

	schema_1_2_0: STRING is
			-- Schema of the 6.0 release
		once
			Result := namespace_1_2_0 +" http://www.eiffel.com/developers/xml/configuration-1-2-0.xsd"
		end

	namespace_1_3_0: STRING is "http://www.eiffel.com/developers/xml/configuration-1-3-0"
			-- Namespace of the 6.1 release

	schema_1_3_0: STRING is
			-- Schema of the 6.1 release
		once
			Result := namespace_1_3_0 +" http://www.eiffel.com/developers/xml/configuration-1-3-0.xsd"
		end

	namespace_1_4_0: STRING is "http://www.eiffel.com/developers/xml/configuration-1-4-0"
			-- Namespace of the 6.2 release

	schema_1_4_0: STRING is
			-- Schema of the 6.2 release
		once
			Result := namespace_1_4_0 +" http://www.eiffel.com/developers/xml/configuration-1-4-0.xsd"
		end

	Latest_namespace: STRING is
			-- Latest configuration namespace
		once
			Result := namespace_1_4_0
		end

	Latest_schema: STRING is
			-- Latest schema location
		once
			Result := schema_1_4_0
		end

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
