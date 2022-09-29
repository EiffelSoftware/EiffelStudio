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
		do
			if
				attached {EXECUTION_ENVIRONMENT}.item ("ISE_EMDC") as l_ise_emdc and then
				not l_ise_emdc.is_whitespace and then
				(create {FILE_UTILITIES}).file_exists (l_ise_emdc)
			then
					-- note: Used mostly during development
				create emdc_location.make_from_string (l_ise_emdc)
			else
				emdc_location := eiffel_layout.tools_bin_path.extended ("emdc").appended (eiffel_layout.executable_suffix)
			end

			cache_location := a_cache_path
		end


feature -- Status report

	emdc_location: PATH

	cache_location: PATH

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
			if exists then
				Result := fut.file_path_exists (cache_location)
			end
			Result := True
		end

	last_error_message: detachable READABLE_STRING_32
			-- <Precursor>
		do
			if not exists then
				Result := {STRING_32} "Unable to find Eiffel Assembly md consumer (emdc)."
			elseif not is_initialized then
				Result := {STRING_32} "Unable to find Eiffel Assembly Cache."
			end
		end

feature -- Clean up

	unload
			-- <Precursor>
		do
		end

feature -- XML generation

	consume_assembly_from_path (a_assembly_paths: READABLE_STRING_GENERAL; a_info_only: BOOLEAN; a_references: detachable READABLE_STRING_GENERAL)
			-- <Precursor>
		local
			p: BASE_PROCESS
			pf: BASE_PROCESS_FACTORY
			args: ARRAYED_LIST [READABLE_STRING_GENERAL]
			ret: INTEGER
			cmd: STRING_32
			dir: DIRECTORY
		do
			create pf
			create args.make (10)
			args.force ("-nologo")
			across
				a_assembly_paths.split (';') as a
			loop
				if not a.is_whitespace then
					args.force ("-a")
					args.force (a)
				end
			end
			args.force ("-o")
			args.force (cache_location.name)
			create dir.make_with_path (cache_location)
			if not dir.exists then
				dir.recursive_create_dir
			end
			if a_info_only then
				args.force ("-g")
			end
			if a_references /= Void then
				across
					a_references.split (';') as r
				loop
					if not r.is_whitespace then
						args.force ("-i")
						args.force (r)
					end
				end
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

--			debug ("consumer")
				print ("#CONSUMER: "+ cmd + "%N")
--			end

			p.launch
			if p.launched then
				ret := p.exit_code
				p.wait_for_exit

			else
				-- Error ...
			end
		end

	consume_assembly (a_name, a_version, a_culture, a_key: READABLE_STRING_GENERAL; a_info_only: BOOLEAN)
			-- <Precursor>
		do
			check False then
				-- Not yet implemented!
			end
		end

feature {NONE} -- Implementation

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
