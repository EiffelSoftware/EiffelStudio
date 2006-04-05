indexing
	description: "Code generator for compile units and namespaces"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	CODE_EIFFEL_FACTORY

inherit
	CODE_FACTORY

	CODE_DOM_PATH

	CODE_SHARED_REFERENCED_ASSEMBLIES
		export
			{NONE} all
		end

	CODE_SHARED_TYPE_REFERENCE_FACTORY
		export
			{NONE} all
		end

feature {CODE_CONSUMER_FACTORY} -- Visitor features.

	generate_compile_unit (a_source: SYSTEM_DLL_CODE_COMPILE_UNIT) is
			-- | Create an instance of `CODE_COMPILE_UNIT'.
			-- | Initialize this instance with `a_source'
			-- | Set `last_compile_unit'.

			-- Generate Eiffel code from `a_source'.
		require
			non_void_source: a_source /= Void
		local
			l_namespaces: SYSTEM_DLL_CODE_NAMESPACE_COLLECTION
			l_code_namespaces: LIST [CODE_NAMESPACE]
			i, l_count: INTEGER
			l_referenced_assemblies: SYSTEM_DLL_STRING_COLLECTION
			l_compile_unit: CODE_COMPILE_UNIT
		do
			l_referenced_assemblies := a_source.referenced_assemblies
			from
				l_count := l_referenced_assemblies.count
				reset
			until
				i = l_count
			loop
				if not Referenced_assemblies.has_file (l_referenced_assemblies.item (i)) then
					Referenced_assemblies.extend_file (l_referenced_assemblies.item (i))
					if not Referenced_assemblies.assembly_added then
						Event_manager.raise_event ({CODE_EVENTS_IDS}.Missing_reference, [l_referenced_assemblies.item (i)])
					end
				end
				i := i + 1
			end
			l_namespaces := a_source.namespaces
			if l_namespaces /= Void then
				from
					i := 0
					l_count := l_namespaces.count
					create {ARRAYED_LIST [CODE_NAMESPACE]} l_code_namespaces.make (l_count)
				until
					i = l_count
				loop
					generate_namespace (l_namespaces.item (i))
					l_code_namespaces.extend (last_namespace)
					i := i + 1
				end
				create l_compile_unit.make (l_code_namespaces)
			else
				create l_compile_unit.make (create {ARRAYED_LIST [CODE_NAMESPACE]}.make (0))
				Event_manager.raise_event ({CODE_EVENTS_IDS}.Missing_namespaces, [])
			end
			set_last_compile_unit (l_compile_unit)
		ensure
			non_void_compile_unit: last_compile_unit /= Void
		end

	generate_snippet_compile_unit (a_source: SYSTEM_DLL_CODE_SNIPPET_COMPILE_UNIT) is
			-- | Create an instance of `CODE_SNIPPET_COMPILE_UNIT'.
			-- | Initialize this instance with `a_source'
			-- | Set `last_compile_unit'.

			-- Generate Eiffel code from `a_source'.
		require
			non_void_source: a_source /= Void
		do
			set_last_compile_unit (create {CODE_SNIPPET_COMPILE_UNIT}.make (a_source))
		ensure
			non_void_compile_unit: last_compile_unit /= Void
		end

	generate_namespace (a_source: SYSTEM_DLL_CODE_NAMESPACE) is
			-- | Create instance of `CODE_NAMESPACE'.
			-- | Set `current_namespace' with `a_namespace'
			-- | Initialize this instance with `a_source'
			-- | Set `current_namespace' with Void because there is no more current namespace
			-- | Set `last_namespace'.

			-- Generate Eiffel code from `a_source'.
		require
			non_void_source: a_source /= Void
		local
			i, l_count: INTEGER
			l_imports: SYSTEM_DLL_CODE_NAMESPACE_IMPORT_COLLECTION
			l_namespace: CODE_NAMESPACE
			l_types: SYSTEM_DLL_CODE_TYPE_DECLARATION_COLLECTION
			l_type: SYSTEM_DLL_CODE_TYPE_DECLARATION
			l_type_reference: CODE_TYPE_REFERENCE
			l_type_attributes: TYPE_ATTRIBUTES
			l_deferred, l_frozen, l_expanded: BOOLEAN
			l_generated_type: CODE_GENERATED_TYPE
			l_deferred_type: CODE_DEFERRED_TYPE
			l_generated_types: LIST [CODE_GENERATED_TYPE]
			l_all_features: HASH_TABLE [CODE_FEATURE, STRING]
			l_feature: CODE_FEATURE
			l_name, l_unique_name, l_counter: STRING
			l_parents: CODE_PARENT_COLLECTION
			l_is_interface: BOOLEAN
		do
			create l_namespace.make (a_source.name)
			set_current_namespace (l_namespace)
			if a_source.name /= Void and then a_source.name.length > 0 then
				l_name := a_source.name
			end
			from
				l_imports := a_source.imports
				l_count := l_imports.count
			until
				i = l_count
			loop
				l_namespace.add_import (l_imports.item (i).namespace)
				i := i + 1
			end
			l_types := a_source.types
			if l_types /= Void then

				-- First initialize generated types from codedom types
				from
					l_count := l_types.count
					i := 0
				until
					i = l_count
				loop
					l_type := l_types.item (i)
					l_type_attributes := l_type.type_attributes
					l_deferred := l_type.is_interface or (l_type_attributes & {TYPE_ATTRIBUTES}.Abstract = {TYPE_ATTRIBUTES}.Abstract)
					l_frozen := l_type_attributes & {TYPE_ATTRIBUTES}.Sealed = {TYPE_ATTRIBUTES}.Sealed
					l_expanded := l_type.is_struct
					l_type_reference := Type_reference_factory.type_reference_from_declaration (l_type, l_name)
					if l_deferred then
						create l_deferred_type.make (l_type_reference)
						if l_type.is_interface then
							l_deferred_type.set_is_interface
						end
						l_generated_type := l_deferred_type
					end
					if l_frozen then
						if l_expanded then
							create {CODE_FROZEN_EXPANDED_TYPE} l_generated_type.make (l_type_reference)
						else
							create {CODE_FROZEN_TYPE} l_generated_type.make (l_type_reference)
						end
					elseif l_expanded then
						create {CODE_EXPANDED_TYPE} l_generated_type.make (l_type_reference)
					else
						create {CODE_GENERATED_TYPE} l_generated_type.make (l_type_reference)
					end
					l_generated_type.set_partial (l_type.is_partial)
					Resolver.add_generated_type (l_generated_type)
					i := i + 1
				end

				-- Then process generated types and put result in generated namespace
				from
					i := 0
				until
					i = l_count
				loop
					code_dom_generator.generate_type_from_dom (l_types.item (i))
					l_namespace.types.extend (last_type)
					i := i + 1
				end

				-- Finally check for rename clauses, this needs to be done after the generation is complete
				-- as we need the class hierarchy
				from
					l_generated_types := l_namespace.types
					l_generated_types.start
				until
					l_generated_types.after
				loop
					l_generated_type := l_generated_types.item
					l_all_features := l_generated_type.all_features
					l_parents := l_generated_type.parents
					from
						l_all_features.start
					until
						l_all_features.after
					loop
						l_feature := l_all_features.item_for_iteration
						l_name := l_feature.eiffel_name
						if not l_feature.is_redefined and l_parents.has_feature (l_name) then
							l_type_reference := l_parents.parent_type_with_homonym
							Resolver.search (l_type_reference)
							if Resolver.found then
								l_deferred_type ?= Resolver.found_type
								l_is_interface := l_deferred_type /= Void and then l_deferred_type.is_interface
							else
								l_is_interface := l_type_reference.dotnet_type /= Void and then l_type_reference.dotnet_type.is_interface
							end
							if not l_is_interface then
								-- Only add rename clause if parent is not an interface as otherwise method is not flagged as being redefined
								l_counter := rename_counter.out
								create l_unique_name.make (l_name.count + l_counter.count + 1)
								l_unique_name.append (l_name)
								l_unique_name.append_character ('_')
								l_unique_name.append (l_counter)
								l_generated_type.add_rename_clause (l_type_reference, Type_reference_factory.type_reference_from_code (l_generated_type).member_from_code (l_feature), l_unique_name)
							end
						end
						l_all_features.forth
					end
					l_generated_types.forth
				end
			else
				Event_manager.raise_event ({CODE_EVENTS_IDS}.Missing_types, [l_namespace.name])
			end
			set_last_namespace (l_namespace)
		ensure
			non_void_namespace: last_namespace /= Void
			non_void_compile_unit_implies_not_empty_namespaces_list: last_compile_unit /= Void implies last_compile_unit.namespaces.count > 0
		end

	rename_counter: INTEGER is
			-- Counter starting at 2 and automatically incremented after each query
		do
			if rename_counter_cell = Void then
				rename_counter_cell := 1
			end
			rename_counter_cell.set_item (rename_counter_cell.item + 1)
			Result := rename_counter_cell.item
		end

	rename_counter_cell: INTEGER_REF;
			-- Cell for counter

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
end -- class CODE_EIFFEL_FACTORY

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
