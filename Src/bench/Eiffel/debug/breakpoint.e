
class BREAKPOINT

feature

	offset: INTEGER;
			-- Offset of the breakpoint in
			-- byte code array.

	set_offset (i: INTEGER) is
			-- Set `offset' to `i'.
		do
			offset := i
		end;

	is_continue: BOOLEAN;
			-- Does current correspond
			-- to a breakpoint where the
			-- application should stop?

	set_continue is
		do	
			is_continue := True
		end;

	set_stop is
		do
			is_continue := False
		end;

	real_body_id: INTEGER;
			-- Body id associated with byte
			-- code array containing Current
			-- breakpoint.

	set_real_body_id (i: INTEGER) is
			-- Set `real_body_id' to `i'.
		do
			real_body_id := i
		end;

end
