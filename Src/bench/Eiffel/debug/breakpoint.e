
class BREAKPOINT

inherit

	ANY
		redefine
			is_equal
		end;

	HASHABLE
		redefine
			is_equal
		end

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

feature -- comparison

	is_equal (other: like Current): BOOLEAN is
			-- `other' is equal to `Current' if they represent
			-- the same physical breakpoint in the byte code, 
			-- in other words they have the same `real_body_id' 
			-- and `offset' (`is_continue' is just a status of 
			-- the breakpoint).
		do
			Result := (other.offset = offset) and 
							(other.real_body_id = real_body_id)
		end;

feature -- Hash code

	hash_code: INTEGER is
		do
			Result := real_body_id * 100 + offset
		end;

end
