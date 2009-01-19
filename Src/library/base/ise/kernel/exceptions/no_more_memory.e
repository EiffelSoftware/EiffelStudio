note
	description: "[
		Exception raised when no more memory can be allocated.
		]"
	library: "Free implementation of ELKS library"
	copyright: "Copyright (c) 1986-2006, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see forum.txt)"
	date: "$Date$"
	revision: "$Revision$"

class
	NO_MORE_MEMORY

inherit
	EIFFEL_RUNTIME_EXCEPTION

feature -- Access

	frozen code: INTEGER
			-- Exception code
		do
			if internal_code = {EXCEP_CONST}.Out_of_memory then
				Result := internal_code
			else
					-- Default to `No_more_memory'.
				Result := {EXCEP_CONST}.No_more_memory
			end
		end

feature {EXCEPTION_MANAGER} -- Status setting

	set_code (a_code: like code)
			-- Set `code' with `a_code'.
		do
			internal_code := code
		end

feature {NONE} -- Accesss

	frozen internal_meaning: STRING = "No more memory."

	internal_code: like code
			-- Internal code

end
