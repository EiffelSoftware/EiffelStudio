note
	description: "Path to EiffelCodeDomProvider components"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	CODE_DOM_PATH

inherit
	CODE_REGISTRY_KEYS
		export
			{NONE} all
		end

	CODE_SHARED_EVENT_MANAGER
		export
			{NONE} all
		end

	OPERATING_ENVIRONMENT
		export
			{NONE} all
		end

feature -- Access

	Codedom_installation_path: STRING
			-- Path to installed CodeDom provider
		local
			l_key: REGISTRY_KEY
			l_path: SYSTEM_STRING
		once
			l_key := {REGISTRY}.local_machine.open_sub_key (Setup_key, False)
			if l_key = Void then
				Event_manager.raise_event ({CODE_EVENTS_IDS}.Missing_setup_key, [])
			else
				l_path ?= l_key.get_value (Installation_dir_value)
				if l_path = Void then
					Event_manager.raise_event ({CODE_EVENTS_IDS}.Missing_installation_directory, [])
				else
					Result := l_path
					if Result.count > 1 and then Result.item (Result.count) = Directory_separator then
						Result.keep_head (Result.count - 1)
					end
				end
			end
		ensure
			no_ending_directory_separator: Result /= Void implies Result.item (Result.count) /= Directory_separator
		end

	Default_metadata_cache_path: STRING
			-- Default path to Eiffel metadata cache
		once
			if Codedom_installation_path /= Void then
				create Result.make_from_string (Codedom_installation_path)
				Result.append_character (Directory_separator)
				Result.append ("Assemblies")
			end
		ensure
			do_not_end_with_directory_separator: Result /= Void implies Result.item (Result.count) /= Directory_separator
		end

	Default_compiler_metadata_cache_path: STRING
			-- Default path to Compiler metadata cache
		once
			if Codedom_installation_path /= Void then
				create Result.make_from_string (Codedom_installation_path)
				Result.append_character (Directory_separator)
				Result.append ("CompilerAssemblies")
			end
		ensure
			do_not_end_with_directory_separator: Result /= Void implies Result.item (Result.count) /= Directory_separator
		end

	Default_precompile_cache: STRING
			-- Default path to precompiled libraries
		once
			if Codedom_installation_path /= Void then
				create Result.make_from_string (Codedom_installation_path)
				Result.append_character (Directory_separator)
				Result.append ("precompile")
			end
		ensure
			do_not_end_with_directory_separator: Result /= Void implies Result.item (Result.count) /= Directory_separator
		end

	Default_precompile_ace_file: STRING
			-- Default path to precompile ace file
		once
			if Codedom_installation_path /= Void then
				create Result.make_from_string (Codedom_installation_path)
				Result.append_character (Directory_separator)
				Result.append ("compiler")
				Result.append_character (Directory_separator)
				Result.append ("precomp")
				Result.append_character (Directory_separator)
				Result.append ("ace.ace")
			end
		ensure
			do_not_end_with_directory_separator: Result /= Void implies Result.item (Result.count) /= Directory_separator
		end

	Default_configs_directory: STRING
			-- Path to configs directory used by default if config file path is not specified in registry
		local
			l_install_dir: STRING
			l_dir: DIRECTORY
		once
			l_install_dir := Codedom_installation_path
			if l_install_dir /= Void then
				create l_dir.make (l_install_dir)
				if l_dir.exists then
					create l_dir.make (l_install_dir + Directory_separator.out + "Configs")
					if not l_dir.exists then
						l_dir.create_dir
					end
					Result := l_dir.name
				end
			else
				Event_manager.raise_event ({CODE_EVENTS_IDS}.missing_installation_directory, [])
			end
		end
		
	Default_config_file_path: STRING
			-- Default path to config file if not overwritten in Registry settings
		once
			Result := Default_configs_directory
			if Result /= Void then
				Result.append_character (Directory_separator)
				Result.append ("default.ecd")
			end
		end
	
	Compiler_path: STRING
			-- Path to compiler
		local
			l_key: REGISTRY_KEY
			l_path, l_platform: SYSTEM_STRING
		once
			l_key := {REGISTRY}.local_machine.open_sub_key (Compiler_key, False)
			if l_key = Void then
				Event_manager.raise_event ({CODE_EVENTS_IDS}.Missing_compiler_key, [])
			else
				l_path ?= l_key.get_value (Ise_eiffel_value)
				if l_path = Void then
					Event_manager.raise_event ({CODE_EVENTS_IDS}.Missing_ise_eiffel, [])
				else
					l_platform ?= l_key.get_value (Ise_platform_value)
					if l_platform = Void then
						Event_manager.raise_event ({CODE_EVENTS_IDS}.Missing_ise_platform, [])
					else
						Result := l_path
						if Result.item (Result.count) /= Directory_separator then
							Result.append_character (Directory_separator)
						end
						Result.append ("studio")
						Result.append_character (Directory_separator)
						Result.append ("spec")
						Result.append_character (Directory_separator)
						Result.append (create {STRING}.make_from_cil (l_platform))
						Result.append_character (Directory_separator)
						Result.append ("bin")
					end
				end
			end
		ensure
			no_ending_directory_separator: Result /= Void implies Result.item (Result.count) /= Directory_separator
		end

	Documentation_path: STRING
			-- Path to documentation file
		once
			create Result.make (Codedom_installation_path.count + 1 + 13 + 1 + Documentation_file_name.count)
			Result.append (Codedom_installation_path)
			Result.append (Directory_separator.out)
			Result.append ("Documentation")
			Result.append (Directory_separator.out)
			Result.append (Documentation_file_name)
		end

	Documentation_file_name: STRING = "Eiffel for ASP.NET.chm";
			-- Documentation chm file name

note
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
end -- class CODE_DOM_PATH

