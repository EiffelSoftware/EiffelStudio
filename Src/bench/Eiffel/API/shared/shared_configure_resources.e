indexing
	description: "Shared resources used by the compiler."
	date: "$Date$"
	revision: "$Revision$"

class
	SHARED_CONFIGURE_RESOURCES

feature -- Resources

	Configure_resources: RESOURCE_TABLE is
			-- Resources specified by the user
			-- (Calls `init_resources'. To include your own
			-- resource files redefine `init_resources'.)
		once
			!! Result.make (0)
		end

feature -- Resource names

	r_AutomaticBackup: STRING is "automatic_backup"
	r_Fail_on_rescue: STRING is "fail_on_rescue"
	r_Cache_size: STRING is "cache_size"
	r_Graphics_disabled: STRING is "graphics_disabled"
	r_Windows_timer_delay: STRING is "windows_timer_delay"
	r_Metamorphosis_disabled: STRING is	"metamorphosis_disabled"
	r_collection_period: STRING is "period"

feature {NONE} -- Convenient access

	Fail_on_rescue: BOOLEAN is
			-- Fail on rescue?
		once
			Result := Configure_resources.get_boolean (r_Fail_on_rescue, False)
		end

	Metamorphosis_disabled: BOOLEAN is
			-- Is extra metamorphosis disabled?
		once
			Result := Configure_resources.get_boolean (r_Metamorphosis_disabled, False)
		end

end -- class SHARED_CONFIGURE_RESOURCES
