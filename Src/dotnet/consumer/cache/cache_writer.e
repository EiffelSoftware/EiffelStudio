indexing
	description: "Allows for adding/removing assemblies from the EAC"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

frozen class
	CACHE_WRITER

inherit
	SYSTEM_OBJECT

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

	SHARED_ASSEMBLY_LOADER

	KEY_ENCODER
		export
			{NONE} all
		end

	ARGUMENTS
		export
			{NONE} all
		end

	SHARED_CLR_VERSION
		export
			{NONE} all
			{ANY} clr_version
		end

	SHARED_LOGGER
		export
			{NONE} all
		end

	IDISPOSABLE

create
	make

feature {NONE} -- Initialization

	make is
			-- New instance of Current for runtime version `a_clr_version'.
		do
			create cache_reader
		end

feature -- Clean Up

	dispose is
			-- Clean up used resources.
		do
		end

feature -- Basic Operations

	add_assembly (a_path: STRING; a_info_only: BOOLEAN) is
			-- Add assembly at `a_path' and its dependencies into cache.
		require
			non_void_path: a_path /= Void
			valid_path: not a_path.is_empty
			path_exists: (create {RAW_FILE}.make (a_path)).exists
		local
			l_processed: ARRAYED_LIST [STRING]
		do
			create l_processed.make (0)
			l_processed.compare_objects
			add_assembly_ex (a_path, a_info_only, Void, l_processed)
		end

	add_assembly_ex (a_path: STRING; a_info_only: BOOLEAN; a_other_assemblies: LIST [STRING]; a_processed: ARRAYED_LIST [STRING]) is
			-- Add assembly at `a_path' and its dependencies into cache.
		require
			non_void_path: a_path /= Void
			valid_path: not a_path.is_empty
			path_exists: (create {RAW_FILE}.make (a_path)).exists
			a_other_assemblies_contains_valid_items: a_other_assemblies /= Void implies a_other_assemblies.is_empty or else
				a_other_assemblies.for_all (agent (a_item: STRING): BOOLEAN
					do
						Result := a_item /= Void and then a_item.as_lower.is_equal (a_item)
					end)
			a_other_assemblies_compares_objects: a_other_assemblies /= Void implies a_other_assemblies.object_comparison
			a_processed_attached: a_processed /= Void
			a_processed_compares_objects: a_processed.object_comparison
			a_processed_contains_valid_items: a_processed.is_empty or else a_processed.for_all (agent (a_item: STRING): BOOLEAN
					do
						Result := a_item /= Void and then a_item.as_lower.is_equal (a_item)
					end)
		local
			l_string_tuple: TUPLE [STRING]
			l_assembly_folder: STRING
			l_ca: CONSUMED_ASSEMBLY
			l_assembly: ASSEMBLY
			l_old_assembly: ASSEMBLY
			l_name: ASSEMBLY_NAME
			l_consumer: ASSEMBLY_CONSUMER
			l_dir: DIRECTORY
			l_names: NATIVE_ARRAY [ASSEMBLY_NAME]
			l_info: CACHE_INFO
			l_assembly_path: STRING
			l_assembly_info_updated: BOOLEAN
			l_lower_path: like a_path
			l_reader: like cache_reader
			l_reason: SYSTEM_STRING
			l_result: SYSTEM_OBJECT
			retried: BOOLEAN
			i: INTEGER
		do
			if not retried then
				guard.lock

				{SYSTEM_DLL_TRACE}.write_line_string ({SYSTEM_STRING}.format ("Adding assembly (does not mean consuming) '{0}'.", a_path))
				l_reason := "New entry"

				l_reader := cache_reader
				l_ca := l_reader.consumed_assembly_from_path (a_path)
				if l_ca = Void then
					l_lower_path := {PATH}.get_full_path (a_path.as_lower)
				else
					l_lower_path := l_ca.location
					if l_ca.has_info_only and not a_info_only then
						l_reason := "Consuming extra information"
					end
				end

				l_assembly := assembly_loader.load_from_gac_or_path (l_lower_path)
				create l_consumer.make (Current)
				if l_assembly /= Void then
					a_processed.extend (l_lower_path)

					l_assembly_path := l_assembly.location.to_lower

					if l_ca = Void then
							-- This case presents itself either when the assembly has never been consumed,
							-- or when an assembly has been consumed as a referenced assembly, which means
							-- it, at present, only has a GAC path.
						l_ca := l_reader.consumed_assembly_from_path (l_assembly_path)
						if l_ca /= Void then
							l_ca.set_location (l_lower_path)
							l_assembly_info_updated := True
						end
					end

					if l_ca /= Void and then l_ca.is_consumed then
						{SYSTEM_DLL_TRACE}.write_line_string ({SYSTEM_STRING}.format ("'{0}' has already been consumed. Checking...", a_path))

							-- Examine existing data and modify
						if l_assembly.global_assembly_cache then
							if not l_ca.gac_path.is_equal (l_assembly_path) then
								l_ca.set_gac_path (l_assembly_path)
								l_ca.set_is_in_gac (True)
								l_assembly_info_updated := True
								{SYSTEM_DLL_TRACE}.write_line_string ("Assembly GAC path changed.")
							end
							if not l_ca.gac_path.is_equal (l_lower_path) and then not l_ca.location.is_equal (l_lower_path) then
								l_ca.set_location (l_lower_path)
								l_ca.set_is_in_gac (True)
								l_assembly_info_updated := True
								{SYSTEM_DLL_TRACE}.write_line_string ("Assembly location path changed.")
							end
						elseif not l_ca.location.is_equal (l_assembly_path) then
							l_ca.set_location (l_assembly_path)
							l_ca.set_is_in_gac (False)
							l_assembly_info_updated := True
							{SYSTEM_DLL_TRACE}.write_line_string ("Assembly is no longer in GAC.")
								-- Do not reset GAC path, because it really does not affect anything.
								-- Plus it should be preserved for future look ups, just because a GAC assembly in no longer
								-- present doesn't mean that we cannot still look at it's consumed metadata
						end

						if l_assembly_info_updated then
								-- The assembly information requires updating
							{SYSTEM_DLL_TRACE}.write_line_string ({SYSTEM_STRING}.format ("Storing changed assembly information for '{0}'.", a_path))
							l_info := l_reader.info
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
				if l_ca /= Void and then l_ca.is_consumed and then ((not a_info_only and l_ca.has_info_only) or else cache_reader.is_assembly_stale (l_lower_path)) then
						-- unconsume stale assembly
					unconsume_assembly (l_lower_path)
					l_name := l_assembly.get_name
					l_ca.set_culture (culture_from_info (l_name.culture_info))
					l_ca.set_version (l_name.version.to_string)
					l_ca.set_key (public_key_token_from_array (l_name.get_public_key_token))
				end

					-- Reset update (for optimizations)
				l_assembly_info_updated := False

				if l_ca /= Void and then l_ca.is_consumed then
					{SYSTEM_DLL_TRACE}.write_line_string ({SYSTEM_STRING}.format ("Assembly '{0}' is not being consumed because it is up-to-date.", a_path))
					l_reason := "Out of date"
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
					l_assembly_folder := l_reader.absolute_assembly_path_from_consumed_assembly (l_ca)
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

					if notifier /= Void then
						notifier.notify_consume (create {NOTIFY_MESSAGE}.make (l_ca, a_path, l_reason, cache_reader.absolute_consume_path))
					end

						-- Load assembly from path, so path assembly is consumed.
						-- MS resort to a load performance trick where they provide assemblies with no implementation
						-- in a local path and the implementation in the GAC.
					l_old_assembly := l_assembly
					l_assembly := assembly_loader.load_from (l_lower_path)
					if l_assembly = Void then
						l_assembly := l_old_assembly
					end
					l_consumer.consume (l_assembly, assembly_loader, a_info_only)

					if not l_consumer.successful then
						set_error (Consume_error, a_path)
					else
						l_assembly_info_updated := True
						l_info := l_reader.info
						l_ca.set_is_consumed (True, a_info_only)
		 				l_info.update_assembly (l_ca)

						update_info (l_info)
					end
				end

				if l_consumer.successful then
					{SYSTEM_DLL_TRACE}.write_line_string ({SYSTEM_STRING}.format ("Processing assembly dependencies...%N%NAssembly: {0}.", a_path))
					if notifier /= Void then
						notifier.notify_info ("Synchronizing cache...")
					end

					l_names := l_assembly.get_referenced_assemblies
					from
						i := 0
					until
						i = l_names.count
					loop
						l_name := l_names.item (i)
						l_assembly := assembly_loader.load (l_name)
						if l_assembly /= Void and then not a_processed.has (l_assembly.location) and then not (l_reader.is_assembly_in_cache (l_assembly.location, True) or else cache_reader.is_assembly_stale (l_assembly.location)) then
								-- Adds only lookup info
							add_assembly_ex (l_assembly.location, a_info_only or else (a_other_assemblies = Void or else not a_other_assemblies.has (l_assembly.location.to_lower)), a_other_assemblies, a_processed)
							l_assembly_info_updated := True
						end
						i := i + 1
					end
					if l_assembly_info_updated then
						if notifier /= Void then
							notifier.notify_info ({SYSTEM_STRING}.format ("Synchronizing cache...%N%NLocation: {0}", cache_reader.absolute_consume_path))
						end
						update_assembly_mappings (l_ca)
						update_client_assembly_mappings (l_ca)
					end
				end

				if notifier /= Void then
					notifier.clear_notification
				end
			else
				{SYSTEM_DLL_TRACE}.write_line_string ({SYSTEM_STRING}.format ("Failed to consume assembly '{0}'.", a_path))

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
			debug ("log_exceptions")
				log_last_exception
			end
			if not retried then
				retried := True
				retry
			end
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
			l_reader: like cache_reader
			retried: BOOLEAN
		do
			check
				assembly_exists: cache_reader.is_assembly_in_cache (a_path, True)
			end
			if not retried then
				guard.lock
				{SYSTEM_DLL_TRACE}.write_line_string ({SYSTEM_STRING}.format ("Unconsuming assembly '{0}'", a_path))

				l_reader := cache_reader
				if status_printer /= Void then
					create l_string_tuple
					l_string_tuple.put ("Updating assembly consumed metadata: '" + a_path +
						"' has been modified since last consumption.%N", 1)
					status_printer.call (l_string_tuple)
				end
				l_ca := l_reader.consumed_assembly_from_path (a_path)
				if l_ca /= Void then
					l_info := l_reader.info
						-- Remove consumed metadata
					create l_dir.make (l_reader.absolute_assembly_path_from_consumed_assembly (l_ca))
					if l_dir.exists then
						l_dir.recursive_delete
					end
					l_ca.set_is_consumed (False, True)
					l_info.update_assembly (l_ca)
					update_client_assembly_mappings (l_ca)
					update_info (l_info)
				end
			else
				set_error (Update_error, a_path)
			end
			guard.unlock
		rescue
			debug ("log_exceptions")
				log_last_exception
			end
			if not retried then
				retried := True
				retry
			end
		end

	remove_recursive_assembly (a_path: STRING) is
			-- Remove assembly identified by `a_path' and its clients from cache.
		require
			non_void_path: a_path /= Void
			valid_path: not a_path.is_empty
		local
			l_ca: CONSUMED_ASSEMBLY
			l_assemblies: ARRAY [CONSUMED_ASSEMBLY]
			retried: BOOLEAN
			l_reader: like cache_reader
			i: INTEGER
		do
			if not retried then
				guard.lock
				l_reader := cache_reader
				remove_assembly_internal (a_path)
				l_ca := consumed_assembly_from_path (a_path)

				l_assemblies := l_reader.client_assemblies (l_ca)
				from
					i := 1
				until
					i > l_assemblies.count
				loop
					if l_assemblies.item (i) /= Void and then l_reader.is_assembly_in_cache (l_assemblies.item (i).gac_path, False) then
						remove_recursive_assembly (l_assemblies.item (i).gac_path)
					end
					i := i + 1
				end
			else
				set_error (Remove_error, a_path)
			end
			guard.unlock
		rescue
			debug ("log_exceptions")
				log_last_exception
			end
			if not retried then
				retried := True
				retry
			end
		end

	clean_cache is
			-- cleans up cache and removes all incomplete consumed assembly metadata
		local
			l_cache_folder: DIRECTORY
			l_assemblies: ARRAY [CONSUMED_ASSEMBLY]
			l_ca: CONSUMED_ASSEMBLY
			retried: BOOLEAN
			l_upper: INTEGER
			l_remove: BOOLEAN
			l_removed: BOOLEAN
			i: INTEGER
		do
			if not retried then
				guard.lock
				{SYSTEM_DLL_TRACE}.write_line_string ({SYSTEM_STRING}.format ("Cleaning EAC '{0}'.", cache_reader.eac_path))

				create l_cache_folder.make (cache_reader.eiffel_assembly_cache_path)
				if l_cache_folder.exists then
					l_assemblies := cache_reader.info.assemblies

						-- Unconsumed assemblies that cannot be found
					from
						i := l_assemblies.lower
						l_upper := l_assemblies.count
					until
						i > l_upper
					loop
						l_ca := l_assemblies.item (i)
						l_remove := not l_ca.is_consumed
						if not l_remove and then not (create {RAW_FILE}.make (l_ca.location)).exists then
							if not (create {RAW_FILE}.make (l_ca.gac_path)).exists then
								l_remove := True
							end
						end
						if l_remove then
								-- Remove assembly
							unconsume_assembly (l_ca.location)
							update_client_assembly_mappings (l_ca)
							l_removed := True
						end
						i := i + 1
					end
				end
			end
			guard.unlock
		rescue
			debug ("log_exceptions")
				log_last_exception
			end
			if not retried then
				retried := True
				retry
			end
		end

	compact_cache_info is
			-- comapcts cache info by removing all CONSUMED_ASSEMBLYs that are marked as being unconsumed
		local
			l_info: CACHE_INFO
			l_assemblies: ARRAY [CONSUMED_ASSEMBLY]
			l_removed: BOOLEAN
			retried: BOOLEAN
			i: INTEGER
		do
			if not retried then
				guard.lock

				{SYSTEM_DLL_TRACE}.write_line_string ({SYSTEM_STRING}.format ("Compacting EAC '{0}'.", cache_reader.eac_path))

				l_info := cache_reader.info
				l_assemblies := l_info.assemblies
				from
					i := 1
				until
					i > l_assemblies.count
				loop
					if l_assemblies.item (i) /= Void and then not l_assemblies.item (i).is_consumed then
						l_info.remove_assembly (l_assemblies.item (i))
						l_removed := True
					end
					i := i + 1
				end
				if l_removed then
					update_info (l_info)
				end
			end
			guard.unlock
		rescue
			debug ("log_exceptions")
				log_last_exception
			end
			if not retried then
				retried := True
				retry
			end
		end

	consumed_assembly_from_path (a_path: STRING): CONSUMED_ASSEMBLY is
			-- retrieve a consumed assembly for `a_path' and store in cache info for retrieval
		require
			non_void_path: a_path /= Void
			valid_path: not a_path.is_empty
			valid_assembly_path: assembly_loader.load_from_gac_or_path (a_path) /= Void
		local
			l_id: STRING
			l_info: CACHE_INFO
			l_path: like a_path
			retried: BOOLEAN
		do
			if not retried then
				guard.lock
				l_path := {PATH}.get_full_path (a_path)
				Result := cache_reader.consumed_assembly_from_path (l_path)
				if Result = Void then
					l_id := {GUID}.new_guid.to_string
					l_id.to_upper
					Result := create_consumed_assembly_from_path (l_id, l_path)
					if Result /= Void then
						l_info := cache_reader.info
						l_info.add_assembly (Result)
						update_info (l_info)
					end
				end
			end
			guard.unlock
		rescue
			debug ("log_exceptions")
				log_last_exception
			end
			if not retried then
				retried := True
				retry
			end
		end

	update_info (a_info: CACHE_INFO) is
			-- Update EAC information file with `info'.
		require
			non_void_info: a_info /= Void
		local
			l_absolute_xml_info_path: STRING
			serializer: EIFFEL_SERIALIZER
			retried: BOOLEAN
		do
			if not retried then
				guard.lock
				if a_info.is_dirty then
					a_info.set_is_dirty (False)
					l_absolute_xml_info_path := cache_reader.Absolute_info_path
					create serializer
					serializer.serialize (a_info, l_absolute_xml_info_path, False)
				end
			end
			guard.unlock
		ensure
			not_info_is_dirty: not a_info.is_dirty
		rescue
			debug ("log_exceptions")
				log_last_exception
			end
			if not retried then
				retried := True
				retry
			end
		end

