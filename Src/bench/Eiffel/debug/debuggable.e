
class DEBUGGABLE

feature

	byte_code: CHARACTER_ARRAY;

	real_body_index: INTEGER;

	real_body_id: INTEGER;

	breakable_points: SORTED_TWO_WAY_LIST [AST_POSITION];

	set_breakable_points (bp: SORTED_TWO_WAY_LIST [AST_POSITION]) is
		do
			breakable_points := bp
		end;

	set_byte_code (ca: CHARACTER_ARRAY) is
		do
			byte_code := ca
		end;

	set_real_body_index (i: INTEGER) is
		do
			real_body_index := i
		end;

	set_real_body_id (i: INTEGER) is
		do
			real_body_id := i
		end;

end
