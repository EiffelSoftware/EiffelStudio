indexing
	description: "[
					Generate XML from given .NET assembly.
					The XML can be used to consume the types
					defined in the assembly from Eiffel.
					]"
	date: "$Date$"
	revision: "$Revision$"

class
	ASSEMBLY_CONSUMER

inherit
	ASSEMBLY_CONSUMPTION_ERRORS
	
	REFLECTION

	CALLBACK_INTERFACE

	COMMON_PATH

	SHARED_ASSEMBLY_MAPPING

	SHARED_CONSUMED_ASSEMBLY_FACTORY

	NAME_FORMATTER

	SHARED_CONSUMED_ASSEMBLY_FACTORY

create
	default_create

feature -- Basic Operations

	consume (ass: ASSEMBLY) is
			-- Generate XML from `ass' metadata into `dest_path'.
		require
			non_void_assembly: ass /= Void
			non_void_destination_path: destination_path /= Void
			valid_destination_path: (create {DIRECTORY}.make (destination_path)).exists
		local
			referenced_assemblies: NATIVE_ARRAY [ASSEMBLY_NAME]
			i, count: INTEGER
			ca: CONSUMED_ASSEMBLY
		do
			referenced_assemblies := ass.get_referenced_assemblies
			reset_assembly_mapping
			count := referenced_assemblies.count
			create assembly_ids.make (1, count + 1)
			ca := Consumed_assembly_factory.consumed_assembly (ass)
			assembly_ids.put (ca, 1)
			assembly_mapping.put (1, ca.out)
			from
				i := 1
			until
				i > count
			loop
				ca := Consumed_assembly_factory.consumed_assembly_from_name (referenced_assemblies.item (i - 1))
				i := i + 1
				assembly_ids.put (ca, i)
				assembly_mapping.put (i, ca.out)
			end
			prepare_consumed_types (ass)
			serialize_consumed_types				
		end

	consume_from_name (aname: ASSEMBLY_NAME) is
			-- Generate XML for assembly with name `aname'.
		require
			non_void_name: aname /= Void
			signed_name: aname.get_public_key_token /= Void
		local
			ass: ASSEMBLY
			retried: BOOLEAN
		do
			if not retried then
				ass := feature {ASSEMBLY}.load_assembly_name (aname)
				check
					assembly_loaded: ass /= Void
				end
				consume (ass)
			else
					-- An error occured
				set_error (Assembly_not_found_error, create {STRING}.make_from_cil (aname.name))
			end
		rescue
			retried := True
			retry
		end
		
	is_assembly_modified (ass: ASSEMBLY; apath: STRING): BOOLEAN is
			-- is the assembly 'ass' newer than the version in the specified path 'apath'
		require
			non_void_assembly: ass /= Void
			non_void_path: apath /= Void
		local
			assembly_file: RAW_FILE
			path_to_assembly: STRING
			consumed_path: STRING
			consumed_path_timestamp: INTEGER
			assembly_file_timestamp: INTEGER
			consumed_folder: DIRECTORY
		do
			consumed_path := apath.clone (apath)
			
			-- Set the default value for all conditions where the assembly date cannot be compared
			Result := False
				
			create path_to_assembly.make_from_cil (ass.code_base)
			if path_to_assembly.count > 8 and path_to_assembly.substring_index ("file:///", 1) = 1 then
				path_to_assembly := path_to_assembly.substring (9, path_to_assembly.count)
				create assembly_file.make (path_to_assembly)
				create consumed_folder.make (consumed_path)
				
				if consumed_folder.exists and then assembly_file.exists then
					consumed_path.prune_all_trailing ((create {OPERATING_ENVIRONMENT}).directory_separator)

					consumed_path_timestamp := (create {RAW_FILE}.make (consumed_path)).date
					assembly_file_timestamp := assembly_file.date
					
					Result := (consumed_path_timestamp < assembly_file_timestamp)
				elseif not consumed_folder.exists and then assembly_file.exists then
					Result := True
				end
			end
		ensure
			non_void_result : Result /= Void
		end
		
feature -- Access

	file_name (type: CONSUMED_TYPE): STRING is
			-- File name where `type' will be serialized.
		do
			Result := type.dotnet_name + Xml_extension
		end
		
	Xml_extension: STRING is ".xml"
			-- XML file extension

	destination_path: STRING
			-- Path where XML files are generated

feature -- Element Settings

	set_destination_path (path: STRING) is
			-- Set `destination_path' with `path'.
		require
			non_void_path: path /= Void
			valid_path: (create {DIRECTORY}.make (path)).exists
		do
			destination_path := path
		ensure
			destination_path_set: destination_path = path
		end
		
