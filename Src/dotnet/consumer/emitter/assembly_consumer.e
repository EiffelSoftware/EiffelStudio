indexing
	description: "[
					Generate XML from given .NET assembly.
					The XML can be used to consume the types
					defined in the assembly from Eiffel.
					]"

class
	ASSEMBLY_CONSUMER

inherit
	ASSEMBLY_CONSUMPTION_ERRORS
	
	REFLECTION

	CALLBACK_INTERFACE

	COMMON_PATH

	SHARED_ASSEMBLY_MAPPING

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
			count := referenced_assemblies.get_length
			create assembly_ids.make (1, count + 1)
			create ca.make (ass)
			assembly_ids.put (ca, 1)
			assembly_mapping.put (1, ca.out)
			from
				i := 1
			until
				i > count
			loop
				create ca.make_from_name (referenced_assemblies.item (i - 1))
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
		do
			ass := feature {ASSEMBLY}.load (aname)
			if ass = Void then
				set_error (Assembly_not_found_error, create {STRING}.make_from_cil (aname.get_name))
			else
				consume (ass)
			end
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
			i, j: INTEGER
			done: BOOLEAN
			type_consumer: TYPE_CONSUMER
			types: NATIVE_ARRAY [TYPE]
			t: TYPE
		do
			create type_consumers.make (1024)
			from
				modules := ass.get_modules
				i := 0
			until
				i >= modules.get_length or done
			loop
				from
					types := modules.item (i).get_types
					j := 0
				until
					j >= types.get_length or done
				loop
					t := types.item (j)
					if is_consumed_type (t) then
						create type_consumer.make (t)
						type_consumers.put (type_consumer, type_consumer.consumed_type.dotnet_name)
						if status_printer /= Void then
							status_printer.call (["Analyzed " + type_consumer.consumed_type.dotnet_name])
						end
						if status_querier /= Void then
							status_querier.call ([])
							done := status_querier.last_result
						end
					end
					j := j + 1
				end
				i := i + 1
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
		do
			(create {DIRECTORY}.make (destination_path + Classes_path)).create_dir
			create serializer
			create types.make (type_consumers.count)
			from
				type_consumers.start
			until
				type_consumers.after or done
			loop
				type_consumer := type_consumers.item_for_iteration
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
					error_printer.call ([error_message])
				else
					if status_printer /= Void then
						status_printer.call (["Written " + s])
					end
					if status_querier /= Void then
						status_querier.call ([])
						done := status_querier.last_result
					end
				end
				type_consumers.forth
			end
			create mapping.make (assembly_ids)
			serializer.serialize (types, destination_path + Assembly_types_file_name)
			serializer.serialize (mapping, destination_path + Assembly_mapping_file_name)
		end

	type_consumers: HASH_TABLE [TYPE_CONSUMER, STRING]
			-- Assembly type consumers

	assembly_ids: ARRAY [CONSUMED_ASSEMBLY]
			-- Assembly ids

end -- class ASSEMBLY_CONSUMER
