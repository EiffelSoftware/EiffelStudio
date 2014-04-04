note
	description: "Summary description for {NUMERIC_INFO}."
	date: "$Date$"
	revision: "$Revision$"

class
	NUMERIC_INFO_WITH_DECIMAL

inherit
	ANY
		redefine
			is_equal
		end

create
	make

feature {NONE} -- Init

	make
		do
			create numeric_t
			create other_numeric_t
		end

feature -- Access

	int_16: INTEGER_16

	int_32: INTEGER_32

	int_64: INTEGER_64

	real_32_t: REAL_32

	real_64_t: REAL_64

	numeric_t, other_numeric_t: DECIMAL

feature -- Query

	is_equal (other: like Current): BOOLEAN
			-- Is `other' attached to an object considered
			-- equal to current object?
		do
			Result :=
					int_16 = other.int_16 and then
					int_32 = other.int_32 and then
					int_64 = other.int_64 and then
					real_32_t = other.real_32_t and then
					real_64_t = other.real_64_t and then
					numeric_t ~ other.numeric_t and then
					other_numeric_t ~ other.other_numeric_t
		end

feature -- Element Change

	set_int_16 (i: INTEGER_16)
			-- Set `int_16' with `i'.
		do
			int_16 := i
		end

	set_int_32 (i: INTEGER_32)
			-- Set `int_32' with `i'.
		do
			int_32 := i
		end

	set_int_64 (i: INTEGER_64)
			-- Set `int_64' with `i'.
		do
			int_64 := i
		end

	set_real_32_t (i: REAL_32)
			-- Set `real_32_t' with `i'.
		do
			real_32_t := i
		end

	set_real_64_t (i: REAL_64)
			-- Set `real_64_t' with `i'.
		do
			real_64_t := i
		end

	set_numeric_t (i: DECIMAL)
			-- Set `numeric_t' with `i'.
		do
			numeric_t := i
		end

	set_other_numeric_t (i: DECIMAL)
			-- Set `numeric_t' with `i'.
		do
			other_numeric_t := i
		end

feature -- Output

	out_32: STRING_32
			-- Display contents
		do
			create Result.make (100)
			Result.append_string_general ("int_16:")
			Result.append_string_general (int_16.out)
			Result.append_string_general ("%T")
			Result.append_string_general ("int_32:")
			Result.append_string_general (int_32.out)
			Result.append_string_general ("%T")
			Result.append_string_general ("int_64:")
			Result.append_string_general (int_64.out)
			Result.append_string_general ("%T")
			Result.append_string_general ("real_32_t:")
			Result.append_string_general (real_32_t.out)
			Result.append_string_general ("%T")
			Result.append_string_general ("real_64_t:")
			Result.append_string_general (real_64_t.out)
			Result.append_string_general ("%T")
			Result.append_string_general ("numeric_t:")
			Result.append_string_general (numeric_t.out)
			Result.append_string_general ("%T")
		end

end
