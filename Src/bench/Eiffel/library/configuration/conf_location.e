indexing
	description: "Objects that represent a directory location."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	CONF_LOCATION

inherit
	ANY
		redefine
			is_equal
		end

	CONF_VALIDITY
		undefine
			is_equal
		end

	KL_SHARED_OPERATING_SYSTEM
		export
			{NONE} all
		undefine
			is_equal
		end

	KL_SHARED_FILE_SYSTEM
		export
			{NONE} all
		undefine
			is_equal
		end

	KL_SHARED_EXECUTION_ENVIRONMENT
		export
			{NONE} all
		undefine
			is_equal
		end

create
	make_from_path,
	make_from_full_path

feature {NONE} -- Initialization

	make_from_path (a_path: STRING; a_target: CONF_TARGET) is
			-- Create with `a_path' (without a filename).
			-- e.g. aa/bb/cc =>
			-- directory = aa/bb/cc
			-- file =
		require
			a_path_not_void: a_path /= Void
			a_target_not_void: a_target /= Void
		do
			set_path (a_path)
			target := a_target
		ensure
			target_set: target = a_target
		end

	make_from_full_path (a_full_path: STRING; a_target: CONF_TARGET) is
			-- Create with `a_full_path' (with a filename).
			-- e.g. aa/bb/cc =>
			-- directory = aa/bb
			-- file = cc
		require
			a_full_path_not_void: a_full_path /= Void
			a_target_not_void: a_target /= Void
		do
			set_full_path (a_full_path)
			target := a_target
		ensure
			target_set: target = a_target
		end


feature -- Access, stored in configuration file

	original_path: STRING
			-- Path without resolved variables and parent cluster path.

