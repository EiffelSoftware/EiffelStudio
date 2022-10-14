note
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

	make
			-- New instance of Current for runtime version `a_clr_version'.
		do
			create cache_reader
		end

feature -- Clean Up

	dispose
			-- Clean up used resources.
		do
		end

feature -- Basic Operations

	add_assembly (a_path: READABLE_STRING_32; a_info_only: BOOLEAN)
			-- Add assembly at `a_path' and its dependencies into cache.
		require
			non_void_path: a_path /= Void
			valid_path: not a_path.is_empty
			path_exists: (create {RAW_FILE}.make_with_name (a_path)).exists
		local
			l_processed: ARRAYED_LIST [READABLE_STRING_32]
		do
			create l_processed.make (0)
			l_processed.compare_objects
			add_assembly_ex (a_path, a_info_only, Void, l_processed)
		end

	add_assembly_ex (a_path: READABLE_STRING_32; a_info_only: BOOLEAN; a_other_assemblies: detachable LIST [READABLE_STRING_32]; a_processed: ARRAYED_LIST [READABLE_STRING_32])
			-- Add assembly at `a_path' and its dependencies into cache.
		require
			non_void_path: a_path /= Void
			valid_path: not a_path.is_empty
			path_exists: (create {RAW_FILE}.make_with_name (a_path)).exists
			a_other_assemblies_contains_valid_items: a_other_assemblies /= Void implies a_other_assemblies.is_empty or else
				∀ a: a_other_assemblies ¦ attached a and then a.is_case_insensitive_equal (a)
			a_other_assemblies_compares_objects: a_other_assemblies /= Void implies a_other_assemblies.object_comparison
			a_processed_attached: a_processed /= Void
			a_processed_compares_objects: a_processed.object_comparison
			a_processed_contains_valid_items: a_processed.is_empty or else
				∀ a: a_processed ¦ attached a and then a.is_case_insensitive_equal (a)
		local
			l_string_tuple: TUPLE [STRING_32]
			l_assembly_folder: PATH
			l_ca: CONSUMED_ASSEMBLY
			l_assembly: ASSEMBLY
			l_old_assembly: ASSEMBLY
			l_name: ASSEMBLY_NAME
			l_consumer: ASSEMBLY_CONSUMER
			l_dir: DIRECTORY
			l_names: NATIVE_ARRAY [detachable ASSEMBLY_NAME]
			l_info: CACHE_INFO
			l_assembly_path: PATH
			l_assembly_location: STRING_32
			l_assembly_info_updated: BOOLEAN
			l_lower_path: PATH
			l_reader: like cache_reader
			l_reason: SYSTEM_STRING
			retried: BOOLEAN
			i: INTEGER
		do
			if not retried then
				guard.lock

				{SYSTEM_DLL_TRACE}.write_line_string ({SYSTEM_STRING}.format ("Adding assembly (does not mean consuming) '{0}'.", a_path.to_cil))
				l_reason := "New entry"

				l_reader := cache_reader
				if l_reader.is_initialized then
					l_ca := l_reader.consumed_assembly_from_path (create {PATH}.make_from_string (a_path))
				end
				if l_ca = Void then
					create l_lower_path.make_from_string (a_path.as_lower)
					l_lower_path := l_lower_path.canonical_path
				else
					l_lower_path := l_ca.location
					if l_ca.has_info_only and not a_info_only then
						l_reason := "Consuming extra information"
					end
				end

				l_assembly := assembly_loader.load_from_gac_or_path (l_lower_path.name)
				if l_assembly /= Void and then attached l_assembly.location as l_location then
					create l_consumer.make (Current)
					a_processed.extend (l_lower_path.name)

					create l_assembly_path.make_from_string (create {STRING_32}.make_from_cil (l_location.to_lower))

					if l_ca = Void and l_reader.is_initialized then
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
						{SYSTEM_DLL_TRACE}.write_line_string ({SYSTEM_STRING}.format ("'{0}' has already been consumed. Checking...", a_path.to_cil))

							-- Examine existing data and modify
						if l_assembly.global_assembly_cache then
							if not l_ca.gac_path.same_as (l_assembly_path) then
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
						elseif not l_ca.location.same_as (l_assembly_path) then
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
							{SYSTEM_DLL_TRACE}.write_line_string ({SYSTEM_STRING}.format ("Storing changed assembly information for '{0}'.", a_path.to_cil))
							l_info := l_reader.info
							if l_info /= Void then
								l_info.update_assembly (l_ca)
								update_info (l_info)
							end
							update_client_assembly_mappings (l_ca)
						end
						l_info := Void
					end

						-- only consume `assembly' if assembly has not already been consumed,
						-- corresponding assembly has been modified or if consumer tool has been
						-- modified.
					if
						l_ca /= Void and then l_ca.is_consumed and then
						((not a_info_only and l_ca.has_info_only) or else
							cache_reader.is_assembly_stale (l_lower_path))
					then
							-- unconsume stale assembly
						unconsume_assembly (l_lower_path)
						if attached l_assembly.get_name as n then
							l_ca.set_culture (culture_from_info (n.culture_info))
							l_ca.set_version (version_from_info (n.version))
							l_ca.set_key (public_key_token_from_array (n.get_public_key_token))
						else
							check
								get_name_attached: False
							end
						end
					end

						-- Reset update (for optimizations)
					l_assembly_info_updated := False

					if l_ca /= Void and then l_ca.is_consumed then
						{SYSTEM_DLL_TRACE}.write_line_string ({SYSTEM_STRING}.format ("Assembly '{0}' is not being consumed because it is up-to-date.", a_path.to_cil))
						if attached status_printer as l_status_printer then
							create l_string_tuple
							l_string_tuple.put ({STRING_32} "Up-to-date check: '" + a_path +
								"' has not been modified since last consumption.%N", 1)
							l_status_printer.call (l_string_tuple)
						end
					else
						if l_ca = Void then
							l_ca := consumed_assembly_from_path (l_lower_path.name)
						end
						if l_ca /= Void then
							l_assembly_folder := l_reader.absolute_assembly_path_from_consumed_assembly (l_ca)
							create l_dir.make_with_path (l_assembly_folder)
							if not l_dir.exists then
								l_dir.create_dir
							end

							l_consumer.set_status_printer (status_printer)
							l_consumer.set_error_printer (error_printer)
							l_consumer.set_status_querier (status_querier)
							l_consumer.set_destination_path (l_dir.path)

							if attached notifier as l_notifier then
								l_notifier.notify_consume (
									create {CONSUMPTION_NOTIFY_MESSAGE}.make (l_ca,
										a_path, create {STRING_32}.make_from_cil (l_reason), cache_reader.absolute_consume_path))
							end

								-- Load assembly from path, so path assembly is consumed.
								-- MS resort to a load performance trick where they provide
								-- assemblies with no implementation
								-- in a local path and the implementation in the GAC.
							l_old_assembly := l_assembly
							l_assembly := assembly_loader.load_from (l_lower_path.name)
							if l_assembly = Void then
								l_assembly := l_old_assembly
							end
							l_consumer.consume (l_assembly, assembly_loader, a_info_only)

							if not l_consumer.successful then
								set_error (Consume_error, a_path)
							else
								l_assembly_info_updated := True
								l_info := l_reader.info
								if l_info /= Void and l_ca /= Void then
									l_ca.set_is_consumed (True, a_info_only)
									l_info.update_assembly (l_ca)
									update_info (l_info)
								end
							end
						end
					end

					if l_consumer.successful then
						{SYSTEM_DLL_TRACE}.write_line_string ({SYSTEM_STRING}.format ("Processing assembly dependencies...%N%NAssembly: {0}.", a_path.to_cil))
						if attached notifier as l_notifier then
							l_notifier.notify_info ("Synchronizing cache...")
						end

						l_names := l_assembly.get_referenced_assemblies
						if l_names /= Void then
							from
								i := 0
							until
								i = l_names.count
							loop
								l_name := l_names.item (i)
								if l_name /= Void then
									l_assembly := assembly_loader.load (l_name)
									if l_assembly /= Void and then attached l_assembly.location as l_ass_location then
										l_assembly_location := l_ass_location
										create l_assembly_path.make_from_string (l_assembly_location)
										if
											not a_processed.has (l_assembly_location) and then
											not (l_reader.is_assembly_in_cache (l_assembly_path, True) or else
													cache_reader.is_assembly_stale (l_assembly_path))
										then
												-- Adds only lookup info
											add_assembly_ex (l_assembly_location,
												a_info_only or else
												(a_other_assemblies = Void or else
													not a_other_assemblies.has (l_assembly_location.as_lower)),
												a_other_assemblies, a_processed)
											l_assembly_info_updated := True
										end
									end
								end
								i := i + 1
							end
						end
						if l_assembly_info_updated and l_ca /= Void then
							if
								attached notifier as l_notifier and then
								attached {SYSTEM_STRING}.format ("Synchronizing cache...%N%NLocation: {0}", cache_reader.absolute_consume_path.name.to_cil) as l_msg
							then
								l_notifier.notify_info (create {STRING_32}.make_from_cil (l_msg))
							end
							update_assembly_mappings (l_ca)
							update_client_assembly_mappings (l_ca)
						end
					end

					if attached notifier as l_notifier then
						l_notifier.clear_notification
					end
				end
			else
				{SYSTEM_DLL_TRACE}.write_line_string ({SYSTEM_STRING}.format ("Failed to consume assembly '{0}'.", a_path.to_cil))

				if l_name /= Void and then attached l_name.to_string as l_error_msg then
					set_error (Assembly_not_found_error, create {STRING_32}.make_from_cil (l_error_msg))
				elseif l_assembly /= Void and then attached l_assembly.full_name as l_ass_full_name then
					set_error (Assembly_dependancies_not_found_error, create {STRING_32}.make_from_cil (l_ass_full_name))
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

	unconsume_assembly (a_path: PATH)
			-- Unconsumes assembly at `a_path'. This means all consumed metadata in removed
			-- and the consumed assembly entry is_consumed attribute is set to false.
			-- Note: Does not update any assembly reference mappings. Call `update_client_assembly_mapppings' to
			-- perform this.
		require
			non_void_path: a_path /= Void
			valid_path: not a_path.is_empty
		local
			l_string_tuple: TUPLE [STRING_32]
			l_dir: DIRECTORY
			l_ca: detachable CONSUMED_ASSEMBLY
			l_info: detachable CACHE_INFO
			l_reader: like cache_reader
			retried: BOOLEAN
		do
			check
				assembly_exists: cache_reader.is_assembly_in_cache (a_path, True)
			end
			if not retried then
				guard.lock
				{SYSTEM_DLL_TRACE}.write_line_string ({SYSTEM_STRING}.format ("Unconsuming assembly '{0}'", a_path.name.to_cil))

				l_reader := cache_reader
				if attached status_printer as l_status_printer then
					create l_string_tuple
					l_string_tuple.put ({STRING_32} "Updating assembly consumed metadata: '" + a_path.name +
						"' has been modified since last consumption.%N", 1)
					l_status_printer.call (l_string_tuple)
				end
				l_ca := l_reader.consumed_assembly_from_path (a_path)
				l_info := l_reader.info
				if l_ca /= Void and l_info /= Void then
						-- Remove consumed metadata
					create l_dir.make_with_path (l_reader.absolute_assembly_path_from_consumed_assembly (l_ca))
					if l_dir.exists then
						l_dir.recursive_delete
					end
					l_ca.set_is_consumed (False, True)
					l_info.update_assembly (l_ca)
					update_client_assembly_mappings (l_ca)
					update_info (l_info)
				end
			else
				set_error (Update_error, a_path.name)
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

	remove_recursive_assembly (a_path: PATH)
			-- Remove assembly identified by `a_path' and its clients from cache.
		require
			non_void_path: a_path /= Void
			valid_path: not a_path.is_empty
		local
			l_ca: detachable CONSUMED_ASSEMBLY
			retried: BOOLEAN
			l_reader: like cache_reader
			i: INTEGER
		do
			if not retried then
				guard.lock
				l_reader := cache_reader
				remove_assembly_internal (a_path)
				l_ca := consumed_assembly_from_path (a_path.name)
				if l_ca /= Void and then attached l_reader.client_assemblies (l_ca) as l_assemblies then
					from
						i := 1
					until
						i > l_assemblies.count
					loop
						if l_reader.is_assembly_in_cache (l_assemblies.i_th (i).gac_path, False) then
							remove_recursive_assembly (l_assemblies.i_th (i).gac_path)
						end
						i := i + 1
					end
				end
			else
				set_error (Remove_error, a_path.name)
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

	clean_cache
			-- cleans up cache and removes all incomplete consumed assembly metadata
		local
			l_cache_folder: DIRECTORY
			l_assemblies: ARRAYED_LIST [CONSUMED_ASSEMBLY]
			l_ca: CONSUMED_ASSEMBLY
			retried: BOOLEAN
		do
			if not retried then
				guard.lock
				{SYSTEM_DLL_TRACE}.write_line_string ({SYSTEM_STRING}.format ("Cleaning EAC '{0}'.", cache_reader.eac_path.to_cil))

				create l_cache_folder.make_with_path (cache_reader.eiffel_assembly_cache_path)
				if l_cache_folder.exists and attached cache_reader.info as l_info then
					l_assemblies := l_info.assemblies

						-- Unconsumed assemblies that cannot be found
					from
						l_assemblies.start
					until
						l_assemblies.after
					loop
						l_ca := l_assemblies.item
						if
							not l_ca.is_consumed or else
							not (create {RAW_FILE}.make_with_path (l_ca.location)).exists and then
							not (create {RAW_FILE}.make_with_path (l_ca.gac_path)).exists
						then
								-- Remove assembly.
							unconsume_assembly (l_ca.location)
							update_client_assembly_mappings (l_ca)
						end
						l_assemblies.forth
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

	compact_cache_info
			-- comapcts cache info by removing all CONSUMED_ASSEMBLYs that are marked as being unconsumed
		local
			l_info: detachable CACHE_INFO
			l_assemblies: ARRAYED_LIST [CONSUMED_ASSEMBLY]
			l_ca: CONSUMED_ASSEMBLY
			l_removed: BOOLEAN
			retried: BOOLEAN
		do
			if not retried then
				guard.lock

				{SYSTEM_DLL_TRACE}.write_line_string ({SYSTEM_STRING}.format ("Compacting EAC '{0}'.", cache_reader.eac_path.to_cil))

				l_info := cache_reader.info
				if l_info /= Void then
					l_assemblies := l_info.assemblies
					from
						l_assemblies.start
					until
						l_assemblies.after
					loop
						l_ca := l_assemblies.item
						if l_ca.is_consumed then
							l_info.remove_assembly (l_ca)
							l_removed := True
						end
						l_assemblies.forth
					end
					if l_removed then
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

	consumed_assembly_from_path (a_path: READABLE_STRING_32): detachable CONSUMED_ASSEMBLY
			-- retrieve a consumed assembly for `a_path' and store in cache info for retrieval
		require
			non_void_path: a_path /= Void
			valid_path: not a_path.is_empty
			valid_assembly_path: assembly_loader.load_from_gac_or_path (a_path) /= Void
		local
			l_id_upper: STRING_32
			l_path: PATH
			retried: BOOLEAN
		do
			if not retried then
				guard.lock
				create l_path.make_from_string (a_path)
				l_path := l_path.canonical_path
				if cache_reader.is_initialized then
					Result := cache_reader.consumed_assembly_from_path (l_path)
				end
				if
					not attached Result and then
					attached {GUID}.new_guid.to_string as l_id
				then
					l_id_upper := l_id
					l_id_upper.to_upper
					Result := create_consumed_assembly_from_path (l_id_upper, l_path)
					if Result /= Void and attached cache_reader.info as l_info then
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

	update_info (a_info: CACHE_INFO)
			-- Update EAC information file with `info'.
		require
			non_void_info: a_info /= Void
		local
			l_absolute_xml_info_path: PATH
			retried: BOOLEAN
		do
			if not retried then
				guard.lock
				if a_info.is_dirty then
					a_info.set_is_dirty (False)
					l_absolute_xml_info_path := cache_reader.Absolute_info_path
					{EIFFEL_SERIALIZATION}.serialize (a_info, l_absolute_xml_info_path.name, False)
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

	remove_assembly_internal (a_path: PATH)
			-- Remove assembly identified by `a_path' and its clients from cache.
		require
			non_void_path: a_path /= Void
			valid_path: not a_path.is_empty
		local
			l_ca: detachable CONSUMED_ASSEMBLY
			l_dir: DIRECTORY
			l_info: detachable CACHE_INFO
			l_reader: like cache_reader
			retried: BOOLEAN
		do
			if not retried then
				guard.lock
				l_reader := cache_reader
				{SYSTEM_DLL_TRACE}.write_line_string ({SYSTEM_STRING}.format ("Removing assembly '{0}'.", a_path.name.to_cil))
				l_ca := consumed_assembly_from_path (a_path.name)
				if l_ca /= Void then
					create l_dir.make_with_path (l_reader.absolute_assembly_path_from_consumed_assembly (l_ca))
					if l_dir.exists then
						l_dir.recursive_delete
					end
					if l_reader.is_assembly_in_cache (a_path, False) then
						l_info := l_reader.info
						if l_info /= Void then
							l_info.remove_assembly (l_ca)
							update_info (l_info)
						end
					end
				end
			else
				set_error (Remove_error, a_path.name)
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

	create_consumed_assembly_from_path (a_id: READABLE_STRING_32; a_path: PATH): detachable CONSUMED_ASSEMBLY
			-- Creates a new CONSUMED_ASSEMBLY
		require
			non_void_id: a_id /= Void
			valid_id: not a_id.is_empty
			non_void_path: a_path /= Void
			valid_path: not a_path.is_empty
			valid_assembly_path: assembly_loader.load_from_gac_or_path (a_path.name) /= Void
		local
			l_ass_name: SYSTEM_STRING
			l_assembly_name: STRING_32
			l_key: STRING_32
			l_culture: STRING_32
			l_version: STRING_32
			l_is_in_gac: BOOLEAN
			folder_name: STRING_32
		do
			if
				attached assembly_loader.load_from_gac_or_path (a_path.name) as l_assembly and then
				attached l_assembly.location as l_location and then
				attached l_assembly.get_name as l_name
			then
				l_key := public_key_token_from_array (l_name.get_public_key_token)
				l_culture := culture_from_info (l_name.culture_info)
				l_is_in_gac := l_assembly.global_assembly_cache
				if not l_is_in_gac and then is_mscorlib (l_assembly) then
					l_is_in_gac := True
				end
				l_version := version_from_info (l_name.version)
				l_ass_name := l_name.name
				check l_ass_name_attached: l_ass_name /= Void end
				create l_assembly_name.make_from_cil (l_ass_name)

				if conservative_mode then
					create folder_name.make_from_string (a_id)
				else
					create folder_name.make (l_assembly_name.count + a_id.count + 1)
					folder_name.append (l_assembly_name)
					folder_name.append_character ('!')
					folder_name.append_string_general (a_id)
				end

				create Result.make (a_id, folder_name, l_assembly_name, l_version, l_culture, l_key, a_path, create {PATH}.make_from_string (create {STRING_32}.make_from_cil (l_location)), l_is_in_gac)
			end
		ensure
			non_void_result: Result /= Void
		end

	update_assembly_mappings (a_assembly: CONSUMED_ASSEMBLY)
			-- updates serialized assembly mappings and sets consumed status based on contents of EAC.
		require
			non_void_assembly: a_assembly /= Void
			is_consumed: a_assembly.is_consumed
		local
			l_mappings: detachable CONSUMED_ASSEMBLY_MAPPING
			l_assemblies: ARRAYED_LIST [CONSUMED_ASSEMBLY]
			l_serializer: EIFFEL_SERIALIZER
			l_ref_ca: like consumed_assembly_from_path
			retried: BOOLEAN
		do
			if not retried then
				guard.lock

				{SYSTEM_DLL_TRACE}.write_line_string ({SYSTEM_STRING}.format ("Updating assembly mappings for '{0}'.", a_assembly.text.to_cil))

				l_serializer := {EIFFEL_SERIALIZATION}.serializer
				l_mappings := cache_reader.assembly_mapping_from_consumed_assembly (a_assembly)
				if l_mappings /= Void then
					from
						l_assemblies := l_mappings.assemblies
						l_assemblies.start
					until
						l_assemblies.after
					loop
						l_ref_ca := consumed_assembly_from_path (l_assemblies.item.location.name)
						if l_ref_ca /= Void then
							l_assemblies.replace (l_ref_ca)
						else
							l_assemblies.item.set_is_consumed (False, True)
						end
						l_assemblies.forth
					end
					l_serializer.serialize (l_mappings, cache_reader.absolute_assembly_mapping_path_from_consumed_assembly (a_assembly).name, False)
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

	update_client_assembly_mappings (a_assembly: CONSUMED_ASSEMBLY)
			-- updates serialized assembly mappings or all clients of `a_assembly' and sets consumed status based on contents of EAC.
		require
			non_void_assembly: a_assembly /= Void
		local
			l_clients: detachable ARRAYED_LIST [CONSUMED_ASSEMBLY]
			retried: BOOLEAN
		do
			if not retried then
				guard.lock

				{SYSTEM_DLL_TRACE}.write_line_string ({SYSTEM_STRING}.format ("Updating client mappings for '{0}'.", a_assembly.text.to_cil))

				l_clients := cache_reader.client_assemblies (a_assembly)
				if l_clients /= Void then
					from
						l_clients.start
					until
						l_clients.after
					loop
						update_assembly_mappings (l_clients.item)
						l_clients.forth
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

	cache_reader: CACHE_READER
			-- associated cache reader

	culture_from_info (a_info: detachable CULTURE_INFO): STRING_32
			-- Returns culture string from `a_info'
		do
			if not attached a_info then
				Result := neutral_culture
			elseif attached a_info.to_string as l_info_name then
				Result := l_info_name
				if Result.is_empty then
					Result := neutral_culture
				end
			else
				check
					to_string_attached: False
				then
				end
			end
		ensure
			result_not_void: Result /= Void
			not_result_is_empty: not Result.is_empty
		end

	neutral_culture: STRING_32 = "neutral"
			-- neutral culture

	version_from_info (a_info: detachable VERSION): STRING_32
			-- Returns culture string from `a_info'
		do
			if not attached a_info then
				create Result.make_empty
			elseif attached a_info.to_string as l_info_name then
				Result := l_info_name
			else
				check
					to_string_attached: False
				then
				end
			end
		ensure
			result_not_void: Result /= Void
		end

	public_key_token_from_array (a_array: detachable NATIVE_ARRAY [NATURAL_8]): STRING_32
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

	null_public_key_token: STRING_32 = "null"
			-- Null public key tokens

feature {NONE} -- Notification

	notifier: detachable NOTIFIER
			-- Windows ballon tip notifier
		do
			Result := guard.notifier
		end

invariant
	non_void_cache_reader: cache_reader /= Void

note
	copyright: "Copyright (c) 1984-2022, Eiffel Software"
	license: "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options: "http://www.eiffel.com/licensing"
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
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
