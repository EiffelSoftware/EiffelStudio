note
	description: "File system routines."
	author: "Andreas Leitner"
	revised_by: "Alexander Kogtenkov"
	date: "$Date$"
	revision: "$Revision$"

class AUT_FILE_SYSTEM_ROUTINES

inherit
	ANY

	KL_SHARED_EXECUTION_ENVIRONMENT
		export {NONE} all end

	KL_SHARED_FILE_SYSTEM
		export {NONE} all end

	KL_IMPORTED_STRING_ROUTINES
		export {NONE} all end

create {AUT_SHARED_FILE_SYSTEM_ROUTINES}

	make

feature {NONE} -- Initialization

	make
		do
		end

feature -- Basic routines

	interpreted_pathname (a_base_directory: STRING; a_pathname: STRING): STRING
			-- Interpreted version of `a_pathname'; All environment
			-- variables will be replaced by their value. Undefined
			-- environment variables are left untouched. If `a_pathname'
			-- is a relative pathname it will be made absolute. Note that
			-- `a_base_directory' must be absolute.
		require
			a_base_directory_not_void: a_base_directory /= Void
			a_base_directory_not_empty: a_base_directory.count > 0
			a_pathname_not_void: a_pathname /= Void
			a_pathname_not_empty: a_pathname.count > 0
		do
			Result := interpreted_string (a_pathname)
			if file_system.is_relative_pathname (Result) then
				Result := file_system.pathname (a_base_directory, Result)
			end
		ensure
			pathname_not_void: Result /= Void
			pathname_not_empty: Result.count > 0
		end

	absolute_parent_directory_of_filename (a_filename: STRING): STRING
			-- Absolute parent directory of `a_filename'
		require
			a_filename_not_void: a_filename /= Void
			a_filename_not_empty: a_filename.count > 0
		do
			Result := file_system.dirname (a_filename)
			Result := file_system.absolute_pathname (Result)
			Result := file_system.canonical_pathname (Result)
		ensure
			directory_not_void: Result /= Void
			directory_not_empty: Result.count > 0
		end

	interpreted_string (a_string: STRING): STRING
			-- String where the environment variables have been
			-- replaced by their values. The environment variables
			-- are considered to be either ${[^}]*} or $[a-zA-Z0-9_]+
			-- and the dollar sign is escaped using $$. Non defined
			-- environment variables are replaced by empty strings.
			-- The result is not defined when `a_string' does not
			-- conform to the conventions above.
			-- Return a new string each time.
			-- NOTE: That ${ISE_EIFFEL} is treated special. Even if it
			-- is not defined, it will be tried to gather a sane value.
		require
			a_string_not_void: a_string /= Void
		local
			str: STRING
			value: STRING
			i, nb: INTEGER
			c: CHARACTER
			stop: BOOLEAN
			eiffel_compiler: AUT_ISE_EIFFEL_COMPILER
		do
			from
				i := 1
				nb := a_string.count
				Result := STRING_.new_empty_string (a_string, nb)
			until
				i > nb
			loop
				c := a_string.item (i)
				i := i + 1
				if c /= '$' then
					if c /= '%U' then
						Result.append_character (c)
					else
						Result := STRING_.appended_substring (Result, a_string, i - 1, i - 1)
					end
				elseif i > nb then
						-- Dollar at the end of `a_string'.
						-- Leave it as it is.
					Result.append_character ('$')
				else
					c := a_string.item (i)
					if c = '$' then
							-- Escaped dollar character.
						Result.append_character ('$')
						i := i + 1
					else
							-- Found beginning of a environment variable
							-- It is either ${VAR} or $VAR.
						str := STRING_.new_empty_string (a_string, 5)
						if c = '{' then
								-- Looking for a right brace.
							from
								i := i + 1
								stop := False
							until
								i > nb or stop
							loop
								c := a_string.item (i)
								if c = '}' then
									stop := True
								elseif c /= '%U' then
									str.append_character (c)
								else
									check same_type: str.same_type (a_string) end
									STRING_.append_substring_to_string (str, a_string, i, i)
								end
								i := i + 1
							end
						else
								-- Looking for a non-alphanumeric character
								-- (i.e. [^a-zA-Z0-9_]).
							from
								stop := False
							until
								i > nb or stop
							loop
								c := a_string.item (i)
								inspect c
								when 'a'..'z', 'A'..'Z', '0'..'9', '_' then
									str.append_character (c)
									i := i + 1
								else
									stop := True
								end
							end
						end
						value := execution_environment.variable_value (str)
						if STRING_.same_string (str, "ISE_EIFFEL") and value = Void then
							create eiffel_compiler.make
							if eiffel_compiler.is_ise_eiffel_installed then
								value := eiffel_compiler.ise_eiffel_path
							end
						end
						if value /= Void then
							Result := STRING_.appended_string (Result, value)
						end
					end
				end
			end
		ensure
			interpreted_string_not_void: Result /= Void
		end

	last_error: BOOLEAN
			-- Did an error happen?

	copy_recursive (a_source_directory_name, a_target_directory_name: READABLE_STRING_GENERAL)
			-- Copy `a_source_directory_name' to `a_target_directory_name' recursively.
			-- Directories named "CVS" and ".svn" will not be copied.
		require
			a_source_directory_name_not_void: a_source_directory_name /= Void
			a_target_directory_name_not_void: a_target_directory_name /= Void
		local
			source_directory: DIRECTORY
			sub_directory: DIRECTORY
			entry_name: STRING_32
			full_entry_name, target_full_entry_name: PATH
			dirname: PATH
			u: FILE_UTILITIES
		do
			create dirname.make_from_string (a_target_directory_name)
			create sub_directory.make_with_path (dirname)
			if not sub_directory.exists then
				sub_directory.create_dir
				if not sub_directory.is_closed then
					sub_directory.close
				end
			end
			create dirname.make_from_string (a_source_directory_name)
			create source_directory.make_with_path (dirname)
			if source_directory.exists then
				source_directory.open_read
				if not source_directory.is_closed then
					from
						source_directory.start
						source_directory.readentry
					until
						source_directory.last_entry_32 = Void
					loop
						entry_name := source_directory.last_entry_32
						if not entry_name.same_string_general (".") and not entry_name.same_string_general ("..") then
							create full_entry_name.make_from_string (a_source_directory_name)
							full_entry_name := full_entry_name.extended (entry_name)
							create target_full_entry_name.make_from_string (a_target_directory_name)
							target_full_entry_name := target_full_entry_name.extended (entry_name)
							create sub_directory.make_with_path (full_entry_name)
							if sub_directory.exists then
								-- We have a directory entry
								if not (equal (entry_name, "CVS") or equal (entry_name, ".svn")) then
									create sub_directory.make_with_path (target_full_entry_name)
									if not sub_directory.exists then
										sub_directory.create_dir
									end
									if not sub_directory.is_closed then
										sub_directory.close
									end
									copy_recursive (full_entry_name.name, target_full_entry_name.name)
								end
							else
									-- We have a file entry
								u.copy_file_path (full_entry_name, target_full_entry_name)
							end
						end
						source_directory.readentry
					end
					source_directory.close
				end
			end
		end

note
	copyright: "Copyright (c) 1984-2019, Eiffel Software"
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
