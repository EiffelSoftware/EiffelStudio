indexing
	description: 
		"General notion of an eiffel command (semantic unity).%
		%To write an actual command inherit from this class and%
		%implement the `execute' feature";
	date: "$Date$";
	revision: "$Revision $"

deferred class E_CMD

feature -- Access

	executable: BOOLEAN is
			-- Is Current command executable?
			-- (True by default)
		do
			Result := True
		end

feature -- Execution

	execute is
			-- Execute Current command.
		require
			executable: executable
		deferred
		end;

end -- class E_CMD
