indexing
	description: "Node for integer constant. Version for Bench."
	date: "$Date$"
	revision: "$Revision$"

class INTEGER_CONSTANT

inherit
	ATOMIC_AS
		rename
			context as ast_context
		undefine
			is_character, line_number
		redefine
			is_integer, good_integer, is_equivalent,
			type_check, byte_node, value_i, make_integer
		end

	VALUE_I
		undefine
			string_value
		redefine
			generate, is_integer, is_propagation_equivalent,
			set_real_value
		end

	EXPR_B
		rename
			real_type as byte_real_type,
			generate as byte_generate,
			size as byte_size
		export
			{NONE} byte_real_type, byte_generate, byte_size
		redefine
			print_register, make_byte_code,
			is_simple_expr, is_predefined, generate_il
		end;

create
	make, make_default

feature {NONE} -- Initialization

	make_default is
			-- Create an integer constant of size 32.
		do
			size := 32
		ensure
			size_set: size = 32
		end
		
	make (n: INTEGER) is
			-- Create an integer constant value of size `n'.
		require
			valid_n: n = 32 or n = 64
		do
			size := n
		ensure
			size_set: size = n
		end

feature {AST_FACTORY} -- Initialization

	initialize (is_negative: BOOLEAN; s: STRING) is
			-- Create a new INTEGER AST node.
		do
			read_integer_value (is_negative , s)
		end

	initialize_from_hexa (s: STRING) is
			-- Create a new INTEGER AST node from `s' string representing
			-- an integer in hexadecimal starting with the following sequence
			-- "0x".
		require
			s_not_void: s /= Void
			s_not_empty: not s.is_empty
			s_not_too_big: s.count <= 18
		do
			read_hexa_value (s)
		end

feature -- Properties

	value: INTEGER is
			-- Integer value if `size' is 32 bits.
		require
			valid_size: size = 32
		do
			Result := lower
		end

	lower, upper: INTEGER
			-- Representation of integers.
	
	size: INTEGER
			-- Is current representation using 64 bits?

	is_integer: BOOLEAN is True
			-- Is it an integer value ?

	is_simple_expr: BOOLEAN is True;
			-- A constant is a simple expression

	is_predefined: BOOLEAN is True
			-- A constant is a predefined structure.

	type: TYPE_I is
			-- Integer type
		once
			Result := Long_c_type;
		end

feature -- Comparison

	is_equivalent (other: like Current): BOOLEAN is
			-- Is `other' equivalent to the current object ?
		do
			Result := lower = other.lower and then upper = other.upper and then size = other.size
		end

feature -- Type checking

	valid_type (t: TYPE_A): BOOLEAN is
			-- Is the current value compatible with `t'?
		local
			int_a: INTEGER_A
		do
			Result := t.is_integer 
			if Result then
				int_a ?= t
				Result := size = 64 implies size = int_a.size
			end
		end

	type_check is
			-- Type check an integer type
		do
				-- Put onto the type stack an integer actual type
			inspect size
			when 8 then ast_context.put (Integer_8_type)
			when 16 then ast_context.put (Integer_16_type)
			when 32 then ast_context.put (Integer_type)
			when 64 then ast_context.put (Integer_64_type)
			end
		end

	byte_node: INTEGER_CONSTANT is
			-- Associated byte code
		do
			Result := Current
		end

	make_integer: INT_VAL_B is
			-- Integer value for Intervals.
		do
			create Result.make (lower)
		end

feature -- Conveniences

	value_i: INTEGER_CONSTANT is
			-- Interface value
		do
				-- Need to clone since 
			Result := clone (Current)
		end

	to_integer_64: INTEGER_64 is
			-- Extract information about `upper' and `lower' to
			-- build an INTEGER_64.
		require
			valid_size: size = 64
		do
			Result := (upper.to_integer_64 |<< 32) | lower.to_integer_64
		end

	is_propagation_equivalent (other: like Current): BOOLEAN is
		do
			Result := same_type (other) and then is_equivalent (other)
		end

	used (r: REGISTRABLE): BOOLEAN is
		do
		end;

