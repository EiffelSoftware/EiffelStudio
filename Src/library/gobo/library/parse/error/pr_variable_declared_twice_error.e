indexing

	description:

		"Error: Variable declared twice"

	library:    "Gobo Eiffel Parse Library"
	author:     "Eric Bezault <ericb@gobo.demon.co.uk>"
	copyright:  "Copyright (c) 1999, Eric Bezault"
	date:       "$Date$"
	revision:   "$Revision$"

class PR_VARIABLE_DECLARED_TWICE_ERROR

inherit

	UT_ERROR

creation

	make

feature {NONE} -- Initialization

	make (filename: STRING; line: INTEGER; a_name: STRING) is
			-- Create a new error reporting that the variable
			-- `a_name' has been declared twice.
		require
			filename_not_void: filename /= Void
			a_name_not_void: a_name /= Void
		do
			!! parameters.make (1, 3)
			parameters.put (filename, 1)
			parameters.put (line.out, 2)
			parameters.put (a_name, 3)
		end

feature -- Access

	default_template: STRING is "%"$1%", line $2: nonterminal $3 declared twice" 
			-- Default template used to built the error message

	code: STRING is "PR0016"
			-- Error code

invariant

	-- dollar0: $0 = program name
	-- dollar1: $1 = filename
	-- dollar2: $2 = line number
	-- dollar3: $3 = variable name

end -- class PR_VARIABLE_DECLARED_TWICE_ERROR
