indexing
	description: "[
		Retrieve Eiffel names corresponding to dotnet names, for variables, features and types.
		Need some context.
				]"
	date: "$Date$"
	revision: "$Revision$"

class
	ECDP_TYPE_CONVERTER

inherit
	ECDP_CODE_DOM_PATH

create
	default_create

feature {NONE} -- Private Access

	generated_types: HASH_TABLE [ECDP_GENERATED_TYPE, STRING] is
			-- [Generated types
			--				Value: `EG_GENERATED_TYPE'
			--				Key: ID corresponding to CodeDom type name]
		once
			create Result.make (5)
		ensure
			non_void_result: Result /= Void
		end

	types: HASH_TABLE [ECDP_TYPE, STRING] is
			-- [All types in Codedom tree
			--				Value: dynamically `ECDP_TYPE'
			--				Key: ID corresponding to CodeDom type name]
		once
			create Result.make (5)
		ensure
			non_void_result: Result /= Void
		end

	variables: HASH_TABLE [STRING, STRING] is
			-- [All variables in current_feature: parameters and locals
			--				Value: `STRING' corresponding to Eiffel type name
			--				Key: ID corresponding to the Eiffel variable name]
		once
			create Result.make (20)
		ensure
			non_void_result: Result /= Void
		end

feature {ECDP_ARRAY_EXPRESSION_FACTORY} -- Private Access

	features: HASH_TABLE [STRING, STRING] is
			-- [All features in current_type
			--				Value: `STRING' corresponding to Eiffel type name
			--				Key: ID corresponding to the Eiffel variable name]
		once
			create Result.make (150)
		ensure
			non_void_result: Result /= Void
		end

feature -- Basics Operations

	update_generated_type (a_generated_type: ECDP_GENERATED_TYPE) is
			-- Add `a_generated_type' to `generated_types'.
		require
			non_void_generated_type: a_generated_type /= Void 
		do
			Generated_types.remove (a_generated_type.name)
			Generated_types.put (a_generated_type, a_generated_type.name)
			types.put (a_generated_type, a_generated_type.name)
		ensure
			a_generated_type_set: generated_types.has_item (a_generated_type)
		end
		
	initialize_emitter_from_referenced_assemblies (referenced_assemblies: LINKED_LIST [ECDP_REFERENCED_ASSEMBLY]) is
			-- Make sure all assemblies contained within `referenced_assemblies' and their dependencies are emitted.
		require
			non_void_referenced_assemblies: referenced_assemblies /= Void
		local
			l_ace_file: ECDP_ACE_FILE_WRITER
			l_location: STRING
			cache_reflection: CACHE_REFLECTION
			cache_manager: COM_ISE_CACHE_MANAGER
			l_referenced_assembly_names: NATIVE_ARRAY [ASSEMBLY_NAME]
			l_assembly_name, local_referenced_assemblies, l_assembly_location: STRING
			assembly_name: ASSEMBLY_NAME
			k: INTEGER
			l_cursor: CURSOR
			referenced_assembly_found: BOOLEAN
			l_assembly, current_assembly: ASSEMBLY
			current_assembly_name, current_referenced_assembly_name: ASSEMBLY_NAME
			local_cache_emit_directory: STRING
			emission_directory: DIRECTORY
		do
			create l_ace_file.make
			l_ace_file.referenced_assemblies.wipe_out
			from
				referenced_assemblies.start
			until
				referenced_assemblies.after
			loop
				if (Mscorlib).is_equal (referenced_assemblies.item.assembly.get_name.name) then
					create l_location.make_from_cil (referenced_assemblies.item.assembly.location)
					if l_location.substring_index (Version_1_1, 1) > 0 then
						set_clr_version (Version_1_1)
					else
						set_clr_version (Version_1_0)
					end
				end
				l_ace_file.add_referenced_assembly (referenced_assemblies.item)
				referenced_assemblies.forth
			end

				-- Add referenced assemblies (not given by wxml).
			from
				l_ace_file.referenced_assemblies.start
			until
				l_ace_file.referenced_assemblies.after
			loop
				l_referenced_assembly_names := l_ace_file.referenced_assemblies.item.assembly.get_referenced_assemblies
				from
					k := 0
				until
					k >= l_referenced_assembly_names.count
				loop
					l_cursor := l_ace_file.referenced_assemblies.cursor
					from
						l_ace_file.referenced_assemblies.start
						referenced_assembly_found := False
					until
						l_ace_file.referenced_assemblies.after or referenced_assembly_found
					loop
						current_assembly := l_ace_file.referenced_assemblies.item.assembly
						current_assembly_name := current_assembly.get_name
						current_referenced_assembly_name := l_referenced_assembly_names.item (k)
						if current_assembly_name.full_name.equals (current_referenced_assembly_name.full_name) then
							referenced_assembly_found := True
						end
						l_ace_file.referenced_assemblies.forth
					end
					l_ace_file.referenced_assemblies.go_to (l_cursor)
					
					if not referenced_assembly_found then
						l_assembly := load_assembly_from_assembly_name (l_referenced_assembly_names.item (k))
						if l_assembly /= Void then
							l_assembly_name := create {STRING}.make_from_cil (l_assembly.get_name.name)
							if l_assembly /= Void then
								l_ace_file.referenced_assemblies.extend (create {ECDP_REFERENCED_ASSEMBLY}.make (l_assembly))
							end
						end
					end
	
					k := k + 1
				end
				l_ace_file.Referenced_assemblies.forth
			end
			
			-- Consume any missing local assemblies.
			
			create cache_manager
			cache_manager.initialize (Clr_version)
			
			create cache_reflection.make (Clr_version)
			
			from
				l_ace_file.Referenced_assemblies.start
				local_referenced_assemblies := ""
			until
				l_ace_file.Referenced_assemblies.after
			loop
				assembly_name := l_ace_file.Referenced_assemblies.item.assembly.get_name
				if not cache_reflection.is_assembly_in_cache (assembly_name) then
					if not local_referenced_assemblies.is_equal ("") then
						local_referenced_assemblies.extend (';')
					end
					create l_assembly_location.make_from_cil (l_ace_file.Referenced_assemblies.item.assembly.location)
					local_referenced_assemblies.append (l_assembly_location)
				end
				l_ace_file.Referenced_assemblies.forth
			end
			
			if not local_referenced_assemblies.is_empty then
				local_cache_emit_directory := local_cache_path.twin
				create emission_directory.make (local_cache_emit_directory)
				if not emission_directory.exists then
					emission_directory.create_dir
				end
				cache_manager.consume_local_assembly (local_referenced_assemblies, local_cache_emit_directory)
			end
		end

	add_generated_type (a_generated_type_name: STRING) is
			-- Add `a_generated_type_name' to `generated_types'.
		require
			non_void_generated_type_name: a_generated_type_name /= Void
			not_empty_a_generated_type_name: not a_generated_type_name.is_empty
		local
			a_generated_type: ECDP_GENERATED_TYPE
		do
			if not generated_types.has (a_generated_type_name) then
				create a_generated_type.make
				a_generated_type.set_name (a_generated_type_name)
				generated_types.put (a_generated_type, a_generated_type_name)
				add_type (a_generated_type)
			end
		ensure
			generated_types_set: generated_types.has (a_generated_type_name)
		end
	
	add_external_type (an_external_type_name: STRING) is
			-- Add `an_external_type_name' to `types'.
		require
			non_void_generated_type: an_external_type_name /= Void
			not_empty_a_type_name: not an_external_type_name.is_empty
			external_type: is_external_type (an_external_type_name)
		local
			an_external_type: ECDP_EXTERNAL_TYPE
		do
			if not types.has (an_external_type_name) then
				create an_external_type.make
				an_external_type.set_name (an_external_type_name)
				add_type (an_external_type)
			end
		ensure
			types_set: types.has (an_external_type_name)
		end

	add_feature (a_type_name: STRING; an_eiffel_feature_name: STRING) is
			-- Add `an_eiffel_feature_name' to `features'.
		require
			non_void_a_type_name: a_type_name /= Void
			non_void_an_eiffel_feature_name: an_eiffel_feature_name /= Void
			not_empty_a_type_name: not a_type_name.is_empty
			not_empty_an_eiffel_feature_name: not an_eiffel_feature_name.is_empty
		local
			l_name: STRING
		do
			if not is_generated_type (a_type_name) then
				l_name := unique_variable_name (an_eiffel_feature_name)
				features.put (a_type_name, l_name)
			else
				features.put (a_type_name, an_eiffel_feature_name)
			end
		end

	add_variable (a_type_name: STRING; a_unique_variable_name: STRING) is
			-- Add `a_variable_name' to `variables'.
		require
			non_void_a_type_name: a_type_name /= Void
			not_empty_a_type_name: not a_type_name.is_empty
			non_void_a_variable_name: a_unique_variable_name /= Void
			not_empty_a_variable_name: not a_unique_variable_name.is_empty
		do
			variables.put (a_type_name, a_unique_variable_name)
		ensure
			variable_set: variables.has_item (a_type_name)
		end


