class
	ASSERTION_I

create
	make_no,
	make_require,
	make_ensure,
	make_loop,
	make_check,
	make_invariant,
	make_all

feature {NONE} -- Initialization

	make_no is
			-- Create an assertion level which does not check assertions.
		do
			level := 0
		ensure
			level_is_zero: level = 0
		end

	make_require is
			-- Create an assertion level which does not check assertions.
		do
			level := ck_require
		ensure
			level_set: level = ck_require
		end

	make_ensure is
			-- Create an assertion level which does not check assertions.
		do
			level := ck_ensure
		ensure
			level_set: level = ck_ensure
		end

	make_check is
			-- Create an assertion level which does not check assertions.
		do
			level := ck_check
		ensure
			level_set: level = ck_check
		end

	make_loop is
			-- Create an assertion level which does not check assertions.
		do
			level := ck_loop
		ensure
			level_set: level = ck_loop
		end

	make_invariant is
			-- Create an assertion level which does not check assertions.
		do
			level := ck_invariant
		ensure
			level_set: level = ck_invariant
		end

	make_all is
			-- Create an assertion level which does not check assertions.
		do
			level := ck_require | ck_ensure | ck_check | ck_loop | ck_invariant
		ensure
			level_set: level = (ck_require | ck_ensure | ck_check | ck_loop | ck_invariant)
		end

feature -- Access

	level: INTEGER
			-- Coded assertion being checked.

feature -- Merge

	merge (other: ASSERTION_I) is
			-- Merge level of `other' into Current.
		require
			other_not_void: other /= Void
		do
			if other.level = 0 then
				level := 0
			else
				level := level | other.level
			end
		ensure
			level_set: other.level /= 0 implies (level & other.level) = other.level
			level_erased: other.level = 0 implies level = 0
		end

feature -- Status

	check_precond: BOOLEAN is
			-- Must preconditions be checked ?
		do
			Result := (level & ck_require) = ck_require
		end

	check_postcond: BOOLEAN is
			-- Must postconditions be checked ?
		do
			Result := (level & ck_ensure) = ck_ensure
		end

	check_invariant: BOOLEAN is
			-- must invariant be checked ?
		do
			Result := (level & ck_invariant) = ck_invariant
		end

	check_loop: BOOLEAN is
			-- Must loop assertions be checked ?
		do
			Result := (level & ck_loop) = ck_loop
		end

	check_check: BOOLEAN is
			-- Must check clauses be checked ?
		do
			Result := (level & ck_check) = ck_check
		end

	check_all: BOOLEAN is
			-- Must check all clauses?
		do
			Result := check_precond and check_postcond and check_invariant
				and check_loop and check_check
		end

feature -- Generation

	generate (buffer: GENERATION_BUFFER) is
			-- Generate assertion level in `file'.
		require
			good_argument: buffer /= Void
		do
			buffer.putstring ("(int16) ")
			buffer.putint (level)
		end

	make_byte_code (ba: BYTE_ARRAY) is
			-- Generate byte code representation of the assertion
		do
			ba.append_short_integer (level)
		end

feature -- Constants

	ck_require: INTEGER is 0x1
	ck_ensure: INTEGER is 0x2
	ck_check: INTEGER is 0x4
	ck_loop: INTEGER is 0x8
	ck_invariant: INTEGER is 0x10
			-- Value used during C generation to define assertion level.
			-- See values in `eif_option.h'.

end