feature {NONE} -- Implementation	

	remove_assembly_internal (a_path: STRING) is
			-- Remove assembly identified by `a_path' and its clients from cache.
		require
			non_void_path: a_path /= Void
			valid_path: not a_path.is_empty
		local
			l_ca: CONSUMED_ASSEMBLY
			l_dir: DIRECTORY
			l_info: CACHE_INFO
			l_reader: like cache_reader
			retried: BOOLEAN
		do
			if not retried then
				guard.lock
				l_reader := cache_reader
				{SYSTEM_DLL_TRACE}.write_line_string ({SYSTEM_STRING}.format ("Removing assembly '{0}'.", a_path))
				l_ca := consumed_assembly_from_path (a_path)
				create l_dir.make (l_reader.absolute_assembly_path_from_consumed_assembly (l_ca))
				if l_dir.exists then
					l_dir.recursive_delete
				end
				if l_reader.is_assembly_in_cache (a_path, False) then
					l_info := l_reader.info
					l_info.remove_assembly (l_ca)
					update_info (l_info)
				end
			else
				set_error (Remove_error, a_path)
			end
			guard.unlock
		rescue
			debug ("log_exceptions")
				log_last_exception
			end
			if not retried then
				retried := True
				retry
			end
		end

	create_consumed_assembly_from_path (a_id: STRING; a_path: STRING): CONSUMED_ASSEMBLY is
			-- Creates a new CONSUMED_ASSEMBLY
		require
			non_void_id: a_id /= Void
			valid_id: not a_id.is_empty
			non_void_path: a_path /= Void
			valid_path: not a_path.is_empty
			valid_assembly_path: assembly_loader.load_from_gac_or_path (a_path) /= Void
		local
			l_assembly: ASSEMBLY
			l_name: ASSEMBLY_NAME
			l_key: STRING
			l_culture: STRING
			l_is_in_gac: BOOLEAN
			folder_name: STRING
		do
			l_assembly := assembly_loader.load_from_gac_or_path (a_path)
			if l_assembly /= Void then
				l_name := l_assembly.get_name
				l_key := public_key_token_from_array (l_name.get_public_key_token)
				l_culture := culture_from_info (l_name.culture_info)
				l_is_in_gac := l_assembly.global_assembly_cache
				if not l_is_in_gac and then is_mscorlib (l_assembly) then
					l_is_in_gac := True
				end

				if conservative_mode then
					folder_name := a_id.twin
				else
					create folder_name.make (l_name.name.length + a_id.count + 1)
					folder_name.append (create {STRING_8}.make_from_cil (l_name.name))
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
			l_serializer: EIFFEL_SERIALIZER
			l_ref_ca: like consumed_assembly_from_path
			retried: BOOLEAN
			i: INTEGER
		do
			if not retried then
				guard.lock

				{SYSTEM_DLL_TRACE}.write_line_string ({SYSTEM_STRING}.format ("Updating assembly mappings for '{0}'.", a_assembly.out))

				create l_serializer
				l_mappings := cache_reader.assembly_mapping_from_consumed_assembly (a_assembly)

				from
					i := 1
				until
					i > l_mappings.assemblies.count
				loop
					if l_mappings.assemblies.item (i) /= Void then
						l_ref_ca := consumed_assembly_from_path (l_mappings.assemblies.item (i).location)
						if l_ref_ca /= Void then
							l_mappings.assemblies.put (l_ref_ca, i)
						else
							l_mappings.assemblies.item (i).set_is_consumed (False, True)
						end
					end
					i := i + 1
				end
				l_serializer.serialize (l_mappings, cache_reader.absolute_assembly_mapping_path_from_consumed_assembly (a_assembly), False)
			end
			guard.unlock
		rescue
			debug ("log_exceptions")
				log_last_exception
			end
			if not retried then
				retried := True
				retry
			end
		end

	update_client_assembly_mappings (a_assembly: CONSUMED_ASSEMBLY) is
			-- updates serialized assembly mappings or all clients of `a_assembly' and sets consumed status based on contents of EAC.
		require
			non_void_assembly: a_assembly /= Void
		local
			l_clients: ARRAY [CONSUMED_ASSEMBLY]
			retried: BOOLEAN
			i: INTEGER
		do
			if not retried then
				guard.lock

				{SYSTEM_DLL_TRACE}.write_line_string ({SYSTEM_STRING}.format ("Updating client mappings for '{0}'.", a_assembly.out))

				l_clients := cache_reader.client_assemblies (a_assembly)
				from
					i := 1
				until
					i > l_clients.count
				loop
					if l_clients.item (i) /= Void then
						update_assembly_mappings (l_clients.item (i))
					end
					i := i + 1
				end
			end
			guard.unlock
		rescue
			debug ("log_exceptions")
				log_last_exception
			end
			if not retried then
				retried := True
				retry
			end
		end

	cache_reader: CACHE_READER
			-- associated cache reader

 	culture_from_info (a_info: CULTURE_INFO): STRING is
 			-- Returns culture string from `a_info'
 		require
 			a_info_not_void: a_info /= Void
 		do
 			Result := a_info.to_string
 			if Result.is_empty then
 				Result := neutral_culture
 			end
		ensure
			result_not_void: Result /= Void
			not_result_is_empty: not Result.is_empty
 		end

	neutral_culture: STRING is "neutral"
			-- neutral culture

 	public_key_token_from_array (a_array: NATIVE_ARRAY [NATURAL_8]): STRING is
 			-- Returns culture string from `a_info'
 		do
			if a_array = Void or else a_array.length = 0 then
				Result := null_public_key_token
			else
				Result := encoded_key (a_array)
			end
		ensure
			result_not_void: Result /= Void
			not_result_is_empty: not Result.is_empty
 		end

	null_public_key_token: STRING is "null"
			-- Null public key tokens

feature {NONE} -- Notification

	notifier: NOTIFIER is
			-- Windows ballon tip notifier
		do
			Result := guard.notifier
		ensure
			result_attached: Result /= Void
		end

invariant
	non_void_cache_reader: cache_reader /= Void

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"


end -- class CACHE_WRITER
