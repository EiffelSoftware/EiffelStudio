indexing
	description: "Provides access to Eiffel metadata (EAC)"
	date: "$Date$"
	revision: "$Revision$"

class
	CODE_EIFFEL_METADATA_PROVIDER

inherit
	CODE_SHARED_NAME_FORMATTER
		export
			{NONE} all
		end
	
	CODE_SHARED_TYPE_REFERENCE_FACTORY
		export
			{NONE} all
		end
	
	CODE_STOCK_TYPE_REFERENCES
		export
			{NONE} all
		end
	
	CODE_CONFIGURATION
		export
			{NONE} all
		end
	
	CODE_DIRECTIONS
		export
			{NONE} all
		end

feature -- Access

	type_eiffel_name (a_type: TYPE): STRING is
			-- Eiffel class name for .NET type `a_type'
		require
			non_void_type: a_type /= Void
		do
			Result := cache_reflection.type_name (a_type)
			Result.prepend ((create {CODE_REFERENCED_ASSEMBLY}.make (a_type.assembly)).assembly_prefix)
		end

	feature_eiffel_name (a_name: STRING; a_arguments: NATIVE_ARRAY [TYPE]; a_type: TYPE): STRING is
			-- Eiffel name of .NET routine `a_name' from `a_type' with arguments `a_arguments'
		require
			non_void_name: a_name /= Void
			non_void_type: a_type /= Void
		do
			Result := cache_reflection.feature_name (a_type, a_name, a_arguments)
			if Result = Void and a_arguments /= Void then
				Result := cache_reflection.feature_name (a_type, a_name, static_arguments_types (a_type, a_name, a_arguments))
			end
			if Result = Void then
				Result := Name_formatter.formatted_feature_name (a_name)
				Event_manager.raise_event (feature {CODE_EVENTS_IDS}.Missing_feature, [a_name, a_type.full_name])
			end
		ensure
			non_void_eiffel_name: Result /= Void
		end

	feature_type (a_name: STRING; a_arguments: NATIVE_ARRAY [TYPE]; a_type: TYPE): CODE_TYPE_REFERENCE is
			-- Type of result of feature `a_name' with arguments `a_arguments' in type `a_type'.
		require
			non_void_name: a_name /= Void
			non_void_type: a_type /= Void
		local
			l_entities: LIST [CONSUMED_ENTITY]
			l_entity: CONSUMED_ENTITY
			l_type: CONSUMED_REFERENCED_TYPE
		do
			l_entities := cache_reflection.entities (a_type, a_name)
			if l_entities /= Void then
				if l_entities.count > 1 then
					if a_arguments /= Void then
						l_entity := cache_reflection.entity (l_entities, a_arguments)
						if l_entity /= Void then
							l_type := l_entity.return_type
						else
							Event_manager.raise_event (feature {CODE_EVENTS_IDS}.Missing_feature, [a_name, a_type.full_name])
						end
					else
						Event_manager.raise_event (feature {CODE_EVENTS_IDS}.Missing_parameters, ["feature " + a_name + " from " + a_type.full_name])
						l_type := l_entities.first.return_type
					end
				elseif l_entities.count = 1 then
					l_type := l_entity.return_type
				else
					Event_manager.raise_event (feature {CODE_EVENTS_IDS}.Missing_feature, [a_name, a_type.full_name])
				end
			end
			if l_type /= Void then
				Result := Type_reference_factory.type_reference_from_name (l_type.name)
			else
				Result := None_type_reference
			end
		ensure
			non_void_feature_type: Result /= Void
		end

	features (a_name: STRING; a_type: TYPE): LIST [CODE_MEMBER_REFERENCE] is
			-- Features with .NET name `a_name' in type `a_type' if any
		require
			non_void_name: a_name /= Void
			non_void_type: a_type /= Void
		local
			l_entities: LIST [CONSUMED_ENTITY]
			l_type: CODE_TYPE_REFERENCE
			l_arguments: LIST [CODE_PARAMETER_DECLARATION_EXPRESSION]
			l_entity: CONSUMED_ENTITY
			l_entity_arguments: ARRAY [CONSUMED_ARGUMENT]
			i, l_count: INTEGER
		do
			l_entities := cache_reflection.entities (a_type, a_name)
			if l_entities /= Void then
				l_type := Type_reference_factory.type_reference_from_type (a_type)
				create {ARRAYED_LIST [CODE_MEMBER_REFERENCE]} Result.make (l_entities.count)
				from
					l_entities.start
				until
					l_entities.after
				loop
					l_entity := l_entities.item
					l_entity_arguments := l_entity.arguments
					from
						l_count := l_entity_arguments.count
						create {ARRAYED_LIST [CODE_PARAMETER_DECLARATION_EXPRESSION]} l_arguments.make (l_count)
						i := 1
					until
						i > l_count
					loop
						l_arguments.extend (create {CODE_PARAMETER_DECLARATION_EXPRESSION}.make (
								create {CODE_VARIABLE_REFERENCE}.make (l_entity_arguments.item (i).dotnet_name,
									Type_reference_factory.type_reference_from_name (l_entity_arguments.item (i).type.name),
									Type_reference_factory.type_reference_from_type (a_type)), in_argument))
						i := i + 1
					end
					Result.extend (l_type.member (l_entity.dotnet_name, l_arguments, l_entity.is_method and l_entity.is_virtual and not l_entity.is_new_slot))
					l_entities.forth
				end
			end
		end
		
