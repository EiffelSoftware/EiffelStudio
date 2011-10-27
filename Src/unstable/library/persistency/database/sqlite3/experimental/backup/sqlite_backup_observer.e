note
	description: "[

	]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	SQLITE_BACKUP_OBSERVER

feature {NONE} -- Handlers

	on_backup_started (a_backup: SQLITE_BACKUP; a_pages: NATURAL)
			-- Called when a backup is started.
			--
			-- `a_backup': A database backup processor issuing the event.
			-- `a_pages': The number of pages in the source database to back up (in total)
		do

		end

	on_backup_step (a_backup: SQLITE_BACKUP; a_remaining_pages: NATURAL)
			-- Called when progress has been made on the back up and there is still more remaining to
			-- process.
			--
			-- `a_backup': A database backup processor issuing the event.
			-- `a_remaining_pages': The number of pages remaining to process.
		require
			a_remaining_pages_positive: a_remaining_pages > 0
		do

		end

	on_backup_finished (a_backup: SQLITE_BACKUP)
			-- Called when a backup has finished, regardless of any error.
			--
			-- `a_backup': A database backup processor issuing the event.
		do

		end

	on_backup_aborted (a_backup: SQLITE_BACKUP)
			-- Called when a backup has finished, due to abortion or another error.
			--
			-- `a_backup': A database backup processor issuing the event.
		do

		end


;note
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
