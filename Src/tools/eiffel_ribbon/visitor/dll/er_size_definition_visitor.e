note
	description: "[
					Size definition vistor when using DLL
			]"
	date: "$Date$"
	revision: "$Revision$"

class
	ER_SIZE_DEFINITION_VISITOR

inherit
	ER_VISITOR
		redefine
			visit_size_definitions
		end

feature -- Command

	visit_size_definitions (a_ribbon_size_definitions: ER_XML_TREE_ELEMENT)
			-- <Precursor>
			-- When using DLL for saving, size definitions in different Ribbon markup XML are same.
			-- When loading size definitions, `sub_root_xml_hash_table' only has size definitions loaded from last file.
			-- This is OK, since the size definitions in all Ribbon markup XMLs are same.
		local
			l_singleton: ER_SHARED_TOOLS
			l_size_definition_tool: detachable ER_SIZE_DEFINITION_EDITOR
			l_writer: ER_SIZE_DEFINITION_WRITER
			l_name: detachable STRING
		do
			if a_ribbon_size_definitions.name.same_string (constants.ribbon_size_definitions) then
				create l_singleton
				l_size_definition_tool := l_singleton.size_definition_cell.item
				if l_size_definition_tool /= Void then
					from
						l_writer := l_size_definition_tool.size_definition_writer
						l_writer.sub_root_xml_hash_table.wipe_out
						a_ribbon_size_definitions.start
					until
						a_ribbon_size_definitions.after
					loop
						if attached {ER_XML_TREE_ELEMENT} a_ribbon_size_definitions.item_for_iteration as l_element and then
							l_element.name.same_string (constants.size_definition) then
							from
								l_element.start
							until
								l_element.after
							loop
								if attached {XML_ATTRIBUTE} l_element.item_for_iteration as l_attribute and then
									l_attribute.name.same_string (constants_attribute.name) then
									l_name := l_attribute.value
								end
								l_element.forth
							end
							if l_name /= Void then
								l_writer.sub_root_xml_hash_table.put (l_element, l_name)
							end
						end

						a_ribbon_size_definitions.forth
					end

					l_size_definition_tool.size_definition_writer.update_combo_box (l_size_definition_tool.name_combo_box, void)
				end

			end
		end

note
	copyright: "Copyright (c) 1984-2011, Eiffel Software"
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
