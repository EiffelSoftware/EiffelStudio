note
	description: "Abstract representation of a file system location."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	CONF_LOCATION

inherit
	CONF_VALIDITY
		redefine
			is_equal
		end

	KL_SHARED_OPERATING_SYSTEM
		export
			{NONE} all
		redefine
			is_equal
		end

	KL_SHARED_FILE_SYSTEM
		export
			{NONE} all
		redefine
			is_equal
		end

	SHARED_EXECUTION_ENVIRONMENT
		redefine
			is_equal
		end

	SHARED_CONF_SETTING
		undefine
			is_equal
		end

	EIFFEL_LAYOUT
		undefine
			is_equal
		end

feature -- Access, stored in configuration file

	original_path: READABLE_STRING_32
			-- Path without resolved variables and parent cluster path.
			-- Directory separators are always using the Windows one, i.e. '\'.

feature -- Access queries

	original_file: STRING_32
			-- The file part of `original_path'.
		local
			cnt, i: INTEGER
			f: detachable like original_file
		do
			cnt := original_path.count
			if cnt > 0 then
				i := original_path.last_index_of ('\', cnt)
				if i /= cnt then
					f := original_path.substring (i + 1, cnt)
				end
			end
			if f = Void then
				create Result.make_empty
			else
				Result := f
			end
		ensure
			Result_not_void: Result /= Void
		end

	evaluated_path: PATH
			-- The fully resolved path with file name.
		do
			Result := evaluated_path_relative_to_location (target.library_root)
		ensure
			Result_not_void: Result /= Void
		end

	evaluated_path_relative_to_location (a_root_location: PATH): PATH
			-- The fully resolved path with file name relative to directory `a_root_location`.
		local
			i, j, k: INTEGER
			l_old_i: INTEGER
			l_key: detachable like original_path
			l_value: detachable READABLE_STRING_32
			l_relative_base: like original_path
			l_offset: INTEGER
			l_stop: BOOLEAN
			l_result: STRING_32
		do
			create l_result.make_from_string (original_path)

				-- Replace $| with parent path
			if
				attached parent as l_parent and then
				l_result.count >= 2 and then l_result.item (1) = '$' and then l_result.item (2) = '|'
			then
				l_relative_base := l_parent.evaluated_path.name
				l_result.replace_substring (l_relative_base, 1, 2)
				l_result.insert_character ('\', l_relative_base.count + 1)
			end

				-- Replace $ABC and ${ABC} with user defined or environment variables
			from
				l_offset := 1
				i := l_result.index_of ('$', l_offset)
			until
				i = 0 or l_stop
			loop
				l_key := Void
				l_old_i := i

					-- in each loop we decrease the number of $ by 1, except if it is a $(ABC), then we increase the offset
				if i /= 0 and then l_result.item (i+1) = '{' then
					j := l_result.index_of ('}', i)
					if j /= 0 and j > i+2 then
						l_key := l_result.substring (i+2, j-1)
					end
				elseif i /= 0 and then l_result.item (i+1) = '(' then
					l_offset := l_result.index_of (')', i) + 2
				elseif i /= 0 then
					j := l_result.index_of (' ', i) - 1
					k := l_result.index_of ('\', i) - 1
					if j < i then
						j := l_result.count
					end
					if k > i then
						j := j.min (k)
					end
					l_key := l_result.substring (i+1, j)
				end

				if l_key /= Void then
					l_value := target.variables.item (l_key.as_lower)
					if l_value = Void then
						l_value := execution_environment.item (l_key)
						if l_value = Void and is_eiffel_layout_defined then
							l_value := eiffel_layout.get_environment_32 (l_key)
						end
						if l_value = Void then
							l_value := once {STRING_32} ""
						end
							-- we don't want to update stored values, this is done when the project is loaded
						target.record_environ_variable (l_value, l_key)
					end
					l_result.replace_substring (to_internal_format (l_value), i, j)
				end

				i := l_result.index_of ('$', l_offset)
				if i > 0 then
						-- Check if last variable was extracted correctly
					l_stop := l_old_i = i
				end
			end

				-- Handle mapping (iron, ...)
			if attached conf_location_mapper.mapped_path (l_result) as l_mapping then
				l_result := l_mapping
			end

				-- Handle file incasesensitivity under windows
			if operating_system.is_windows then
				l_result.to_lower
			else
					-- The above computation is done using the internal format which is using `\' as
					-- directory separator, so we need to convert those to `/' for Unix.
				update_path_to_unix (l_result)
			end
			create Result.make_from_string (l_result)

				-- Handle relative path
			if Result.is_relative then
				Result :=
					(if Result.is_empty then
						a_root_location
					else
						a_root_location.extended_path (Result)
					end).canonical_path
			end
		ensure
			Result_not_void: Result /= Void
		end

	evaluated_directory: PATH
			-- The directory part of `evaluated_path'.
		do
			Result := evaluated_path
		ensure
			Result_not_void: Result /= Void
		end

	evaluated_file: STRING_32
			-- The file part of `evaluated_path'.
		do
			if attached evaluated_path.entry as l_entry then
				create Result.make_from_string (l_entry.name)
			else
				check path_has_entry: False end
					-- Unknown file name from path `evaluated_path.name' !
				Result := {STRING_32} "Unknown file name from " + evaluated_path.name
			end
		ensure
			Result_not_void: Result /= Void
		end

	directory_separator: CHARACTER
			-- The directory separator for the curren platform.
		do
			if operating_system.is_windows then
				Result := windows_file_system.directory_separator
			else
				Result := unix_file_system.directory_separator
			end
		end

	build_path (a_directory, a_file: READABLE_STRING_32): like evaluated_path
			-- Add `a_directory' and `a_filename' to current directory.
			-- `a_directory' can be in any format.
		require
			a_directory_not_void: a_directory /= Void
			a_file_not_void: a_file /= Void
		deferred
		ensure
			Result_not_void: Result /= Void
		end

feature {CONF_ACCESS} -- Update, stored in configuration file

	set_parent (a_parent: like parent)
			-- Set `parent' to `a_parent'.
		do
			parent := a_parent
		ensure
			parent_set: parent = a_parent
		end

	set_target (a_target: like target)
			-- Set `target' to `a_target'
		require
			a_target_not_void: a_target /= Void
		do
			target := a_target
		ensure
			target_set: target = a_target
		end

