note
	description: "Helper for creating files used in C code generation"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	SHARED_CODE_FILES

inherit
	PROJECT_CONTEXT

	SYSTEM_CONSTANTS

feature -- Makefile generation

	Make_f (final_mode: BOOLEAN): INDENT_FILE
			-- Makefile for C compilation
		do
			create Result.make_open_write (full_file_name (final_mode, Void, Makefile_sh, Void))
		ensure
			is_open_write: Result.is_open_write
		end

feature -- Action

	force_c_compilation_in_sub_dir (final_mode: BOOLEAN; sub_dir: detachable READABLE_STRING_GENERAL)
			-- Delete file `finished'.
		local
			finished_file: PLAIN_TEXT_FILE
			dir_name: PATH
		do
				-- Has side effect: creating a folder
			dir_name := validated_dir_name (final_mode, sub_dir)

			create finished_file.make_with_path (dir_name.extended (finished_file_for_make))
			if finished_file.exists and then finished_file.is_writable then
				finished_file.delete
			end
		end

feature -- C code generation

	gen_file_name (final_mode: BOOLEAN; base_name: READABLE_STRING_GENERAL): PATH
			-- Generate a file name either in workbench or final mode with
			-- a `.c' extension in the E1 directory.
		require
			base_name_not_void: base_name /= Void
		do
			Result := full_file_name (final_mode, packet_name (system_object_prefix, 1), base_name, Dot_c)
		ensure
			result_not_void: Result /= Void
		end

	x_gen_file_name (final_mode: BOOLEAN; base_name: READABLE_STRING_GENERAL): PATH
			-- Generate a file name either in workbench or final mode with
			-- a `.x' extension in the E1 directory.
		require
			base_name_not_void: base_name /= Void
		do
			if final_mode then
				Result := full_file_name (final_mode, packet_name (system_object_prefix, 1), base_name, Dot_x)
			else
				Result := full_file_name (final_mode, packet_name (system_object_prefix, 1), base_name, Dot_c)
			end
		ensure
			result_not_void: Result /= Void
		end

	final_file_name (base_name, extension: READABLE_STRING_GENERAL; n: INTEGER): PATH
			-- Generate a file name in final_mode with file `extension'
			-- in system directory E`n'.
		require
			base_name_not_void: base_name /= Void
			extension_not_void: extension /= Void
			positive_n: n >= 1
		do
			Result := full_file_name (True, packet_name (system_object_prefix, n), base_name, extension)
		ensure
			result_not_void: Result /= Void
		end

	workbench_file_name (base_name, extension: READABLE_STRING_GENERAL; n: INTEGER): PATH
			-- Generate a file in workbench_mode with file `extension'
			-- in system directory E1.
		require
			base_name_not_void: base_name /= Void
			extension_not_void: extension /= Void
			n_positive: n > 0
		do
			Result := full_file_name (False, packet_name (system_object_prefix, n), base_name, extension)
		ensure
			result_not_void: Result /= Void
		end

	full_file_name (final_mode: BOOLEAN; sub_dir: detachable READABLE_STRING_GENERAL; file_name: READABLE_STRING_GENERAL; extension: detachable READABLE_STRING_GENERAL): PATH
			-- Generated file name for `final_mode' creating a subdirectory
			-- if `sub_dir' is not Void or empty, using `file_name'+`extension' as filename.
			-- Side effect: Create the corresponding subdirectory if it
			-- does not exist yet.
		require
			file_name_not_void: file_name /= Void
		local
			l_name: STRING_32
		do
				-- Has side effect: creating a folder
			Result := validated_dir_name (final_mode, sub_dir)
			if extension /= Void then
				create l_name.make (file_name.count + extension.count)
				l_name.append_string_general (file_name)
				l_name.append_string_general (extension)
				Result := Result.extended (l_name)
			else
				Result := Result.extended (file_name)
			end
		ensure
			result_not_void: Result /= Void
		end

	packet_name (sub_dir_prefix: CHARACTER; a_packet_number: INTEGER): STRING
			-- Name of subdirectory.
		require
			a_packet_number_non_negative: a_packet_number >= 0
		do
			create Result.make (6)
			Result.append_character (sub_dir_prefix)
			Result.append_integer (a_packet_number)
		ensure
			packet_name_not_void: Result /= Void
		end

feature {NONE} -- Implementation

	validated_dir_name (final_mode: BOOLEAN; sub_dir: detachable READABLE_STRING_GENERAL): PATH
			-- Validated dir, create it if not exist.
		local
			dir: DIRECTORY
		do
			if final_mode then
				Result := project_location.final_path
			else
				Result := project_location.workbench_path
			end

			if sub_dir /= Void and then not sub_dir.is_empty then
				Result := Result.extended (sub_dir)
			end

				-- Side effect here, we create a new subdirectory if it does
				-- not exist yet.
			create dir.make_with_path (Result)
			if not dir.exists then
				dir.create_dir
			end
		ensure
			Result_attached: Result /= Void
		end

note
	copyright:	"Copyright (c) 1984-2013, Eiffel Software"
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

end -- end class SHARED_CODE_FILES