feature -- Access queries

	original_directory: STRING is
			-- The directory part of `original_path' (without trailing '\').
		do
			Result := directory (original_path)
		ensure
			Result_not_void: Result /= Void
		end

	original_file: STRING is
			-- The file part of `original_path'.
		do
			Result := file (original_path)
		ensure
			Result_not_void: Result /= Void
		end

	evaluated_path: STRING is
			-- The fully resolved path without file name.
		do
			Result := file_system.pathname_from_file_system (internal_evaluated_path, windows_file_system)
		ensure
			Result_not_void: Result /= Void
		end

	evaluated_directory: STRING is
			-- The directory part of `evaluated_path' (without trailing '\' or '/').
		do
			Result := file_system.pathname_from_file_system(directory (internal_evaluated_path), windows_file_system)
		ensure
			Result_not_void: Result /= Void
		end

	evaluated_file: STRING is
			-- The file part of `evaluated_path'.
		do
			Result := file (internal_evaluated_path)
		ensure
			Result_not_void: Result /= Void
		end

	directory_separator: CHARACTER is
			-- The directory separator for the curren platform.
		do
			if operating_system.is_windows then
				Result := windows_file_system.directory_separator
			else
				Result := unix_file_system.directory_separator
			end
		end

	build_path (a_directory, a_file: STRING): STRING is
			-- Add directories and filename to current directory.
			-- `a_directory' can be in any format.
		require
			a_directory_not_void: a_directory /= Void
			a_file_not_void: a_file /= Void
		local
			l_dir: STRING
		do
			Result := evaluated_directory
			if not a_directory.is_empty then
				l_dir := windows_file_system.pathname_from_file_system (a_directory, unix_file_system)
				if l_dir.item (1) /= '\' then
					l_dir.prepend_character ('\')
				end
			else
				create l_dir.make_empty
			end
			if a_file.is_empty and not l_dir.is_empty and then l_dir.item (l_dir.count) = '\' then
				l_dir.remove_tail (1)
			end
			if not a_file.is_empty then
				l_dir.append ("\"+a_file)
			end
			l_dir := file_system.pathname_from_file_system (l_dir, windows_file_system)
			Result.append (l_dir)
		ensure
			Result_not_void: Result /= Void
		end


feature {CONF_ACCESS} -- Update, stored in configuration file

	set_path (a_path: like original_path) is
			-- Set `original_path' to `a_path'.
			-- e.g. aa/bb/cc =>
			-- directory = aa/bb/cc
			-- file =
		require
			a_path_not_void: a_path /= Void
		do
			original_path := to_internal (a_path)
			if original_path.item (original_path.count) /= '\' then
				original_path.append_character ('\')
			end
		end

	set_full_path (a_path: STRING) is
			-- Set `original_path' to `a_path'.
			-- e.g. aa/bb/cc =>
			-- directory = aa/bb
			-- file = cc
		require
			a_path_not_void: a_path /= Void
		do
			original_path := to_internal (a_path)
		end

	set_parent (a_parent: like parent) is
			-- Set `parent' to `a_parent'.
		do
			parent := a_parent
		ensure
			parent_set: parent = a_parent
		end

	set_target (a_target: like target) is
			-- Set `target' to `a_target'
		require
			a_target_not_void: a_target /= Void
		do
			target := a_target
		ensure
			target_set: target = a_target
		end

feature -- Comparison

	is_equal (other: like Current): BOOLEAN is
			-- Is it the same location as `other'?
		do
			Result := equal (original_path, other.original_path)
		end

feature {NONE} -- Implementation, attributes stored in configuration file

	parent: CONF_LOCATION
			-- The path of the parent directory (if any).

	target: CONF_TARGET
			-- The target where we can get our variable settings.

feature {NONE} -- Implementation

	--| The internal format uses the windows format (because we would otherwise loos the drive letter)
	--| directories are always terminated by a \

	to_internal (a_path: STRING): STRING is
			-- Convert `a_path' into the internal representation.
		require
			a_path_not_void: a_path /= Void
		do
				-- always works, even if a_path is already in windows file format
			Result := windows_file_system.pathname_from_file_system (a_path, unix_file_system)

				-- convert $\ ($/ was converted into $\) at the beginning into $| because
				-- internally we only accept this as indicator for the parent path.
			if Result.count >= 2 and then Result.item (1) = '$' then
				if Result.item (2) = '\' or Result.item (2) = '/' then
					Result.put ('|', 2)
				end
			end
		end


	internal_evaluated_path: STRING is
			-- The fully resolved path with file name in internal format.
		local
			i, j, k: INTEGER
			l_key: STRING
			l_value: STRING
			l_relative_base: STRING
			l_offset: INTEGER
		do
			Result := original_path.twin

				-- replace $| with parent path
			if parent /= Void then
				if Result.count >= 2 and then Result.item (1) = '$' and then Result.item (2) = '|' then
					Result.replace_substring (parent.evaluated_directory+"\", 1, 2)
				end
			end

				-- replace $ABC and ${ABC} with user defined or environment variables
			from
				l_offset := 1
				i := Result.index_of ('$', l_offset)
			until
				i = 0
			loop
					-- in each loop we decrease the number of $ by 1, except if it is a $(ABC), then we increase the offset
				if i /= 0 and then Result.item (i+1) = '{' then
					j := Result.index_of ('}', i)
					if j /= 0 and j > i+2 then
						l_key := Result.substring (i+2, j-1)
					end
				elseif i /= 0 and then Result.item (i+1) = '(' then
					l_offset := Result.index_of (')', i) + 2
				elseif i /= 0 then
					j := Result.index_of (' ', i) - 1
					k := Result.index_of ('\', i) - 1
					if j < i then
						j := Result.count
					end
					if k > i then
						j := j.min (k)
					end
					l_key := Result.substring (i+1, j)
				end

				if l_key /= Void then
					l_value := target.variables.item (l_key.as_lower)
					if l_value = Void then
						l_value := target.environ_variables.item (l_key.as_lower)
						if l_value = Void then
							l_value := execution_environment.variable_value (l_key)
							if l_value = Void then
								l_value := ""
							end
							target.environ_variables.force (l_value, l_key.as_lower)
						end
					end
					Result.replace_substring (to_internal (l_value), i, j)
				end

				i := Result.index_of ('$', l_offset)
			end

				-- handle relative path
			if (Result.count >= 2 and then Result.item (1).is_alpha_numeric and Result.item (2) /= ':') or else Result.item (1) = '.' then
				l_relative_base := target.location
				if l_relative_base /= Void then
					Result.prepend (l_relative_base)
				else
					Result.prepend ("\")
				end
			end
		ensure
			Result_not_void: Result /= Void
		end


	directory (a_path: STRING): STRING is
			-- Get the directory of `a_path' that is in the internal format.
			-- a_path = directory + '\' + path
		require
			a_path_not_void: a_path /= Void
		local
			cnt, i: INTEGER
		do
			cnt := a_path.count
			if cnt > 0 then
				i := a_path.last_index_of ('\', cnt)
				if i /= 0 then
					Result := a_path.substring (1, i-1)
				end
			end
			if Result = Void then
				create Result.make_empty
			end
		ensure
			Result_not_void: Result /= Void
		end

	file (a_path: STRING): STRING is
			-- Get the file of `a_path' that is in the internal format.
			-- a_path = directory + '\' + path
		require
			a_path_not_void: a_path /= Void
		local
			cnt, i: INTEGER
		do
			cnt := a_path.count
			if cnt > 0 then
				i := a_path.last_index_of ('\', cnt)
				if i /= cnt then
					Result := a_path.substring (i+1, cnt)
				end
			end
			if Result = Void then
				create Result.make_empty
			end
		ensure
			Result_not_void: Result /= Void
		end


invariant
	original_path_not_void: original_path /= Void
	target_not_void: target /= Void

indexing
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
