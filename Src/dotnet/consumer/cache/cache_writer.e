indexing
	description: "Allows for adding/removing assemblies from the EAC"
	date: "$Date$"
	revision: "$Revision$"

class
	CACHE_WRITER

inherit
	CALLBACK_INTERFACE

	CACHE_ERRORS
	
	CACHE_SETTINGS
		export
			{NONE} all
		end
	
	SHARED_CACHE_MUTEX_GUARD
		export 
			{NONE} all
		end
		
	SAFE_ASSEMBLY_LOADER
		export
			{ANY} all
		end
		
	KEY_ENCODER
		export
			{NONE} all
		end
		
	ARGUMENTS
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
			create cache_reader.make (a_clr_version)
			update_info (cache_reader.info)
		ensure
			clr_version_set: clr_version = a_clr_version
		end
	
feature -- Access

	clr_version: STRING
			-- Version of CLR runtime.

feature -- Basic Operations

	add_assembly (a_path: STRING) is
			-- Add assembly at `a_path' and its dependencies into cache.
		require
			non_void_path: a_path /= Void
			valid_path: not a_path.is_empty
			path_exists: (create {RAW_FILE}.make (a_path)).exists
		local		
			l_string_tuple: TUPLE [STRING]
			l_assembly_folder: STRING
			l_ca: CONSUMED_ASSEMBLY
			l_assembly: ASSEMBLY
			l_name: ASSEMBLY_NAME
			l_consumer: ASSEMBLY_CONSUMER
			l_dir: DIRECTORY
			l_names: NATIVE_ARRAY [ASSEMBLY_NAME]
			l_info: CACHE_INFO
			l_assembly_path: STRING
			l_assembly_info_updated: BOOLEAN
			l_lower_path: like a_path
			l_retried: BOOLEAN
			i: INTEGER
		do
			guard.lock
			if not l_retried then
				l_ca := cache_reader.consumed_assembly_from_path (a_path)
				if l_ca = Void then
					l_lower_path := a_path.as_lower
				else
					l_lower_path := l_ca.location
				end
				
				l_assembly := load_from_gac_or_path (l_lower_path)
			
				create l_consumer.make (Current)
				if l_assembly /= Void then
					l_assembly_path := l_assembly.location.to_lower
					
					if l_ca = Void then
							-- This case presents itself either when the assembly has never been consumed,
							-- or when an assembly has been consumed as a referenced assembly, which means
							-- it, at present, only has a GAC path.
						l_ca := cache_reader.consumed_assembly_from_path (l_assembly_path)
					end
					
					if l_ca /= Void and then l_ca.is_consumed then
							-- Examine existing data and modify
						if l_assembly.global_assembly_cache then	
							if not l_ca.gac_path.is_equal (l_assembly_path) then
								l_ca.set_gac_path (l_assembly_path)
								l_ca.set_is_in_gac (True)
								l_assembly_info_updated := True
							end
							if not l_ca.gac_path.is_equal (l_lower_path) and then not l_ca.location.is_equal (l_lower_path) then
								l_ca.set_location (l_lower_path)
								l_ca.set_is_in_gac (True)
								l_assembly_info_updated := True
							end
						elseif not l_ca.location.is_equal (l_assembly_path) then
							l_ca.set_location (l_assembly_path)
							l_ca.set_is_in_gac (False)
							l_assembly_info_updated := True
								-- Do not reset GAC path, because it really does not affect anything.
								-- Plus it should be preserved for future look ups, just because a GAC assembly in no longer
								-- present doesn't mean that we cannot still look at it's consumed metadata
						end
						
						if l_assembly_info_updated then
								-- The assembly information requires updating
							l_info := cache_reader.info
							l_info.update_assembly (l_ca)
							update_info (l_info)
							update_client_assembly_mappings (l_ca)	
						end
						l_info := Void
					end
				end
					
					-- only consume `assembly' if assembly has not already been consumed,
					-- corresponding assembly has been modified or if consumer tool has been 
					-- modified.
				if l_ca /= Void and then l_ca.is_consumed and then is_assembly_stale (l_lower_path) then
						-- unconsume stale assembly
					unconsume_assembly (l_lower_path)
				end
					
					-- Reset update (for optimizations)
				l_assembly_info_updated := False
				
				if l_ca /= Void and then l_ca.is_consumed then
					if status_printer /= Void then
						create l_string_tuple
						l_string_tuple.put ("Up-to-date check: '" +	a_path +
							"' has not been modified since last consumption.%N", 1)
						status_printer.call (l_string_tuple)
					end
				else
					if l_ca = Void then
						l_ca := consumed_assembly_from_path (l_lower_path)
					end
					l_assembly_folder := cache_reader.absolute_assembly_path_from_consumed_assembly (l_ca)
					create l_dir.make (l_assembly_folder)
					if not l_dir.exists then
						l_dir.create_dir
					end

					if status_printer /= Void then
						l_consumer.set_status_printer (status_printer)
					end
					if error_printer /= Void then
						l_consumer.set_error_printer (error_printer)
					end
					if status_querier /= Void then
						l_consumer.set_status_querier (status_querier)	
					end
					l_consumer.set_destination_path (l_dir.name)
					l_consumer.consume (l_assembly)
					
					if not l_consumer.successful then
						set_error (Consume_error, a_path)
					else
						l_assembly_info_updated := True
						l_info := cache_reader.info
						l_ca.set_is_consumed (True)
		 				l_info.update_assembly (l_ca)
						update_info (l_info)
					end					
				end
				
				if l_consumer.successful then
					l_names := l_assembly.get_referenced_assemblies
					from
						i := 0
					until
						i = l_names.count
					loop
						l_name := l_names.item (i)
						l_assembly := load_assembly_by_name (l_name)
						if l_assembly /= Void and then not cache_reader.is_assembly_in_cache (l_assembly.location, True) or else is_assembly_stale (l_assembly.location) then
							add_assembly (l_assembly.location)
							l_assembly_info_updated := True
						end
						i := i + 1
					end
					if l_assembly_info_updated then
						update_assembly_mappings (l_ca)	
					end
					
				end
			else
				if l_name /= Void then
					set_error (Assembly_not_found_error, l_name.to_string)
				elseif l_assembly /= Void then
					set_error (Assembly_dependancies_not_found_error, l_assembly.full_name)
				else
					set_error (Assembly_not_found_error, a_path)
				end
			end
			guard.unlock
		rescue
			l_retried := True
			retry
		end

	unconsume_assembly (a_path: STRING) is
			-- Unconsumes assembly at `a_path'. This means all consumed metadata in removed
			-- and the consumed assembly entry is_consumed attribute is set to false.
			-- Note: Does not update any assembly reference mappings. Call `update_client_assembly_mapppings' to
			-- perform this.
		require
			non_void_path: a_path /= Void
			valid_path: not a_path.is_empty
		local
			l_string_tuple: TUPLE [STRING]
			l_dir: DIRECTORY
			l_ca: CONSUMED_ASSEMBLY
			l_info: CACHE_INFO
			l_retried: BOOLEAN
		do
			check
				assembly_exists: cache_reader.is_assembly_in_cache (a_path, True)
			end
			guard.lock
			if not l_retried then
				if status_printer /= Void then
					create l_string_tuple
					l_string_tuple.put ("Updating assembly consumed metadata: '" + a_path +
						"' has been modified since last consumption.%N", 1)
					status_printer.call (l_string_tuple)
				end
				l_ca := cache_reader.consumed_assembly_from_path (a_path)
				if l_ca /= Void then
					l_info := cache_reader.info
						-- Remove consumed metadata
					create l_dir.make (cache_reader.absolute_assembly_path_from_consumed_assembly (l_ca))
					if l_dir.exists then
						l_dir.recursive_delete
					end
					l_ca.set_is_consumed (False)
					l_info.update_assembly (l_ca)
					update_info (l_info)					
				end
			else
				set_error (Update_error, a_path)
			end
			guard.unlock
		rescue
			l_retried := True
			retry
		end
	
	remove_recursive_assembly (a_path: STRING) is
			-- Remove assembly identified by `a_path' and its clients from cache.
		require
			non_void_path: a_path /= Void
			valid_path: not a_path.is_empty
		local
			l_ca: CONSUMED_ASSEMBLY
			l_assemblies: ARRAY [CONSUMED_ASSEMBLY]
			l_retried: BOOLEAN
			i: INTEGER
		do
			guard.lock
			if not l_retried then
				remove_assembly_internal (a_path)
				l_ca := consumed_assembly_from_path (a_path)

				l_assemblies := cache_reader.client_assemblies (l_ca)
				from
					i := 1
				until
					i > l_assemblies.count
				loop
					if cache_reader.is_assembly_in_cache (l_assemblies.item (i).gac_path, False) then
						remove_recursive_assembly (l_assemblies.item (i).gac_path)					
					end
					i := i + 1
				end
			else
				set_error (Remove_error, a_path)
			end
			guard.unlock
		rescue
			l_retried := True
			retry
		end
		
	clean_cache is
			-- cleans up cache and removes all incomplete consumed assembly metadata
		local
			l_cache_folder: DIRECTORY
			l_assembly_path: STRING
			l_directories: ARRAYED_LIST [STRING]
			l_assemblies: ARRAY [CONSUMED_ASSEMBLY]
			l_match: BOOLEAN
			l_retried: BOOLEAN
			i: INTEGER
		do
			guard.lock
			if not l_retried then								
				create l_cache_folder.make (cache_reader.eiffel_assembly_cache_path)
				if l_cache_folder.exists then
					l_assemblies := cache_reader.info.assemblies
					
					l_directories := l_cache_folder.linear_representation
					if l_directories.count > 2 then
						from
							l_directories.start	
						until
							l_directories.after
						loop
							l_match := False
							from
								i := 1
							until
								l_match or i > l_assemblies.count
							loop
								if l_assemblies.item (i).folder_name.is_equal (l_directories.item) then
									if not l_assemblies.item (i).is_consumed then
											-- there is no entry in cache info so lets remove it
										l_assembly_path := cache_reader.eiffel_assembly_cache_path.twin
										l_assembly_path.append_character ((create {OPERATING_ENVIRONMENT}).directory_separator)
										l_assembly_path.append (l_directories.item)
										create l_cache_folder.make (l_assembly_path)
										if l_cache_folder.exists then
											l_cache_folder.recursive_delete
										end
									end
									l_match := True
								end
								i := i + 1
							end
							l_directories.forth
						end	
					end
				end	
			end
			guard.unlock
		rescue
			l_retried := True
			retry
		end		
		
	compact_cache_info is
			-- comapcts cache info by removing all CONSUMED_ASSEMBLYs that are marked as being unconsumed
		local
			l_info: CACHE_INFO
			l_assemblies: ARRAY [CONSUMED_ASSEMBLY]
			l_removed: BOOLEAN
			i: INTEGER
		do
			guard.lock
			l_info := cache_reader.info
			l_assemblies := l_info.assemblies
			from
				i := 1
			until
				i > l_assemblies.count
			loop
				if not l_assemblies.item (i).is_consumed then
					l_info.remove_assembly (l_assemblies.item (i))
					l_removed := True
				end
				i := i + 1
			end
			if l_removed then
				update_info (l_info)
			end
			guard.unlock
		end		
		
	consumed_assembly_from_path (a_path: STRING): CONSUMED_ASSEMBLY is
			-- retrieve a consumed assembly for `a_path' and store in cache info for retrieval
		require
			non_void_path: a_path /= Void
			valid_path: not a_path.is_empty
			valid_assembly_path: load_assembly_from_path (a_path) /= Void
		local
			l_id: STRING
			l_info: CACHE_INFO
		do
			guard.lock
			Result := cache_reader.consumed_assembly_from_path (a_path)
			if Result = Void then
				l_id := feature {GUID}.new_guid.to_string
				l_id.to_upper
				Result := create_consumed_assembly_from_path (l_id, a_path)
				l_info := cache_reader.info
				l_info.add_assembly (Result)
				update_info (l_info)
			end
			guard.unlock
		ensure
			result_not_void: Result /= Void
		end
		
	update_info (a_info: CACHE_INFO) is
			-- Update EAC information file with `info'.
		require
			non_void_info: a_info /= Void
		local
			l_absolute_xml_info_path: STRING
			serializer: EIFFEL_XML_SERIALIZER
		do
			guard.lock
			if a_info.is_dirty then
				a_info.set_is_dirty (False)
				l_absolute_xml_info_path := cache_reader.Absolute_info_path
				create serializer
				serializer.serialize (a_info, l_absolute_xml_info_path)
			end
			guard.unlock
		ensure
			not_info_is_dirty: not a_info.is_dirty
		end

feature {NONE} -- Implementation

	is_assembly_stale (a_path: STRING): BOOLEAN is
			-- Is assembly `a_path' out of date
			-- Returns false if assembly has not already been consumed.
		require
			non_void_path: a_path /= Void
			valid_path: not a_path.is_empty
		local
			l_ca: CONSUMED_ASSEMBLY
			l_consume_path: STRING
			l_file_info: FILE_INFO
			l_dir_info: DIRECTORY_INFO
			l_so: SYSTEM_OBJECT
			l_new_ca: CONSUMED_ASSEMBLY
		do
			l_ca := cache_reader.consumed_assembly_from_path (a_path)
			if l_ca /= Void and then l_ca.is_consumed then
				l_consume_path := cache_reader.absolute_assembly_path_from_consumed_assembly (l_ca)

				create l_dir_info.make (l_consume_path)
				create l_file_info.make (l_ca.location)
				Result := not l_dir_info.exists or feature {SYSTEM_DATE_TIME}.compare (l_file_info.last_write_time, l_dir_info.creation_time) > 0
				if not Result then
					-- User could have swaped file to an older version
					l_new_ca := create_consumed_assembly_from_path ("dummy", a_path)
					Result := not l_new_ca.is_assembly_info_equal (l_ca)
				end
				if not Result then
						-- now check in consumer is newer
					l_so := Current
					create l_file_info.make (l_so.get_type.assembly.location)
					Result := feature {SYSTEM_DATE_TIME}.compare (l_file_info.last_write_time, l_dir_info.creation_time) > 0
				end
			end


			debug ("assemblies_are_never_stale")
				Result := False
			end
		end
		
	remove_assembly_internal (a_path: STRING) is
			-- Remove assembly identified by `a_path' and its clients from cache.
		require
			non_void_path: a_path /= Void
			valid_path: not a_path.is_empty
		local
			l_ca: CONSUMED_ASSEMBLY
			l_dir: DIRECTORY
			l_info: CACHE_INFO
			l_retried: BOOLEAN
		do
			guard.lock
			if not l_retried then
				l_ca := consumed_assembly_from_path (a_path)
				create l_dir.make (cache_reader.absolute_assembly_path_from_consumed_assembly (l_ca))
				if l_dir.exists then
					l_dir.recursive_delete
				end
				if cache_reader.is_assembly_in_cache (a_path, False) then
					l_info := cache_reader.info
					l_info.remove_assembly (l_ca)
					update_info (l_info)
				end
			else
				set_error (Remove_error, a_path)
			end
			guard.unlock
		rescue
			l_retried := True
			retry
		end
		
	create_consumed_assembly_from_path (a_id: STRING; a_path: STRING): CONSUMED_ASSEMBLY is
			-- Creates a new CONSUMED_ASSEMBLY
		require
			non_void_id: a_id /= Void
			valid_id: not a_id.is_empty
			non_void_path: a_path /= Void
			valid_path: not a_path.is_empty
			valid_assembly_path: load_assembly_from_path (a_path) /= Void
		local
			l_assembly: ASSEMBLY
			l_name: ASSEMBLY_NAME
			l_key: STRING
			l_culture: STRING
			l_is_in_gac: BOOLEAN
			folder_name: STRING
		do
			l_assembly := load_from_gac_or_path (a_path)
			if l_assembly /= Void then
				l_name := l_assembly.get_name
				
				if l_name.get_public_key_token = Void or else l_name.get_public_key_token.length = 0 then
					l_key := "null"
				else
					l_key := encoded_key (l_name.get_public_key_token)
				end
				l_culture := l_name.culture_info.to_string
				if l_culture.is_empty then
					l_culture := "neutral"				
				end
				
				l_is_in_gac := l_assembly.global_assembly_cache
				if not l_is_in_gac and then is_mscorlib (l_assembly) then
					l_is_in_gac := True
				end
				
				if conservative_mode then
					folder_name := a_id.twin
				else
					create folder_name.make (l_name.name.length + a_id.count + 1)
					folder_name.append (l_name.name)
					folder_name.append_character ('!')
					folder_name.append (a_id)				
				end
				
				create Result.make (a_id, folder_name, l_name.name, l_name.version.to_string, l_culture, l_key, a_path, l_assembly.location, l_is_in_gac)
			end
		ensure
			non_void_result: Result /= Void
		end
		
	update_assembly_mappings (a_assembly: CONSUMED_ASSEMBLY) is
			-- updates serialized assembly mappings and sets consumed status based on contents of EAC.
		require
			non_void_assembly: a_assembly /= Void
			is_consumed: a_assembly.is_consumed
		local
			l_mappings: CONSUMED_ASSEMBLY_MAPPING
			l_serializer: EIFFEL_XML_SERIALIZER
			l_ref_ca: like consumed_assembly_from_path
			i: INTEGER
		do
			guard.lock
			create l_serializer
			l_mappings := cache_reader.assembly_mapping_from_consumed_assembly (a_assembly)
			
			from
				i := 1
			until
				i > l_mappings.assemblies.count
			loop
				l_ref_ca := consumed_assembly_from_path (l_mappings.assemblies.item (i).location)
				if l_ref_ca /= Void then
					l_mappings.assemblies.put (l_ref_ca, i)
				else
					l_mappings.assemblies.item (i).set_is_consumed (False)
				end
				i := i + 1
			end
			l_serializer.serialize (l_mappings, cache_reader.absolute_assembly_mapping_path_from_consumed_assembly (a_assembly))
			guard.unlock
		end

	update_client_assembly_mappings (a_assembly: CONSUMED_ASSEMBLY) is
			-- updates serialized assembly mappings or all clients of `a_assembly' and sets consumed status based on contents of EAC.
		require
			non_void_assembly: a_assembly /= Void
			is_consumed: a_assembly.is_consumed
		local
			l_clients: ARRAY [CONSUMED_ASSEMBLY]
			i: INTEGER
		do
			guard.lock
			l_clients := cache_reader.client_assemblies (a_assembly)
			from
				i := 1
			until
				i > l_clients.count
			loop
				update_assembly_mappings (l_clients.item (i))
				i := i + 1
			end
			guard.unlock
		end
		
	cache_reader: CACHE_READER
			-- associated cache reader

invariant
	non_void_cache_reader: cache_reader /= Void

end -- class CACHE_WRITER
