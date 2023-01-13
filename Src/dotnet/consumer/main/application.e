note
	description: "Emitter (consumer) application entry point for command-line execution."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	APPLICATION

inherit
	ANY

	AR_SHARED_SUBSCRIBER
		export
			{NONE} all
		end

	SHARED_ASSEMBLY_LOADER
		export
			{NONE} all
		end

	LOCALIZED_PRINTER
		export
			{NONE} all
		end

create
	make

feature {NONE} -- Initialization

	make
			-- Application entry point
		local
			l_parser: ARGUMENT_PARSER
		do
			create l_parser.make
			l_parser.execute (agent start (l_parser))
			if not l_parser.is_successful then
					-- Finish process with an invalid parameter error code.
				(create {EXCEPTIONS}).die (0x57)
			end
		end

	start (a_parser: ARGUMENT_PARSER)
			-- Starts application
		local
			l_manager: CACHE_MANAGER
			l_resolver: CONSUMER_AGUMENTED_RESOLVER
			l_assemblies: ARRAYED_LIST [IMMUTABLE_STRING_32]
			l_references: ARRAYED_LIST [IMMUTABLE_STRING_32]
			l_files: ARRAYED_LIST [READABLE_STRING_32]
			l_processed: ARRAYED_LIST [READABLE_STRING_32]
			l_info_only: BOOLEAN
			l_assembly: READABLE_STRING_32
			l_verbose: BOOLEAN
			l_cache_writer: CACHE_WRITER
			l_writer: like writer
			l_use_json: BOOLEAN
			l_error: BOOLEAN
			l_domain: detachable APP_DOMAIN
			l_receiver: detachable SYSTEM_OBJECT
			l_is_silent: BOOLEAN
		do
			if a_parser.use_specified_cache then
				create l_manager.make_with_path (a_parser.cache_path)
			else
				create l_manager.make
			end
			l_cache_writer := l_manager.cache_writer
			l_verbose := a_parser.show_verbose_output
			l_use_json := a_parser.use_json_storage
			l_is_silent := a_parser.is_silent
			if l_verbose then
				l_cache_writer.set_error_printer (agent display_error)
				l_cache_writer.set_status_printer (agent display_message_with_new_line)
			end

			l_writer := writer

			if not l_is_silent then
				if attached {RUNTIME_ENVIRONMENT}.get_runtime_directory as l_runtime_dir then
					l_writer.put_string ("Using runtime directory: ")
					l_writer.put_string (utf32_to_console_encoding (console_encoding, create {STRING_32}.make_from_cil (l_runtime_dir)))
					l_writer.new_line
					l_writer.new_line
				end
			end

			if l_use_json then
				{EIFFEL_SERIALIZATION}.set_use_json_storage (True)
				if not l_is_silent then
					l_writer.put_string ("Using JSON storage")
					l_writer.new_line
					l_writer.new_line
				end
			end

			if a_parser.add_assemblies then
				l_assemblies := a_parser.assemblies
				l_references := a_parser.reference_paths
					-- NOTE: For now ignore, a_parser.sdk_paths [2022-12-20]

				create l_files.make (30)
				if attached {RUNTIME_ENVIRONMENT}.get_runtime_directory as l_runtime_dir then
					l_files.extend (create {STRING_32}.make_from_cil (l_runtime_dir))
				end
				l_files.append (l_assemblies)
				l_files.append (l_references)

				l_info_only := a_parser.add_information_only

				create l_resolver.make (l_files)
				l_domain := {APP_DOMAIN}.current_domain
				if attached l_domain then
					resolve_subscriber.subscribe (l_domain, l_resolver)
				else
					check
						from_documentation: False
					then
					end
				end

					-- Preload assemblies
				from l_assemblies.start until l_assemblies.after loop
					l_receiver := assembly_loader.load_from (l_assemblies.item)
					l_assemblies.forth
				end

					-- Consume assemblies
				create l_processed.make (l_assemblies.count * 3)
				l_processed.compare_objects

				from l_assemblies.start until l_assemblies.after loop
					l_assembly := l_assemblies.item
					{SYSTEM_DLL_TRACE}.write_line ({SYSTEM_STRING}.format ("Requesting consumption of assembly '{0}'.", l_assembly.to_cil), "Info")
					display_message ({STRING_32} "Requesting consumption of assembly '" + l_assembly + "' into '")
					display_message_with_new_line (cache_reader.absolute_consume_path.name + "' ...")
					l_resolver.add_resolve_path_from_file_name (l_assembly)
					assembly_loader.set_resolver (l_resolver)
					l_cache_writer.add_assembly_ex (l_assembly, l_info_only, l_assemblies, l_processed)
					if not l_cache_writer.successful then
						display_error ({STRING_32} "   Warning: Assembly '" + l_assembly + "' could not be consumed!")
						if l_cache_writer.error_message /= Void then
							display_error ({STRING_32} "   Reason: " + l_cache_writer.error_message)
						end
						{SYSTEM_DLL_TRACE}.write_line ({SYSTEM_STRING}.format ("'{0}' could not be consumed.", l_assembly.to_cil), "Warning")
						l_error := True
					end
					assembly_loader.set_resolver (Void)
					l_resolver.remove_resolve_path_from_file_name (l_assembly)

					l_assemblies.forth
				end
				assembly_loader.set_resolver (Void)
				if l_domain /= Void then
					resolve_subscriber.unsubscribe (l_domain, l_resolver)
				end
			elseif a_parser.remove_assemblies then
				l_assemblies := a_parser.assemblies

				from l_assemblies.start until l_assemblies.after loop
					l_assembly := l_assemblies.item
					{SYSTEM_DLL_TRACE}.write_line ({SYSTEM_STRING}.format ("Unconsuming assembly '{0}'.", l_assembly.to_cil), "Info")
					display_message ({STRING_32} "Unconsuming assembly '" + l_assembly + "' from '")
					display_message_with_new_line (cache_reader.absolute_consume_path.name + "'...")
					l_cache_writer.unconsume_assembly (create {PATH}.make_from_string (l_assembly))
					if not l_manager.is_successful then
						display_error ({STRING_32} "   Warning: Assembly '" + l_assembly + "' could not be removed (unconsumed)!")
						if l_cache_writer.error_message /= Void then
							display_error ({STRING_32} "   Reason: " + l_cache_writer.error_message)
						end
						{SYSTEM_DLL_TRACE}.write_line ({SYSTEM_STRING}.format ("'{0}' could not be removed (unconsumed).", l_assembly.to_cil), "Warning")
						l_error := True
					end
					l_assemblies.forth
				end
			elseif a_parser.list_assemblies then
				display_cache_content (l_manager, a_parser.show_verbose_output)
			elseif a_parser.clean_cache then
				l_writer.put_string ("Cleaning and compacting cache '")
				display_message_with_new_line (cache_reader.absolute_consume_path.name + "'...")
				l_manager.cache_writer.clean_cache
			end

			l_manager.unload
			if not l_is_silent then
				display_message_with_new_line ("%NCompleted.%N")
			end

			if a_parser.wait_for_user_interaction then
				io.put_string ("Please press enter to exit...")
				io.read_line
			end

			if l_error then
				(create {EXCEPTIONS}).die (-1)
			end
		end