feature -- Settings

	set_lower (i: INTEGER) is
			-- Assign `i' to `lower'.
		do
			lower := i
		ensure
			lower_set: lower = i
		end

	set_real_value (t: INTEGER_A) is
			-- Extract size information of `t' and assign it to Current.
			-- It will discard existing information, because it might be
			-- possible that we entered an INTEGER_8 constant value.
		do
			size := t.size
		ensure then
			size_set: size = t.size
		end

feature -- Output

	string_value: STRING is
		do
			if size <= 32 then
				Result := lower.out
			else
				Result := to_integer_64.out
			end
		end	

feature {AST_EIFFEL} -- Output

	simple_format (ctxt: FORMAT_CONTEXT) is
			-- Reconstitute text.
		do
			ctxt.put_text_item (
				create {NUMBER_TEXT}.make (string_value)
			)
		end

feature -- Generation

	print_register is
			-- Print integer constant
			--| The '()' are present for the case where int_val=INT32_MIN,
			--| ie: if we printed -INT32_MIN in Eiffel, we would get --INT32_MIN in C.
		do
			generate (buffer)
		end;

	generate (buf: GENERATION_BUFFER) is
			-- Generate value in `buf'.
			-- The '()' are present for the case where lower=INT32_MIN,
			-- ie: if we printed -INT32_MIN in Eiffel, we would get --INT32_MIN in C.
		do
			inspect size
			when 8 then
				buf.putstring ("(EIF_INTEGER_8) (")
				buf.putstring (lower.out)
				buf.putstring ("L)")
			when 16 then
				buf.putstring ("(EIF_INTEGER_16) (")
				buf.putstring (lower.out)
				buf.putstring ("L)")
			when 32 then
				buf.putstring ("(EIF_INTEGER_32) (")
				buf.putstring (lower.out)
				buf.putstring ("L)")
			when 64 then
				buf.putstring ("(EIF_INTEGER_64) (")
				buf.putstring (to_integer_64.out)
				buf.putstring ("L)")
			end
		end

	generate_il is
			-- Generate IL code for integer constant value.
		do
			inspect size 
			when 8 then il_generator.put_integer_8_constant (lower)
			when 16 then il_generator.put_integer_16_constant (lower)
			when 32 then il_generator.put_integer_32_constant (lower)
			when 64 then il_generator.put_integer_64_constant (to_integer_64)
			end
		end

	make_byte_code (ba: BYTE_ARRAY) is
			-- Generate byte code for an integer constant value.
		do
			inspect size
			when 8 then
				ba.append (Bc_int8)
				ba.append (lower.to_character)
			when 16 then
				ba.append (Bc_int16)
				ba.append_short_integer (lower)
			when 32 then
				ba.append (Bc_int)
				ba.append_integer (lower)
			when 64 then
				ba.append (Bc_int64)
				ba.append_integer_64 (to_integer_64)
			end
		end

feature -- Error reporting

	vqmc: VQMC is
		do
			create {VQMC3} Result
		end

feature -- Trace

	dump: STRING is
		do
			Result := lower.out
		end
	
feature {COMPILER_EXPORTER}

	good_integer: BOOLEAN is
			-- Is the atomic a good integer bound for multi-branch ?
		do
			Result := size <= 32
		end

feature {NONE} -- Translation

	read_hexa_value (s: STRING) is
			-- Convert `s' hexadecimal value into an integer representation.
		require
			s_not_void: s /= Void
			s_large_enough: s.count > 2
		local
			i, j: INTEGER
			last_integer: INTEGER
			area: SPECIAL [CHARACTER]
			val: CHARACTER
		do
			area := s.area
			j := s.count - 1

			from
			until
				(j - i) < 2 or i = 8
			loop
				val := area.item (j - i).lower
				inspect
					val
				when 'a' then
					last_integer := last_integer | (10 |<< (i * 4))
				when 'b' then
					last_integer := last_integer + (11 |<< (i * 4))
				when 'c' then
					last_integer := last_integer + (12 |<< (i * 4))
				when 'd' then
					last_integer := last_integer + (13 |<< (i * 4))
				when 'e' then
					last_integer := last_integer + (14 |<< (i * 4))
				when 'f' then
					last_integer := last_integer + (15 |<< (i * 4))
				else
					last_integer := last_integer + ((val.code - 48) |<< (i * 4))
				end
				i := i + 1
			end
			lower := last_integer

			if j > 9 then
				from
					i := 0
					last_integer := 0
					j := j - 8
				until
					(j - i) < 2
				loop
					val := area.item (j - i).lower
					inspect
						val
					when 'a' then
						last_integer := last_integer | (10 |<< (i * 4))
					when 'b' then
						last_integer := last_integer + (11 |<< (i * 4))
					when 'c' then
						last_integer := last_integer + (12 |<< (i * 4))
					when 'd' then
						last_integer := last_integer + (13 |<< (i * 4))
					when 'e' then
						last_integer := last_integer + (14 |<< (i * 4))
					when 'f' then
						last_integer := last_integer + (15 |<< (i * 4))
					else
						last_integer := last_integer + ((val.code - 48) |<< (i * 4))
					end
					i := i + 1
				end
				upper := last_integer
				size := 64
			else
				size := 32
			end
		end

	largest_integer_32: STRING is "2147483648"
			-- Largest string representation of 2^31.

	read_integer_value (is_negative: BOOLEAN; s: STRING) is
			-- Read integer expressed in decimal representation.
		require
			s_not_void: s /= Void
		local
			last_integer: INTEGER
			last_int_64: INTEGER_64
			area: SPECIAL [CHARACTER]
			i, nb: INTEGER
			is_32bits, done: BOOLEAN
		do
			area := s.area
			nb := s.count
	
			is_32bits := nb < 10
			if not is_32bits and then nb = 10 then
				if is_negative then
					is_32bits := s < largest_integer_32
					if not is_32bits and then s.is_equal (largest_integer_32) then
						done := True
						size := 32
						lower := 0x7fffffff
					end
				else
					is_32bits := s < largest_integer_32
				end
			end

			if not done then
				if is_32bits then
					from
					until
						i >= nb
					loop
						last_integer := (last_integer * 10) + area.item (i).code - 48
						i := i + 1
					end
					if is_negative then
						last_integer := -last_integer
					end
					lower := last_integer
					size := 32
				else
					from
					until
						i >= nb
					loop
						last_int_64 := (last_int_64 * 10) + area.item (i).code - 48
						i := i + 1
					end

					if is_negative then
						last_int_64 := -last_int_64
					end

					size := 64
					lower := (last_int_64 & 0x00000000FFFFFFFF).to_integer
					upper := ((last_int_64 |>> 32) & 0x00000000FFFFFFFF).to_integer
				end
			end
		end

end -- class INTEGER_CONSTANT
