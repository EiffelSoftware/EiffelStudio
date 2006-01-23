indexing
	description: "Application configuration file for Eiffel Codedom Provider"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

	note: "Queries `default_root_class' and `precompile_ace_file' can return `Void'."

class
	ECDM_CONFIGURATION

inherit
	CODE_CONFIGURATION
		export
			{NONE} reload
		redefine
			is_equal,
			load
		end

create
	make_empty,
	load

feature -- Initialization

	make_empty (a_config_folder, a_config_name: STRING) is
			-- Create default configuration file in `a_config_file'.
		require
			non_void_config_folder: a_config_folder /= Void
			non_void_config_name: a_config_name /= Void
		do
			initialize_default_values
			initialize_prefixes
			set_name (a_config_name)
			set_folder (a_config_folder)
			save
		end

	load (a_config_file: STRING) is
			-- Load configuration file `a_config_file'.
			-- Set `name' and `folder'.
		local
			l_index, l_index2: INTEGER
		do
			Precursor {CODE_CONFIGURATION} (a_config_file)
			l_index := a_config_file.last_index_of ((create {OPERATING_ENVIRONMENT}).Directory_separator, a_config_file.count)
			l_index2 := a_config_file.last_index_of ('.', a_config_file.count)
			if l_index > 1 then
				set_folder (a_config_file.substring (1, l_index - 1))
			else
				set_folder ((create {EXECUTION_ENVIRONMENT}).Current_working_directory)
			end
			if l_index2 > l_index + 1 then
				set_name (a_config_file.substring (l_index + 1, l_index2 - 1))
			else
				-- There is something wrong (a '\' after the last '.')
				if l_index < a_config_file.count then
					set_name (a_config_file.substring (l_index + 1, a_config_file.count))
				else
					set_name ("NoName")
				end
			end
		end

feature -- Comparison

	is_equal (other: like Current): BOOLEAN is
			-- Is `other' attached to an object considered
			-- equal to current object?
		do
			Result := path.as_lower.is_equal (other.path.as_lower)
		end

feature -- Access

	folder: STRING
			-- Configuration folder

	name: STRING
			-- Configuration name

	path: STRING is
			-- Configuration file full path
		do
			create Result.make (folder.count + name.count + Configuration_file_extension.count + 1)
			Result.append (folder)
			Result.append_character ((create {OPERATING_ENVIRONMENT}).Directory_separator)
			Result.append (name)
			Result.append (Configuration_file_extension)
		end

	last_save_successful: BOOLEAN
			-- Was last call to `save' successful?

	Configuration_file_extension: STRING is ".ecd"
			-- Configuration files extension

feature -- Basic Operations

	save is
			-- Save to file at `path'.
			-- Overwrite if already exist.
		local
			l_config_file: PLAIN_TEXT_FILE
			l_retried: BOOLEAN
			l_res: SYSTEM_OBJECT
		do
			if not l_retried then
				last_save_successful := False
				create l_config_file.make (path)
				if not {SYSTEM_DIRECTORY}.exists (folder) then
					l_res := {SYSTEM_DIRECTORY}.create_directory (folder)
				end
				l_config_file.open_write
				l_config_file.put_string ("<?xml version=%"1.0%"?>%N")
				l_config_file.put_string ("<configuration>%N")
				l_config_file.put_string ("%T<general>%N")
				l_config_file.put_string ("%T%T<fail_on_error>")
				l_config_file.put_string (fail_on_error.out)
				l_config_file.put_string ("</fail_on_error>%N")
				l_config_file.put_string ("%T%T<log_level>")
				l_config_file.put_string (log_level.out)
				l_config_file.put_string ("</log_level>%N")
				l_config_file.put_string ("%T%T<log_source_name>")
				l_config_file.put_string (log_source_name)
				l_config_file.put_string ("</log_source_name>%N")
				l_config_file.put_string ("%T%T<log_server_name>")
				l_config_file.put_string (log_server_name)
				l_config_file.put_string ("</log_server_name>%N")
				l_config_file.put_string ("%T%T<log_name>")
				l_config_file.put_string (log_name)
				l_config_file.put_string ("</log_name>%N")
				l_config_file.put_string ("%T</general>%N")
				l_config_file.put_string ("%T<prefixes>%N")
				from
					prefixes.start
				until
					prefixes.after
				loop
					l_config_file.put_string ("%T%T<prefix value=%"")
					l_config_file.put_string (prefixes.item_for_iteration)
					l_config_file.put_string ("%" assembly=%"")
					l_config_file.put_string (prefixes.key_for_iteration)
					l_config_file.put_string ("%"/>%N")
					prefixes.forth
				end
				l_config_file.put_string ("%T</prefixes>%N")
				l_config_file.put_string ("%T<compiler>%N")
				if default_root_class /= Void then
					l_config_file.put_string ("%T%T<default_root_class>")
					l_config_file.put_string (default_root_class)
					l_config_file.put_string ("</default_root_class>%N")
				end
				if metadata_cache /= Void then
					l_config_file.put_string ("%T%T<metadata_cache>")
					l_config_file.put_string (metadata_cache)
					l_config_file.put_string ("</metadata_cache>%N")
				end
				if compiler_metadata_cache /= Void then
					l_config_file.put_string ("%T%T<compiler_metadata_cache>")
					l_config_file.put_string (compiler_metadata_cache)
					l_config_file.put_string ("</compiler_metadata_cache>%N")
				end
				if precompile_ace_file /= Void then
					l_config_file.put_string ("%T%T<precompile_ace_file>")
					l_config_file.put_string (precompile_ace_file)
					l_config_file.put_string ("</precompile_ace_file>%N")
				end
				if precompile_cache /= Void then
					l_config_file.put_string ("%T%T<precompile_cache>")
					l_config_file.put_string (precompile_cache)
					l_config_file.put_string ("</precompile_cache>%N")
				end
				l_config_file.put_string ("%T</compiler>%N")
				l_config_file.put_string ("</configuration>")
				l_config_file.close
				last_save_successful := True
			end
		rescue
			l_retried := True
			retry
		end

feature -- Element Settings

	set_folder (a_config_folder: STRING) is
			-- Set `folder' with `a_config_folder'.
		require
			non_void_configuration_folder: a_config_folder /= Void
			valid_folder: a_config_folder.count > 3 implies a_config_folder.item (a_config_folder.count) /= (create {OPERATING_ENVIRONMENT}).Directory_separator
		do
			folder := a_config_folder
		ensure
			configuration_folder_set: folder = a_config_folder
		end

	set_name (a_config_name: STRING) is
			-- Set `name' with `a_config_name'.
		require
			non_void_configuration_name: a_config_name /= Void
		do
			name := a_config_name
		ensure
			configuration_name_set: name = a_config_name
		end

	set_fail_on_error (a_value: BOOLEAN) is
			-- Set `fail_on_error' with `a_value'.
		do
			config_values.force (a_value.out, "fail_on_error")
		end

	set_log_level (a_value: INTEGER) is
			-- Set `log_level' with `a_value'.
			-- See class CODE_EVENT_LOG_LEVEL for possible values
		do
			config_values.force (a_value.out, "log_level")
		end

	set_log_source_name (a_value: STRING) is
			-- set `log_source_name' with `a_value'.
		require
			non_void_source: a_value /= Void
		do
			config_values.force (a_value, "log_source_name")
		end

	set_log_server_name (a_value: STRING) is
			-- Set `log_server_name' with `a_value'.
		require
			non_void_name: a_value /= Void
		do
			config_values.force (a_value, "log_server_name")
		end

	set_log_name (a_value: STRING) is
			-- Set `log_name' with `a_value'.
		require
			non_void_name: a_value /= Void
		do
			config_values.force (a_value, "log_name")
		end

	set_precompile_ace_file (a_value: STRING) is
			-- Set `precompile_ace_file' with `a_value'.
		do
			config_values.force (a_value, "precompile_ace_file")
		end

	set_precompile_cache (a_value: STRING) is
			-- Set `precompile_cache' with `a_value'.
		do
			config_values.force (a_value, "precompile_cache")
		end

	set_metadata_cache (a_value: STRING) is
			-- Set `metadata_cache' with `a_value'.
		do
			config_values.force (a_value, "metadata_cache")
		end

	set_compiler_metadata_cache (a_value: STRING) is
			-- Set `compiler_metadata_cache' with `a_value'.
		do
			config_values.force (a_value, "compiler_metadata_cache")
		end

	set_default_root_class (a_value: STRING) is
			-- set `default_root_class' with `a_value'.
		require
			non_void_root_class: a_value /= Void
		do
			config_values.force (a_value, "default_root_class")
		end

	add_prefix (a_assembly, a_prefix: STRING) is
			-- Add `a_assembly' to list of prefixed assemblies with prefix `a_prefix'.
		require
			non_void_assembly: a_assembly /= Void
			non_void_prefix: a_prefix /= Void
		do
			prefixes.force (a_prefix, a_assembly)
		ensure
			added: prefixes.has (a_assembly) and then assembly_prefix (a_assembly).is_equal (a_prefix)
		end

	remove_prefix (a_assembly: STRING) is
			-- Remove `a_assembly' from list of prefixed assemblies.
		require
			non_void_assembly: a_assembly /= Void
		do
			prefixes.remove (a_assembly)
		ensure
			removed: not prefixes.has (a_assembly)
		end

invariant
	non_void_configuration_folder: folder /= Void
	valid_configuration_folder: not folder.is_empty and then folder.count > 3 implies (folder.item (folder.count) /= (create {OPERATING_ENVIRONMENT}).Directory_separator)
	non_void_configuration_name: name /= Void
	non_void_log_source_name: log_source_name /= Void
	non_void_log_server_name: log_server_name /= Void
	non_void_log_name: log_name /= Void

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 see http://www.eiffel.com/licensing/gpl.txt)"
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


end -- class ECDM_CONFIGURATION

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
