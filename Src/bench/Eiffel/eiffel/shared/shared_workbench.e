class SHARED_WORKBENCH
	
feature

	Workbench: WORKBENCH_I is
			-- Shared access to the workbench
		once
			Result := init_workbench;
		end;

	System: SYSTEM_I is
			-- Shared access to the current system
		require
			system_defined: Workbench.system_defined
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

	compilation_modes: COMPILATION_MODES is
			-- Status of current compilation
		once
			!! Result;
		end;

feature {NONE}

	init_workbench: WORKBENCH_I is
		do
		end;

end
