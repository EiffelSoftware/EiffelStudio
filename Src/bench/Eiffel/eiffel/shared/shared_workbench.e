class SHARED_WORKBENCH
	
feature

	Workbench: WORKBENCH_I is
			-- Shared access to the workbench
		once
			Result := init_workbench;
		end;

	System: SYSTEM_I is
			-- Shared access to the current system
		once
debug ("DLE SYSTEM")
io.error.put_string ("First call to `System'.");
io.error.new_line
end;
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

feature {NONE}

	init_workbench: WORKBENCH_I is
		do
		end;

end