feature {NONE} -- Implementation

	cache_reflection: CACHE_REFLECTION is
			-- EAC access
		once
			create Result.make ((create {CODE_EXECUTION_ENVIRONMENT}).Clr_version)
		end

	static_arguments_types (a_caller_type: TYPE; a_dotnet_feature_name: STRING; a_arguments_types: NATIVE_ARRAY [TYPE]): NATIVE_ARRAY [TYPE] is
			-- Static signature of `a_dotnet_feature_name' from `a_caller_type' with dynamic arguments `arguments_types'
		require
			non_void_type: a_caller_type /= Void
			non_void_feature_name: a_dotnet_feature_name /= Void
			non_void_arguments_types: a_arguments_types /= Void
		local
			i, j, k: INTEGER
			l_methods: NATIVE_ARRAY [METHOD_BASE]
			l_parameters: NATIVE_ARRAY [PARAMETER_INFO]
			l_wrong_method, l_stop, l_static_equal_dynamique: BOOLEAN
		do
			if a_arguments_types.count = 0 then
				Result := a_arguments_types
			else
				if a_dotnet_feature_name.is_equal (".ctor") then
					l_methods := a_caller_type.get_constructors
				else
					l_methods := a_caller_type.get_methods_binding_flags (feature {BINDING_FLAGS}.instance | feature {BINDING_FLAGS}.static | feature {BINDING_FLAGS}.public | feature {BINDING_FLAGS}.non_public)
				end
				
				from
					l_static_equal_dynamique := False
				until
					l_methods = Void or else i = l_methods.count or l_static_equal_dynamique
				loop
					if l_methods.item (i).name.equals (a_dotnet_feature_name.to_cil) then
						l_parameters := l_methods.item (i).get_parameters
						if l_parameters.count = a_arguments_types.count then
							from
								j := 0
								l_wrong_method := False
							until
								j = l_parameters.count or l_wrong_method
							loop
								l_wrong_method := not are_conform (l_parameters.item (j).parameter_type, a_arguments_types.item (j))
								j := j + 1
							end
							
							if not l_wrong_method then
								-- add method to list of possible methods : methods.item (i)
								if Result = Void then
									from
										k := 0
										create Result.make (l_parameters.count)
										l_static_equal_dynamique := True
									until
										k = l_parameters.count
									loop
										Result.put (k, l_parameters.item (k).parameter_type)
										l_static_equal_dynamique := l_static_equal_dynamique and l_parameters.item (k).parameter_type.equals_type (a_arguments_types.item (k))
										k := k + 1
									end
								else
										-- Compare each argument type, and allways take the more specialised
									from
										j := 0
										l_stop := False
									until
										j = l_parameters.count or l_stop
									loop
											-- Are parameters more specialised than current parameters result?
										if l_parameters.item (j).parameter_type.is_subclass_of (Result.item (j)) then
											from
												k := 0
												l_static_equal_dynamique := True
											until
												k = l_parameters.count
											loop
												Result.put (k, l_parameters.item (k).parameter_type)
												l_static_equal_dynamique := l_static_equal_dynamique and l_parameters.item (k).parameter_type.equals_type (a_arguments_types.item (k))
												k := k + 1
											end
											l_stop := True
										end
									end
								end
							end	-- add method
						end
					end
					i := i + 1
				end
			end
		ensure
			non_void_static_arguments_types: Result /= Void
			valid_static_arguments_types: Result.length = a_arguments_types.count
		end

		are_conform (a_static_type, a_dynamic_type: TYPE): BOOLEAN is
				-- Does `a_dynamic_type' conform to `a_static_type'?
			local
				l_static_name, l_dynamic_name: STRING
			do
				Result := a_static_type.is_assignable_from (a_dynamic_type)
				if not Result then
					create l_static_name.make_from_cil (a_static_type.full_name)
					create l_dynamic_name.make_from_cil (a_dynamic_type.full_name)
					Result := 
								(l_dynamic_name.is_equal ("System.Byte") and then (l_static_name.is_equal ("System.Int16") or
																				l_static_name.is_equal ("System.Int32") or
																				l_static_name.is_equal ("System.Int64") or
																				l_static_name.is_equal ("System.Real") or
																				l_static_name.is_equal ("System.Double")))
								or										
								(l_dynamic_name.is_equal ("System.Real") and then l_static_name.is_equal ("System.Double"))

				end
			end
		
end -- class CODE_EIFFEL_METADATA_PROVIDER

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