note
	description: "[
		Initialization configuration used during initialization of the SQLite API.
	]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	SQLITE_INITALIZATION_CONFIG

feature -- Access

	api: detachable SQLITE_API assign set_api
			-- The SQLite API the configuration has been applied to.

	threading_mode: INTEGER assign set_threading_mode
			-- Threading mode (single, multi, serialized).
		do
			Result := internal_threading_mode.item
		end

feature -- Element change

	set_api (a_api: like api)
			-- Set the SQLite API the configuration will be applied to.
			--
			-- `a_api': The owning API or Void to orphan.
		require
			a_api_is_interface_usable: attached a_api implies a_api.is_interface_usable
		do
			api := a_api
		ensure
			api_set: api = a_api
		end

	set_threading_mode (a_mode: INTEGER)
			-- Set SQLite's threading accessiblity mode.
		require
			is_config_writable: is_config_writable
			a_mode_is_valid_threading_mode: is_valid_threading_mode (a_mode)
		do
			internal_threading_mode.put (a_mode)
		ensure
			threading_mode_set: threading_mode = a_mode
		end

feature -- Status report

	is_config_writable: BOOLEAN
			-- Indicates if the configuration is writable.
			-- Configurations are no longer writable after SQLite has been initialized.
		do
			Result := (not attached api as l_api) or else not l_api.is_initialized
		ensure
			not_api_is_initialized: (not attached api as l_api) or else not l_api.is_initialized
		end

	is_memory_stats_enabled: BOOLEAN assign set_is_memory_stats_enabled
			-- Indicates if memory statistics are enabled.
		do
			Result := internal_is_memory_stats_enabled.item
		end

feature -- Status report: Validation

	is_valid_threading_mode (a_mode: INTEGER): BOOLEAN
			-- Determines if a mode is a valid threading mode for the configuration
		do
			Result := a_mode = {SQLITE_THREADING_MODES}.SQLITE_CONFIG_SINGLETHREAD or
				a_mode = {SQLITE_THREADING_MODES}.SQLITE_CONFIG_MULTITHREAD or
				a_mode = {SQLITE_THREADING_MODES}.SQLITE_CONFIG_SERIALIZED
		end

feature -- Status setting

	set_is_memory_stats_enabled (a_enable: BOOLEAN)
			-- Enables/disables memory statistics.
			--
			-- `a_enabled': True if memory statistics functions are enabled; False otherwise.
		require
			is_config_writable: is_config_writable
		do
			internal_is_memory_stats_enabled.put (a_enable)
		ensure
			is_memory_stats_enabled_set: is_memory_stats_enabled = a_enable
		end

feature {NONE} -- Implementation

	internal_threading_mode: CELL [INTEGER]
			-- Process-bound `threading_mode'.
		note
			once_status: global
		once
			create Result.put ({SQLITE_THREADING_MODES}.SQLITE_CONFIG_SINGLETHREAD)
		end

	internal_is_memory_stats_enabled: CELL [BOOLEAN]
			-- Process-bound `is_memory_stats_enabled'.
		note
			once_status: global
		once
			create Result.put (False)
		end

invariant
	threading_mode_is_valid_threading_mode: is_valid_threading_mode (threading_mode)

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
