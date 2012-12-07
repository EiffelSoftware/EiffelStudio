note
	description: "[
					XML tree manager when using DLL

				]"
	date: "$Date$"
	revision: "$Revision$"

class
	ER_XML_TREE_MANAGER

feature -- Command

	load_tree (a_index: INTEGER)
			-- Load from Microsoft XML ribbon markup tree
		local
			l_callback: ER_XML_CALLBACKS
			l_factory: XML_PARSER_FACTORY
			l_parser: XML_PARSER
			l_constants: ER_MISC_CONSTANTS
		do
			create l_constants
			if attached l_constants.xml_full_file_name (a_index) as l_file_name then
				create l_factory
				l_parser := l_factory.new_parser

				create l_callback.make
				l_parser.set_callbacks (l_callback)
				l_parser.parse_from_path (l_file_name)

				xml_root := l_callback.xml_root
				check set: xml_root /= Void end
			else
				check should_not_happend: False end
			end
		end

	xml_root: detachable ER_XML_TREE_ELEMENT
			-- XML root element
;note
	copyright: "Copyright (c) 1984-2012, Eiffel Software"
	license: "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
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
