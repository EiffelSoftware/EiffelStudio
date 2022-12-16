note
	description: "[
			Use "emdc" executable execution to consume dotnet assemblies.
			
			If the environment variable "ISE_EMDC" is set and not blank, use that path for the executable.
		]"
	author: "$Author$"
	date: "$Date$"
	revision: "$Revision$"

class
	MD_CONSUMER_PROCESS

inherit
	CONSUMER
		rename
			is_available as exists,
			release as unload
		end

	EIFFEL_LAYOUT
	SHARED_EXECUTION_ENVIRONMENT

create
	make

feature {NONE} -- Initialization

	make (a_cache_path: PATH; a_runtime_version: READABLE_STRING_GENERAL)
			-- Create new instance of md consumer
		require
			attached a_cache_path
			not a_cache_path.is_empty
			attached a_runtime_version
			not a_runtime_version.is_empty
		local
			dir: DIRECTORY
		do
			emdc_location :=
				if attached {EXECUTION_ENVIRONMENT}.item ("ISE_EMDC") as s then
					create {PATH}.make_from_string (s)
				else
					eiffel_layout.emdc_command_name
				end
			cache_location := a_cache_path
			create dir.make_with_path (a_cache_path)
			if not dir.exists then
				dir.recursive_create_dir
			end
			if not exists then
				last_error_message := {SHARED_LOCALE}.locale.formatted_string
					({SHARED_LOCALE}.locale.translation_in_context ("Cannot find .NET metadata consumer at %"$1%"", "metadata_consumer"),
					emdc_location.name)
			elseif not is_initialized then
				last_error_message := {SHARED_LOCALE}.locale.formatted_string
					({SHARED_LOCALE}.locale.translation_in_context ("The path to the metadata cache does not exist and cannot be created: $1", "metadata_consumer"),
					a_cache_path.name)
			end
		end

feature -- Status report

	emdc_location: PATH
			-- The path to the "emdc" executable.

	cache_location: PATH
			-- The path to the consumed metadata cache.

	exists: BOOLEAN
			-- <Precursor>
		local
			fut: FILE_UTILITIES
		do
			Result := fut.file_path_exists (emdc_location)
		end

	is_initialized: BOOLEAN
			-- <Precursor>
		local
			fut: FILE_UTILITIES
		do
			Result := exists and then fut.directory_path_exists (cache_location)
		end

	last_error_message: detachable READABLE_STRING_32
			-- <Precursor>

feature -- Clean up

	unload
			-- <Precursor>
		do
		end

feature -- XML generation

	consume_assembly_from_path (a_assembly_paths: ITERABLE [READABLE_STRING_32]; a_info_only: BOOLEAN; a_references: detachable ITERABLE [READABLE_STRING_32])
			-- <Precursor>
		local
			p: BASE_PROCESS
			pf: BASE_PROCESS_FACTORY
			args: ARRAYED_LIST [READABLE_STRING_GENERAL]
			cmd: STRING_32
		do
			create pf
			create args.make (10)
			args.force ("-nologo")
			across
				a_assembly_paths as a
			loop
				args.force ("-a")
				args.force (a)
			end
			if is_eiffel_layout_defined and then eiffel_layout.use_json_dotnet_md_cache then
				args.force ("-json") -- For "JSON" storage
			end
			args.force ("-o")
			args.force (cache_location.name)
			if a_info_only then
				args.force ("-g")
			end
			if a_references /= Void then
				across
					a_references as r
				loop
					args.force ("-i")
					args.force (r)
				end
			end
			if
				not eiffel_layout.default_il_environment.installed_sdks.is_empty and then
				attached eiffel_layout.default_il_environment.installed_sdks.new_cursor as c and then
				attached c.item as sdk_path
			then
				args.extend ("-i")
				args.extend (sdk_path.name)
				args.extend ("-i")
				args.extend (sdk_path.extended ("ref").name)
			end
			if attached execution_environment.item (eiffel_layout.default_il_environment.ise_dotnet_framework_env) as d then
				args.extend ("-i")
				args.extend (d)
			end

			p := pf.process_launcher (emdc_location.name, args, emdc_location.parent.name)

			create cmd.make_from_string_general (emdc_location.name)
			across
				args as a
			loop
				cmd.append_character (' ')
				if a.has (' ') then
					cmd.append_character ('"')
					cmd.append (a)
					cmd.append_character ('"')
				else
					cmd.append (a)
				end
			end

			debug ("consumer")
				print ("#CONSUMER: " + {UTF_CONVERTER}.string_32_to_utf_8_string_8 (cmd) + "%N")
			end

			p.launch
			if p.launched then
				p.wait_for_exit
				if p.exit_code /= 0 then
					last_error_message := {SHARED_LOCALE}.locale.formatted_string
						({SHARED_LOCALE}.locale.translation_in_context ("Exited with code %"$1%"", "metadata_consumer"),
						"0x" + p.exit_code.to_hex_string)
				end
			else
				last_error_message := {SHARED_LOCALE}.locale.formatted_string
					({SHARED_LOCALE}.locale.translation_in_context ("Failed to start %"$1%"", "metadata_consumer"),
					emdc_location.name)
			end
		end

	consume_assembly (a_name, a_version, a_culture, a_key: READABLE_STRING_GENERAL; a_info_only: BOOLEAN)
			-- <Precursor>
		do
			last_error_message := {SHARED_LOCALE}.locale.translation_in_context
				("Consuming .NET metadata from assemblies from GAC is not implemented", "metadata_consumer")
		end

note
	ca_ignore: "CA011", "CA011: too many arguments"
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
