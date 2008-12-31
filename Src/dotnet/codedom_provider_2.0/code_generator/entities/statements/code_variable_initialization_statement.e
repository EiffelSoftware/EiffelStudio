note
	description: "Initialize generated local variable whose type is expanded and generated for use in default value expression"
	date: "$$"
	revision: "$$"

class
	CODE_VARIABLE_INITIALIZATION_STATEMENT

inherit
	CODE_STATEMENT

create
	make

feature {NONE} -- Initialization

	make (a_variable: STRING)
			-- Initialize `variable'.
		require
			non_void_variable: a_variable /= Void
		do
			variable := a_variable
		ensure
			variable_set: variable = a_variable
		end

feature -- Access

	variable: STRING
			-- Variable

	need_dummy: BOOLEAN
			-- Does statement require dummy local variable?
		do
			Result := False
		end

feature -- Code generation

	code: STRING
			-- Result := "create `variable'"
			-- Eiffel code of variable initialization statement
		do
			create Result.make (7 + variable.count)
			if line_pragma /= Void then
				Result.append (line_pragma.code)
			end
			Result.append ("create ")
			Result.append (variable)
		end

invariant
	non_void_variable: variable /= Void

end -- class CODE_VARIABLE_INITIALIZATION_STATEMENT

