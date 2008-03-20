indexing
	description: "[
		Base visitor iterator for visiting code template models.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

deferred class
	CODE_TEMPLATE_VISITOR_ITERATOR

inherit
	CODE_TEMPLATE_VISITOR_I
		redefine
			process_code_category_collection,
			process_code_declaration_collection,
			process_code_template_collection,
			process_code_template_definition
		end

feature {CODE_NODE} -- Processing

	process_code_category_collection (a_value: !CODE_CATEGORY_COLLECTION)
			-- Process object `a_value'.
		do
			process_collection (({!CODE_COLLECTION [ANY]}) #? a_value)
		end

	process_code_declaration_collection (a_value: !CODE_DECLARATION_COLLECTION)
			-- Process object `a_value'.
		do
			process_collection (({!CODE_COLLECTION [ANY]}) #? a_value)
		end

	process_code_template_collection (a_value: !CODE_TEMPLATE_COLLECTION)
			-- Process object `a_value'.
		do
			process_collection (({!CODE_COLLECTION [ANY]}) #? a_value)
		end

	process_code_template_definition (a_value: !CODE_TEMPLATE_DEFINITION)
			-- Process object `a_value'.
		do
			if is_applicable_visitation_entity (a_value.metadata) then
				process_code_metadata (a_value.metadata)
			end
			if is_applicable_visitation_entity (a_value.declarations) then
				process_code_declaration_collection (a_value.declarations)
			end
			if is_applicable_visitation_entity (a_value.templates) then
				process_code_template_collection (a_value.templates)
			end
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
