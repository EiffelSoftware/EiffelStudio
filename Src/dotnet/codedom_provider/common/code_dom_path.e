indexing
	description: "Path to EiffelCodeDomProvider components"
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

	Codedom_installation_path: STRING is
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

	Default_metadata_cache_path: STRING is
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

	Default_compiler_metadata_cache_path: STRING is
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

	Default_precompile_cache: STRING is
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

	Default_precompile_ace_file: STRING is
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

	Default_configs_directory: STRING is
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
		
	Default_config_file_path: STRING is
			-- Default path to config file if not overwritten in Registry settings
		once
			Result := Default_configs_directory
			if Result /= Void then
				Result.append_character (Directory_separator)
				Result.append ("default.ecd")
			end
		end
	
	Compiler_path: STRING is
			-- Path to compiler
		local
			l_key: REGISTRY_KEY
			l_path: SYSTEM_STRING
		once
			l_key := {REGISTRY}.local_machine.open_sub_key (Compiler_key, False)
			if l_key = Void then
				Event_manager.raise_event ({CODE_EVENTS_IDS}.Missing_compiler_key, [])
			else
				l_path ?= l_key.get_value (Ise_eiffel_value)
				if l_path = Void then
					Event_manager.raise_event ({CODE_EVENTS_IDS}.Missing_ise_eiffel, [])
				else
					Result := l_path
					if Result.item (Result.count) /= Directory_separator then
						Result.append_character (Directory_separator)
					end
					Result.append ("studio")
					Result.append_character (Directory_separator)
					Result.append ("spec")
					Result.append_character (Directory_separator)
					Result.append ("windows")
					Result.append_character (Directory_separator)
					Result.append ("bin")
				end
			end
		ensure
			no_ending_directory_separator: Result /= Void implies Result.item (Result.count) /= Directory_separator
		end

	Documentation_path: STRING is
			-- Path to documentation file
		once
			create Result.make (Codedom_installation_path.count + 1 + 13 + 1 + Documentation_file_name.count)
			Result.append (Codedom_installation_path)
			Result.append (Directory_separator.out)
			Result.append ("Documentation")
			Result.append (Directory_separator.out)
			Result.append (Documentation_file_name)
		end

	Documentation_file_name: STRING is "Eiffel for ASP.NET.chm"
			-- Documentation chm file name

end -- class CODE_DOM_PATH

--+--------------------------------------------------------------------
--| Eiffel CodeDOM Provider
--| Copyright (C) 2001-2004 Eiffel Software
--| Eiffel Software Confidential
--| All rights reserved. Duplication and distribution prohibited.
--|
--| Eiffel Software
--| 356 Storke Road, Goleta, CA 93117 USA
--| http://www.eiffel.com
--+--------------------------------------------------------------------
