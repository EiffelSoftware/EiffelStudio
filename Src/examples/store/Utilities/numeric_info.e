note
	description: "Summary description for {NUMERIC_INFO}."
	date: "$Date$"
	revision: "$Revision$"

class
	NUMERIC_INFO

create
	make

feature

	int_16: INTEGER_16

	int_32: INTEGER_32

	int_64: INTEGER_64

	real_32_t: REAL_32

	real_64_t: REAL_64

	numeric_t: REAL_64

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

	set_numeric_t (i: REAL_64)
			-- Set `numeric_t' with `i'.
		do
			numeric_t := i
		end

	make
		do
		end

	out_32: STRING_32
			-- Display contents
		do
			create Result.make (100)
			Result.append ("int_16:")
			Result.append (int_16.out)
			Result.append ("%T")
			Result.append ("int_32:")
			Result.append (int_32.out)
			Result.append ("%T")
			Result.append ("int_64:")
			Result.append (int_64.out)
			Result.append ("%T")
			Result.append ("real_32_t:")
			Result.append (real_32_t.out)
			Result.append ("%T")
			Result.append ("real_64_t:")
			Result.append (real_64_t.out)
			Result.append ("%T")
			Result.append ("numeric_t:")
			Result.append (numeric_t.out)
			Result.append ("%T")
		end

end
