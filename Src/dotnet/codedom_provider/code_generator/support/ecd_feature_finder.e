indexing
	description: "Resolve .NET features from name, arguments and target type"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ECD_FEATURE_FINDER

inherit
	ECD_EXECUTION_ENVIRONMENT
		export
			{NONE} all
		end

	ECD_SHARED_CODE_GENERATOR_CONTEXT

feature -- Access

	eiffel_feature_name_from_dynamic_args (a_dotnet_type: TYPE; a_dotnet_feature_name: STRING; feature_arguments: LINKED_LIST [ECD_EXPRESSION]): STRING is
 			-- Get the eiffel feature name passing the feature's dotnet type, the dotnet feature name and these dynamiques arguments
		require
			non_void_a_dotnet_type: a_dotnet_type /= Void
			non_void_feature_name: a_dotnet_feature_name /= Void
			not_empty_feature_name: not a_dotnet_feature_name.is_empty
			non_void_feature_arguments: feature_arguments /= Void
		local
			i: INTEGER
			l_eiffel_entities: LINKED_LIST [CONSUMED_ENTITY]
			l_eiffel_entity: CONSUMED_ENTITY
			l_arguments_types: NATIVE_ARRAY [TYPE]
			l_static_arguments_types: NATIVE_ARRAY [TYPE]
			l_cache_reflection: CACHE_REFLECTION
		do
			if Resolver.is_generated_type (a_dotnet_type.name) then
				Result := (create {ECD_ENTITY_NAME_RESOLVER}).eiffel_entity_name (a_dotnet_feature_name)
			else
				create l_cache_reflection.make (Clr_version)
				l_eiffel_entities := l_cache_reflection.entities (a_dotnet_type, a_dotnet_feature_name)
				if l_eiffel_entities.count = 1 then
					Result := l_eiffel_entities.first.eiffel_name
				elseif l_eiffel_entities.count > 1 then
						-- overloded method (find the good one)
					from
						feature_arguments.start
						create l_arguments_types.make (feature_arguments.count)
						i := 0
					until
						feature_arguments.after
					loop
						l_arguments_types.put (i, feature_arguments.item.type)
						i := i + 1
						feature_arguments.forth
					end

						-- try with dynamique args
					l_eiffel_entity := l_cache_reflection.entity (l_eiffel_entities, l_arguments_types)
					if l_eiffel_entity = Void then
						l_static_arguments_types := static_arguments_types (a_dotnet_type, a_dotnet_feature_name, l_arguments_types)
						if l_static_arguments_types /= Void then
							l_eiffel_entity := l_cache_reflection.entity (l_eiffel_entities, l_static_arguments_types)
						end	
					end
					if l_eiffel_entity /= Void then
						Result := l_eiffel_entity.eiffel_name
					end
				end
			end
			if Result = Void then
				(create {ECD_EVENT_MANAGER}).raise_event (feature {ECD_EVENTS_IDS}.Missing_feature, [a_dotnet_type.to_string, a_dotnet_feature_name])
				Result := (create {NAME_FORMATTER}).formatted_feature_name (a_dotnet_feature_name)
			end
		ensure
			non_void_name: Result /= Void
		end

	declaring_type (a_dotnet_type_name: STRING; a_dotnet_feature_name: STRING; feature_arguments: LINKED_LIST [ECD_EXPRESSION]): STRING is
			-- Name of .NET type where `a_dotnet_feature_name' from `a_dotnet_type_name' is first declared
		require
			non_void_a_dotnet_type: a_dotnet_type_name /= Void
			not_empty_a_dotnet_type_name: not a_dotnet_type_name.is_empty
			non_void_feature_name: a_dotnet_feature_name /= Void
			not_empty_feature_name: not a_dotnet_feature_name.is_empty
			non_void_feature_arguments: feature_arguments /= Void
		local
			l_type: ECD_GENERATED_TYPE
		do
			if Resolver.is_generated_type (a_dotnet_type_name) then
				l_type := Resolver.generated_type (a_dotnet_type_name)
				from
					l_type.parents.start
				until
					l_type.parents.after or Result /= Void
				loop
					if has_feature (l_type.parents.item.name, a_dotnet_feature_name, feature_arguments) then
						Result := l_type.parents.item.name
					end
					l_type.parents.forth
				end
			end
			if Result = Void then
				(create {ECD_EVENT_MANAGER}).raise_event (feature {ECD_EVENTS_IDS}.Non_generated_type, [a_dotnet_type_name, "declaring_type", "feature finder"])
				Result := a_dotnet_type_name
			end
		ensure
			non_void_result: Result /= Void
		end

	eiffel_feature_name_from_static_args (a_dotnet_type: TYPE; a_dotnet_feature_name: STRING; a_feature_arguments: NATIVE_ARRAY [TYPE]): STRING is
 			-- Eiffel feature name corresponding to .NET method `a_dotnet_feature_name' from type `a_dotnet_type' with statics arguments `a_feature_arguments'
		require
			non_void_a_dotnet_type: a_dotnet_type /= Void
			non_void_feature_name: a_dotnet_feature_name /= Void
			not_empty_feature_name: not a_dotnet_feature_name.is_empty
			valid_arguments: a_feature_arguments = Void implies Resolver.is_generated_type (a_dotnet_type.name)
		local
			l_cache_reflection: CACHE_REFLECTION
			l_rescued: BOOLEAN
		do
			if not l_rescued then
				if Resolver.is_generated_type (a_dotnet_type.name) then
					Result := Resolver.eiffel_entity_name (a_dotnet_feature_name)
				else
					create l_cache_reflection.make (Clr_version)
					if l_cache_reflection.is_assembly_in_cache (a_dotnet_type.assembly.get_name) then
						Result := l_cache_reflection.feature_name (a_dotnet_type, a_dotnet_feature_name, a_feature_arguments)
					else
						(create {ECD_EVENT_MANAGER}).raise_event (feature {ECD_EVENTS_IDS}.Missing_consumed_assembly, [a_dotnet_type.assembly.get_name])
					end
				end
			end
		rescue
			(create {ECD_EVENT_MANAGER}).raise_event (feature {ECD_EVENTS_IDS}.Rescued_exception, [feature {ISE_RUNTIME}.last_exception])
			l_rescued := True
			retry
		end

	has_feature (a_dotnet_type_name: STRING; a_dotnet_feature_name: STRING; feature_arguments: LINKED_LIST [ECD_EXPRESSION]): BOOLEAN is
			-- Does `a_dotnet_type_name' contain `a_dotnet_feature_name' with `feature_arguments'?
		require
			non_void_a_dotnet_type_name: a_dotnet_type_name /= Void
			not_empty_a_dotnet_type_name: not a_dotnet_type_name.is_empty
			non_void_a_dotnet_feature_name: a_dotnet_feature_name /= Void
			not_empty_a_dotnet_feature_name: not a_dotnet_feature_name.is_empty
			non_void_feature_arguments: feature_arguments /= Void
		local
			i, j: INTEGER
			l_caller_type: TYPE
			l_methods: NATIVE_ARRAY [METHOD_BASE]
			l_parameters: NATIVE_ARRAY [PARAMETER_INFO]
			l_arguments: NATIVE_ARRAY [TYPE]
		do
			if Resolver.is_generated_type (a_dotnet_type_name) then
				Result := Resolver.generated_type (a_dotnet_type_name).has_feature (a_dotnet_feature_name, feature_arguments)
			else
				l_caller_type := Dotnet_types.dotnet_type (a_dotnet_type_name)
				
				if l_caller_type /= Void then
					if a_dotnet_feature_name.is_equal (".ctor") then
						l_methods := l_caller_type.get_constructors
					else
						l_methods := l_caller_type.get_methods_binding_flags (feature {BINDING_FLAGS}.instance | feature {BINDING_FLAGS}.static | feature {BINDING_FLAGS}.public | feature {BINDING_FLAGS}.non_public)
					end
					
					from
						feature_arguments.start
						create l_arguments.make (feature_arguments.count)
					until
						feature_arguments.after
					loop
						l_arguments.put (i, feature_arguments.item.type)
						i := i + 1
						feature_arguments.forth
					end

					from
						i := 0
					until
						Result or l_methods = Void or else i = l_methods.count
					loop
						if l_methods.item (i).name.equals (a_dotnet_feature_name.to_cil) then
							l_parameters := l_methods.item (i).get_parameters
							if l_parameters.count = l_arguments.count then
								from
									j := 0
									Result := True
								until
									j = l_parameters.count or not Result
								loop
									Result := are_conform (l_parameters.item (j).parameter_type, l_arguments.item (j))
									j := j + 1
								end
							end
						end
						i := i + 1
					end
				end
			end
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

feature {NONE} -- Implementation
		
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
			
end -- class ECD_FEATURE_FINDER

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