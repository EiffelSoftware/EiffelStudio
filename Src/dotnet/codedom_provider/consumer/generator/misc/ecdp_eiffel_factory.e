indexing
	-- Code code_generator for compile units and namespaces

class
	ECDP_EIFFEL_FACTORY

inherit
	ECDP_FACTORY

	ECDP_CODE_DOM_PATH

create
	make			

feature {ECDP_CONSUMER_FACTORY} -- Visitor features.

	generate_compile_unit (a_source: SYSTEM_DLL_CODE_COMPILE_UNIT) is
			-- | Create an instance of `EG_COMPILE_UNIT'.
			-- | Initialize this instance with `a_source'
			-- | Set `last_compile_unit'.

			-- Generate Eiffel code from `a_source'.
		require
			non_void_source: a_source /= Void
		local
			a_compile_unit: ECDP_COMPILE_UNIT
		do
			create a_compile_unit.make
			initialize_compile_unit (a_source, a_compile_unit)
			set_last_compile_unit (a_compile_unit)
		ensure
			non_void_compile_unit: last_compile_unit /= Void
			compile_unit_generated: last_compile_unit.ready
		end

	generate_snippet_compile_unit (a_source: SYSTEM_DLL_CODE_SNIPPET_COMPILE_UNIT) is
			-- | Create an instance of `EG_SNIPPET_COMPILE_UNIT'.
			-- | Initialize this instance with `a_source'
			-- | Set `last_compile_unit'.

			-- Generate Eiffel code from `a_source'.
		require
			non_void_source: a_source /= Void
		local
			a_snippet_compile_unit: ECDP_SNIPPET_COMPILE_UNIT
			value: STRING
		do
			create a_snippet_compile_unit.make
			create value.make_from_cil (a_source.value)
			initialize_referenced_assemblies (a_source)
			a_snippet_compile_unit.set_value (value)
			set_last_compile_unit (a_snippet_compile_unit)
		ensure
			non_void_compile_unit: last_compile_unit /= Void
			compile_unit_ready: last_compile_unit.ready
		end

	generate_namespace (a_source: SYSTEM_DLL_CODE_NAMESPACE) is
			-- | Create instance of `EG_NAMESPACE'.
			-- | Set `current_namespace' with `a_namespace'
			-- | Initialize this instance with `a_source'
			-- | Set `current_namespace' with Void because there is no more current namespace
			-- | Set `last_namespace'.

			-- Generate Eiffel code from `a_source'.
		require
			non_void_source: a_source /= Void
		local
			a_namespace: ECDP_NAMESPACE
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

	initialize_compile_unit (a_source: SYSTEM_DLL_CODE_COMPILE_UNIT; a_compile_unit: ECDP_COMPILE_UNIT) is
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
			i, j: INTEGER
			l_generated_type_name: STRING
			namespaces: SYSTEM_DLL_CODE_NAMESPACE_COLLECTION
			a_namespace: SYSTEM_DLL_CODE_NAMESPACE
			a_generated_type: SYSTEM_DLL_CODE_TYPE_DECLARATION
		do	
			initialize_referenced_assemblies (a_source)
			Eiffel_types.clear_all_local_variables

			namespaces := a_source.namespaces
			from
			until
				namespaces = Void or else
				i = namespaces.count
			loop
				a_namespace := namespaces.item (i)
				from
					j := 0
				until
					a_namespace.types = Void or else j = a_namespace.types.count
				loop
					a_generated_type := a_namespace.types.item (j)
					create l_generated_type_name.make_from_cil (a_generated_type.name)
					eiffel_types.add_generated_type (l_generated_type_name)
					
					j := j + 1
				end
				
				code_dom_generator.generate_namespace_from_dom (a_namespace)
				a_compile_unit.namespaces.extend (last_namespace)
				i := i + 1
			end

			if a_source.user_data.contains (From_eiffel_code_key) then
				a_compile_unit.set_from_eiffel (True)
			end
		end	

	initialize_referenced_assemblies (a_compile_unit: SYSTEM_DLL_CODE_COMPILE_UNIT) is
			-- Add all assemblies contained in `a_compile_unit' in `assemblies'.
			-- Consume Assemblies in Eiffel GAC (local or global) if not present
			-- FIXME Raphael: This shouldn't be here because it's VS specific
		require
			non_void_a_compile_unit: a_compile_unit /= Void
		local
--			i: INTEGER
--			l_assembly: ASSEMBLY
--			l_referenced_assemblies: LINKED_LIST [ECDP_REFERENCED_ASSEMBLY]
--			vs_references: VS_REFERENCES
--			vs_reference: VS_REFERENCE
		do
				-- Create our list of referenced assemblies, resorting to compile unit if we have no project references to inspect
--			create l_referenced_assemblies.make
--			if vs_project /= Void then
--				vs_references := vs_project.references
--				from
--					i := 1
--				until
--					i > vs_references.count
--				loop
--					vs_reference := vs_references.item (i)				
--					l_assembly := load_assembly (vs_reference.path)
--					if l_assembly /= Void then
--						l_referenced_assemblies.extend (create {ECDP_REFERENCED_ASSEMBLY}.make (l_assembly))
--					end
--					i := i + 1
--				end				
--			else
--				from
--					i := 0
--				until
--					i = a_compile_unit.referenced_assemblies.count				
--				loop
--					l_assembly := load_assembly (a_compile_unit.referenced_assemblies.item (i))
--					if l_assembly /= Void then
--						l_referenced_assemblies.extend (create {ECDP_REFERENCED_ASSEMBLY}.make (l_assembly))
--					end
--					i := i + 1
--				end
--			end
--			Eiffel_types.initialize_emitter_from_referenced_assemblies (l_referenced_assemblies)
		end

	initialize_namespace (a_source: SYSTEM_DLL_CODE_NAMESPACE; a_namespace: ECDP_NAMESPACE) is
			-- | Call in loop `generate_type_from_dom'.
	
			-- Generate namespace types with no parents from `a_source'.
		require
			non_void_source: a_source /= Void
			non_void__namespace: a_namespace /= Void
			not_empty_types_list: a_source.types.count > 0
		local
			types: SYSTEM_DLL_CODE_TYPE_DECLARATION_COLLECTION
			i: INTEGER
			a_type: SYSTEM_DLL_CODE_TYPE_DECLARATION
		do
			a_namespace.set_name (create {STRING}.make_from_cil (a_source.name))
			
			types := a_source.types
			from
			until
				types = Void or else
				i = types.count
			loop
				a_type := types.item (i)
				code_dom_generator.generate_type_from_dom (a_type)
				a_namespace.types.extend (last_type)
				i := i + 1
			end

			if a_source.user_data.contains (From_eiffel_code_key) then
				a_namespace.set_from_eiffel (True)
			end
		end
	
end -- class ECDP_EIFFEL_FACTORY

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