indexing
	description: "Code generator for compile units and namespaces"
	date: "$Date$"
	revision: "$Revision$"

class
	CODE_EIFFEL_FACTORY

inherit
	CODE_FACTORY

	CODE_DOM_PATH

	CODE_REFERENCED_ASSEMBLIES
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
				reset_referenced_assemblies
			until
				i = l_count
			loop
				add_referenced_assembly (l_referenced_assemblies.item (i))
				if not assembly_added then
					Event_manager.raise_event (feature {CODE_EVENTS_IDS}.Missing_reference, [l_referenced_assemblies.item (i)])
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
				Event_manager.raise_event (feature {CODE_EVENTS_IDS}.Missing_namespaces, [])
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
			set_last_compile_unit (create {CODE_SNIPPET_COMPILE_UNIT}.make (a_source.value))
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
			l_name: STRING
			l_type_attributes: TYPE_ATTRIBUTES
			l_deferred: BOOLEAN
			l_frozen: BOOLEAN
			l_expanded: BOOLEAN
			l_generated_type: CODE_GENERATED_TYPE
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
				from
					l_count := l_types.count
					i := 0
				until
					i = l_count
				loop
					l_type := l_types.item (i)
					l_type_attributes := l_type.type_attributes
					l_deferred := l_type.is_interface or (l_type_attributes & feature {TYPE_ATTRIBUTES}.Abstract = feature {TYPE_ATTRIBUTES}.Abstract)
					l_frozen := l_type_attributes & feature {TYPE_ATTRIBUTES}.Sealed = feature {TYPE_ATTRIBUTES}.Sealed
					l_expanded := l_type.is_struct
					l_type_reference := Type_reference_factory.type_reference_from_declaration (l_type, l_name)
					if l_deferred then
						create {CODE_DEFERRED_TYPE} l_generated_type.make (l_type_reference)
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
					Resolver.add_generated_type (l_generated_type)
					i := i + 1
				end
				from
					l_count := l_types.count
					i := 0
				until
					i = l_count
				loop
					code_dom_generator.generate_type_from_dom (l_types.item (i))
					l_namespace.types.extend (last_type)
					i := i + 1
				end
			else
				Event_manager.raise_event (feature {CODE_EVENTS_IDS}.Missing_types, [l_namespace.name])
			end
			set_last_namespace (l_namespace)
		ensure
			non_void_namespace: last_namespace /= Void
			non_void_compile_unit_implies_not_empty_namespaces_list: last_compile_unit /= Void implies last_compile_unit.namespaces.count > 0
		end

end -- class CODE_EIFFEL_FACTORY

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