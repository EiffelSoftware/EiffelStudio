indexing
	description: "Actual type for natural type."
	date: "$Date$"
	revision: "$Revision$"

class
	NATURAL_A

inherit
	BASIC_A
		rename
			make as cl_make
		redefine
			is_natural, associated_class,
			same_as, is_numeric
		end

create
	make

feature {NONE} -- Initialization

	make (n: INTEGER) is
			-- Create instance of NATURAL_A represented by `n' bits.
		require
			valid_n: n = 8 or n = 16 or n = 32 or n = 64
		do
			size := n.to_integer_8
			cl_make (associated_class.class_id)
		ensure
			size_set: size = n
		end

feature -- Property

	is_natural: BOOLEAN is True
			-- Is the current type an natural type ?

	size: INTEGER_8
			-- Current is stored on `size' bits.
	
feature -- Access

	same_as (other: TYPE_A): BOOLEAN is
			-- Is the current type the same as `other' ?
		local
			i: NATURAL_A
		do
			Result := other.is_natural
			if Result then
				i ?= other
				Result := size = i.size
			end
		end

	associated_class: CLASS_C is
			-- Class NATURAL
		do
			inspect size
			when 8 then Result := System.natural_8_class.compiled_class
			when 16 then Result := System.natural_16_class.compiled_class
			when 32 then Result := System.natural_32_class.compiled_class
			when 64 then Result := System.natural_64_class.compiled_class
			end
		end

feature {COMPILER_EXPORTER}

	is_numeric: BOOLEAN is True
			-- Is the current type a numeric type ?

	type_i: NATURAL_I is
			-- C type
		do
			inspect size
			when 8 then Result := uint8_c_type
			when 16 then Result := uint16_c_type
			when 32 then Result := uint32_c_type
			when 64 then Result := uint64_c_type
			end
		end

invariant
	correct_size: size = 8 or size = 16 or size = 32 or size = 64

end
