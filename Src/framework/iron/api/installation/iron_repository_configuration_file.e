note
	date: "$Date$"
	revision: "$Revision$"

class
	IRON_REPOSITORY_CONFIGURATION_FILE

inherit
	IRON_EXPORTER

create
	make

feature {NONE} -- Initialization

	make (fn: PATH)
		local
			s: STRING_8
			f: RAW_FILE
			fac: IRON_REPOSITORY_FACTORY
		do
			path := fn
			create repositories.make (1)
			create f.make_with_path (fn)
			if f.exists and then f.is_access_readable then
				f.open_read
				from
					create fac
				until
					f.exhausted or f.end_of_file
				loop
					f.read_line_thread_aware
					s := f.last_string
					s.left_adjust
					s.right_adjust
					if s.is_empty then
							-- ignore
					elseif s[1] = '#' then
							-- ignore commented line for now
					else
						if attached fac.new_repository (s) as repo then
							if not has_repository (repo) then
								add_repository (repo)
							end
						else
							check valid_repo_location: False end
						end
					end
				end
				f.close
			end
		end

	path: PATH

feature -- Access

	repositories: ARRAYED_LIST [IRON_REPOSITORY]

feature -- Status

	has_repository (repo: IRON_REPOSITORY): BOOLEAN
			-- Has repository `repo` registered?
		do
			across
				repositories as ic
			until
				Result
			loop
				Result := ic.is_same_repository (repo)
			end
		end

	has_repository_by_uri (a_uri: READABLE_STRING_GENERAL): BOOLEAN
			-- Has repository associated with location `a_uri` ?
		do
			across
				repositories as ic
			until
				Result
			loop
				Result := a_uri.same_string (ic.location_string)
			end
		end

feature -- Change

	add_repository (a_repo: IRON_REPOSITORY)
		require
			repository_not_registered: not has_repository (a_repo)
		do
			repositories.force (a_repo)
		end

	remove_repository (a_repo: IRON_REPOSITORY)
		local
			reps: like repositories
		do
			from
				reps := repositories
				reps.start
			until
				reps.after
			loop
				if reps.item.is_same_repository (a_repo) then
					reps.remove
				else
					reps.forth
				end
			end
		end

	remove_repository_by_uri (a_uri: READABLE_STRING_GENERAL)
		local
			reps: like repositories
		do
			from
				reps := repositories
				reps.start
			until
				reps.after
			loop
				if reps.item.location_string.same_string_general (a_uri) then
					reps.remove
				else
					reps.forth
				end
			end
		end

feature -- Operation

	save
		do
			save_to (path)
		end

	save_to (fn: PATH)
		local
			f: RAW_FILE
		do
			create f.make_with_path (fn)
			if not f.exists or else f.is_writable then
				f.create_read_write
				f.put_string ("# List of iron repositories%N")
				f.put_string ("#%N# note: order is important to resolve name conflicts%N# (a repository has priority over the following ones).%N")
				f.put_new_line
				across
					repositories as ic
				loop
					f.put_string (ic.location_string)
					f.put_new_line
				end
				f.close
			end
		end

note
	copyright: "Copyright (c) 1984-2023, Eiffel Software"
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
