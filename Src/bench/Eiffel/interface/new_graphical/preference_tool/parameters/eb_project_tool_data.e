indexing
	description:
		"All shared attributes specific to the project tool"
	date: "$Date$"
	revision: "$Revision$"

class
	EB_PROJECT_TOOL_DATA

inherit
	SHARED_RESOURCES

feature -- Access

	raise_on_error: BOOLEAN is
		do
			Result := boolean_resource_value ("raise_on_error", True)
		end

	context_unified_stone: BOOLEAN is
		do
			Result := boolean_resource_value ("unified_stone", False)
		end

	graphical_output_disabled: BOOLEAN is
		do
			Result := boolean_resource_value ("graphical_output_disabled", False)
		end
		
	confirm_freeze: BOOLEAN is
			-- About the freezing dialog (Freezing implies some C compilation.
			-- ..do you want to proceed? Yes/No): should we display it or
			-- assume that the user has choosen "Yes"
		do
			Result := boolean_resource_value ("confirm_freeze", True)
		end

	set_confirm_freeze (new_value: BOOLEAN) is
			-- Set `confirm_freeze' to `new_value'
		do
			set_boolean ("confirm_freeze", new_value)
		end

end -- class EB_PROJECT_TOOL_DATA
