class SHARED_WORKBENCH
	
feature {NONE}

	Workbench: WORKBENCH_I is
			-- Shared access to the workbench
		once
			Result := init_workbench;
		end;

	init_workbench: WORKBENCH_I is
		do
		end;

	System: SYSTEM_I is
			-- Shared access to the current system
		once
			Result := Workbench.system
		end;

	Universe: UNIVERSE_I is
			-- Shared access to the current universe
		once
			Result := Workbench.universe
		end;

	Lace: LACE_I is
			-- Access to the lace controller
		once
			Result := Workbench.lace;
		end;

end
