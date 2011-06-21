note
	description: "Summary description for {ER_SIZE_DEFINITION_VISITOR}."
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
		local
			l_singleton: ER_SHARED_SINGLETON
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

end
