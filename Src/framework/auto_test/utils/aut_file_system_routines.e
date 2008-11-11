indexing
	description: "File system routines"
	author: "Andreas Leitner"
	date: "$Date$"
	revision: "$Revision$"

class AUT_FILE_SYSTEM_ROUTINES

inherit

	UT_SHARED_TEMPLATE_EXPANDER
		export {NONE} all end

	KL_SHARED_EXECUTION_ENVIRONMENT
		export {NONE} all end

	KL_SHARED_FILE_SYSTEM
		export {NONE} all end

	KL_IMPORTED_STRING_ROUTINES
		export {NONE} all end

create {AUT_SHARED_FILE_SYSTEM_ROUTINES}

	make

feature {NONE} -- Initialization

	make is
		do
		end

feature -- Basic routines

	interpreted_pathname (a_base_directory: STRING; a_pathname: STRING): STRING is
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

	absolute_parent_directory_of_filename (a_filename: STRING): STRING is
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

	interpreted_string (a_string: STRING): STRING is
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

	copy_recursive (a_source_directory_name: STRING; a_target_directory_name: STRING) is
			-- Copy `a_source_directory_name' to `a_target_directory_name' recursively.
			-- Directories named "CVS" and ".svn" will not be copied.
			-- TODO: Rewrite to use Gobo classes.
		require
			a_source_directory_name_not_void: a_source_directory_name /= Void
			a_target_directory_name_not_void: a_target_directory_name /= Void
		local
			source_directory: DIRECTORY
			sub_directory: DIRECTORY
			file: RAW_FILE
			entry_name: STRING
			full_entry_name: STRING
			target_full_entry_name: STRING
			dirname: DIRECTORY_NAME
		do
			create dirname.make_from_string (a_target_directory_name)
			create sub_directory.make (dirname)
			if not sub_directory.exists then
				sub_directory.create_dir
				if not sub_directory.is_closed then
					sub_directory.close
				end
			end
			create dirname.make_from_string (a_source_directory_name)
			create source_directory.make (dirname)
			if source_directory.exists then
				source_directory.open_read
				if not source_directory.is_closed then
					from
						source_directory.start
						source_directory.readentry
					until
						source_directory.lastentry = Void
					loop
						entry_name := source_directory.lastentry
						if
							not equal (entry_name, ".") and
								not equal (entry_name, "..")
						then
							full_entry_name := file_system.pathname (a_source_directory_name, entry_name)
							target_full_entry_name := file_system.pathname (a_target_directory_name, entry_name)
							create sub_directory.make (full_entry_name)
							if sub_directory.exists then
								-- We have a directory entry
								if not (equal (entry_name, "CVS") or equal (entry_name, ".svn")) then
									create sub_directory.make (target_full_entry_name)
									if not sub_directory.exists then
										sub_directory.create_dir
									end
									if not sub_directory.is_closed then
										sub_directory.close
									end
									copy_recursive (create {DIRECTORY_NAME}.make_from_string (full_entry_name),
														 create {DIRECTORY_NAME}.make_from_string (target_full_entry_name))
								end
							else
								-- We have a file entry
								create file.make_open_read (full_entry_name)
								if not file.is_closed then
									file.close
									file_system.copy_file (full_entry_name,
																  target_full_entry_name)
								end
							end
						end
						source_directory.readentry
					end
					source_directory.close
				end
			end
		end

	recursive_create_directory (a_directory_name: STRING) is
			-- Create `a_directory_name' physically if it doesn't exist
			-- and the permissions allow to do so.
			-- Don't throw an exception if the parent directory doesn't exist.
		require
			a_directory_name_is_valid: (create {DIRECTORY_NAME}.make_from_string (a_directory_name)).is_valid
		local
			dir: DIRECTORY
			parent_dir_name: STRING
		do
			create dir.make (a_directory_name)
			parent_dir_name := file_system.dirname (a_directory_name)
			if not dir.exists and not equal (a_directory_name, parent_dir_name) then
				recursive_create_directory (parent_dir_name)
				if (create {DIRECTORY}.make (parent_dir_name)).exists then
					dir.create_dir
				end
			end
		end

end
