indexing
	description: "Implementation of EB_FORMAT_LIST for the EiffelBench Class Tool"
	date: "$Date$"
	revision: "$Revision$"

class
	EB_CLASS_FORMATTER_LIST

inherit
	EB_FORMATTER_LIST
		redefine
			make, tool
		end

creation
	make

feature {NONE} -- Initialization

	make (a_tool: like tool) is
			-- initialize the panel list
		local
			f : EB_FORMATTER
		do
			Precursor (a_tool)
			
			Create {EB_TEXT_FORMATTER} f.make (tool)
			add_formatter (f)

		end

feature -- Constants

	default_format: EB_FORMATTER is
		do
			Result := first
		end

feature -- Constants

	separators: LINKED_LIST [INTEGER] is
			-- separators position in the format toolbar
		once
			create Result.make
			Result.extend (5)
			Result.extend (9)
		end

	tool: EB_CLASS_TOOL

end -- class EB_CLASS_FORMATTER_LIST
