indexing

	description: 
		"Class instance that calls the custom tool.";
	date: "$Date$";
	revision: "$Revision $"

deferred class CUSTOM_CALLER

feature -- Access

	associated_custom_tool: CUSTOM_W is
			-- Associated custom tool
			-- (Used for type checking and system validity)
		deferred
		end;

feature -- Actions

	execute_apply_action (a_cust_tool: like associated_custom_tool) is
			-- Action performed when apply button is activated
		deferred
		end;

	execute_save_action (a_cust_tool: like associated_custom_tool) is
			-- Action performed when save button is activated
		deferred
		end;

end -- class CUSTOM_CALLER