feature {NONE} -- Implementation

	prepare_consumed_types (ass: ASSEMBLY) is
			-- Build `consumed_types'.
		require
			non_void_assembly: ass /= Void
		local
			modules: NATIVE_ARRAY [MODULE]
			i, j, type_count, module_count, generated_count: INTEGER
			done: BOOLEAN
			type_consumer: TYPE_CONSUMER
			module_types: NATIVE_ARRAY [TYPE]
			t: TYPE
			type_name: TYPE_NAME_SOLVER
			simple_name, dotnet_name: STRING
			list: SORTED_TWO_WAY_LIST [TYPE_NAME_SOLVER]
			used_names: HASH_TABLE [STRING, STRING]
			names: HASH_TABLE [SORTED_TWO_WAY_LIST [TYPE_NAME_SOLVER], STRING]
			l_string_tuple: like string_tuple
			l_empty_tuple: like empty_tuple
		do
			modules := ass.get_modules
			module_count := modules.count
			create names.make (1024)
			l_string_tuple := string_tuple
			l_empty_tuple := empty_tuple
			from
				i := 0
			until
				i >= module_count or done
			loop
				from
					module_types := modules.item (i).get_types
					type_count := module_types.count
					j := 0
				until
					j >= type_count
				loop
					t := module_types.item (j)
					if is_consumed_type (t) then
						generated_count := generated_count + 1
						create type_name.make (t)
						simple_name := type_name.simple_name
						names.search (simple_name)
						if names.found then
							names.found_item.extend (type_name)
						else
							create list.make
							list.extend (type_name)
							names.put (list, simple_name)
						end
					end
					j := j + 1
				end
				if status_querier /= Void then
					status_querier.call (l_empty_tuple)
					done := status_querier.last_result
				end
				i := i + 1
			end
			create used_names.make (generated_count)
			create type_consumers.make (generated_count)
			from
				names.start
			until
				names.after or done
			loop
				list := names.item_for_iteration
				from
					list.start
				until
					list.after
				loop
					type_name := list.item
					create dotnet_name.make_from_cil (type_name.internal_type.full_name)
					simple_name := formatted_type_name (dotnet_name, used_names)
					type_name.set_eiffel_name (simple_name)
					list.forth
				end
				if status_querier /= Void then
					status_querier.call (l_empty_tuple)
					done := status_querier.last_result
				end
				names.forth
			end
			used_names := Void
			from
				names.start
			until
				names.after or done
			loop
				list := names.item_for_iteration
				from
					list.start
				until
					list.after
				loop
					type_name := list.item
					create type_consumer.make (type_name.internal_type, type_name.eiffel_name)
					type_consumers.put (type_consumer, type_name.eiffel_name)
					if status_printer /= Void then
						l_string_tuple.put ("Analyzed " +
							create {STRING}.make_from_cil (type_name.internal_type.full_name), 1)
						status_printer.call (l_string_tuple)
					end
					if status_querier /= Void then
						status_querier.call (l_empty_tuple)
						done := status_querier.last_result
					end
					list.forth
				end
				if status_querier /= Void then
					status_querier.call (l_empty_tuple)
					done := status_querier.last_result
				end
				names.forth
			end
		end
		
	serialize_consumed_types is
			-- Build `consumed_types'.
		local
			type_consumer: TYPE_CONSUMER
			serializer: EIFFEL_XML_SERIALIZER
			s, fn: STRING
			done: BOOLEAN
			type: CONSUMED_TYPE
			parent: CONSUMED_REFERENCED_TYPE
			types: CONSUMED_ASSEMBLY_TYPES
			mapping: CONSUMED_ASSEMBLY_MAPPING
			l_string_tuple: like string_tuple
			l_empty_tuple: like empty_tuple
			l_is_delegate, l_is_value_type: BOOLEAN
		do
			(create {DIRECTORY}.make (destination_path + Classes_path)).create_dir
			create serializer
			create types.make (type_consumers.count)			
			l_string_tuple := string_tuple
			l_empty_tuple := empty_tuple
			from
				type_consumers.start
			until
				type_consumers.after or done
			loop
				type_consumer := type_consumers.item_for_iteration
				type_consumers.remove (type_consumers.key_for_iteration)
				type_consumer.initialize
				if not type_consumer.initialized then
						-- An error occured during the initialization of type.
						-- Notice the problem on this specific type and try the next type.
					if type_consumer.consumed_type.dotnet_name /= Void then
						set_error (Type_initialization_error, "One of the features of "+ type_consumer.consumed_type.dotnet_name +" is invalid.")
					else	
						set_error (Type_initialization_error, "")
					end
				else
					type := type_consumer.consumed_type
					parent := type.parent
					if parent /= Void then
						l_is_value_type := parent.name.is_equal ("System.ValueType")
						l_is_delegate := parent.name.is_equal ("System.MulticastDelegate") or parent.name.is_equal ("System.Delegate")					
					end
					types.put (type.dotnet_name, type.eiffel_name, type.is_interface, type.is_enum, l_is_delegate, l_is_value_type)
					fn := file_name (type)
					create s.make (fn.count + destination_path.count + Classes_path.count)
					s.append (destination_path)
					s.append (Classes_path)
					s.append (fn)
					serializer.serialize (type, s)
					if not serializer.successful and error_printer /= Void then
						set_error (Serialization_error, type.eiffel_name + ", " + serializer.error_message)
						l_string_tuple.put (error_message, 1)
						error_printer.call (l_string_tuple)
					else
						if status_printer /= Void then
							l_string_tuple.put ("Written " + s, 1)
							status_printer.call (l_string_tuple)
						end
						if status_querier /= Void then
							status_querier.call (l_empty_tuple)
							done := status_querier.last_result
						end
					end
				end
			end
			create mapping.make (assembly_ids)
			serializer.serialize (types, destination_path + Assembly_types_file_name)
			serializer.serialize (mapping, destination_path + Assembly_mapping_file_name)
		end

	type_consumers: HASH_TABLE [TYPE_CONSUMER, STRING]
			-- Assembly type consumers

	assembly_ids: ARRAY [CONSUMED_ASSEMBLY]
			-- Assembly ids

feature {NONE} -- Constants

	empty_tuple: TUPLE is
			-- Empty tuple to avoid too many TUPLE creation which can be slow.
		once
			create Result.make
		end

	string_tuple: TUPLE [STRING] is
			-- Tuple that contain only a string object.
		once
			create Result.make
		end

end -- class ASSEMBLY_CONSUMER
