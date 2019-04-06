note
	description: "[
		Application to resave ECFs using the configuration library.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	ECF_RESAVE

inherit

	ECF_SHARED_CONF_HELPERS

	SHARED_EXECUTION_ENVIRONMENT

	LOCALIZED_PRINTER

	CONF_ACCESS

create
	make

feature {NONE} -- Initialization

	make (args: ECF_RESAVE_ARGUMENT_PARSER)
			-- Application entry point
		do
			start (args)
		end

feature {NONE} -- Execution

	start (a_options: ECF_RESAVE_ARGUMENT_PARSER)
			-- Starts application once all arguments have been parsed
		require
			a_options_attached: a_options /= Void
			a_options_is_successful: a_options.is_successful
		local
			dv: ECF_DIRECTORY_CUSTOM_ITERATOR
			l_files: ARRAYED_LIST [READABLE_STRING_32]
			l_eprinter: ERROR_CUI_PRINTER
		do
			namespace := a_options.namespace
			schema := a_options.schema
			reset_uuid_requested := a_options.reset_uuid_requested
			is_quiet := a_options.is_quiet

				-- Add specified files
			create l_files.make (0)
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
			across
				l_files as ic
			loop
				resave_config (ic.item)
			end

			if attached conf_helpers.error_handler as l_eh then
				create l_eprinter
				if l_eh.has_warnings then
					l_eh.trace_warnings (l_eprinter)
				end
				if not l_eh.is_successful then
					l_eh.trace_errors (l_eprinter)
					(create {EXCEPTIONS}).die (1)
				end
			end
		end

	namespace, schema: detachable READABLE_STRING_GENERAL

	reset_uuid_requested: BOOLEAN
			-- Reset ECF UUID?

	is_quiet: BOOLEAN
			-- Should only errors be printed?

feature {NONE} -- Basic operations

	resave_config (a_file_name: READABLE_STRING_32)
			-- Loads and resaves `a_file_name' using the configuration system.
		local
			b: BOOLEAN
			l_cfg: detachable CONF_SYSTEM
		do
			if a_file_name /= Void and then not a_file_name.is_empty and then conf_helpers.is_file_readable (a_file_name) then
				print_message ("Loading configuration file '")
				print_message (a_file_name)
				print_message ("'... ")
				l_cfg := config_system_from (a_file_name)
				if attached config_redirection_from (a_file_name) as redir then
					print_message ("Done%N")
					print_message ("Saving redirection file... ")
					if reset_uuid_requested then
						print_message (" (reset UUID) ")
						redir.set_uuid (Void) -- As we don't know if targetted ecf file is going to be resaved with new uuid, just remove UUID on redirection.
					end
					b := save_conf_file_with_namespace_and_schema (redir, a_file_name, namespace, schema)
					print_message (if b then "Done%N" else "Failed!%N" end)
				elseif l_cfg /= Void then
					print_message ("Done%N")
					print_message ("Saving configuration file... ")
					if reset_uuid_requested and not l_cfg.is_generated_uuid then
						print_message (" (reset UUID) ")
						l_cfg.set_uuid ((create {UUID_GENERATOR}).generate_uuid)
					end
					b := save_conf_file_with_namespace_and_schema (l_cfg, a_file_name, namespace, schema)
					print_message (if b then "Done%N" else "Failed!%N" end)
				else
					print_message ("Failed!%N")
				end
			else
				print_message ("Invalid file!%N")
			end
		end

feature {NONE} -- Output

	print_message (m: READABLE_STRING_GENERAL)
			-- Print `m` to standard output if enabled.
		do
			if not is_quiet then
				localized_print (m)
			end
		end

;note
	copyright:	"Copyright (c) 1984-2019, Eiffel Software and others"
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
