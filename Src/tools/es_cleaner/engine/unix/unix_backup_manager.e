note
	description: "[
		A unix-specific implementation of a backup manager, used to backup and restore configurations.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$date$";
	revision: "$revision$"

class
	UNIX_BACKUP_MANAGER

inherit
	BACKUP_MANAGER
		redefine
			path_provider
		end

create
	make

feature {NONE} -- Access

	path_provider: UNIX_PATH_PROVIDER
			-- Access to Eiffel related paths
		do
			Result ?= package.path_provider
		end

feature {NONE} -- Access

	backup_preferences_time_stamp: INTEGER_32
			-- Backup timestamp for preferences
		do
				--| TODO
			check False end
		end

feature  -- Basic operations

	backup_preferences
			-- Backs up preferences configuration file(s)
		do
				--| TODO
			check False end
		end

	restore_preferences
			-- Restores from a back up the preferences configuration file(s).
		do
				--| TODO
			check False end
		end

feature -- Query

	does_backup_preferences_exist: BOOLEAN
			-- Determines if the backed up preferences data exists
		do
				--| TODO
			check False end
		end

;note
	copyright:	"Copyright (c) 1984-2007, Eiffel Software"
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
