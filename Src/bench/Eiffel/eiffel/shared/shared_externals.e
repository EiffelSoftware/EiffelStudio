-- Shared external information

class SHARED_EXTERNALS

inherit

	SHARED_WORKBENCH
	
feature {NONE}

	Externals: EXTERNALS is
			-- System external feature table
		once
			Result := system.externals;
		end;

end
