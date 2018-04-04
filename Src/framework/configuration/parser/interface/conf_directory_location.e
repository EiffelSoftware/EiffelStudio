note
	description: "Objects that represent a directory location."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	CONF_DIRECTORY_LOCATION

inherit
	CONF_LOCATION

create
	make

feature {NONE} -- Initialization

	make (a_path: like original_path; a_target: CONF_TARGET)
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

feature -- Access

	build_path (a_directory, a_file: READABLE_STRING_32): like evaluated_path
			-- Add `a_directory' and `a_filename' to current directory.
			-- `a_directory' can be in any format.
		local
			l_dir: STRING_32
		do
			Result := evaluated_path
			if not a_directory.is_empty then
				create l_dir.make_from_string (a_directory)
					-- PATH handles Unix path. This is necessary in the case
					-- `l_dir' contains a windows separator which could not be
					-- understood as a separator on Unix.
				update_path_to_unix (l_dir)
					-- Make sure, it does not start with a slash '/' !
				from until not l_dir.starts_with_general ("/") loop
					l_dir.remove_head (1)
				end
				Result := Result.extended (l_dir)
			end
			if not a_file.is_empty then
				Result := Result.extended (a_file)
			end
		end

feature {CONF_ACCESS} -- Update stored in configuration file.

	set_path (a_path: like original_path)
			-- Set `original_path' to `a_path'.
			-- e.g. aa/bb/cc =>
			-- directory = aa/bb/cc
			-- file =
		require
			a_path_not_void: a_path /= Void
		local
			s: like to_internal_format
		do
			s := to_internal_format (a_path)
			if s.is_empty then
				s.append_character ('.')
			end
			if s[s.count] /= '\' then
				s.append_character ('\')
			end
			original_path := s
		end

note
	copyright:	"Copyright (c) 1984-2018, Eiffel Software"
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
