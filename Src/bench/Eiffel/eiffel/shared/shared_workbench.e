class SHARED_WORKBENCH

inherit
	SHARED_COMPILATION_MODES
	
feature -- Access

	Workbench: WORKBENCH_I is
			-- Shared access to the workbench
		once
			create Result
		end

	System: SYSTEM_I is
			-- Shared access to the current system
		require
			system_defined: Workbench.system_defined
		once
			Result := Workbench.system
		end

	Universe: UNIVERSE_I is
			-- Shared access to the current universe
		once
			Result := Workbench.universe
		end

	Lace: LACE_I is
			-- Access to the lace controller
		once
			Result := Workbench.lace
		end

end
