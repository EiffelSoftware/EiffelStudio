note
	description: "Unsupported Objective-C type declaration."
	date: "$Date$"
	revision: "$Revision$"

class
	OBJC_UNSUPPORTED_TYPE_DECL

inherit
	OBJC_TYPE_DECL
		redefine
			debug_output
		end

create
	make

feature -- Debug Output

	debug_output: STRING
			-- String that should be displayed in debugger to represent `Current'.
		do
			Result := "?"
		end

end
