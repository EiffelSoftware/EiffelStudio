indexing

	description: 
		"Shared resources used by the compiler.";
	date: "$Date$";
	revision: "$Revision $"

class SHARED_CONFIGURE_RESOURCES

feature -- Resources

	Configure_resources: RESOURCE_TABLE is
			-- Resources specified by the user
			-- (Calls `init_resources'. To include your own
			-- resource files redefine `init_resources'.)
		once
			!! Result.make (0)
		end;

feature -- Resource names

	r_AutomaticBackup: STRING is		"automatic_backup";
	r_Fail_on_rescue: STRING is		"fail_on_rescue";
	r_Trace_debug: STRING is		"trace_debug";
	r_Cache_size: STRING is			"cache_size";
	r_Concurrent_eiffel: STRING is		"concurrent_eiffel";
	r_Graphics_disabled: STRING is		"graphics_disabled";
	r_Tabs_disabled: STRING is		"tabs_disabled"

feature {NONE} -- Convenient access

	enabled_debug_trace: BOOLEAN is
			-- Enable debug trace
		once
			Result := Configure_resources.get_boolean (r_trace_debug, False)
		end;

	fail_on_rescue: BOOLEAN is
			-- Fail on rescue?
		once
			Result := Configure_resources.get_boolean (r_Fail_on_rescue, False)
		end

end -- class SHARED_RESOURCES