feature {NONE} -- Private
		
	add_type (a_type: ECDP_TYPE) is
			-- Add `a_type' to `types'.
		require
			non_void_a_type: a_type /= Void
		do
			if not types.has (a_type.name) then
				types.put (a_type, a_type.name)
			end
		ensure
			type_set: types.has_item (a_type)
		end

	static_arguments_types (caller_type: TYPE; a_dotnet_feature_name: STRING; arguments_types: NATIVE_ARRAY [TYPE]): NATIVE_ARRAY [TYPE] is
			-- Get static signature of `a_feature'.
		local
			i, j, k: INTEGER
			methods: NATIVE_ARRAY [METHOD_BASE]
			parameters: NATIVE_ARRAY [PARAMETER_INFO]
			a_param: PARAMETER_INFO
			wrong_method, stop, static_equal_dynamique: BOOLEAN
			a_dynamic_param, a_static_param: TYPE
			a_static_param_name, a_dynamic_param_name: STRING
		do
			if arguments_types.count = 0 then
				Result := arguments_types
			else
				
				if a_dotnet_feature_name.is_equal (".ctor") then
					methods := caller_type.get_constructors
				else
					methods := caller_type.get_methods_binding_flags (	feature {BINDING_FLAGS}.instance |
																		feature {BINDING_FLAGS}.static |
																		feature {BINDING_FLAGS}.public |
																		feature {BINDING_FLAGS}.non_public)
				end
				
				from
					i := 0
					static_equal_dynamique := False
				until
					methods = Void or else i = methods.count or static_equal_dynamique
				loop
					if methods.item (i).name.equals (a_dotnet_feature_name.to_cil) then
						parameters := methods.item (i).get_parameters
						if parameters.count = arguments_types.count then
							from
								j := 0
								wrong_method := False
							until
								j = parameters.count or wrong_method
							loop
								a_dynamic_param := arguments_types.item (j)
								a_param := parameters.item (j)
								a_static_param := a_param.parameter_type
								if not a_static_param.is_assignable_from (a_dynamic_param) then
									create a_static_param_name.make_from_cil (a_static_param.full_name)
									create a_dynamic_param_name.make_from_cil (a_dynamic_param.full_name)
									if 
										a_dynamic_param_name.is_equal ("System.Byte") and then
										(a_static_param_name.is_equal ("System.Int16") or
										a_static_param_name.is_equal ("System.Int32") or
										a_static_param_name.is_equal ("System.Int64") or
										a_static_param_name.is_equal ("System.Real") or
										a_static_param_name.is_equal ("System.Double") )
									then
										wrong_method := False
									elseif 
										a_dynamic_param_name.is_equal ("System.Real") and then
										a_static_param_name.is_equal ("System.Double")
									then
										wrong_method := False
									else
										wrong_method := True
									end
								end
								j := j + 1
							end
							
							if not wrong_method then
								-- add method to list of possible methods : methods.item (i)
								if Result = Void then
									from
										k := 0
										create Result.make (parameters.count)
									until
										k = parameters.count
									loop
										Result.put (k, parameters.item (k).parameter_type)
										k := k + 1
									end
								else
										-- Compare each argument type, and allways take the more specialised
									from
										j := 0
										stop := False
									until
										j = parameters.count or stop
									loop
											-- Are parameters more specialised than current parameters result?
										if parameters.item (j).parameter_type.is_subclass_of (Result.item (j)) then
											from
												k := 0
												static_equal_dynamique := True
											until
												k = parameters.count
											loop
												Result.put (k, parameters.item (k).parameter_type)
												if static_equal_dynamique and then
												parameters.item (k).parameter_type.equals_type (arguments_types.item (k)) then
													static_equal_dynamique := True
												else
													static_equal_dynamique := False
												end
												k := k + 1
											end
											stop := true
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
			valid_static_arguments_types: Result.length = arguments_types.count
		end
	
feature -- Status Repport

	is_generated_type (a_type_name: STRING): BOOLEAN is
			-- is `a_type_name' key of `eg_generated_types'?
		require
			non_void_a_type_name: a_type_name /= Void
			not_empty_a_type_name: not a_type_name.is_empty
		do
			if generated_types.has (a_type_name) then
				Result := True
			else
				Result := False
			end
		end

	is_external_type (a_type_name: STRING): BOOLEAN is
			-- is `a_type_name' key of `eg_generated_types'?
		require
			non_void_a_type_name: a_type_name /= Void
			not_empty_a_type_name: not a_type_name.is_empty
		do
			if generated_types.has (a_type_name) then
				Result := False
			else
				Result := True
			end
		end

	has_feature (a_dotnet_type_name: STRING; a_dotnet_feature_name: STRING; feature_arguments: LINKED_LIST [ECDP_EXPRESSION]): BOOLEAN is
			-- Does `a_dotnet_type_name' contain `a_dotnet_feature_name' with `arguments'?
		require
			non_void_a_dotnet_type_name: a_dotnet_type_name /= Void
			not_empty_a_dotnet_type_name: not a_dotnet_type_name.is_empty
			non_void_a_dotnet_feature_name: a_dotnet_feature_name /= Void
			not_empty_a_dotnet_feature_name: not a_dotnet_feature_name.is_empty
			non_void_feature_arguments: feature_arguments /= Void
		local
			i, j: INTEGER
			caller_type: TYPE
			methods: NATIVE_ARRAY [METHOD_BASE]
			parameters: NATIVE_ARRAY [PARAMETER_INFO]
			a_param: PARAMETER_INFO
			wrong_method: BOOLEAN
			a_dynamic_param, a_static_param: TYPE
			a_static_param_name, a_dynamic_param_name: STRING
			arguments: NATIVE_ARRAY [TYPE]
		do
			if is_generated_type (a_dotnet_type_name) then
				Result := Generated_types.item (a_dotnet_type_name).has_feature (a_dotnet_feature_name, feature_arguments)
			else
				caller_type := dotnet_type (a_dotnet_type_name)
				
				if caller_type /= Void then
					from
						feature_arguments.start
						create arguments.make (feature_arguments.count)
						i := 0
					until
						feature_arguments.after
					loop
						arguments.put (i, feature_arguments.item.type)
	
						i := i + 1
						feature_arguments.forth
					end
	
	
					if a_dotnet_feature_name.is_equal (".ctor") then
						methods := caller_type.get_constructors
					else
						methods := caller_type.get_methods_binding_flags (	feature {BINDING_FLAGS}.instance |
																			feature {BINDING_FLAGS}.static |
																			feature {BINDING_FLAGS}.public |
																			feature {BINDING_FLAGS}.non_public)
					end
					
					from
						i := 0
					until
						Result or methods = Void or else i = methods.count
					loop
						if methods.item (i).name.equals (a_dotnet_feature_name.to_cil) then
							parameters := methods.item (i).get_parameters
							if parameters.count = arguments.count then
								from
									j := 0
									wrong_method := False
								until
									j = parameters.count or wrong_method
								loop
									a_dynamic_param := arguments.item (j)
									a_param := parameters.item (j)
									a_static_param := a_param.parameter_type
									if not a_static_param.is_assignable_from (a_dynamic_param) then
										create a_static_param_name.make_from_cil (a_static_param.full_name)
										create a_dynamic_param_name.make_from_cil (a_dynamic_param.full_name)
										if 
											a_dynamic_param_name.is_equal ("System.Byte") and then
											(a_static_param_name.is_equal ("System.Int16") or
											a_static_param_name.is_equal ("System.Int32") or
											a_static_param_name.is_equal ("System.Int64") or
											a_static_param_name.is_equal ("System.Real") or
											a_static_param_name.is_equal ("System.Double") )
										then
											wrong_method := False
										elseif 
											a_dynamic_param_name.is_equal ("System.Real") and then
											a_static_param_name.is_equal ("System.Double")
										then
											wrong_method := False
										else
											wrong_method := True
										end
									end
									j := j + 1
								end
								
								Result := not wrong_method
							end
						end
						
						i := i + 1
					end
				end
			end
		end

