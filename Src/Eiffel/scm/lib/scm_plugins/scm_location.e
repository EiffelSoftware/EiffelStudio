note
	description: "Summary description for {SCM_LOCATION}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	SCM_LOCATION

feature {NONE} -- Initialization

	make (a_root: PATH)
		do
			location := a_root
		end

feature -- Access

	location: PATH

	location_path_name: STRING_32
		do
			Result := internal_location_path_name
			if Result = Void then
				Result := location.name
				internal_location_path_name := Result
			end
		end

	nature: STRING
		deferred
		end

feature {NONE} -- Internals

	internal_location_path_name: detachable like location_path_name

feature -- Query

	relative_location (a_location: PATH): READABLE_STRING_32
		local
			rn,n: READABLE_STRING_32
			p: PATH
			i:  INTEGER
		do
			rn := location_path_name
			n := a_location.name
			i := n.index_of (a_location.directory_separator, rn.count)
			if i > 0 then
				create p.make_from_string (n.head (i - 1))
			else
				create p.make_from_string (n.head (rn.count))
			end
			if p.same_as (location) then
				if n.same_string (rn) then
					rn := location.parent.name
				end
				Result := n.substring (rn.count + 2, n.count)
			else
				Result := n
			end
		end

feature -- Status report

	same_as (other: SCM_LOCATION): BOOLEAN
		do
			Result := location.same_as (other.location)
		end

feature -- Execution

	changes (a_root_loc, loc: PATH; cfg: SCM_CONFIG): detachable SCM_STATUS_LIST
			-- Related path of changed nodes.
		deferred
		ensure
			not has_error implies Result /= Void
		end

	revert (a_changelist: SCM_CHANGELIST; cfg: SCM_CONFIG): detachable STRING_32
			-- Revert list of locations `a_locations`.
		deferred
		ensure
			not has_error implies Result /= Void
		end

	add (a_changelist: SCM_CHANGELIST; cfg: SCM_CONFIG): detachable STRING_32
			-- Added list of locations `a_locations`.
		deferred
		ensure
			not has_error implies Result /= Void
		end

	delete (a_changelist: SCM_CHANGELIST; cfg: SCM_CONFIG): detachable STRING_32
			-- Added list of locations `a_locations`.
		deferred
		ensure
			not has_error implies Result /= Void
		end

	commit (a_commit_set: SCM_SINGLE_COMMIT_SET; cfg: SCM_CONFIG)
		require
			same_location: same_as (a_commit_set.changelist.root)
			is_ready: a_commit_set.is_ready
		deferred
		ensure
			a_commit_set.is_processed
		end

	diff (a_changelist: SCM_CHANGELIST; cfg: SCM_CONFIG): detachable SCM_DIFF
		require
			same_location: same_as (a_changelist.root)
		deferred
		end

feature -- Error		

	reset_error
		do
			has_error := False
		end

	has_error: BOOLEAN

invariant

note
	copyright: "Copyright (c) 1984-2022, Eiffel Software"
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
