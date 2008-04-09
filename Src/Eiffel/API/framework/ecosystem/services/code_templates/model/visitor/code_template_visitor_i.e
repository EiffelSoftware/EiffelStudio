indexing
	description: "[
		Visitor interface for visiting a code template model.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

deferred class
	CODE_TEMPLATE_VISITOR_I

inherit
	USABLE_I

feature {CODE_NODE} -- Processing

	process_code_category_collection (a_value: !CODE_CATEGORY_COLLECTION)
			-- Process object `a_value'.
		require
			is_interface_usable: is_interface_usable
			is_applicable_visitation_entity: is_applicable_visitation_entity (a_value)
		deferred
		end

	process_code_declaration_collection (a_value: !CODE_DECLARATION_COLLECTION)
			-- Process object `a_value'.
		require
			is_interface_usable: is_interface_usable
			is_applicable_visitation_entity: is_applicable_visitation_entity (a_value)
		deferred
		end

	process_code_literal_declaration (a_value: !CODE_LITERAL_DECLARATION)
			-- Process object `a_value'.
		require
			is_interface_usable: is_interface_usable
			is_applicable_visitation_entity: is_applicable_visitation_entity (a_value)
		deferred
		end

	process_code_metadata (a_value: !CODE_METADATA)
			-- Process object `a_value'.
		require
			is_interface_usable: is_interface_usable
			is_applicable_visitation_entity: is_applicable_visitation_entity (a_value)
		deferred
		end

	process_code_object_declaration (a_value: !CODE_OBJECT_DECLARATION)
			-- Process object `a_value'.
		require
			is_interface_usable: is_interface_usable
			is_applicable_visitation_entity: is_applicable_visitation_entity (a_value)
		deferred
		end

	process_code_template (a_value: !CODE_TEMPLATE)
			-- Process object `a_value'.
		require
			is_interface_usable: is_interface_usable
			is_applicable_visitation_entity: is_applicable_visitation_entity (a_value)
		deferred
		end

	process_code_template_collection (a_value: !CODE_TEMPLATE_COLLECTION)
			-- Process object `a_value'.
		require
			is_interface_usable: is_interface_usable
			is_applicable_visitation_entity: is_applicable_visitation_entity (a_value)
		deferred
		end

	process_code_template_definition (a_value: !CODE_TEMPLATE_DEFINITION)
			-- Process object `a_value'.
		require
			is_interface_usable: is_interface_usable
			is_applicable_visitation_entity: is_applicable_visitation_entity (a_value)
		deferred
		end

	process_code_versioned_template (a_value: !CODE_VERSIONED_TEMPLATE)
			-- Process object `a_value'.
		require
			is_interface_usable: is_interface_usable
			is_applicable_visitation_entity: is_applicable_visitation_entity (a_value)
		deferred
		end

feature {NONE} -- Processing

	process_collection (a_collection: !CODE_COLLECTION [ANY])
			-- Processes a collection of code nodes.
			--
			-- `a_collection': The collection items to process.	
		require
			is_interface_usable: is_interface_usable
		local
			l_items: !DS_BILINEAR [ANY]
		do
			l_items := a_collection.items
			l_items.do_all (agent (a_node: ANY)
				do
					if {l_node: !CODE_NODE} a_node and then is_applicable_visitation_entity (l_node) then
						l_node.process (({!CODE_TEMPLATE_VISITOR_I}) #? Current)
					end
				end)
		end

feature {CODE_NODE} -- Query

	is_applicable_visitation_entity (a_value: !ANY): BOOLEAN
			-- Determines if object instance `a_value' is applicable for a visitation
		do
			Result := True
		end

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
