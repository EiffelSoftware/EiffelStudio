
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
