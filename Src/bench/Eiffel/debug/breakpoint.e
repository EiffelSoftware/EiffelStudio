
class BREAKPOINT

inherit

	HASHABLE
		redefine
			is_equal
		end

feature -- Properties

	offset: INTEGER;
			-- Offset of the breakpoint in
			-- byte code array.

	is_continue: BOOLEAN;
			-- Does current correspond
			-- to a breakpoint where the
			-- application should stop?

	real_body_id: REAL_BODY_ID;
			-- Body id associated with byte
			-- code array containing Current
			-- breakpoint.

feature -- Access

	hash_code: INTEGER is
			-- Hash code for breakpoint
		do
			Result := real_body_id.hash_code * 100 + offset
		end;

feature -- Setting

	set_continue is
			-- Set `is_continue' to True.
		do	
			is_continue := True
		ensure
			is_continue: is_continue
		end;

	set_stop is
			-- Set `is_continue' to False.
		do
			is_continue := False
		ensure
			not_continue:  not is_continue
		end;

	set_offset (i: INTEGER) is
			-- Set `offset' to `i'.
		do
			offset := i
		ensure
			set: offset = i
		end;

	set_real_body_id (i: REAL_BODY_ID) is
			-- Set `real_body_id' to `i'.
		do
			real_body_id := i
		ensure
			set: real_body_id = i
		end;

feature -- Comparison

	is_equal (other: like Current): BOOLEAN is
			-- Is `other' equal to `Current' if they represent
			-- the same physical breakpoint in the byte code, 
			-- in other words they have the same `real_body_id' 
			-- and `offset' (`is_continue' is just a status of 
			-- the breakpoint).
		do
			Result := (other.offset = offset) and 
							equal (other.real_body_id, real_body_id)
		end;

end -- class BREAKPOINT