feature -- Status Setting

	clear_all_feature_variables is
			-- clear all content of `variables'
		do
			features.clear_all
		end

	clear_all_local_variables is
			-- clear all content of `variables'
		do
			variables.clear_all
			cast_variable_number.put (1)
		end

	initialize_features (a_type: ECDP_GENERATED_TYPE) is
			-- initialize `effeil_types.features'
			-- | clear `features' and
			-- | loop on `parents', `creation_routine', `features' of `a_type' to initialize `features'
		require
			non_void_a_type: a_type /= Void
		local
			an_attribute: ECDP_ATTRIBUTE
			a_function: ECDP_FUNCTION
			a_get_property: ECDP_PROPERTY_GETTER
			a_set_property: ECDP_PROPERTY_SETTER
			a_snippet_feature: ECDP_SNIPPET_FEATURE
			l_feature_name: STRING
		do
			clear_all_feature_variables
			
				-- parents features
			from
				a_type.parents.start
			until
				a_type.parents.after
			loop
				if is_generated_type (a_type.parents.item.name) then
					initialize_features (Generated_types.item (a_type.parents.item.name))
				else
					initialize_features_with_external (a_type.parents.item.name)
				end
				a_type.parents.forth
			end
			
				-- creation routine features of `a_type'
			from
				a_type.creation_routines.start
			until
				a_type.creation_routines.after
			loop
				add_feature (Void_type, a_type.creation_routines.item.name)
				a_type.creation_routines.forth
			end
			
				-- attributes and features of `a_type'
			from
				a_type.features.start
			until
				a_type.features.after
			loop
				create l_feature_name.make_from_string (a_type.features.item.name)
				an_attribute ?= a_type.features.item
				if an_attribute /= Void then
					add_feature (an_attribute.type, an_attribute.name)
				else
					a_function ?= a_type.features.item
					if a_function /= Void then
						add_feature (a_function.returned_type, a_function.name)
					else
						a_get_property ?= a_type.features.item
						if a_get_property /= Void then
							add_feature (a_get_property.returned_type, "get_" + a_get_property.name)
						else
							a_set_property ?= a_type.features.item
							if a_set_property /= Void then
								add_feature (a_set_property.property_type_name, "set_" + a_set_property.name)
							else
								a_snippet_feature ?= a_type.features.item
								if a_snippet_feature /= Void then
									add_feature (Void_type, "this_is_a_snippet_feature_and_we_do_not_know_its_name_neither_its_returned_type")
								else
										-- procedure...
									add_feature (Void_type, a_type.features.item.name)
								end
							end
						end
					end
				end
				a_type.features.forth
			end
		end
		
	initialize_features_with_external (an_external_type_name: STRING) is
			-- Add to `Features' all features associated to `an_external_type_name'.
		require
			non_void_an_external_type_name: an_external_type_name /= Void
			not_empty_an_external_type_name: not an_external_type_name.is_empty
		local
			i: INTEGER
			l_cache_reflection: CACHE_REFLECTION
			local_cache_reader: LOCAL_CACHE_READER
			l_constructors: ARRAY [CONSUMED_CONSTRUCTOR]
			l_fields: ARRAY [CONSUMED_FIELD]
			l_procedures: ARRAY [CONSUMED_PROCEDURE]
			l_functions: ARRAY [CONSUMED_FUNCTION]
			l_properties: ARRAY [CONSUMED_PROPERTY]
			l_events: ARRAY [CONSUMED_EVENT]
			l_external_type: ECDP_EXTERNAL_TYPE
			l_consumed_type: CONSUMED_TYPE
		do
			l_external_type ?= Types.item (an_external_type_name)
			if l_external_type /= Void then
				create l_cache_reflection.make (Clr_version)
				l_consumed_type := l_cache_reflection.consumed_type (l_external_type.type)
				if l_consumed_type = Void then
					create local_cache_reader.make_with_path (Local_cache_path, Clr_version)
					l_consumed_type := local_cache_reader.consumed_type (l_external_type.type)
				end
				if l_consumed_type /= Void then
					from
						i := 1
						l_constructors := l_consumed_type.constructors
					until
						l_constructors = Void or else i > l_constructors.count
					loop
						add_feature (Void_type, l_constructors.item (i).eiffel_name)
						i := i + 1
					end
					from
						i := 1
						l_fields := l_consumed_type.fields
					until
						l_fields = Void or else i > l_fields.count
					loop
						add_feature (l_fields.item (i).return_type.name, l_fields.item (i).eiffel_name)
						i := i + 1
					end
					from
						i := 1
						l_procedures := l_consumed_type.procedures
					until
						l_procedures = Void or else i > l_procedures.count
					loop
						add_feature (Void_type, l_procedures.item (i).eiffel_name)
						i := i + 1
					end
					from
						i := 1
						l_functions := l_consumed_type.functions
					until
						l_functions = Void or else i > l_functions.count
					loop
						add_feature (l_functions.item (i).return_type.name, l_functions.item (i).eiffel_name)
						i := i + 1
					end
					from
						i := 1
						l_properties := l_consumed_type.properties
					until
						l_properties = Void or else i > l_properties.count
					loop
						if l_properties.item (i).setter /= Void then
							add_feature (Void_type, l_properties.item (i).setter.eiffel_name)
						end
						if l_properties.item (i).getter /= Void then
							add_feature (l_properties.item (i).getter.return_type.name, l_properties.item (i).getter.eiffel_name)
						end
						i := i + 1
					end
					from
						i := 1
						l_events := l_consumed_type.events
					until
						l_events = Void or else i > l_events.count
					loop
						if l_events.item (i).adder /= Void then
							add_feature (Void_type, l_events.item (i).adder.eiffel_name)
						end
						if l_events.item (i).remover /= Void then
							add_feature (Void_type, l_events.item (i).remover.eiffel_name)
						end
						if l_events.item (i).raiser /= Void then
							add_feature (l_events.item (i).raiser.return_type.name, l_events.item (i).raiser.eiffel_name)
						end
						i := i + 1
					end
				end
			end
		end


