indexing
	description: "Code generator for types"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	CODE_TYPE_FACTORY

inherit
	CODE_MEMBER_FACTORY

	CODE_USER_DATA_KEYS
		export
			{NONE} all
		end

feature {CODE_CONSUMER_FACTORY} -- Visitor features.

	generate_type (a_source: SYSTEM_DLL_CODE_TYPE_DECLARATION) is
			-- | Check whether `a_source' is expanded or deferred
			-- | to create instance of `CODE_GENERATED_TYPE' or `EXPANDED_TYPE' or `DEFERRED_TYPE'.
			-- | Initialize the CODE_TYPE instance with `a_source' -> Call `Initialize_type'
			-- | Set `current_type' with Void because there is no more current type
			-- | Set `last_type'.

			-- Generate Eiffel code from `a_source'.
		require
			non_void_source: a_source /= Void
			valid_source: (current_namespace /= Void implies Resolver.is_generated (Type_reference_factory.type_reference_from_declaration (a_source, current_namespace.name))) and
							(current_namespace = Void implies Resolver.is_generated (Type_reference_factory.type_reference_from_declaration (a_source, Void)))
		local
			l_type: CODE_GENERATED_TYPE
			l_name: STRING
		do
			if current_namespace /= Void then
				l_name := current_namespace.name
			end
			Resolver.search (Type_reference_factory.type_reference_from_declaration (a_source, l_name))
			check
				found: Resolver.found
			end
			l_type := Resolver.found_type
			set_current_type (l_type)
			initialize_indexing_clause (a_source)
			initialize_generic_parameters (a_source)
			initialize_parents (a_source)
			initialize_features (a_source)
			set_current_type (Void)
			set_last_type (l_type)
		ensure
			non_void_last_type: last_type /= Void
		end

feature {NONE} -- Type generation

	initialize_parents (a_source: SYSTEM_DLL_CODE_TYPE_DECLARATION) is
			-- Generate type parents from `a_source'.
		require
			non_void_source: a_source /= Void
			non_void_type: current_type /= Void
		local
			i, l_count: INTEGER
			l_parents: SYSTEM_DLL_CODE_TYPE_REFERENCE_COLLECTION
			l_parent: SYSTEM_DLL_CODE_TYPE_REFERENCE
			l_object_parent: CODE_PARENT
			l_parent_type: CODE_TYPE_REFERENCE
			l_type: SYSTEM_TYPE
		do
			l_parents := a_source.base_types
			if a_source.is_partial then
				-- We need to artificially add the parent to the class
				-- because ASP.NET doesn't do it. Microsoft added the type of
				-- the parent class in the `UserData' field of the codedom node.
				l_type ?= a_source.user_data.item (("BaseClassDefinition").to_cil)
				if l_type /= Void then
					i := l_parents.add (create {SYSTEM_DLL_CODE_TYPE_REFERENCE}.make (l_type))
				end
			end
			if l_parents /= Void then
				from
					l_count := l_parents.count
					i := 0
				until
					i = l_count
				loop
					l_parent := l_parents.item (i)
					if not l_parent.base_type.to_lower.is_equal ("valuetype") then
						l_parent_type := Type_reference_factory.type_reference_from_reference (l_parent)
						create l_object_parent.make (l_parent_type)
						current_type.add_parent (l_object_parent)
					end
					i := i + 1
				end
			end
		end

	initialize_features (a_source: SYSTEM_DLL_CODE_TYPE_DECLARATION) is
			-- | Call in loop `generate_member_from_dom'.

			-- Generate type features from `a_source'.
		require
			non_void_source: a_source /= Void
			not_empty_features: a_source.members.count > 0
		local
			i, l_count: INTEGER
			l_members: SYSTEM_DLL_CODE_TYPE_MEMBER_COLLECTION
		do
			l_members := a_source.members
			if l_members = Void then
				Event_manager.raise_event ({CODE_EVENTS_IDS}.Missing_members, ["type feature initialization"])
			else
				from
					l_count := l_members.count
				until
					i = l_count
				loop
					code_dom_generator.generate_member_from_dom (l_members.item (i))
					i := i + 1
				end
			end
		end

	initialize_indexing_clause (a_source: SYSTEM_DLL_CODE_TYPE_DECLARATION) is
			-- Initialize indexing clause of `current_type' with info of `a_source'.
		require
			non_void_a_source: a_source /= Void
			non_void_type: current_type /= Void
		local
			l_comments: SYSTEM_DLL_CODE_COMMENT_STATEMENT_COLLECTION
			i, l_count: INTEGER
			l_comment: SYSTEM_DLL_CODE_COMMENT
			l_indexing_clause: CODE_INDEXING_CLAUSE
			l_text: STRING
			l_custom_attributes: SYSTEM_DLL_CODE_ATTRIBUTE_DECLARATION_COLLECTION
		do
			-- Retrieve type comments.
			create l_indexing_clause.make
			l_indexing_clause.set_tag ("description")
			l_comments := a_source.comments
			create l_text.make (32)
			if l_comments /= Void then
				from
					l_count := l_comments.count
				until
					i = l_count
				loop
					l_comment := l_comments.item (i).comment
					if l_comment.doc_comment then
						l_text.append (l_comment.text)
					end
					i := i + 1
				end
			else
				l_text.append ("Generated type")
			end
			l_indexing_clause.set_text (l_text)

			-- Retrieve type customs attributes.
			l_custom_attributes := a_source.custom_attributes
			if l_custom_attributes /= Void then
				from
					i := 0
					l_count := l_custom_attributes.count
				until
					i = l_count
				loop
					code_dom_generator.generate_custom_attribute_declaration (l_custom_attributes.item (i))
					l_indexing_clause.add_custom_attribute (last_custom_attribute_declaration)
					i := i + 1
				end
			end
			current_type.add_indexing_clause (l_indexing_clause)
		end

	initialize_generic_parameters (a_source: SYSTEM_DLL_CODE_TYPE_DECLARATION) is
			-- Initialize generic parameters of `current_type' with info of `a_source'.
		require
			attached_source: a_source /= Void
			attached_type: current_type /= Void
		local
			l_parameters: SYSTEM_DLL_CODE_TYPE_PARAMETER_COLLECTION
			l_parameter: SYSTEM_DLL_CODE_TYPE_PARAMETER
			i, j, l_count, l_count2: INTEGER
			l_param: CODE_GENERIC_PARAMETER
			l_constraints: SYSTEM_DLL_CODE_TYPE_REFERENCE_COLLECTION
		do
			l_parameters := a_source.type_parameters
			if l_parameters /= Void then
				from
					l_count := l_parameters.count
				until
					i = l_count
				loop
					l_parameter := l_parameters.item (i)
					create l_param.make (l_parameter.name)
					l_param.set_creation_constraint (l_parameter.has_constructor_constraint)
					l_constraints := l_parameter.constraints
					if l_constraints /= Void then
						from
							l_count2 := l_constraints.count
							j := 0
						until
							j = l_count
						loop
							l_param.add_constraint (Type_reference_factory.type_reference_from_reference (l_constraints.item (j)))
							j := j + 1
						end
					end
					i := i + 1
					current_type.add_generic_parameter (l_param)
				end
			end
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
end -- class CODE_TYPE_FACTORY

--+--------------------------------------------------------------------
--| Eiffel CodeDOM Provider
--| Copyright (C) 2001-2006 Eiffel Software
--| Eiffel Software Confidential
--| All rights reserved. Duplication and distribution prohibited.
--|
--| Eiffel Software
--| 356 Storke Road, Goleta, CA 93117 USA
--| http://www.eiffel.com
--+--------------------------------------------------------------------
