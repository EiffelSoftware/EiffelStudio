note
	description: "[
		Helper class for files.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	FILE_HELPERS

feature -- Query

	safe_file_name (a_file_name: READABLE_STRING_8): STRING
			-- Generates a safe suffixed file name from an original file name.
			--
			-- `a_file_name': An original file name to suffix.
			-- `Result': A safe suffixed file name.
		require
			a_file_name_attached: a_file_name /= Void
			not_a_file_name_is_empty: not a_file_name.is_empty
		local
			l_ext: detachable READABLE_STRING_8
			nb: INTEGER
			i: INTEGER
		do
			nb := a_file_name.count
			create Result.make (nb + safe_file_name_suffix.count)
			i := a_file_name.last_index_of ('.', nb)
			if i = 0 then
				i := nb
			end
			if i > safe_file_name_suffix.count then
				l_ext := a_file_name.substring ((i - safe_file_name_suffix.count), i - 1)
			end
			if l_ext = Void or else not l_ext.is_case_insensitive_equal (safe_file_name_suffix) then
					-- Even on *nix compare case insensitive because a safe extension is a safe extension.
				if i < nb  then
					Result.append (a_file_name.substring (1, i - 1))
					Result.append (safe_file_name_suffix)
					Result.append (a_file_name.substring (i, nb))
				else
					Result.append (a_file_name)
					Result.append (safe_file_name_suffix)
				end
			else
				Result.append (a_file_name)
			end
		ensure
			result_attached: Result /= Void
			not_a_result_is_empty: not Result.is_empty
		end

	unsafe_file_name (a_file_name: READABLE_STRING_8): STRING
			-- Generates a unsafe suffixed file name from an original file name.
			--
			-- `a_file_name': An original file name to unsuffix.
			-- `Result': A unsafe file name.
		require
			a_file_name_attached: a_file_name /= Void
			not_a_file_name_is_empty: not a_file_name.is_empty
		local
			l_ext: detachable READABLE_STRING_8
			nb: INTEGER
			i: INTEGER
		do
			nb := a_file_name.count
			create Result.make (nb + safe_file_name_suffix.count)
			i := a_file_name.last_index_of ('.', nb)
			if i = 0 then
				i := nb
			end
			if i > safe_file_name_suffix.count then
				l_ext := a_file_name.substring ((i - safe_file_name_suffix.count), i - 1)
			end
			if l_ext /= Void and then l_ext.is_case_insensitive_equal (safe_file_name_suffix) then
					-- Even on *nix compare case insensitive because a safe extension is a safe extension.
				if i < nb  then
					Result.append (a_file_name.substring (1, i - safe_file_name_suffix.count - 1))
					Result.append (a_file_name.substring (i, nb))
				end
			else
				Result.append (a_file_name)
			end
		ensure
			result_attached: Result /= Void
			not_a_result_is_empty: not Result.is_empty
		end

	license_file_name (a_file_name: READABLE_STRING_8): STRING
			-- Generates a license file name from a configuration file name.
			--
			-- `a_file_name': An original file name create a license file name from.
			-- `Result': A license file name.
		require
			a_file_name_attached: a_file_name /= Void
			not_a_file_name_is_empty: not a_file_name.is_empty
		local
			l_ext: detachable READABLE_STRING_8
			nb: INTEGER
			i: INTEGER
		do
			nb := a_file_name.count
			create Result.make_from_string (a_file_name)
			i := a_file_name.last_index_of ('.', nb)
			if i = 0 then
				i := nb
			end
			if i > license_extension.count then
				l_ext := a_file_name.substring ((i - license_extension.count), i - 1)
			end
			if l_ext = Void or else l_ext /~ license_extension then
				if i < nb  then
					Result.keep_head (i)
				else
					Result.append_character ('.')
				end
				Result.append (license_extension)
			end
		ensure
			result_attached: Result /= Void
			not_a_result_is_empty: not Result.is_empty
		end


feature {NONE} -- Constants

	safe_file_name_suffix: STRING = "-safe"
	license_extension: STRING = "lic"

;note
	copyright:	"Copyright (c) 1984-2009, Eiffel Software"
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
