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

	set_from_array (v:  ARRAY [ANY])
		local
			i1: detachable INTEGER_16_REF
			i2: detachable INTEGER_32_REF
			i3: detachable INTEGER_64_REF
			r1: detachable REAL_32_REF
			r2, r3: detachable REAL_64_REF
		do
			if attached {INTEGER_16_REF} v.item (1) as l_int16 then
				i1 := l_int16
			end

			if attached {INTEGER_32_REF} v.item (2) as l_int32 then
				i2 := l_int32
			end

			if attached {INTEGER_64_REF} v.item (3) as l_int64 then
				i3 := l_int64
			end

			if attached {REAL_32_REF} v.item (4) as l_r1 then
				r1 := l_r1
			end

			if attached {REAL_64_REF} v.item (5) as l_r2 then
				r2 := l_r2
			end

			if attached {REAL_64_REF} v.item (6) as l_r3 then
				r3 := l_r3
			end

			check i1 /= Void end -- FIXME: implied by...?
			int_16 := i1.item
			check i2 /= Void end -- FIXME: implied by...?
			int_32 := i2.item
			check i3 /= Void end -- FIXME: implied by...?
			int_64 := i3.item

			check r1 /= Void end -- FIXME: implied by...?
			real_32_t := r1.item
			check r2 /= Void end -- FIXME: implied by...?
			real_64_t := r2.item
			check r3 /= Void end -- FIXME: implied by...?
			numeric_t := r3.item
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