feature {NONE} -- Output

	display_cache_content (a_manager: CACHE_MANAGER; a_verbose: BOOLEAN)
			-- Displays a list of content for a manager `a_maanger'
		require
			a_manager_attached: a_manager /= Void
		local
			l_writer: like writer
			l_assemblies: detachable ARRAYED_LIST [CONSUMED_ASSEMBLY]
			l_assembly: CONSUMED_ASSEMBLY
			l_index: INTEGER
			l_sindex: STRING
			l_prefix: STRING
			l_cp: CACHE_PATH
			l_corrupted: ARRAYED_LIST [CONSUMED_ASSEMBLY]
			l_partial_count, l_full_count, l_awaiting_count: INTEGER
			l_count: INTEGER
			i: INTEGER
		do
			l_assemblies := cache_reader.assemblies
			if
				attached l_assemblies and then
				∀ a: l_assemblies ¦ attached a implies not a.is_consumed
			then
				l_assemblies := Void
			end

			l_writer := writer

			l_writer.put_string ("Displaying contents of Eiffel Assembly Cache%N")
			display_message_with_new_line (cache_reader.absolute_consume_path.name + ":")

			create l_cp
			create l_corrupted.make (0)

			if attached l_assemblies then
				l_count := l_assemblies.count

				create l_sindex.make_filled (' ', (l_count ^ 0.1).truncated_to_integer + 1)
				if a_verbose then
					create l_prefix.make_filled (' ', l_sindex.count + 2)
				else
					l_prefix := ""
				end
				from i := 1 until i > l_count loop
					l_assembly := l_assemblies [i]
					if l_assembly.is_consumed or a_verbose then
						l_index := l_index + 1

						l_writer.new_line
						l_writer.put_string (l_sindex.substring (1, l_sindex.count - l_index.out.count))
						l_writer.put_integer (l_index)
						l_writer.put_string (once ": ")
						if a_verbose then
							l_writer.put_character ('{')
							display_message (l_assembly.unique_id)
							l_writer.put_character ('}')
							l_writer.new_line
							l_writer.put_string (l_prefix)
						end
						display_message (l_assembly.name)
						l_writer.put_string (once ", Version=")
						display_message (l_assembly.version)
						l_writer.put_string (once ", Culture=")
						display_message (l_assembly.culture)
						l_writer.put_string (once ", PublicKeyToken=")
						display_message (l_assembly.key)
						if a_verbose then
							l_writer.new_line
							l_writer.put_string (l_prefix)
							display_message_with_new_line (l_assembly.location.name)
							l_writer.put_string (l_prefix)
							l_writer.put_string (once "Consumed status: ")
							if l_assembly.is_consumed then
								if l_assembly.has_info_only then
									l_writer.put_string (once "partial")
								else
									l_writer.put_string (once "full")
								end
								if {SYSTEM_DIRECTORY}.exists (l_cp.absolute_assembly_path_from_consumed_assembly (l_assembly).name) then
									if not {SYSTEM_FILE}.exists (l_cp.absolute_type_mapping_path (l_assembly).name) then
										l_writer.put_string (once ", corrupted! - Missing .NET type name mapping information.")
										l_corrupted.extend (l_assembly)
									elseif not {SYSTEM_FILE}.exists (l_cp.absolute_assembly_mapping_path_from_consumed_assembly (l_assembly).name) then
										l_writer.put_string (once ", corrupted! - Missing reference assembly information.")
										l_corrupted.extend (l_assembly)
									elseif not l_assembly.has_info_only and then not {SYSTEM_FILE}.exists (l_cp.absolute_type_path (l_assembly).name) then
										l_writer.put_string (once ", corrupted! - Missing class member name mapping information.")
										l_corrupted.extend (l_assembly)
									else
										if l_assembly.has_info_only then
											l_partial_count := l_partial_count + 1
										else
											l_full_count := l_full_count + 1
										end
									end
								else
									l_writer.put_string (once ", corrupted! - No cache folder.")
									l_corrupted.extend (l_assembly)
								end
							else
								l_writer.put_string (once "not consumed")
								l_awaiting_count := l_awaiting_count + 1
							end
							l_writer.new_line
						end
					end
					i := i + 1
				end

				if a_verbose then
						-- Add two spaces to justify text to cach information
					l_sindex.append ("  ")

					check summary_count_filled: l_count = (l_full_count + l_partial_count + l_awaiting_count + l_corrupted.count) end

						-- Output summary
					l_writer.new_line
					l_writer.put_string ("Content Summary")
					l_writer.new_line
					l_writer.put_string (l_sindex)
					l_writer.put_string ("Fully consumed      : ")
					l_writer.put_integer (l_full_count)
					l_writer.new_line
					l_writer.put_string (l_sindex)
					l_writer.put_string ("Partially consumed  : ")
					l_writer.put_integer (l_partial_count)
					l_writer.new_line
					l_writer.put_string (l_sindex)
					l_writer.put_string ("Awaiting consumption: ")
					l_writer.put_integer (l_awaiting_count)
					if not l_corrupted.is_empty then
						l_writer.new_line
						l_writer.put_string (l_sindex)
						l_writer.put_string ("Corrupted           : ")
						l_writer.put_integer (l_corrupted.count)
						l_writer.new_line
						l_writer.new_line
						l_writer.put_string ("Cache contains corrupted entries!")
						from l_corrupted.start until l_corrupted.after loop
							l_assembly := l_corrupted.item
							l_writer.new_line
							l_writer.put_string (l_sindex)
							l_writer.put_string ("Entry: ")
							l_writer.put_character ('{')
							display_message (l_assembly.unique_id)
							l_writer.put_string ("} - ")
							display_message (l_assembly.name)
							l_writer.put_string (once ", ")
							display_message (l_assembly.version)
							l_writer.put_string (once ", ")
							display_message (l_assembly.culture)
							l_writer.put_string (once ", ")
							display_message (l_assembly.key)
							l_corrupted.forth
						end
					end
				end
				l_writer.new_line
			else
				l_writer.put_string ("No consumed assemblies found in cache.")
				l_writer.new_line
			end
		end

	display_message (a_msg: READABLE_STRING_GENERAL)
			-- Displays a status message
		require
			a_msg_attached: a_msg /= Void
		do
			writer.put_string (utf32_to_console_encoding (Console_encoding, a_msg))
		end

	display_message_with_new_line (a_msg: READABLE_STRING_GENERAL)
			-- Displays a status message
		require
			a_msg_attached: a_msg /= Void
		local
			l_writer: like writer
		do
			l_writer := writer
			l_writer.put_string (utf32_to_console_encoding (Console_encoding, a_msg))
			l_writer.new_line
		end

	display_error (a_msg: READABLE_STRING_GENERAL)
			-- Displays a status error message
		require
			a_msg_attached: a_msg /= Void
		local
			l_writer: like error_writer
		do
			l_writer := error_writer
			l_writer.put_string (utf32_to_console_encoding (Console_encoding, a_msg))
			l_writer.new_line
		end

	writer: IO_MEDIUM
			-- Writer used to display verbose information
		once
			Result := io.output
		end

	error_writer: IO_MEDIUM
			-- Writer used to display verbose error information
		once
			Result := io.error
		end

feature {NONE} -- Implementation

	cache_reader: CACHE_READER
		once
			create Result
		end

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
