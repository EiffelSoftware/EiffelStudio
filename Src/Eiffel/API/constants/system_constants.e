note
	description: "System level constants."
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class SYSTEM_CONSTANTS

inherit
	SHARED_PLATFORM_CONSTANTS

	PRODUCT_NAMES

	EIFFEL_LAYOUT
		export
			{NONE} all
		end

feature {NONE}

	Backup: STRING = "BACKUP"

	Backup_info: STRING = "compilation_info.txt"

	Studio_directory_list: STRING = "DIRECTORYLIST"

	C_prefix: CHARACTER = 'C'
			-- Prefix for C generated directories and object files

	System_object_prefix: CHARACTER = 'E'

	Continuation: CHARACTER = '\'

	Comp: STRING = "COMP"

	Descriptor_file_suffix: CHARACTER = 'd'

	Documentation: STRING = "Documentation"

	dot_e: STRING = ".e"

	Dot_c: STRING = ".c"

	Dot_cpp: STRING = ".cpp"

	Dot_h: STRING = ".h"

	Dot_x: STRING = ".x"

	Dot_xpp: STRING = ".xpp"

	Dot_profile_information: STRING = "pfi"

	Driver: STRING
			-- Name of `driver' executable used to execute melted code.
		once
			if {PLATFORM_CONSTANTS}.is_windows then
				create Result.make (15)
				Result.append (eiffel_layout.Eiffel_c_compiler)
				Result.append ("\driver.exe")
			elseif {PLATFORM_CONSTANTS}.is_vms then
				Result := "driver.exe"
			else
				Result := "driver"
			end
		end

	Epoly: STRING = "epoly"

	Ecall: STRING = "ecall"

	Ececil: STRING = "ececil"

	Efrozen: STRING = "efrozen"

	Eiffelgens: STRING = "EIFGENs"

	Einit: STRING = "einit"

	Eoption: STRING = "eoption"

	Eparents: STRING = "eparents"

	Epattern: STRING = "epattern"

	Eplug: STRING = "eplug"

	Eref: STRING = "eref"

	Esize: STRING = "esize"

	Eoffsets: STRING = "eoffsets"

	Eskelet: STRING = "eskelet"

	Estructure: STRING = "estructure"

	Evisib: STRING = "evisib"

	F_code: STRING = "F_code"

	Feature_table_file_suffix: CHARACTER = 'f'

	Makefile_sh: STRING = "Makefile.SH"

	Partials: STRING = "Partials"

	Precomp_eif: STRING = "precomp.eif"

	Preobj: STRING
			-- Name of C library used in precompiled library.
		once
			if {PLATFORM_CONSTANTS}.is_windows then
				Result := "precomp.lib"
			elseif {PLATFORM_CONSTANTS}.is_unix then
				Result := "preobj.o"
			else
				Result := "preobj.olb"
			end
		end

	Profiler: STRING = "Profiler"

	Project_file_name: STRING = "project.epr"

	ec_lock_file_name: STRING = "ec.lock"

	Removed_log_file_name: STRING = "REMOVED";

	Translation_log_file_name: STRING = "TRANSLAT";

	Finalized_type_mapping: STRING = "class_mapping"

	Finished_file_for_make: STRING = "finished"

	Local_assemblies: STRING = "Assemblies"

	W_code: STRING = "W_code"

	eiffel_extension: STRING = "e"
			-- File extension for an Eiffel source file without the dot

	project_extension: STRING = "epr"
			-- File extension for an Eiffel Studio project file without the dot

	config_extension: STRING = "ecf"
			-- File extension for an Eiffel configuration file without the dot

	ace_file_extension: STRING = "ace"

	Debug_info_extension: STRING = "edb"
			-- Eiffel Debug Breakpoints file (extension)

	Debug_info_name: STRING = "options"
			-- Eiffel Debug Breakpoints file (core name)	

	Il_info_extension: STRING = "edi"
			-- Eiffel Debug Info file (extension)
			-- Used for IL code generation

	Il_info_name: STRING = "il_info"
			-- Eiffel Debug Info file (core name)
			-- Used for IL code generation

	info_flag_end: STRING = "-- end of info"

	data_directory: STRING = "Data"
			-- Directory name `Data'

	eifgens_cluster_directory: STRING = "Cluster"
			-- Directory EIFGENs/[target]/Cluster

	testing_results_directory: STRING = "Testing"
			-- Directory EIFGENs/[target]/Testing

feature-- Versioning

	Compiler_version_number: CONF_VERSION
			-- Version of the compiler
		once
				-- We put (9999 + 1) because if we were to put 10000 the 4 zeros
				-- will get replaced by the delivery scripts (see comments for `svn_revision'.
			create Result.make_version (
				{EIFFEL_ENVIRONMENT_CONSTANTS}.major_version,
				{EIFFEL_ENVIRONMENT_CONSTANTS}.minor_version,
				(svn_revision // (9999 + 1).as_natural_32).as_natural_16,
				(svn_revision \\ (9999 + 1).as_natural_32).as_natural_16)
		end

	Version_number: STRING
			-- Version number composed of
			-- `Major' . `Minor' . `Release' . `Build'.
		once
			create Result.make (30)
			Result.append (compiler_version_number.version)
			Result.append_character (' ')
			Result.append_string (version_type_name)
			Result.append_character (' ')
			Result.append_character ('-')
			Result.append_character (' ')
			Result.append_string (eiffel_layout.eiffel_platform)
		end

	Version_type_name: STRING = "GPL Edition";
			-- Name of version, e.g. GPL edition, Enterprise Edition,...
			-- Default: "GPL Edition"

feature {AUXILIARY_FILES} -- Versioning

	svn_revision: NATURAL_32
			-- SVN revision that build the compiler.
			-- We use `0000' because it is replaced by the actual svn revision number
			-- when doing a delivery.
		do
			Result := 0000
		end

	Version_tag: INTEGER = 0x026



	Version_info: STRING = "";
			-- Information on the version
			-- Default: ""
			-- This can be used by developper to add specific information
			-- displayed on About dialog

	Ace_file_path_tag: STRING = "ace_file_path";
			-- Tags used in project file header.

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

end
