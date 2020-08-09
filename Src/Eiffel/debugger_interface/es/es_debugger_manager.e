note
	description: "Shared object that manages all debugging actions."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: "$Author$"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	ES_DEBUGGER_MANAGER

inherit
	DEBUGGER_MANAGER
		redefine
			classic_close_dbg_daemon_on_end_of_debugging,
			classic_debugger_ending_timeout,
			classic_debugger_location,
			classic_debugger_timeout,
			dotnet_debugger,
			dotnet_debugger_entries,
			dotnet_keep_stepping_info_non_eiffel_feature,
			is_true_boolean_value,
			log_message,
			make,
			set_default_parameters
		end

	SHARED_COMPILER_PREFERENCES

feature {NONE} -- Initialization

	make
			-- <Precursor>
		do
			initialize_preferences
			Precursor {DEBUGGER_MANAGER}
		end

	initialize_preferences
			-- Initialize preferences
		do
			create dbg_preferences.make (preferences.preferences)
		end

	initialize_storage
			-- <Precursor>
		do
			create {ES_DEBUGGER_FS_STORAGE} dbg_storage.make (Current)
		end

feature -- Preferences

	dbg_preferences: DBG_PREFERENCES
			-- Debugger preferences

	debugger_data: EB_DEBUGGER_DATA
			-- Debugger data...
		do
			Result := dbg_preferences.debugger_data
		end

feature -- Settings

	set_default_parameters
			-- <Precursor>
		do
			Precursor {DEBUGGER_MANAGER}
			if attached debugger_data as prefs then
				set_slices (prefs.min_slice, prefs.max_slice)
				set_displayed_string_size (prefs.default_displayed_string_size)
				set_maximum_stack_depth (prefs.default_maximum_stack_depth)
				set_critical_stack_depth (prefs.critical_stack_depth)

				set_max_evaluation_duration (prefs.max_evaluation_duration)
				prefs.max_evaluation_duration_preference.typed_change_actions.extend (agent set_max_evaluation_duration)
				check
					displayed_string_size: displayed_string_size = prefs.default_displayed_string_size
					max_evaluation_duration_set: prefs /= Void implies max_evaluation_duration = prefs.max_evaluation_duration
				end
				set_catcall_detection_mode (prefs.default_catcall_console_warning, prefs.default_catcall_debugger_warning)
			end
		end

	classic_debugger_timeout: INTEGER
			-- <Precursor>
		do
			if attached debugger_data as prefs then
				Result := prefs.classic_debugger_timeout
			end
		end

	classic_debugger_ending_timeout: INTEGER
			-- <Precursor>
		do
			if attached debugger_data as prefs then
				Result := prefs.classic_debugger_ending_timeout
			end
		end

	classic_debugger_location: detachable PATH
			-- <Precursor>
		do
			if attached debugger_data as prefs then
				Result := prefs.classic_debugger_location
			end
		end

	classic_close_dbg_daemon_on_end_of_debugging: BOOLEAN
			-- <Precursor>
		local
			prefs: EB_DEBUGGER_DATA
		do
			prefs := debugger_data
			if prefs /= Void then
				Result := prefs.close_classic_dbg_daemon_on_end_of_debugging
			end
		end

	dotnet_keep_stepping_info_non_eiffel_feature: BOOLEAN
			-- <Precursor>
		local
			prefs: EB_DEBUGGER_DATA
			bp: BOOLEAN_PREFERENCE
		do
			prefs := debugger_data
			if prefs /= Void then
				bp := prefs.keep_stepping_info_dotnet_feature_preference
				Result := bp.value
			end
		end

	dotnet_debugger_entries: ITERABLE [READABLE_STRING_32]
			-- <Precursor>
		do
			if attached debugger_data as prefs then
				Result := prefs.dotnet_debugger_preference.value
			end
		end

	dotnet_debugger: detachable READABLE_STRING_32
		do
			if attached debugger_data as prefs then
				Result := prefs.dotnet_debugger_preference.selected_value
			end
		end

	is_true_boolean_value (a_string: STRING): BOOLEAN
			-- <Precursor>
		do
			if a_string /= Void then
				Result := attached {BOOLEAN_PREFERENCE} preferences.preferences.get_preference (a_string) as bp and then bp.value
			end
		end

feature -- Logger

	log_message (s: STRING_32)
			-- <Precursor>
		local
			l_logger: like logger_service
		do
			l_logger := logger_service
			if attached l_logger.service as srv then
				srv.put_message_with_severity (s, {ENVIRONMENT_CATEGORIES}.debugger, {PRIORITY_LEVELS}.normal)
			end
		end

feature {NONE} -- Logger

	logger_service: SERVICE_CONSUMER [LOGGER_S]
			-- Access to logger service
		do
			if attached internal_logger_service as l_service then
				Result := l_service
			else
				create Result
				internal_logger_service := Result
			end
		end

	internal_logger_service: detachable SERVICE_CONSUMER [LOGGER_S]
			-- Cached version of `logger_service'
			-- Note: Do not use directly!	

;note
	copyright:	"Copyright (c) 1984-2016, Eiffel Software"
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
