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
			if destination_path.item (destination_path.count) /= '\' then
				set_destination_path (destination_path + "\")
			end
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
				ass := feature {ASSEMBLY}.load_assembly_name(aname)
				check
					assembly_loaded: ass /= Void
				end
				consume (ass)
			else
					-- An error occured
				set_error (Assembly_not_found_error, create {STRING}.make_from_cil (aname.get_name))
			end
		rescue
			retried := True
			retry
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
					create dotnet_name.make_from_cil (type_name.internal_type.get_full_name)
					simple_name := formatted_type_name (dotnet_name, 0)
					from
						used_names.search (simple_name)
						i := 1
					until
						not used_names.found
					loop
						simple_name := formatted_type_name (dotnet_name, i)
						i := i + 1
						used_names.search (simple_name)
					end
					used_names.put (simple_name, simple_name)
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
							create {STRING}.make_from_cil (type_name.internal_type.get_full_name), 1)
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
			types: CONSUMED_ASSEMBLY_TYPES
			mapping: CONSUMED_ASSEMBLY_MAPPING
			l_string_tuple: like string_tuple
			l_empty_tuple: like empty_tuple
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
				type := type_consumer.consumed_type
				types.put (type.dotnet_name, type.eiffel_name)
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
