indexing
	description: "Resolve types, features, local variables and arguments names%
					%Codedom does not guarentee unicity of entity names but Eiffel requires it."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ECD_ENTITY_NAME_RESOLVER

inherit
	ECD_FEATURE_CACHE
	
	ECD_VARIABLE_CACHE

	ECD_SHARED_CODE_GENERATOR_CONTEXT

feature -- Access

	eiffel_entity_name (a_dotnet_variable_name: STRING): STRING is
			-- Eiffel variable name corresponding to `a_dotnet_variable_name'
			-- ex : foo.bar -> foo_bar_2
		require
			non_void_a_dotnet_variable_name: a_dotnet_variable_name /= Void
			not_empty_a_dotnet_variable_name: not a_dotnet_variable_name.is_empty
		do
			Result := unique_entity_name ((create {NAME_FORMATTER}).valid_variable_name (a_dotnet_variable_name))
		ensure
			non_void_result: Result /= Void
			not_empty_result: Result.count > 0
		end

	unique_entity_name (a_variable_name: STRING): STRING is
			-- Unique variable name built from `a_variable_name'
		require
			non_void_variable_name: a_variable_name /= Void
			not_empty_variable_name: not a_variable_name.is_empty
		local
			i: INTEGER
		do
			from
				Result := a_variable_name.twin
				if Features.has (Result) or Variables.has (Result) then
					Result.append ("_2")
				end
				i := 3
			until
				not Features.has (Result) and not Variables.has (Result)
			loop
				Result.replace_substring (i.out, Result.last_index_of ('_', Result.count) + 1, Result.count)
				i := i + 1
			end
		end

	dotnet_type_name (a_dotnet_feature_name: STRING): STRING is
			-- Name of .NET type corresponding to `a_dotnet_feature_name'
		require
			non_void_a_dotnet_feature_name: a_dotnet_feature_name /= Void
			not_empty_a_dotnet_feature_namee: not a_dotnet_feature_name.is_empty
		do
			if Features.has (a_dotnet_feature_name) then
				Result := Features.item (a_dotnet_feature_name)
			elseif Variables.has (a_dotnet_feature_name) then
				Result := Variables.item (a_dotnet_feature_name)
			else
				(create {ECD_EVENT_MANAGER}).raise_event (feature {ECD_EVENTS_IDS}.Missing_feature, [a_dotnet_feature_name, "current type"])
			end
		ensure
			valid_dotnet_type_name: Result /= Void and not Result.is_empty
		end


	feature_result_type (a_caller_type: TYPE; a_dotnet_feature_name: STRING; a_feature_arguments: LINKED_LIST [ECD_EXPRESSION]): STRING is
			-- .NET method `a_dotnet_feature_name' from `caller_type' with arguments `a_feature_arguments' return type
		require
			non_void_a_dotnet_feature_name: a_dotnet_feature_name /= Void
			not_empty_a_dotnet_feature_name: not a_dotnet_feature_name.is_empty
			non_void_feature_arguments: a_feature_arguments /= Void
			valid_caller_type: a_caller_type = Void implies is_variable (a_dotnet_feature_name) or is_feature (a_dotnet_feature_name)
		local
			i, j: INTEGER
			l_methods: NATIVE_ARRAY [METHOD_INFO]
			l_members: NATIVE_ARRAY [MEMBER_INFO]
			l_method_name: SYSTEM_STRING
			l_parameters: NATIVE_ARRAY [PARAMETER_INFO]
			l_wrong_method: BOOLEAN
			l_arguments_types, l_static_arguments_types: NATIVE_ARRAY [TYPE]
		do
			if Variables.has (a_dotnet_feature_name) then
				Result := Variables.item (a_dotnet_feature_name)
			elseif Features.has (a_dotnet_feature_name) then
				Result := Features.item (a_dotnet_feature_name)
			else		
				from
					a_feature_arguments.start
					create l_arguments_types.make (a_feature_arguments.count)
					i := 0
				until
					a_feature_arguments.after				
				loop
					l_arguments_types.put (i, a_feature_arguments.item.type)
					
					i := i + 1
					a_feature_arguments.forth
				end

				l_static_arguments_types := Feature_finder.static_arguments_types (a_caller_type, a_dotnet_feature_name, l_arguments_types)
				l_methods := a_caller_type.get_methods (feature {BINDING_FLAGS}.instance | feature {BINDING_FLAGS}.static | feature {BINDING_FLAGS}.public | feature {BINDING_FLAGS}.non_public)
				from
					i := 0
				until
					i = l_methods.count or Result /= Void
				loop
					l_method_name := l_methods.item (i).name
					if l_method_name.equals (a_dotnet_feature_name.to_cil) then
						l_parameters := l_methods.item (i).get_parameters
						if l_static_arguments_types /= Void and then l_parameters.count = l_static_arguments_types.count then
							from
								j := 0
								l_wrong_method := False
							until
								j = l_parameters.count or l_wrong_method
							loop
								if not l_parameters.item (j).parameter_type.equals_type (l_static_arguments_types.item (j)) then
										-- Is arguments_type (j) is inherited from paramete (j)?
									l_wrong_method := not l_static_arguments_types.item (j).is_subclass_of (l_parameters.item (j).parameter_type)
								end
								j := j + 1
							end

							if not l_wrong_method then
								create Result.make_from_cil (l_methods.item (i).return_type.full_name)
							end
						end
					end
					i := i + 1
				end
			end
				-- We may be accessing a static field, therefore loop against all the static fields
			if Result = Void or else Result.is_empty then
				l_members := a_caller_type.get_members (feature {BINDING_FLAGS}.static | feature {BINDING_FLAGS}.public | feature {BINDING_FLAGS}.get_field)
				from
					i := 0
				until
					i = l_members.count or Result /= Void
				loop
					if l_members.item (i).name.equals (a_dotnet_feature_name.to_cil) then
						 create Result.make_from_cil (l_members.item (i).reflected_type.full_name)
					end
					i := i + 1
				end
			end
		ensure
			result_set: Result /= Void
			not_empty_result: not Result.is_empty
		end

end -- class ECD_ENTITY_NAME_RESOLVER

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