feature -- Comparison

	is_equal (other: like Current): BOOLEAN
			-- Is it the same location as `other'?
		do
			Result := equal (original_path, other.original_path)
		end

feature {CONF_ERROR} -- Implementation, attributes stored in configuration file

	parent: detachable CONF_LOCATION
			-- The path of the parent directory (if any).

	target: CONF_TARGET
			-- The target where we can get our variable settings.

feature {NONE} -- Implementation

	to_internal_format (a_path: READABLE_STRING_GENERAL): STRING_32
			-- Convert `a_path' into the internal representation.
			--| The internal format uses the windows format for directory separator.
		require
			a_path_not_void: a_path /= Void
		do
			create Result.make_from_string_general (a_path)

				-- Remove white spaces if any.
			Result.left_adjust
			Result.right_adjust

				-- Internally we always save using Windows file separator.
			Result.replace_substring_all ({STRING_32} "/", {STRING_32} "\")

				-- Convert all $\ ($/ was converted into $\) at the beginning into $| because
				-- internally we only accept this as indicator for the parent path.
			if Result.count >= 2 and then Result.item (1) = '$' and then Result.item (2) = '\' then
				Result.put ('|', 2)
			end
		end

	update_path_to_unix (a_path: STRING_32)
			-- Update `a_path' to Unix by changing all windows separator to Unix one.
		require
			a_path_not_void: a_path /= Void
		do
			a_path.replace_substring_all ({STRING_32} "\", {STRING_32} "/")
		ensure
			a_path_has_not_windows_separator: not a_path.has ('\')
		end

invariant
	original_path_not_void: original_path /= Void
	target_not_void: target /= Void

note
	copyright:	"Copyright (c) 1984-2021, Eiffel Software"
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
end
