indexing
	description: "Allows for adding/removing assemblies from the EAC"

class
	CACHE_WRITER

inherit
	CALLBACK_INTERFACE

	CACHE_ERRORS

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
		do
			assembly := feature {ASSEMBLY}.load (aname)
			if assembly /= Void then
				create cr
				create dir.make (cr.absolute_assembly_path (aname))
				if dir.exists then
					dir.delete_content
					dir.delete
				end
				dir.create_dir
				create consumer
				consumer.set_status_printer (status_printer)
				consumer.set_error_printer (error_printer)
				consumer.set_status_querier (status_querier)
				consumer.set_destination_path (dir.name)
				consumer.consume_from_name (aname)
				if not consumer.successful then
					set_error (Consume_error, create {STRING}.make_from_cil (aname.get_name))
				else
					info := cr.info
	 				info.add_assembly (create {CONSUMED_ASSEMBLY}.make_from_name (aname))
					update_info (info)
					names := assembly.get_referenced_assemblies
					from
						i := 0
					until
						i = names.get_length
					loop
						name := names.item (i)
						if not cr.is_assembly_in_cache (name) then
							add_assembly (name)
						end
						i := i + 1
					end
				end
			else
				set_error (Assembly_not_found_error, create {STRING}.make_from_cil (aname.get_name))
			end
		end
	
	remove_assembly (aname: ASSEMBLY_NAME) is
			-- Remove `aname' and its clients from cache.
		require
			non_void_assembly: aname /= Void
			assembly_in_cache: (create {CACHE_READER}).is_assembly_in_cache (aname)
		local
			info: CACHE_INFO
			cr: CACHE_READER
			i: INTEGER
			assemblies: ARRAY [CONSUMED_ASSEMBLY]
			name: ASSEMBLY_NAME
			conv: CACHE_CONVERSION
			ca: CONSUMED_ASSEMBLY
			dir: DIRECTORY
		do
			create cr
			create dir.make (cr.absolute_assembly_path (aname))
			if dir.exists then
				dir.delete_content
				dir.delete
			end
			info := cr.info
			create ca.make_from_name (aname)
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
		end
		
	update_info (info: CACHE_INFO) is
			-- Update EAC information file with `info'.
		require
			non_void_info: info /= Void
		local
			serializer: EIFFEL_XML_SERIALIZER
		do
			create serializer
			serializer.serialize (info, (create {CACHE_READER}).Absolute_info_path)
		end

end -- class CACHE_WRITER