feature -- Implementation

	eiffel_type_name (a_dotnet_type_name: STRING): STRING is
			-- give the eiffel_name corresponding to `a_dotnet_type_name'
			-- ex : System.Boolean -> BOOLEAN
		require
			non_void_a_dotnet_type_name: a_dotnet_type_name /= Void
			not_empty_a_dotnet_type_namee: not a_dotnet_type_name.is_empty
		local
			a_type: TYPE
			formatter: NAME_FORMATTER
			a_consumed_type: CONSUMED_TYPE
			an_external_type: ECDP_EXTERNAL_TYPE
			local_cache_reader: LOCAL_CACHE_READER
			l_cache_reflection: CACHE_REFLECTION
			l_type_error_name: STRING
		do
			if Generated_types.has (a_dotnet_type_name) then
				create formatter
				Result := formatter.full_formatted_type_name (a_dotnet_type_name)
			else
				if types.has (a_dotnet_type_name) then
					an_external_type ?= types.item (a_dotnet_type_name)
					if an_external_type /= Void then
						a_type := an_external_type.type
					end
					if a_type /= Void then
						create l_cache_reflection.make (Clr_version)
						Result := l_cache_reflection.type_name (a_type)
						if Result = Void or else Result.is_empty then
							create local_cache_reader.make_with_path (Local_cache_path, Clr_version)
							a_consumed_type := local_cache_reader.consumed_type (a_type)
							create Result.make_from_string (a_consumed_type.eiffel_name)
						end
						if not Result.is_empty then
							Result.prepend (assembly_of_type (a_dotnet_type_name).assembly_prefix)
						end
					end
					if Result = Void or else Result.is_empty then
						l_type_error_name := a_dotnet_type_name.twin
						l_type_error_name.replace_substring_all (".", "_")
						Result := "ERROR_Type_not_found_" + l_type_error_name
					end
				else
						-- Probably an eiffel type: INTEGER for example
					Result := a_dotnet_type_name
				end
			end
		ensure
			non_void_result: Result /= Void
			not_empty_result: not Result.is_empty
		end

	assembly_of_type (a_dotnet_type_name: STRING): ECDP_REFERENCED_ASSEMBLY is
 			-- Return assembly in witch is `a_dotnet_type_name'.
		require
			non_void_a_dotnet_type_name: a_dotnet_type_name /= Void
			not_empty_a_dotnet_type_name: not a_dotnet_type_name.is_empty
		local
			stop: BOOLEAN
			l_type: TYPE
			l_ref_ass: ECDP_REFERENCED_ASSEMBLIES
		do
			if not is_generated_type (a_dotnet_type_name) then
				if Assemblies.contains_key (a_dotnet_type_name) then
					Result ?= assemblies.item (a_dotnet_type_name)
				else
					create l_ref_ass
					from
						l_ref_ass.Referenced_assemblies.start
					until
						l_ref_ass.Referenced_assemblies.after or stop
					loop
						l_type := l_ref_ass.Referenced_assemblies.item.assembly.get_type_string (a_dotnet_type_name.to_cil)
						if l_type /= Void then
							Result := l_ref_ass.Referenced_assemblies.item
							stop := True
						end
						l_ref_ass.Referenced_assemblies.forth
					end

					check
						non_void_result: Result /= Void
					end
					Assemblies.set_item (a_dotnet_type_name, Result)
				end
			end
		ensure
			non_void_assemblyof_type: Result /= Void
		end

	dotnet_type_name (a_dotnet_feature_name: STRING): STRING is
			-- give the dotnet_type_name corresponding to `a_dotnet_feature_name'
		require
			non_void_a_dotnet_feature_name: a_dotnet_feature_name /= Void
			not_empty_a_dotnet_feature_namee: not a_dotnet_feature_name.is_empty
		do
			if Features.has (a_dotnet_feature_name) then
				Result := features.item (a_dotnet_feature_name)
			elseif Variables.has (a_dotnet_feature_name) then
				Result := variables.item (a_dotnet_feature_name)
			else
				--	Result := "Unknown variable"
			end
		ensure
			valid_dotnet_type_name: Result /= Void and not Result.is_empty
		end

	eiffel_feature_name_from_dynamic_args (a_dotnet_type: TYPE; a_dotnet_feature_name: STRING; feature_arguments: LINKED_LIST [ECDP_EXPRESSION]): STRING is
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
			arguments_types: NATIVE_ARRAY [TYPE]
			l_static_arguments_types: NATIVE_ARRAY [TYPE]
			l_cache_reflection: CACHE_REFLECTION
			l_local_cache_reflection: LOCAL_CACHE_REFLECTION
		do
			if is_generated_type (create {STRING}.make_from_cil (a_dotnet_type.name)) then
				Result := find_variable_name (a_dotnet_feature_name)
			else
				create l_cache_reflection.make (Clr_version)
				l_eiffel_entities := l_cache_reflection.entities (a_dotnet_type, a_dotnet_feature_name)
				if l_eiffel_entities.count <= 1 then
					if l_eiffel_entities.count = 1 then
						Result := l_eiffel_entities.first.eiffel_name
					else
						create l_local_cache_reflection.make_with_path (Local_cache_path, Clr_version)
						l_eiffel_entities := l_local_cache_reflection.entities (a_dotnet_type, a_dotnet_feature_name)
						if l_eiffel_entities.count <= 1 then
							if l_eiffel_entities.count = 1 then
								Result := l_eiffel_entities.first.eiffel_name
							else
								-- unknown feature
							end
						else
								-- overloded method (find the good one)
							from
								feature_arguments.start
								create arguments_types.make (feature_arguments.count)
								i := 0
							until
								feature_arguments.after
							loop
								arguments_types.put (i, feature_arguments.item.type)
		
								i := i + 1
								feature_arguments.forth
							end
		
								-- try with dynamique args
							l_eiffel_entity := l_local_cache_reflection.entity (l_eiffel_entities, arguments_types)
							if l_eiffel_entity = Void then
								l_static_arguments_types := static_arguments_types (a_dotnet_type, a_dotnet_feature_name, arguments_types)
								l_eiffel_entity := l_local_cache_reflection.entity (l_eiffel_entities, l_static_arguments_types)
							end
							if l_eiffel_entity /= Void then
								Result := l_eiffel_entity.eiffel_name
							end
						end
					end
				else
						-- overloded method (find the good one)
					from
						feature_arguments.start
						create arguments_types.make (feature_arguments.count)
						i := 0
					until
						feature_arguments.after
					loop
						arguments_types.put (i, feature_arguments.item.type)

						i := i + 1
						feature_arguments.forth
					end

						-- try with dynamique args
					l_eiffel_entity := l_cache_reflection.entity (l_eiffel_entities, arguments_types)
					if l_eiffel_entity = Void then
						l_static_arguments_types := static_arguments_types (a_dotnet_type, a_dotnet_feature_name, arguments_types)
						-- HACK This is to prevent the CodeDom crashing if the constructor cannot be found.
						-- This query for static_arguments_types should perhaps never be Void.
						if l_static_arguments_types /= Void then
							l_eiffel_entity := l_cache_reflection.entity (l_eiffel_entities, l_static_arguments_types)
						end	
					end
					if l_eiffel_entity /= Void then
						Result := l_eiffel_entity.eiffel_name
					else
						Result := ""
					end
				end
			end
		end

	eiffel_feature_name_from_static_args (a_dotnet_type: TYPE; a_dotnet_feature_name: STRING; feature_arguments: NATIVE_ARRAY [TYPE]): STRING is
 			-- Get the eiffel feature name passing the feature's dotnet type, the dotnet feature name and these statics arguments
		require
			non_void_a_dotnet_type: a_dotnet_type /= Void
			non_void_feature_name: a_dotnet_feature_name /= Void
			not_empty_feature_name: not a_dotnet_feature_name.is_empty
			valid_arguments: feature_arguments = Void implies is_generated_type (create {STRING}.make_from_cil (a_dotnet_type.name))
		local
			cache_reflection: CACHE_REFLECTION
			local_cache_reflection: LOCAL_CACHE_REFLECTION
			rescued: BOOLEAN
		do
			if not rescued then
				if is_generated_type (create {STRING}.make_from_cil (a_dotnet_type.name)) then
					Result := find_variable_name (a_dotnet_feature_name)
				else
					create cache_reflection.make (Clr_version)
					if cache_reflection.is_assembly_in_cache (a_dotnet_type.assembly.get_name) then
						Result := cache_reflection.feature_name (a_dotnet_type, a_dotnet_feature_name, feature_arguments)
					else
						create local_cache_reflection.make_with_path (Local_cache_path, Clr_version)
						Result := local_cache_reflection.feature_name (a_dotnet_type, a_dotnet_feature_name, feature_arguments)
					end
				end
			end
		rescue
			(create {ECDP_EVENT_MANAGER}).raise_event (feature {ECDP_EVENTS_IDS}.Rescued_exception, [feature {ISE_RUNTIME}.last_exception])
			rescued := True
			retry
		end

	eiffel_constructor_name (a_type: TYPE; an_argument_list: LINKED_LIST [ECDP_EXPRESSION]): STRING is
			-- if `target_object' is_generated_type then search corresponding constructor in `eg_generated_types.creation_routines'
			-- else call assembly manager to know the construtor name corresponding to an_argument_list
			-- Result is empty if no constructor in `type'
		require
			non_void_type: a_type /= Void
			non_void_list: an_argument_list /= Void
		local
			type_name: STRING
			generated_type: ECDP_GENERATED_TYPE
			a_constructor: ECDP_CREATION_ROUTINE
			constructor_found: BOOLEAN
			exception: EXCEPTIONS
		do
			create Result.make (80)

			create type_name.make_from_cil (a_type.name)
			if not is_generated_type (type_name) then
				Result.append (eiffel_feature_name_from_dynamic_args (a_type, ".ctor", an_argument_list))
			else
				if generated_type.creation_routines.count = 0  then
					Result.append ("")
				else
					generated_type := Generated_types.item (type_name)
					from
						generated_type.creation_routines.start
						constructor_found := False
					until
						generated_type.creation_routines.after or constructor_found
					loop
						a_constructor := generated_type.creation_routines.item
						if a_constructor.has_arguments (an_argument_list) then
							constructor_found := true
							Result.append (a_constructor.name)
						end
						generated_type.creation_routines.forth
					end -- loop
	
					if not constructor_found then
						create exception
						exception.raise ("No constructor corresponding to list of arguments !")
					end
				end
			end
		ensure
			non_void_result: Result /= Void
		end

	find_variable_name (a_dotnet_variable_name: STRING): STRING is
			-- give the eiffel_name corresponding to `a_dotnet_variable_name'
			-- ex : toto -> toto_bis
		require
			non_void_a_dotnet_variable_name: a_dotnet_variable_name /= Void
			not_empty_a_dotnet_variable_name: not a_dotnet_variable_name.is_empty
		do
			a_dotnet_variable_name.replace_substring_all (".", "_")
			Result := (create {NAME_FORMATTER}).valid_variable_name (unique_variable_name (a_dotnet_variable_name))
		ensure
			non_void_result: Result /= Void
			not_empty_result: Result.count > 0
		end

	returned_type_feature (caller_type: TYPE; a_dotnet_feature_name: STRING; feature_arguments: LINKED_LIST [ECDP_EXPRESSION]): STRING is
			-- get the returned type of `a_dotnet_feature_name'.
		require
			non_void_a_dotnet_feature_name: a_dotnet_feature_name /= Void
			not_empty_a_dotnet_feature_name: not a_dotnet_feature_name.is_empty
			non_void_feature_arguments: feature_arguments /= Void
		local
			i, j: INTEGER
			methods: NATIVE_ARRAY [METHOD_INFO]
			members: NATIVE_ARRAY [MEMBER_INFO]
			method_name: SYSTEM_STRING
			member_name: SYSTEM_STRING
			parameters: NATIVE_ARRAY [PARAMETER_INFO]
			wrong_method: BOOLEAN
			arguments_types, l_static_arguments_types: NATIVE_ARRAY [TYPE]
		do
			check
				valid_caller_type: caller_type = Void implies Variables.has (a_dotnet_feature_name) or Features.has (a_dotnet_feature_name)
			end

			if Variables.has (a_dotnet_feature_name) then
				Result := Variables.item (a_dotnet_feature_name)
			elseif Features.has (a_dotnet_feature_name) then
				Result := Features.item (a_dotnet_feature_name)
			else		
				from
					feature_arguments.start
					create arguments_types.make (feature_arguments.count)
					i := 0
				until
					feature_arguments.after				
				loop
					arguments_types.put (i, feature_arguments.item.type)
					
					i := i + 1
					feature_arguments.forth
				end

				l_static_arguments_types := static_arguments_types (caller_type, a_dotnet_feature_name, arguments_types)
				methods := caller_type.get_methods (	feature {BINDING_FLAGS}.instance |
														feature {BINDING_FLAGS}.static |
														feature {BINDING_FLAGS}.public |
														feature {BINDING_FLAGS}.non_public)
				from
					i := 0
				until
					i = methods.count or Result /= Void
				loop
					method_name := methods.item (i).name
					if method_name.equals (a_dotnet_feature_name.to_cil) then
						parameters := methods.item (i).get_parameters
						if l_static_arguments_types /= Void and then parameters.count = l_static_arguments_types.count then
							from
								j := 0
								wrong_method := False
							until
								j = parameters.count or wrong_method
							loop
								if not parameters.item (j).parameter_type.equals_type (l_static_arguments_types.item (j)) then
										-- Is arguments_type (j) is inherited from paramete (j)?
									if not l_static_arguments_types.item (j).is_subclass_of (parameters.item (j).parameter_type) then
										wrong_method := True
									end
								end
								j := j + 1
							end

							if not wrong_method then
								create Result.make_from_cil (methods.item (i).return_type.full_name)
							end
						end
					end
					i := i + 1
				end
			end
				-- We may be accessing a static field, therefore loop against all the members
				-- This code will need to be revised
			if Result = Void or else Result.is_empty then
				members := caller_type.get_members
				from
					i := 0
				until
					i = members.count or Result /= Void
				loop
					member_name := members.item (i).name
					if member_name.equals (a_dotnet_feature_name.to_cil) then
						 create Result.make_from_cil (members.item (i).reflected_type.full_name)
					end
					i := i + 1
				end
			end
		ensure
			result_set: Result /= Void
			not_empty_result: not Result.is_empty
		end

	unique_variable_name (a_variable_name: STRING): STRING is
			-- Unique variable name built from `a_variable_name'
		require
			non_void_variable_name: a_variable_name /= Void
			not_empty_variable_name: not a_variable_name.is_empty
		do
			if features.has (a_variable_name) or variables.has (a_variable_name) then
				Result := unique_variable_name (a_variable_name + Suffix)
			else
				Result := a_variable_name
			end
		end
		
	where_is_implemented_feature (a_dotnet_type_name: STRING; a_dotnet_feature_name: STRING; feature_arguments: LINKED_LIST [ECDP_EXPRESSION]): STRING is
			-- return the dotnet type name of the type where is implemented `a_dotnet_feature_name'.
		require
			non_void_a_dotnet_type: a_dotnet_type_name /= Void
			not_empty_a_dotnet_type_name: not a_dotnet_type_name.is_empty
			non_void_feature_name: a_dotnet_feature_name /= Void
			not_empty_feature_name: not a_dotnet_feature_name.is_empty
			non_void_feature_arguments: feature_arguments /= Void
		local
			a_generated_type: ECDP_GENERATED_TYPE
		do
			if Generated_types.has (a_dotnet_type_name) then
				a_generated_type := Generated_types.item (a_dotnet_type_name)
				if a_generated_type.has_immediate_feature (a_dotnet_feature_name) then
					Result := a_dotnet_type_name
				else
					from
						a_generated_type.parents.start
					until
						a_generated_type.parents.after or Result /= Void
					loop
						if has_feature (a_generated_type.parents.item.name, a_dotnet_feature_name, feature_arguments) then
							Result := a_generated_type.parents.item.name
						end
						a_generated_type.parents.forth
					end
				end
			end
		end

	where_is_declared_feature (a_dotnet_type_name: STRING; a_dotnet_feature_name: STRING; feature_arguments: LINKED_LIST [ECDP_EXPRESSION]): STRING is
			-- return the dotnet type name of the type where is declared `a_dotnet_feature_name'.
		require
			non_void_a_dotnet_type: a_dotnet_type_name /= Void
			not_empty_a_dotnet_type_name: not a_dotnet_type_name.is_empty
			non_void_feature_name: a_dotnet_feature_name /= Void
			not_empty_feature_name: not a_dotnet_feature_name.is_empty
			non_void_feature_arguments: feature_arguments /= Void
		local
			a_generated_type: ECDP_GENERATED_TYPE
		do
			if Generated_types.has (a_dotnet_type_name) then
				a_generated_type := Generated_types.item (a_dotnet_type_name)
				from
					a_generated_type.parents.start
				until
					a_generated_type.parents.after or Result /= Void
				loop
					if has_feature (a_generated_type.parents.item.name, a_dotnet_feature_name, feature_arguments) then
						Result := a_generated_type.parents.item.name
					end
					a_generated_type.parents.forth
				end
			end
			if Result = Void then
				Result := a_dotnet_type_name
			end
		ensure
			non_void_result: Result /= Void
		end
		
