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

feature {NONE} -- Implementation

	add_tabs (st:STRUCTURED_TEXT; i: INTEGER) is
			-- Add `i' tabs to `structured_text'.
		local
			j: INTEGER
		do
			from
				j := 1;
			until
				j > i
			loop
				st.add_indent;
				j := j + 1
			end;
		end;

end -- class E_CMD
