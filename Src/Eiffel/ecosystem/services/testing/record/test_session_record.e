note
	description: "[
		Objects representing results from running a {TEST_SESSION_I}.
	]"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	TEST_SESSION_RECORD

inherit
	COMPARABLE

create
	make

feature {NONE} -- Initialization

	make (a_session: like session)
			-- Initialize `Current'.
		do
			create creation_date.make_now
			internal_session := a_session
		ensure
			running: is_running
			session_set: session = a_session
		end

feature -- Access

	creation_date: DATE_TIME
			-- Date when `Current' was created

	frozen repository: TEST_RECORD_REPOSITORY_I
			-- Repository containing `Current'
		require
			is_attached: is_attached
		local
			l_repo: like internal_repository
		do
			l_repo := internal_repository
			check l_repo /= Void end
			Result := l_repo
		ensure
			result_usable: Result.is_interface_usable
			result_contains_current: Result.has_record (Current)
		end

	frozen session: TEST_SESSION_I
			-- Session which adds information to `Current'
		require
			running: is_running
		local
			l_session: like internal_session
		do
			l_session := internal_session
			check l_session /= Void end
			Result := l_session
		end

feature {NONE} -- Access

	frozen internal_repository: detachable like repository
			-- Internal storage for `repository'.
			--
			-- Note: transient attribute so repository is not stored to disk.
		note
			option: transient
		attribute
		end

	frozen internal_session: detachable TEST_SESSION_I
			-- Internal storage for `session'
			--
			-- Note: transient attribute so session is not stored to disk.
		note
			option: transient
		attribute
		end

feature -- Status report

	frozen is_attached: BOOLEAN
			-- Has `Current' been added to a repository?
			--
			-- Note: this does not imply that the repository still contains `Current'.
		do
			Result := attached internal_repository as l_repo and then l_repo.is_interface_usable
		end

	frozen is_running: BOOLEAN
			-- Is `Current' still being updated by a session?
		do
			Result := internal_session /= Void
		end

feature {TEST_RECORD_REPOSITORY_I} -- Status setting

	attach_repository (a_repo: like repository)
			-- Attach `Current' to repository.
		require
			not_attached: not is_attached
		do
			internal_repository := a_repo
		end

	detach_repository
			-- Detach `Current' from repository.
		require
			is_attached: is_attached
		do
			internal_repository := Void
		end

feature {TEST_SESSION_I} -- Status setting

	complete
			-- Detach `session' and notify `repository'.
		require
			running: is_running
		do
			internal_session := Void
			if is_attached then
				repository.report_record_completion (Current)
			end
		end

feature -- Query

	is_less alias "<" (other: TEST_SESSION_RECORD): BOOLEAN
			-- <Precursor>
		do
			Result := creation_date < other.creation_date
		end

invariant
	create_date_attached: creation_date /= Void

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
