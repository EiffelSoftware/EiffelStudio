note
	description: "[
		Information gathered by the Eiffel test wizard to create new test.
	]"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ES_TEST_WIZARD_INFORMATION

inherit
	EB_WIZARD_INFORMATION

	SHARED_DEBUGGER_MANAGER
		export
			{NONE} all
		end

create
	make

feature {NONE} -- Initialization

	make (a_preferences: like preferences)
			-- Initialize `Current'.
		do
			preferences := a_preferences
		end

feature -- Access

	manual_conf: TEST_MANUAL_CREATOR_CONF
			-- Configuration for manual tests
		local
			l_cache: like manual_conf_cache
		do
			l_cache := manual_conf_cache
			if l_cache = Void then
				create l_cache.make (preferences)
				manual_conf_cache := l_cache
			end
			Result := l_cache
		ensure
			result_attached: Result /= Void
		end

	extractor_conf: TEST_EXTRACTOR_CONF
			-- Configuration for extracted tests
		require
			debugger_paused: is_debugger_paused
		local
			l_cache: like extractor_conf_cache
		do
			l_cache := extractor_conf_cache
			if l_cache = Void then
				create l_cache.make (debugger_manager.application_status.current_call_stack, preferences)
				extractor_conf_cache := l_cache
			end
			Result := l_cache
		ensure
			result_attached: Result /= Void
		end

	generator_conf: TEST_GENERATOR_CONF
			-- Configuration for AutoTest
		local
			l_cache: like generator_conf_cache
		do
			l_cache := generator_conf_cache
			if l_cache = Void then
				create l_cache.make (preferences)
				generator_conf_cache := l_cache
			end
			Result := l_cache
		ensure
			result_attached: Result /= Void
		end

	current_conf: TEST_CREATOR_CONF
			-- Configuration currently used by wizard
		require
			has_current_conf: has_current_conf
		local
			l_conf: like internal_conf
		do
			l_conf := internal_conf
			check l_conf /= Void end
			Result := l_conf
		ensure
			result_attached: Result /= Void
		end

feature {NONE} -- Access

	preferences: TEST_PREFERENCES
			-- Preferences used in configurations

	manual_conf_cache: ?like manual_conf
			-- Cache for `manual_conf'

	extractor_conf_cache: ?like extractor_conf
			-- Cache for `extractor_conf'

	generator_conf_cache: ?like generator_conf
			-- Cache for `generator_conf'

	internal_conf: ?like current_conf
			-- Internal storage for `current_conf'

feature -- Status report

	has_current_conf: BOOLEAN
			-- Is `current_conf' set?
		do
			Result := internal_conf /= Void
		end

	is_manual_conf: BOOLEAN
			-- Is `current_conf' a manual configuation?
		do
			Result := ({TEST_MANUAL_CREATOR_CONF}).attempt (internal_conf) /= Void
		end

	is_extractor_conf: BOOLEAN
			-- Is `current_conf' a extractor configuation?
		do
			Result := ({TEST_EXTRACTOR_CONF}).attempt (internal_conf) /= Void
		end

	is_generator_conf: BOOLEAN
			-- Is `current_conf' a AutoTest configuation?
		do
			Result := ({TEST_GENERATOR_CONF}).attempt (internal_conf) /= Void
		end

	is_debugger_paused: BOOLEAN
			-- Is the debugger currently paused?
		do
			Result := debugger_manager.application_is_executing and then
				debugger_manager.application_is_stopped
		end

feature -- Status setting

	set_current_conf (a_conf: like current_conf)
			-- Set `current_conf' to `a_conf'.
		do
			internal_conf := a_conf
		ensure
			has_current_conf: has_current_conf
			current_conf_equals_a_conf: current_conf = a_conf
		end

;note
	copyright: "Copyright (c) 1984-2009, Eiffel Software"
	license:   "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
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
