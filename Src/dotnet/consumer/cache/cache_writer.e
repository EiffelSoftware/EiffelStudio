indexing
	description: "Allows for adding/removing assemblies from the EAC"
	date: "$Date$"
	revision: "$Revision$"

class
	CACHE_WRITER

inherit
	CALLBACK_INTERFACE

	CACHE_ERRORS

	SHARED_CONSUMED_ASSEMBLY_FACTORY
		export
			{NONE} all
		end

feature -- Basic Operations

	add_assembly (assembly: ASSEMBLY) is
			-- Add `assembly' and its dependencies in EAC.
		require
			non_void_assembly: assembly /= Void
			signed_assembly: assembly.get_name.get_public_key_token /= Void
		local
			info: CACHE_INFO
			consumer: ASSEMBLY_CONSUMER
			cr: CACHE_READER
			dir: DIRECTORY_INFO
			retried, retried_2: BOOLEAN
			l_string_tuple: TUPLE [STRING]
			l_assembly: ASSEMBLY
			l_directory_name: STRING
			l_new_assembly: BOOLEAN
		do
			if not retried then
				create cr
				if not cr.is_initialized then
					cr.initialize
				end
				l_directory_name := cr.absolute_assembly_path_from_location (assembly.location)
				create dir.make (l_directory_name.to_cil)
				check
					non_void_assembly_directory: dir /= Void
				end

				create consumer
					-- Only consume the assembly if it has been modified 
					-- or is not allready in the Eiffel assembly cache
				if consumer.is_assembly_modified (assembly, l_directory_name) then
					if dir.exists then
						dir.delete_boolean (True)
					else
						l_new_assembly := True
					end
					dir.create_
					consumer.set_status_printer (status_printer)
					consumer.set_error_printer (error_printer)
					consumer.set_destination_path (l_directory_name)
					consumer.consume (assembly)

					if not consumer.successful then
						dir.delete_boolean (True)
					elseif l_new_assembly then
						-- Update info.xml with new assembly
						info := cr.info
						l_directory_name.remove_tail (1)
						l_directory_name.remove_head (l_directory_name.last_index_of ((create {OPERATING_ENVIRONMENT}).Directory_separator, l_directory_name.count))
		 				info.add_assembly ( create {CONSUMED_ASSEMBLY_INFO}.make (
													Consumed_assembly_factory.consumed_assembly_from_name (assembly.get_name),
													assembly.location,
													l_directory_name, assembly.get_name.flags.to_integer)
											)
						update_info (info)
					else
						-- Info.xml does not need to be updated
					end
				else
					if status_printer /= Void then
						create l_string_tuple
						l_string_tuple.put ("Up-to-date check: '" +	create {STRING}.make_from_cil (assembly.get_name.full_name) +
							"' has not been modified since last consumption.%N", 1)
						status_printer.call (l_string_tuple)
					end
				end
			elseif not retried_2 then
				retried_2 := True
				if dir /= Void then
					dir.delete_boolean (True)
				end
			end
		rescue
			retried := True
			retry
		end

	remove_assembly (location: STRING) is
			-- Remove remove assembly associated to `location' from cache.
		require
			non_void_location: location /= Void
			not_empty_location: not location.is_empty
			valid_location: feature {SYSTEM_FILE}.exists (location.to_cil)
		local
			info: CACHE_INFO
			cr: CACHE_READER
			i: INTEGER
			dir: DIRECTORY
			retried: BOOLEAN
		do
			if not retried then
				create cr
				create dir.make (cr.absolute_assembly_path_from_location (location))
				if dir.exists then
					dir.recursive_delete
				end
				info := cr.info
				info.remove_assembly_from_location (location)
				update_info (info)
			else
				set_error (Remove_error, location)
			end
		rescue
			retried := True
			retry
		end

	update_info (info: CACHE_INFO) is
			-- Update EAC information file with `info'.
		require
			non_void_info: info /= Void
		local
			l_info_path: STRING
			serializer: EIFFEL_XML_SERIALIZER
			bin_serializer: EIFFEL_BINARY_SERIALIZER
		do
			create serializer
			l_info_path := (create {CACHE_READER}).Absolute_info_path
			serializer.serialize (info, l_info_path)
			create bin_serializer
			bin_serializer.serialize (info, l_info_path)
		end

end -- class CACHE_WRITER
