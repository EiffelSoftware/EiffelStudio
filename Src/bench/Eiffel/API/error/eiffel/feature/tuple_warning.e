indexing
	description: "Warning for accepting old TUPLE conformance, but to remind user code that this code will %
		%be disallowed in the future."
	date: "$Date$"
	revision: "$Revision$"

class
	TUPLE_WARNING

inherit
	VJAR
		redefine
			code
		end

	WARNING
		undefine
			error_string,
			trace,
			is_defined
		end

feature -- Status report

	code: STRING is "TUPLE_WARNING"
			-- Code of error.
	
end -- class TUPLE_WARNING
