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

create
	make

feature {NONE} -- Initialization

	make (a_clr_version: STRING) is
			-- New instance of Current for runtime version `a_clr_version'.
		require
			a_clr_version_not_void: a_clr_version /= Void
		do
			clr_version := a_clr_version
		ensure
			clr_version_set: clr_version = a_clr_version
		end
	
feature -- Access

	clr_version: STRING
			-- Version of CLR runtime.

feature -- Basic Operations

	add_assembly (aname: ASSEMBLY_NAME) is
			-- Add `assembly' and its dependencies in EAC.
		require
			non_void_assembly: aname /= Void
			signed_assembly: aname.get_public_key_token /= Void
		local
			info: CACHE_INFO
			consumer: ASSEMBLY_CONSUMER
			cr: CACHE_READER
			dir: DIRECTORY
			names: NATIVE_ARRAY [ASSEMBLY_NAME]
			i: INTEGER
			name: ASSEMBLY_NAME
			assembly: ASSEMBLY
			retried: BOOLEAN
			l_string_tuple: TUPLE [STRING]
			l_new_assembly: BOOLEAN
			l_assembly_folder: STRING
		do
			if not retried then
				assembly := feature {ASSEMBLY}.load_assembly_name (aname)
				check
					assembly_not_void: assembly /= Void
				end
				create cr.make (clr_version)
				
				l_assembly_folder := cr.absolute_assembly_path (assembly.get_name)
				create dir.make (l_assembly_folder)
				
				name := assembly.get_name

				create consumer
					-- only consume `assembly' if assembly has not already been consumed,
					-- corresponding assembly has been modified or if consumer tool has been 
					-- modified.
				if not dir.exists or else consumer.does_consumed_assembly_require_reconsume (assembly, dir.name) or else consumer.is_newer_tool (dir.name) then
					if dir.exists then
						dir.recursive_delete
					else
						l_new_assembly := True
					end
					dir.create_dir
					consumer.set_status_printer (status_printer)
					consumer.set_error_printer (error_printer)
					consumer.set_status_querier (status_querier)
					consumer.set_destination_path (dir.name)
					consumer.consume (assembly)
					
					if not consumer.successful then
						set_error (Consume_error, create {STRING}.make_from_cil (name.name))
					elseif l_new_assembly then
							-- Only add it in `info' if not yet added.
						info := cr.info
		 				info.add_assembly (Consumed_assembly_factory.consumed_assembly_from_name (name))
						update_info (info)
					end
				else
					if status_printer /= Void then
						create l_string_tuple
						l_string_tuple.put ("Up-to-date check: '" +	create {STRING}.make_from_cil (name.full_name) +
							"' has not been modified since last consumption.%N", 1)
						status_printer.call (l_string_tuple)
					end
				end
				
				if consumer.successful then
					names := assembly.get_referenced_assemblies
					from
						i := 0
					until
						i = names.count
					loop
						name := names.item (i)
						if not cr.is_assembly_in_cache (name) then
							add_assembly (name)
						end
						i := i + 1
					end
				end
			else
				set_error (Assembly_not_found_error, create {STRING}.make_from_cil (aname.name))
			end
		rescue
			retried := True
			retry
		end
	
	remove_assembly (aname: ASSEMBLY_NAME) is
			-- Remove `aname' and its clients from cache.
		require
			non_void_assembly: aname /= Void
			assembly_in_cache: (create {CACHE_READER}.make (clr_version)).is_assembly_in_cache (aname)
		local
			info: CACHE_INFO
			cr: CACHE_READER
			i: INTEGER
			assemblies: ARRAY [CONSUMED_ASSEMBLY]
			name: ASSEMBLY_NAME
			conv: CACHE_CONVERSION
			ca: CONSUMED_ASSEMBLY
			dir: DIRECTORY
			retried: BOOLEAN
		do
			if not retried then
				create cr.make (clr_version)
				create dir.make (cr.absolute_assembly_path (aname))
				if dir.exists then
					dir.recursive_delete
				end
				info := cr.info
				ca := Consumed_assembly_factory.consumed_assembly_from_name (aname)
				info.remove_assembly (ca)
				update_info (info)
				assemblies := cr.client_assemblies (ca)
				create conv
				from
					i := 1
				until
					i > assemblies.count
				loop
					name := conv.assembly (assemblies.item (i)).get_name
					if cr.is_assembly_in_cache (name) then
						remove_assembly (name)					
					end
					i := i + 1
				end
			else
				set_error (Remove_error, create {STRING}.make_from_cil (aname.name))
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
			l_absolute_xml_info_path: STRING
			serializer: EIFFEL_XML_SERIALIZER
			bin_serializer: EIFFEL_BINARY_SERIALIZER
		do
			l_absolute_xml_info_path := (create {CACHE_READER}.make (clr_version)).Absolute_info_path
			create serializer
			serializer.serialize (info, l_absolute_xml_info_path)
			create bin_serializer
			bin_serializer.serialize (info, l_absolute_xml_info_path)
		end

end -- class CACHE_WRITER
