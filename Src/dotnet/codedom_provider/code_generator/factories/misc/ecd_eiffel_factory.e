indexing
	description: "Code generator for compile units and namespaces"
	date: "$Date$"
	revision: "$Revision$"

class
	ECD_EIFFEL_FACTORY

inherit
	ECD_FACTORY

	ECD_CODE_DOM_PATH

feature {ECD_CONSUMER_FACTORY} -- Visitor features.

	generate_compile_unit (a_source: SYSTEM_DLL_CODE_COMPILE_UNIT) is
			-- | Create an instance of `EG_COMPILE_UNIT'.
			-- | Initialize this instance with `a_source'
			-- | Set `last_compile_unit'.

			-- Generate Eiffel code from `a_source'.
		require
			non_void_source: a_source /= Void
		local
			a_compile_unit: ECD_COMPILE_UNIT
		do
			create a_compile_unit.make
			initialize_compile_unit (a_source, a_compile_unit)
			set_last_compile_unit (a_compile_unit)
		ensure
			non_void_compile_unit: last_compile_unit /= Void
			compile_unit_generated: last_compile_unit.ready
		end

	generate_snippet_compile_unit (a_source: SYSTEM_DLL_CODE_SNIPPET_COMPILE_UNIT) is
			-- | Create an instance of `ECD_SNIPPET_COMPILE_UNIT'.
			-- | Initialize this instance with `a_source'
			-- | Set `last_compile_unit'.

			-- Generate Eiffel code from `a_source'.
		require
			non_void_source: a_source /= Void
		local
			a_snippet_compile_unit: ECD_SNIPPET_COMPILE_UNIT
		do
			create a_snippet_compile_unit.make
			a_snippet_compile_unit.set_value (a_source.value)
			set_last_compile_unit (a_snippet_compile_unit)
		ensure
			non_void_compile_unit: last_compile_unit /= Void
			compile_unit_ready: last_compile_unit.ready
		end

	generate_namespace (a_source: SYSTEM_DLL_CODE_NAMESPACE) is
			-- | Create instance of `ECD_NAMESPACE'.
			-- | Set `current_namespace' with `a_namespace'
			-- | Initialize this instance with `a_source'
			-- | Set `current_namespace' with Void because there is no more current namespace
			-- | Set `last_namespace'.

			-- Generate Eiffel code from `a_source'.
		require
			non_void_source: a_source /= Void
		local
			a_namespace: ECD_NAMESPACE
		do
			create a_namespace.make
			set_current_namespace (a_namespace)
			initialize_namespace (a_source, a_namespace)
			set_current_namespace (Void)
			set_last_namespace (a_namespace)
		ensure
			non_void_namespace: last_namespace /= Void
			non_void_compile_unit_implies_not_empty_namespaces_list: last_compile_unit /= Void implies last_compile_unit.namespaces.count > 0
			namespace_generated: last_namespace.ready
		end

feature {NONE} -- Implementation

	initialize_compile_unit (a_source: SYSTEM_DLL_CODE_COMPILE_UNIT; a_compile_unit: ECD_COMPILE_UNIT) is
			-- | Initialize `assemblies'
			-- | Call in loop `generate_namespace_from_dom'.
			-- | Add all types found in Namespace in `eg_generated_types'
			-- | Add `last_name_space' to `last_compile_unit'

			-- Generate compile unit namespaces from `a_source'.
		require
			non_void_source: a_source /= Void
			not_empty_namespaces_list: a_source.namespaces.count > 0
			non_void_compil_unit: a_compile_unit /= Void
		local
			i, j, l_count: INTEGER
			l_namespaces: SYSTEM_DLL_CODE_NAMESPACE_COLLECTION
			l_namespace: SYSTEM_DLL_CODE_NAMESPACE
			l_types: SYSTEM_DLL_CODE_TYPE_DECLARATION_COLLECTION
		do	
			Resolver.clear_all_local_variables

			l_namespaces := a_source.namespaces
			if l_namespaces /= Void then
				from
				until
					i = l_namespaces.count
				loop
					l_namespace := l_namespaces.item (i)
					from
						j := 0
						l_types := l_namespace.types
						l_count := l_types.count
					until
						j = l_count
					loop
						Resolver.add_generated_type (l_types.item (j).name)
						j := j + 1
					end
					code_dom_generator.generate_namespace_from_dom (l_namespace)
					a_compile_unit.namespaces.extend (last_namespace)
					i := i + 1
				end
			else
				(create {ECD_EVENT_MANAGER}).raise_event (feature {ECD_EVENTS_IDS}.Missing_namespaces, [])
			end
		end	

	initialize_namespace (a_source: SYSTEM_DLL_CODE_NAMESPACE; a_namespace: ECD_NAMESPACE) is
			-- | Call in loop `generate_type_from_dom'.
	
			-- Generate namespace types with no parents from `a_source'.
		require
			non_void_source: a_source /= Void
			non_void__namespace: a_namespace /= Void
			not_empty_types_list: a_source.types.count > 0
		local
			i, l_count: INTEGER
			l_types: SYSTEM_DLL_CODE_TYPE_DECLARATION_COLLECTION
			l_type: SYSTEM_DLL_CODE_TYPE_DECLARATION
		do
			a_namespace.set_name (a_source.name)
			l_types := a_source.types
			if l_types /= Void then
				from
					l_count := l_types.count
				until
					i = l_count
				loop
					l_type := l_types.item (i)
					code_dom_generator.generate_type_from_dom (l_type)
					a_namespace.types.extend (last_type)
					i := i + 1
				end
			else
				(create {ECD_EVENT_MANAGER}).raise_event (feature {ECD_EVENTS_IDS}.Missing_types, [a_namespace.name])
			end
		end
	
end -- class ECD_EIFFEL_FACTORY

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