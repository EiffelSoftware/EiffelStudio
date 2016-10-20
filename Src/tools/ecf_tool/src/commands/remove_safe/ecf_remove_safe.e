note
	description: "[
		Application to reduce two ECFs (.ecf and -safe.ecf into a unique .ecf, and have redirection for -safe.ecf.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$date$";
	revision: "$revision$"

class
	ECF_REMOVE_SAFE

inherit
	ANY

	ECF_SHARED_CONF_HELPERS

	SHARED_EXECUTION_ENVIRONMENT

	LOCALIZED_PRINTER

create
	make

feature {NONE} -- Initialization

	make (args: ECF_REMOVE_SAFE_ARGUMENT_PARSER)
			-- Application entry point
		do
			start (args)
		end

feature {NONE} -- Execution

	start (a_options: ECF_REMOVE_SAFE_ARGUMENT_PARSER)
			-- Starts application once all arguments have been parsed
		require
			a_options_attached: a_options /= Void
			a_options_is_successful: a_options.is_successful
		local
			dv: ECF_DIRECTORY_CUSTOM_ITERATOR
			l_files: ARRAYED_LIST [READABLE_STRING_32]
			l_processed_files: ARRAYED_LIST [READABLE_STRING_32]
			l_eprinter: ERROR_CUI_PRINTER
		do
				-- Options
			is_verbose := a_options.is_verbose
			keep_safe_as_redirection := a_options.safe_redirected

				-- Add specified files
			create l_files.make (0)
			l_files.compare_objects
			across
				a_options.files as ic
			loop
				l_files.force (ic.item)
			end

				-- Add scanned directories
			create dv.make (agent (ia_fn: PATH; ia_files: LIST [READABLE_STRING_32])
					do
						ia_files.force (ia_fn.name)
					end (?, l_files)
				)
			if not a_options.use_directory_recusion then
				dv.set_directory_excluded_function (agent (ia_fn: PATH): BOOLEAN
						do
							Result := True -- no recursion!
						end
					)
			end
			across
				a_options.directories as ic
			loop
				dv.process_directory (create {PATH}.make_from_string (ic.item))
			end

			if l_files.is_empty then
					-- No files or directories, use current directory
				dv.process_directory (execution_environment.current_working_path)
			end

				-- Resave files
			create l_processed_files.make (l_files.count)
			l_processed_files.compare_objects
			across
				l_files as ic
			loop
				process_config (ic.item, l_files, l_processed_files)
			end

			if attached conf_helpers.error_handler as l_eh then
				create l_eprinter
				if l_eh.has_warnings then
					print ("%N")
					l_eh.trace_warnings (l_eprinter)
				end
				if not l_eh.is_successful then
					print ("%N")
					l_eh.trace_errors (l_eprinter)
					(create {EXCEPTIONS}).die (1)
				end
			end
		end

	is_verbose: BOOLEAN

	keep_safe_as_redirection: BOOLEAN

feature {NONE} -- Basic operations

	process_config (a_file_name: READABLE_STRING_32; a_files: ARRAYED_LIST [READABLE_STRING_32]; a_processed_files: ARRAYED_LIST [READABLE_STRING_32])
			-- Loads and resaves `a_file_name' using the configuration system.
		local
			l_ecf_filename: STRING_32
			f: RAW_FILE
--			s: STRING
			err: BOOLEAN
			p: PATH
			l_ecf_filename_entry: READABLE_STRING_32
		do
			if is_file_in (a_file_name, a_processed_files) then
				if is_verbose then
					localized_print (a_file_name)
					print (" : ")
					print ("already processed !%N")
				end
			else
				localized_print (a_file_name)
				print (" : ")
				if
					a_file_name /= Void and then
					not a_file_name.is_empty and then
					conf_helpers.is_file_readable (a_file_name)
				then
					a_processed_files.force (a_file_name)
					if a_file_name.ends_with_general ("-safe.ecf") then
						create l_ecf_filename.make_from_string (a_file_name)
						update_to_unique_ecf_location (l_ecf_filename)

						if attached config_redirection_from (a_file_name) as l_redir then
							print ("redirection file SKIPPED!%N")
							a_processed_files.force (l_ecf_filename)
						elseif attached config_system_from (a_file_name) as l_cfg then
							update_libraries_location (l_cfg)
							if save_conf_file (l_cfg, a_file_name) then
								print ("update completed.%N")
							else
								print ("update FAILED!%N")
								err := True
							end

							if not err then
								a_processed_files.force (l_ecf_filename)

								print ("  - rename as '")
								localized_print (l_ecf_filename)
								print ("' : ")

								if is_file_in (l_ecf_filename, a_files) then
									create f.make_with_name (l_ecf_filename)
									if f.exists and then f.is_access_writable then
										f.delete
									end

									if f.exists then
										err := True
										print ("FAILED (could not replace '")
										localized_print (l_ecf_filename)
										print ("') !%N")
									end
								end

								if not err then
										-- Rename -safe.ecf into .ecf
									create f.make_with_name (a_file_name)
									if f.exists and then f.is_access_readable then
										f.rename_file (l_ecf_filename)
									else
										print ("FAILED (could rename as '")
										localized_print (l_ecf_filename)
										print ("') !%N")
									end
								end
								if not err then
									print ("done.%N")

									create p.make_from_string (l_ecf_filename)
									if attached p.entry as e then
										l_ecf_filename_entry := e.name
									else
										l_ecf_filename_entry := l_ecf_filename
									end
									if keep_safe_as_redirection then
										print ("  - keep as redirection to '")
										localized_print (l_ecf_filename)
										print ("' : ")
										if attached new_conf_redirection (a_file_name, l_ecf_filename_entry, l_cfg.uuid, "Obsolete: use " + l_ecf_filename_entry + " !") as redir then
											if save_conf_file (redir, a_file_name) then
												print (" done.")
											else
												err := True
												print ("FAILED!")
											end
										else
											err := True
											print ("FAILED!")
										end
										print ("%N")
									end
								end
							end
						else
							print ("FAILED!%N")
						end
					else
						if
							attached safe_version_of_location (a_file_name) as l_safe_fn and then
							is_file_in (l_safe_fn, a_files)
						then
								-- case will be processed from the -safe.ecf file.
							print ("IGNORED !%N")
						else
								-- Update the .ecf file b removing -safe.ecf in lib locations.
							if attached config_redirection_from (a_file_name) as l_redir then
								print ("redirection file SKIPPED !%N")
							elseif attached config_system_from (a_file_name) as l_cfg then
								update_libraries_location (l_cfg)
								if save_conf_file (l_cfg, a_file_name) then
									print ("update completed.%N")
								else
									print ("update FAILED!%N")
									err := True
								end
							end
						end
					end
				else
					print ("INVALID file!%N")
				end
			end
		end

	update_libraries_location (cfg: CONF_SYSTEM)
		do
			across
				cfg.targets as ic
			loop
				across
					ic.item.libraries as libs_ic
				loop
					if attached libs_ic.item as lib then
						update_to_unique_ecf_location (lib.location.original_path)
					end
				end
			end
		end

	safe_version_of_location (a_location: READABLE_STRING_GENERAL): detachable STRING_32
		local
			i: INTEGER
		do
			i := a_location.substring_index ("-safe.ecf", 1)
			if i > 0 then
				Result := a_location.as_string_32
			else
				i := a_location.substring_index (".ecf", 1)
				if i > 0 then
					create Result.make_from_string_general (a_location.substring (1, a_location.count - 4))
					Result.append ("-safe.ecf")
				end
			end
		end

	update_to_unique_ecf_location (a_location: READABLE_STRING_GENERAL)
		require
			is_writable: attached {STRING_GENERAL} a_location
		local
			i: INTEGER
		do
			i := a_location.substring_index ("-safe.ecf", 1)
			if i > 0 then
				if attached {STRING_GENERAL} a_location as loc then
						-- remove the 5 characters of "-safe".
					loc.keep_head (i - 1)
					loc.append (".ecf")
				else
					check is_writable: False end
				end
			else
					-- Keep as it is.
			end
		end

	is_file_in (fn: READABLE_STRING_GENERAL; a_container: ITERABLE [READABLE_STRING_GENERAL]): BOOLEAN
		do
			across
				a_container as ic
			until
				Result
			loop
				Result := fn.same_string (ic.item)
			end
		end

;note
	copyright:	"Copyright (c) 1984-2016, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful, but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
		]"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
