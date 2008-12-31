note
	description: "[
		An interface for concrete backup manager implementations, used to backup and restore configuration data.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$date$";
	revision: "$revision$"

deferred class
	I_BACKUP_MANAGER

feature -- Access

	last_backup_date_stamp: INTEGER
			-- Last back up date, in ticks
		require
			is_restore_data_available: is_restore_data_available
		deferred
		ensure
			result_positive: Result > 0
		end

feature -- Basic operations

	backup (a_config: I_BACKUP_CONFIG)
			-- Backs up configuration files base on user settings.
		require
			a_config_attached: a_config /= Void
			a_config_can_clean: a_config.can_any_processing_occur
		deferred
		end

	restore (a_config: I_BACKUP_CONFIG)
			-- Restores from a back up, if available, configuration files base on user settings.
		require
			a_config_attached: a_config /= Void
			a_config_can_clean: a_config.can_any_processing_occur
			is_restore_data_available: is_restore_data_available
		deferred
		end

feature -- Status report

	is_restore_data_available: BOOLEAN
			-- Determines if the any restore data is available
		deferred
		end

	is_config_restore_data_available (a_config: I_BACKUP_CONFIG): BOOLEAN
			-- Determines if the any restore data is available based on `a_config'
		require
			a_config_attached: a_config /= Void
			a_config_can_clean: a_config.can_any_processing_occur
		deferred
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
