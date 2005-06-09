indexing
	description: "Description of an actual Native array type for IL code generation."
	date: "$Date$"
	revision: "$Revision$"

class
	NATIVE_ARRAY_TYPE_I

inherit
	ONE_GEN_TYPE_I
	
create
	make

feature -- Access

	il_type_name (a_prefix: STRING): STRING is
			-- Name of current class
		do
			Result := true_generics.item (1).il_type_name (a_prefix).twin
			Result.append ("[]")
		end

	deep_il_element_type: CL_TYPE_I is
			-- Find type of array element.
			-- I.e. if you have NATIVE_ARRAY [NATIVE_ARRAY [INTEGER]], it
			-- will return INTEGER.
		require
			true_generics_not_void: true_generics /= Void
		local
			l_native: NATIVE_ARRAY_TYPE_I
		do
			Result ?= true_generics.item (1)
			if Result = Void then
				Result := object_type
			else
				l_native ?= Result
				if l_native /= Void then
					Result := l_native.deep_il_element_type
				end
			end
		ensure
			deep_il_element_type_not_void: Result /= Void
		end

invariant
	il_generation: System.il_generation
		
end
