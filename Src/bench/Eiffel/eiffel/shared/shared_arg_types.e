-- Shared instance of argument types container for conformance of argument
-- anchired types

class SHARED_ARG_TYPES
	
feature {NONE}

	Argument_types: ARG_TYPES is
			-- Shared access to argument types container
		once
			create Result;
		end;

end
