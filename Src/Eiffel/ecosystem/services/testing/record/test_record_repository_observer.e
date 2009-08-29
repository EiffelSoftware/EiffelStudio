note
	description: "[
		Observer for events in {TEST_RECORD_REPOSITORY_I}.
	]"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	TEST_RECORD_REPOSITORY_OBSERVER

inherit
	EVENT_OBSERVER_I

feature {TEST_RECORD_REPOSITORY_I} -- Events

	on_record_added (a_repo: TEST_RECORD_REPOSITORY_I; a_record: TEST_SESSION_RECORD)
			-- Called when a record is added to a repository.
			--
			-- `a_repo': Repository containing new result.
			-- `a_record': Record which was added to `a_repo'.
		require
			a_repo_attached: a_repo /= Void
			a_record_attached: a_record /= Void
			a_repo_usable: a_repo.is_interface_usable
			a_repo_has_record: a_repo.has_record (a_record)
		do
		ensure
			a_repo_usable: a_repo.is_interface_usable
			a_repo_has_result: a_repo.has_record (a_record)
		end

	on_record_updated (a_repo: TEST_RECORD_REPOSITORY_I; a_record: TEST_SESSION_RECORD)
			-- Called when a record was updated in the repository.
			--
			-- `a_repo': Repository containing record.
			-- `a_record': Record which was updated.
		require
			a_repo_attached: a_repo /= Void
			a_record_attached: a_record /= Void
			a_repo_usable: a_repo.is_interface_usable
			a_repo_has_record: a_repo.has_record (a_record)
		do
		ensure
			a_repo_has_record: a_repo.has_record (a_record)
		end

	on_record_removed (a_repo: TEST_RECORD_REPOSITORY_I; a_record: TEST_SESSION_RECORD)
			-- Called after a record was removed from a repository.
			--
			-- `a_repo': Repository that contained result.
			-- `a_record': Record which was removed from `a_repo'.
		require
			a_repo_attached: a_repo /= Void
			a_record_attached: a_record /= Void
			a_repo_usable: a_repo.is_interface_usable
			not_a_repo_has_record: not a_repo.has_record (a_record)
		do
		ensure
			a_repo_usable: a_repo.is_interface_usable
			not_a_repo_has_record: not a_repo.has_record (a_record)
		end

	on_record_property_updated(a_repo: TEST_RECORD_REPOSITORY_I; a_record: TEST_SESSION_RECORD)
			-- Called after a property of a record was changed.
			--
			-- Note: a property is considered any record dependent query in `a_repo'.
			--
			-- `a_repo': Repository that contained result.
			-- `a_record': Record for which a property of `a_repo' was changed.
		require
			a_repo_attached: a_repo /= Void
			a_record_attached: a_record /= Void
			a_repo_usable: a_repo.is_interface_usable
			a_repo_has_record: a_repo.has_record (a_record)
		do
		ensure
			a_repo_usable: a_repo.is_interface_usable
			a_repo_has_result: a_repo.has_record (a_record)
		end

note
	copyright: "Copyright (c) 1984-2009, Eiffel Software"
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
