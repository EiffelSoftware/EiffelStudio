indexing
	description: "All shared preferences for the debugger."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	EB_DEBUGGER_DATA

create
	make

feature {EB_PREFERENCES} -- Initialization

	make (a_preferences: PREFERENCES) is
			-- Create
		require
			preferences_not_void: a_preferences /= Void
		do
			initialize_preferences (a_preferences)
		end

feature {EB_SHARED_PREFERENCES} -- Value

	default_maximum_stack_depth: INTEGER is
			-- 		
		do
			Result := default_maximum_stack_depth_preference.value
		end

	critical_stack_depth: INTEGER is
			-- Call stack depth at which we warn the user against a possible stack overflow.
		do
			Result := critical_stack_depth_preference.value
			if Result < -1 or Result = 0 then
				Result := 1000
			end
		end

	interrupt_every_n_instructions: INTEGER is
		do
			Result := interrupt_every_n_instructions_preference.value
		end

	debug_output_evaluation_enabled: BOOLEAN is
		do
			Result := debug_output_evaluation_enabled_preference.value
		end

	generating_type_evaluation_enabled: BOOLEAN is
		do
			Result := generating_type_evaluation_enabled_preference.value
		end

	default_displayed_string_size: INTEGER is
			-- Default size of string to be retrieved from the application
			-- when debugging (for instance size of `string_value' in ABSTRACT_REFERENCE_VALUE)
			-- (Default value is 50)
		do
			Result := default_displayed_string_size_preference.value
		end

	min_slice: INTEGER is
			-- From which attribute number should special objects be displayed?
		do
			Result := min_slice_preference.value
		end

	max_slice: INTEGER is
			-- Up to which attribute number should special objects be displayed?
		do
			Result := max_slice_preference.value
		end

	max_evaluation_duration: INTEGER is
		do
			Result := max_evaluation_duration_preference.value
		end

feature {EB_SHARED_PREFERENCES} -- Classic specific

	close_classic_dbg_daemon_on_end_of_debugging: BOOLEAN is
			-- Do we close the classic dbg daemon when the debugging is finished ?
		do
			Result := close_classic_dbg_daemon_on_end_of_debugging_preference.value
		end

	classic_debugger_timeout: INTEGER is
		do
			Result := classic_debugger_timeout_preference.value
		end

	classic_debugger_location: STRING is
		do
			Result := classic_debugger_location_preference.value
		end

feature {EB_SHARED_PREFERENCES} -- Dotnet specific

	keep_stepping_info_dotnet_feature: BOOLEAN is
			-- Do we keep stepping into dotnet feature or keep out as soon as possible ?
		do
			Result := keep_stepping_info_dotnet_feature_preference.value
		end

	dotnet_debugger: ARRAY [STRING] is
			-- .NET debugger to launch
		do
			Result := dotnet_debugger_preference.value
		end

feature {EB_SHARED_PREFERENCES} -- Preference

	default_maximum_stack_depth_preference: INTEGER_PREFERENCE
	critical_stack_depth_preference: INTEGER_PREFERENCE
	interrupt_every_n_instructions_preference: INTEGER_PREFERENCE
	keep_stepping_info_dotnet_feature_preference: BOOLEAN_PREFERENCE
	dotnet_debugger_preference: ARRAY_PREFERENCE
	close_classic_dbg_daemon_on_end_of_debugging_preference: BOOLEAN_PREFERENCE
	classic_debugger_timeout_preference: INTEGER_PREFERENCE
	classic_debugger_location_preference: STRING_PREFERENCE
	debug_output_evaluation_enabled_preference: BOOLEAN_PREFERENCE
	generating_type_evaluation_enabled_preference: BOOLEAN_PREFERENCE
	default_displayed_string_size_preference: INTEGER_PREFERENCE
	min_slice_preference: INTEGER_PREFERENCE
	max_slice_preference: INTEGER_PREFERENCE
	max_evaluation_duration_preference: INTEGER_PREFERENCE

feature {NONE} -- Preference Strings

	critical_stack_depth_string: STRING is "debugger.critical_stack_depth"
	default_maximum_stack_depth_string: STRING is "debugger.default_maximum_stack_depth"
	keep_stepping_info_dotnet_feature_string: STRING is "debugger.dotnet.keep_stepping_info_dotnet_feature"
	dotnet_debugger_string: STRING is "debugger.dotnet_debugger"
	close_classic_dbg_daemon_on_end_of_debugging_string: STRING is "debugger.classic_debugger.close_dbg_daemon_on_end_of_debugging"
	classic_debugger_timeout_string: STRING is "debugger.classic_debugger.timeout"
	classic_debugger_location_string: STRING is "debugger.classic_debugger.debugger_location"
	interrupt_every_n_instructions_string: STRING is "debugger.interrupt_every_N_instructions"
	debug_output_evaluation_enabled_string: STRING is "debugger.debug_output_evaluation"
	generating_type_evaluation_enabled_string: STRING is "debugger.generating_type_evaluation"
	default_displayed_string_size_string: STRING is "debugger.default_displayed_string_size"
	min_slice_string: STRING is "debugger.min_slice"
	max_slice_string: STRING is "debugger.max_slice"
	max_evaluation_duration_preference_string: STRING is "debugger.max_evaluation_duration"

feature {NONE} -- Implementation

	initialize_preferences (a_preferences: PREFERENCES) is
		require
			preferences_not_void: a_preferences /= Void
			-- Initialize preference values.
		local
			l_manager: EB_PREFERENCE_MANAGER
		do
			create l_manager.make (a_preferences, "debugger")

			default_maximum_stack_depth_preference := l_manager.new_integer_preference_value (l_manager, default_maximum_stack_depth_string, 500)
			critical_stack_depth_preference := l_manager.new_integer_preference_value (l_manager, critical_stack_depth_string, 500)
			interrupt_every_n_instructions_preference := l_manager.new_integer_preference_value (l_manager, interrupt_every_n_instructions_string, 1)
			debug_output_evaluation_enabled_preference := l_manager.new_boolean_preference_value (l_manager, debug_output_evaluation_enabled_string, True)
			generating_type_evaluation_enabled_preference := l_manager.new_boolean_preference_value (l_manager, generating_type_evaluation_enabled_string, True)
			default_displayed_string_size_preference := l_manager.new_integer_preference_value (l_manager, default_displayed_string_size_string, 50)
			min_slice_preference := l_manager.new_integer_preference_value (l_manager, min_slice_string, 0)
			max_slice_preference := l_manager.new_integer_preference_value (l_manager, max_slice_string, 50)
			max_evaluation_duration_preference := l_manager.new_integer_preference_value (l_manager, max_evaluation_duration_preference_string, 5)
			keep_stepping_info_dotnet_feature_preference := l_manager.new_boolean_preference_value (l_manager, keep_stepping_info_dotnet_feature_string, False)
			dotnet_debugger_preference := l_manager.new_array_preference_value (l_manager, dotnet_debugger_string, <<"[EiffelStudio Dbg];cordbg;DbgCLR">>)
			dotnet_debugger_preference.set_is_choice (True)
			close_classic_dbg_daemon_on_end_of_debugging_preference := l_manager.new_boolean_preference_value (l_manager, close_classic_dbg_daemon_on_end_of_debugging_string, True)
			classic_debugger_timeout_preference := l_manager.new_integer_preference_value (l_manager, classic_debugger_timeout_string, 0)
			classic_debugger_location_preference := l_manager.new_string_preference_value (l_manager, classic_debugger_location_string, "")
		end

invariant
	default_maximum_stack_depth_preference_not_void: default_maximum_stack_depth_preference /= Void
	critical_stack_depth_preference_not_void: critical_stack_depth_preference /= Void
	close_classic_dbg_daemon_on_end_of_debugging_preference_not_void:  close_classic_dbg_daemon_on_end_of_debugging_preference /= Void
	classic_debugger_timeout_preference_not_void: classic_debugger_timeout_preference /= Void
	classic_debugger_location_preference_not_void: classic_debugger_location_preference /= Void
	keep_stepping_info_dotnet_feature_preference_not_void: keep_stepping_info_dotnet_feature_preference /= Void
	interrupt_every_n_instructions_preference_not_void: interrupt_every_n_instructions_preference /= Void
	debug_output_evaluation_enabled_preference_not_void: debug_output_evaluation_enabled_preference /= Void
	generating_type_evaluation_enabled_preference_not_void: generating_type_evaluation_enabled_preference /= Void
	default_displayed_string_size_preference_not_void: default_displayed_string_size_preference /= Void
	min_slice_preference_not_void: min_slice_preference /= Void
	max_slice_preference_not_void: max_slice_preference /= Void

--	_preference_not_void: _preference /= Void

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
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

end -- class EB_DEBUGGER_DATA
