indexing
	description: "Code generator for array expressions"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$$"
	revision: "$$"		
	
class
	CODE_ARRAY_EXPRESSION_FACTORY

inherit
	CODE_EXPRESSION_FACTORY

feature {CODE_CONSUMER_FACTORY} -- Visitor features.

	generate_array_create_expression (a_source: SYSTEM_DLL_CODE_ARRAY_CREATE_EXPRESSION) is
			-- | Create instance of `CODE_ARRAY_CREATE_EXPRESSION'.
			-- | And initialize this instance with `a_source' -> Call `initialise_array_create_expression'
			-- | Set `last_expression'.
			-- Generate Eiffel code from `a_source'.
		require
			non_void_source: a_source /= Void
		local
			l_type: CODE_TYPE_REFERENCE
			l_size: INTEGER
			l_size_expression: CODE_EXPRESSION
			l_initializers: LIST [CODE_EXPRESSION]
			l_inits: SYSTEM_DLL_CODE_EXPRESSION_COLLECTION
			l_array_create_expression: CODE_ARRAY_CREATE_EXPRESSION
			l_create_type: SYSTEM_DLL_CODE_TYPE_REFERENCE
		do
			l_create_type := a_source.create_type
			if l_create_type /= Void then
				l_type := Type_reference_factory.type_reference_from_reference (l_create_type)
				l_size := a_source.size				
				if a_source.size_expression /= Void then
					code_dom_generator.generate_expression_from_dom (a_source.size_expression)
					l_size_expression := last_expression
				end
				l_inits := a_source.initializers
				l_initializers := expressions_from_collection (l_inits)
				if l_size > 0 or l_size_expression /= Void or l_initializers /= Void then
					create l_array_create_expression.make (l_type, l_size, l_size_expression, l_initializers)
					set_last_expression (l_array_create_expression)
				else
					Event_manager.raise_event ({CODE_EVENTS_IDS}.Missing_array_information, [current_context])
				end
			else
				Event_manager.raise_event ({CODE_EVENTS_IDS}.Missing_creation_type, ["array creation expression"])
			end
		ensure
			non_void_last_expression: last_expression /= Void
		end		

	generate_array_indexer_expression (a_source: SYSTEM_DLL_CODE_ARRAY_INDEXER_EXPRESSION) is
			-- | Create instance of `CODE_ARRAY_INDEXER_EXPRESSION'.
			-- | And initialize this instance with `a_source' -> Call `initialise_array_indexer_expression'
			-- | Set `last_expression'.

			-- Generate Eiffel code from `a_source'.
		require
			non_void_source: a_source /= Void
		local
			l_target: CODE_EXPRESSION
			l_indices: ARRAYED_LIST [CODE_EXPRESSION]
			l_ind: SYSTEM_DLL_CODE_EXPRESSION_COLLECTION
			i, l_count: INTEGER
		do
			if a_source.target_object /= Void then
				l_ind := a_source.indices
				if l_ind /= Void then
					code_dom_generator.generate_expression_from_dom (a_source.target_object)
					l_target := last_expression
					from
						l_count := l_ind.count
						create l_indices.make (l_count)
					until
						i = l_count
					loop
						code_dom_generator.generate_expression_from_dom (l_ind.item (i))
						l_indices.extend (last_expression)
						i := i + 1
					end
					set_last_expression (create {CODE_ARRAY_INDEXER_EXPRESSION}.make (l_target, l_indices))
				else
					event_manager.raise_event ({CODE_EVENTS_IDS}.missing_indices, ["array indexer expression"])
				end
			else
				event_manager.raise_event ({CODE_EVENTS_IDS}.missing_target_object, ["array indexer expression"])
			end
		end

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 see http://www.eiffel.com/licensing/gpl.txt)"
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


end -- class CODE_ARRAY_EXPRESSION_FACTORY

--+--------------------------------------------------------------------
--| Eiffel CodeDOM Provider
--| Copyright (C) 2001-2004 Eiffel Software
--| Eiffel Software Confidential
--| All rights reserved. Duplication and distribution prohibited.
--|
--| Eiffel Software
--| 356 Storke Road, Goleta, CA 93117 USA
--| http://www.eiffel.com
--+--------------------------------------------------------------------