indexing
	description: "Internal representation of class POINTER and TYPED_POINTER"
	date: "$Date$"
	revision: "$Revision$"

class POINTER_B 

inherit
	CLASS_B
		redefine
			actual_type, generate_cecil_value, cecil_value
		end

create
	make

feature -- Access

	actual_type: BASIC_A is
			-- Actual double type
		local
			l_formal: FORMAL_A
		do
			if generics /= Void then
				create l_formal
				l_formal.set_position (1)
				create {TYPED_POINTER_A} Result.make_typed (l_formal)
			else
				Result := Pointer_type
			end
		end

	cecil_value: INTEGER is
			-- Cecil value
		do
			Result := Sk_pointer 
		end

feature -- Code generation

	generate_cecil_value is
			-- Generate Cecil type value
		do
			generation_buffer.putstring ("SK_POINTER");
		end

end
