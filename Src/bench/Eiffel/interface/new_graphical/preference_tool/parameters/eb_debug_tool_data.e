indexing
	description: "All shared attributes specific to the debugger"
	date: "$Date$"
	revision: "$Revision$"

class
	EB_DEBUG_TOOL_DATA

inherit
	ANY

	SHARED_RESOURCES
		rename
			initialize as initialize_resources
		export
			{NONE} all
		end

feature -- Access

	debug_tool_width: INTEGER is
		do
			Result := integer_resource_value ("debug_tool_width", 214)
		end

	debug_tool_height: INTEGER is
		do
			Result := integer_resource_value ("debug_tool_height", 214)
		end

	debug_tool_bar: BOOLEAN is
		do
			Result := boolean_resource_value ("debug_tool_bar", True)
		end

	last_saved_stack_path: STRING is
		do
			Result := string_resource_value ("last_saved_stack_path", "C:\")
		end

	interrupt_every_n_instructions: INTEGER is
		do
			Result := integer_resource_value ("interrupt_every_n_instructions", 1)
		end

	debug_output_evaluation_enabled: BOOLEAN is
		do
			Result := boolean_resource_value ("debug_output_evaluation", True)			
		end

	generating_type_evaluation_enabled: BOOLEAN is
		do
			Result := boolean_resource_value ("generating_type_evaluation", True)			
		end
		
	optimized_jit_debugging_enabled: BOOLEAN is
		do
			Result := boolean_resource_value ("enable_optimized_jit_debugging", False)			
		end		

	default_displayed_string_size: INTEGER is
			-- Default size of string to be retrieved from the application
			-- when debugging (for instance size of `string_value' in ABSTRACT_REFERENCE_VALUE)
			-- (Default value is 50)
		do
			Result := integer_resource_value ("debugger__default_displayed_string_size", 50)
		end

	min_slice: INTEGER is
			-- From which attribute number should special objects be displayed?
		do
			Result := integer_resource_value ("min_slice", 0)
		end

	max_slice: INTEGER is
			-- Up to which attribute number should special objects be displayed?
		do
			Result := integer_resource_value ("max_slice", 50)
		end

	local_vs_object_proportion: REAL is
			-- What ratio should we have between the locals tree
			-- and the objects tree in the object tool?
		local
			str: STRING
		do
			str := string_resource_value ("proportion", "0.5")
			if not str.is_real then
				set_string_resource ("proportion", "0.5")
				Result := 0.5
			else
				Result := str.to_real
			end
		end
		
feature -- Element change

	set_last_saved_stack_path (new_path: STRING) is
			-- Set `last_saved_stack_path' to `new_path'.
		do
			set_string_resource ("last_saved_stack_path", new_path)
		end

	set_max_stack_depth (new_depth: INTEGER) is
			-- Set `max_stack_depth' to `new_depth'.
		do
			set_integer_resource ("debugger__default_maximum_stack_depth", new_depth)
		end

end -- class EB_DEBUG_TOOL_DATA
