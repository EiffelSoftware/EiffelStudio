indexing
	description: "Actual type for integer type."
	date: "$Date$"
	revision: "$Revision$"

class
	INTEGER_A

inherit
	BASIC_A
		rename
			make as cl_make
		redefine
			is_integer, associated_class,
			same_as, is_numeric
		end

create
	make

feature {NONE} -- Initialization

	make (n: INTEGER) is
			-- Create instance of INTEGER_A represented by `n' bits.
		require
			valid_n: n = 8 or n = 16 or n = 32 or n = 64
		do
			size := n.to_integer_8
			cl_make (associated_class.class_id)
		ensure
			size_set: size = n
		end

feature -- Property

	is_integer: BOOLEAN is True
			-- Is the current type an integer type ?

	size: INTEGER_8
			-- Current is stored on `size' bits.
	
feature -- Access

	same_as (other: TYPE_A): BOOLEAN is
			-- Is the current type the same as `other' ?
		local
			i: INTEGER_A
		do
			Result := other.is_integer
			if Result then
				i ?= other
				Result := size = i.size
			end
		end

	associated_class: CLASS_C is
			-- Class INTEGER
		do
			inspect size
			when 8 then Result := System.integer_8_class.compiled_class
			when 16 then Result := System.integer_16_class.compiled_class
			when 32 then Result := System.integer_32_class.compiled_class
			when 64 then Result := System.integer_64_class.compiled_class
			end
		end

feature {COMPILER_EXPORTER}

	is_numeric: BOOLEAN is True
			-- Is the current type a numeric type ?

	type_i: LONG_I is
			-- C type
		do
			inspect size
			when 8 then Result := int8_c_type
			when 16 then Result := int16_c_type
			when 32 then Result := long_c_type
			when 64 then Result := int64_c_type
			end
		end

invariant
	correct_size: size = 8 or size = 16 or size = 32 or size = 64

end -- class INTEGER_A
