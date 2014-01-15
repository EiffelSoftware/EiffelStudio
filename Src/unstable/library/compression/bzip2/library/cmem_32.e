note

    description:"[
    			represents a 32 Bit integer type
        		conversion routines from and to pointer implemented
        		]"

    library:    "ELJ/base"
    author:     "Uwe Sander"
	copyright:  "Copyright (c) 2002, Uwe Sander and others"
    license:    "Eiffel Forum License v1"
    date:       "$Date$"
    revision:   "$Revision$"
    last:       "$Author$"
	status:     "Stable"
	complete:   "yes"

expanded class CMEM_32

inherit
	CMEM_I

feature { NONE }

	ptr (a_value: POINTER): POINTER
		do
			Result := a_value
		end

feature { ANY }

	to_external: POINTER 
		do
			Result := ptr ($mem_32);
		end


feature { ANY }

	to_integer: INTEGER
		do
			Result := mem_32
		end

	to_real: REAL
		do
			Result := mem_32
		end

	to_double: DOUBLE
		do
			Result := mem_32
		end

	as_pointer: POINTER
		do
			Result := integer_as_pointer (mem_32)
		end

	from_integer (a_value: INTEGER)
		do
			mem_32 := a_value
		end

	from_pointer (a_value: POINTER)
		do
			mem_32 := pointer_as_integer (a_value)
		end

	from_external (a_value: POINTER)
		do
			mem_32 := deref_pointer_to_integer (a_value)
		end

end