feature {NONE} -- Implementation

	Void_type: STRING is "System.Void"
			-- `System.Void' .NET type name.

	Suffix: STRING is "_bis"
			-- Suffix appended to a feature or a variable to make it unique.

feature {ECDP_EXPRESSION_FACTORY} -- Implementation

	cast_variable_number: CELL [INTEGER] is
			-- number of cast local variable.
		once
			create Result.put (1)
		ensure
			non_void_result: Result /= Void
		end

feature -- Parent type

	parent: STRING
			-- Non interface parent

	set_parent (a_dotnet_parent_name: like parent) is
			-- set `parent' with `a_dotnet_parent_name'.
		require
			valid_a_dotnet_parent_name: a_dotnet_parent_name /= void and then not a_dotnet_parent_name.is_empty
		do
			parent := a_dotnet_parent_name
		ensure
			parent_set: parent = a_dotnet_parent_name
		end

feature -- Dotnet type

	dotnet_type (a_dotnet_type_name: STRING): TYPE is
 			-- Return the runtime Type corresponding to `a_dotnet_type_name'.
		require
			non_void_a_dotnet_type_name: a_dotnet_type_name /= Void
			not_empty_a_dotnet_type_name: not a_dotnet_type_name.is_empty
		local
			l_assembly: ASSEMBLY
			l_ref_ass: ECDP_REFERENCED_ASSEMBLIES
		do
			if not is_generated_type (a_dotnet_type_name) then
				if known_dotnet_types.contains_key (a_dotnet_type_name) then
					Result ?= known_dotnet_types.item (a_dotnet_type_name)
				else
					create l_ref_ass
					from
						l_ref_ass.Referenced_assemblies.start
						Result := Void
					until
						l_ref_ass.Referenced_assemblies.after or Result /= Void
					loop
						l_assembly := l_ref_ass.Referenced_assemblies.item.assembly
						if l_assembly /= Void then
							Result := l_assembly.get_type_string (a_dotnet_type_name.to_cil)
						end
						l_ref_ass.Referenced_assemblies.forth
					end

					check
						non_void_result: Result /= Void
					end
					if Result /= Void then
						known_dotnet_types.set_item (a_dotnet_type_name, Result)
					end
				end
			end
		end

	known_dotnet_types: HASHTABLE is
			-- HASH_TABLE [TYPE, STRING]
			-- Known dotnet types
		once
			create Result.make_from_capacity (150)
		ensure
			non_void_result: Result /= Void
		end

	Assemblies: HASHTABLE is
			-- HASH_TABLE [TYPE, STRING]
		once
			create Result.make_from_capacity (20)
		ensure
			non_void_result: Result /= Void
		end

end -- class ECDP_TYPE_CONVERTER
