indexing
	description: "All shared attributes specific to the debugger"
	date: "$Date$"
	revision: "$Revision$"

class
	EB_DEBUG_TOOL_DATA

create
	make

feature {EB_PREFERENCES} -- Initialization

	make (a_preferences: PREFERENCES) is
			-- Create
		require
			preferences_not_void: a_preferences /= Void
		do
			preferences := a_preferences
			initialize_preferences
		ensure
			preferences_not_void: preferences /= Void
		end	

feature {EB_SHARED_PREFERENCES} -- Value

	width: INTEGER is
		do
			Result := width_preference.value
		end

	height: INTEGER is
		do
			Result := height_preference.value
		end

	last_saved_stack_path: STRING is
		do
			Result := last_saved_stack_path_preference.value
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

	main_splitter_position: INTEGER is
			-- 
		do
			Result := main_splitter_position_preference.value
		end		

	local_vs_object_proportion: REAL is
			-- What ratio should we have between the locals tree
			-- and the objects tree in the object tool?
		local
			str: STRING
		do
			str := local_vs_object_proportion_preference.value
			if not str.is_real then
				local_vs_object_proportion_preference.set_value ("0.5")
				Result := 0.5
			else
				Result := str.to_real
			end
		end

	max_stack_depth: INTEGER is
			--
		do
			Result := max_stack_depth_preference.value
		end
		
	expanded_display_bgcolor: EV_COLOR is
		do
			Result := expanded_display_bgcolor_preference.value
		end

	number_of_watch_tools: INTEGER is
		do
			Result := number_of_watch_tools_preference.value
		end
		
feature {EB_SHARED_PREFERENCES} -- Preference

	width_preference: INTEGER_PREFERENCE
	height_preference: INTEGER_PREFERENCE
	last_saved_stack_path_preference: STRING_PREFERENCE
	interrupt_every_n_instructions_preference: INTEGER_PREFERENCE
	debug_output_evaluation_enabled_preference: BOOLEAN_PREFERENCE
	generating_type_evaluation_enabled_preference: BOOLEAN_PREFERENCE
	min_slice_preference: INTEGER_PREFERENCE
	max_slice_preference: INTEGER_PREFERENCE
	max_evaluation_duration_preference: INTEGER_PREFERENCE
	main_splitter_position_preference: INTEGER_PREFERENCE
	local_vs_object_proportion_preference: STRING_PREFERENCE		
	left_debug_layout_preference: ARRAY_PREFERENCE		
	right_debug_layout_preference: ARRAY_PREFERENCE		
	max_stack_depth_preference: INTEGER_PREFERENCE
	expanded_display_bgcolor_preference: COLOR_PREFERENCE
	number_of_watch_tools_preference: INTEGER_PREFERENCE
	
feature -- Preference Strings

	width_string: STRING is "debugger.width"
	height_string: STRING is "debugger.height"
	last_saved_stack_path_string: STRING is "debugger.last_saved_stack_path"
	interrupt_every_n_instructions_string: STRING is "debugger.interrupt_every_n_instructions"
	debug_output_evaluation_enabled_string: STRING is "debugger.debug_output_evaluation"	
	generating_type_evaluation_enabled_string: STRING is "debugger.generating_type_evaluation"				
	min_slice_string: STRING is "debugger.min_slice"
	max_slice_string: STRING is "debugger.max_slice"
	max_evaluation_duration_preference_string: STRING is "debugger.max_evaluation_duration"
	main_splitter_position_string: STRING is "debugger.main_splitter_position"
	local_vs_object_proportion_string: STRING is "debugger.proportion"					
	max_stack_depth_string: STRING is "debugger.default_maximum_stack_depth"	
	left_debug_layout_string: STRING is "debugger.left_debug_layout"	
	right_debug_layout_string: STRING is "debugger.right_debug_layout"
	expanded_display_bgcolor_string: STRING is "debugger.expanded_display_background_color"
	number_of_watch_tools_string: STRING is "debugger.number_of_watch_tools"

feature {NONE} -- Implementation

	initialize_preferences is
			-- Initialize preference values.
		local
			l_manager: EB_PREFERENCE_MANAGER	
		do		
			create l_manager.make (preferences, "debug_tool")	
		
			width_preference := l_manager.new_integer_resource_value (l_manager, width_string, 214)
			height_preference := l_manager.new_integer_resource_value (l_manager, height_string, 214)			
			last_saved_stack_path_preference := l_manager.new_string_resource_value (l_manager, last_saved_stack_path_string, "")
			interrupt_every_n_instructions_preference := l_manager.new_integer_resource_value (l_manager, interrupt_every_n_instructions_string, 1)
			debug_output_evaluation_enabled_preference := l_manager.new_boolean_resource_value (l_manager, debug_output_evaluation_enabled_string, True)
			generating_type_evaluation_enabled_preference := l_manager.new_boolean_resource_value (l_manager, generating_type_evaluation_enabled_string, True)
			min_slice_preference := l_manager.new_integer_resource_value (l_manager, min_slice_string, 0)
			max_slice_preference := l_manager.new_integer_resource_value (l_manager, max_slice_string, 50)
			max_evaluation_duration_preference := l_manager.new_integer_resource_value (l_manager, max_evaluation_duration_preference_string, 5)
			main_splitter_position_preference := l_manager.new_integer_resource_value (l_manager, main_splitter_position_string, 250)
			local_vs_object_proportion_preference := l_manager.new_string_resource_value (l_manager, local_vs_object_proportion_string, "0.5")					
			max_stack_depth_preference := l_manager.new_integer_resource_value (l_manager, max_stack_depth_string, 100)
			left_debug_layout_preference := l_manager.new_array_resource_value (l_manager, left_debug_layout_string, <<>>)
			right_debug_layout_preference := l_manager.new_array_resource_value (l_manager, right_debug_layout_string, <<>>)
			expanded_display_bgcolor_preference := l_manager.new_color_resource_value (l_manager, expanded_display_bgcolor_string, create {EV_COLOR}.make_with_8_bit_rgb (210, 210, 210))
			number_of_watch_tools_preference := l_manager.new_integer_resource_value (l_manager, number_of_watch_tools_string, 2)					

		end
	
	preferences: PREFERENCES
			-- Preferences

invariant
	preferences_not_void: preferences /= Void
	width_preference_not_void: width_preference /= Void
	height_preference_not_void: height_preference /= Void	
	last_saved_stack_path_preference_not_void: last_saved_stack_path_preference /= Void
	interrupt_every_n_instructions_preference_not_void: interrupt_every_n_instructions_preference /= Void
	debug_output_evaluation_enabled_preference_not_void: debug_output_evaluation_enabled_preference /= Void
	generating_type_evaluation_enabled_preference_not_void: generating_type_evaluation_enabled_preference /= Void
	min_slice_preference_not_void: min_slice_preference /= Void
	max_slice_preference_not_void: max_slice_preference /= Void
	main_splitter_position_preference_not_void: main_splitter_position_preference /= Void
	local_vs_object_proportion_preference_not_void: local_vs_object_proportion_preference /= Void
	left_debug_layout_preference_not_void: left_debug_layout_preference /= Void
	right_debug_layout_preference_not_void: right_debug_layout_preference /= Void
	max_stack_depth_preference_not_void: max_stack_depth_preference /= Void	
	expanded_display_bgcolor_preference_not_void: expanded_display_bgcolor_preference /= Void		
	number_of_watch_tools_preference_not_void: number_of_watch_tools_preference /= Void	

end -- class EB_DEBUG_TOOL_DATA
