indexing
	description : "Objects that help computing file name for IL debug info"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author      : "$Author$"
	date        : "$Date$"
	revision    : "$Revision$"

class
	IL_DEBUG_INFO_HELPERS

inherit
	ANY

	SHARED_WORKBENCH
		export
			{NONE} all
		end

	PROJECT_CONTEXT
		export
			{NONE} all
		end

feature {NONE} -- Query

	is_entry_point (a_feat: FEATURE_I): BOOLEAN is
			-- Is `a_feat' the entry point ?
		require
			feat_not_void: a_feat /= Void
		local
			l_creation_name: STRING
		do
			l_creation_name := System.root_creation_name
			Result := l_creation_name /= Void --| In case we are precompiling |--
					and then a_feat.feature_name.is_equal (l_creation_name)
					and then a_feat.written_class.is_equal (System.root_class.compiled_class)
		end

feature {NONE} -- IL info file names

	Il_info_file_name: FILE_NAME is
			-- Filename for IL info storage used to load data
			-- in the context, we load workbench information
			-- in finalized we generate each time all IL code
			-- so we generate each time all the IL debug info
		do
			if system.is_precompiled and system.is_precompile_finalized then
				Result := Final_il_info_file_name
			else
				Result := Workbench_il_info_file_name
			end
		end

	Workbench_il_info_file_name: FILE_NAME is
			-- Filename for Workbench IL info storage
		do
			create Result.make_from_string (Workbench_generation_path)
			Result.set_file_name (Il_info_name)
			Result.add_extension (Il_info_extension)
		end

	Final_il_info_file_name: FILE_NAME is
			-- Filename for Final IL info storage
		once
			create Result.make_from_string (Final_generation_path)
			Result.set_file_name (Il_info_name)
			Result.add_extension (Il_info_extension)
		end

feature {NONE} -- File name data From compiler world

	workbench_module_directory_path_name: STRING is
			-- Directory path where module are located
		do
			Result := Workbench_generation_path
		end

	finalized_module_directory_path_name: STRING is
			-- Directory path where module are located
		do
			Result := Final_generation_path
		end

	workbench_assembly_directory_path_name: STRING is
			-- Directory path where assemblies are located
			-- that is also valid for precompilation assemblies
		do
			Result := Workbench_bin_generation_path
		end

	finalized_assembly_directory_path_name: STRING is
			-- Directory path where assemblies are located
			-- that is also valid for precompilation assemblies
		do
			Result := Final_bin_generation_path
		end

	precompilation_module_name (a_system_name: STRING): STRING is
		do
			Result := a_system_name + ".dll"
		end

	workbench_precompilation_module_filename (a_system_name: STRING): FILE_NAME is
		do
			create Result.make_from_string (workbench_assembly_directory_path_name)
			Result.set_file_name (precompilation_module_name (a_system_name))
		end

	finalized_precompilation_module_filename (a_system_name: STRING): FILE_NAME is
			-- Finalized precompilation module file name for `a_system_name'.
		do
			create Result.make_from_string (finalized_assembly_directory_path_name)
			Result.set_file_name (precompilation_module_name (a_system_name))
		end

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

end -- class IL_DEBUG_INFO_HELPERS
