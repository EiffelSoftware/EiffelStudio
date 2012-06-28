indexing

	description:

		"Error: Unrecognized %%option"

	library: "Gobo Eiffel Lexical Library"
	copyright: "Copyright (c) 1999, Eric Bezault and others"
	license: "MIT License"
	date: "$Date$"
	revision: "$Revision$"

class LX_UNRECOGNIZED_OPTION_ERROR

inherit

	UT_ERROR

create

	make

feature {NONE} -- Initialization

	make (filename: STRING; line: INTEGER; option: STRING) is
			-- Create a new error reporting 
			-- unrecoginzed %option `option'.
		require
			filename_not_void: filename /= Void
			option_not_void: option /= Void
		do
			create parameters.make (1, 3)
			parameters.put (filename, 1)
			parameters.put (line.out, 2)
			parameters.put (option, 3)
		end

feature -- Access

	default_template: STRING is "%"$1%", line $2: unrecognized %%option: $3"
			-- Default template used to built the error message

	code: STRING is "LX0024"
			-- Error code

invariant

--	dollar0: $0 = program name
--	dollar1: $1 = filename
--	dollar2: $2 = line number
--	dollar3: $3 = option

end
