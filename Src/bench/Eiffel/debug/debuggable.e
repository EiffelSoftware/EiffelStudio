
class DEBUGGABLE

feature -- Data

	byte_code: CHARACTER_ARRAY;
			-- Array of debuggable byte
			-- code

	real_body_index: INTEGER;
			-- Body index of feature associated
			-- with Current.

	real_body_id: INTEGER;
			-- Body id of feature associated
			-- with Current.

	was_frozen: BOOLEAN;
			-- Was the feature associated with
			-- Current initially frozen?

	breakable_points: SORTED_TWO_WAY_LIST [AST_POSITION];

	total_local_count: INTEGER;
			-- Number of locals for byte code: it includes Eiffel local
			-- variables, variants of loops and old expressions
			-- (The Result entity, if any, is not taken into account)

	local_count: INTEGER;
			-- Number of user-declared local variables (appearing in the
			-- local clause of the routine)

	argument_count: INTEGER;
			-- Number of arguments

feature -- Status

	is_breakpoint_set (i: INTEGER): BOOLEAN is
			-- Is the `i'-th breakable point set ?
		do
			if i >= 1 and i <= breakable_points.count then
				Result := breakable_points.i_th (i).is_set
			end
		end; -- is_breakpoint_set

	has_breakpoint_set: BOOLEAN is
			-- Is at least one breakable point set ?
		do
			from
				breakable_points.start
			until
				Result or breakable_points.after
			loop
				Result := breakable_points.item.is_set;
				breakable_points.forth
			end
		end; -- has_breakpoint_set

feature -- Setting

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

	set_was_frozen is
		do
			was_frozen := True
		end;

	set_total_local_count (i: INTEGER) is
		do
			total_local_count := i
		end;

	set_local_count (i: INTEGER) is
		do
			local_count := i
		end;

	set_argument_count (i: INTEGER) is
		do
			argument_count := i
		end;

feature -- Tracing

	trace is
		local
			i: INTEGER
		do
			from
				i := 1;
				io.putstring ("Byte code breakpoints:%N");
			until
				i > byte_code.size
			loop
				if byte_code.item (i) = '%/066/' then
					io.putstring ("Breakpoint, offset: ");
					io.putint (i);
					io.new_line;
				elseif byte_code.item (i) = '%/096/' then
					io.putstring ("Contpoint, offset: ");
					io.putint (i);
					io.new_line;
				end;
				i := i + 1;
			end;
			-- Breakable points
			from
				breakable_points.start;
				io.putstring ("Breakable point offsets: %N");
			until
				breakable_points.after
			loop
				io.putint (breakable_points.item.position);
				io.new_line;
				breakable_points.forth
			end
		end;

end
