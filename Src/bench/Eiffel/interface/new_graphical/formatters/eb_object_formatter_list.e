indexing
	description: "Implementation of EB_FORMAT_LIST for the $EiffelGraphicalCompiler$ Object Tool"
	date: "$Date$"
	revision: "$Revision$"

class
	EB_OBJECT_FORMATTER_LIST

inherit
	EB_FORMATTER_LIST
		redefine
			make, tool
		end

create
	make

feature {NONE} -- Initialization

	make (a_tool: like tool) is
			-- initialize the panel list
		local
			f : EB_FORMATTER
		do
			Precursor {EB_FORMATTER_LIST} (a_tool)
			
			create {EB_ATTRIBUTE_VALUES_FORMATTER} f.make (tool)
			add_formatter (f)
			create {EB_ONCE_RESULTS_FORMATTER} f.make (tool)
			add_formatter (f)
		end

feature -- Constants

	default_format: EB_FORMATTER is
		do
			Result := first
		end

	text_format: EB_FORMATTER is
			-- No text format for the object tool
		do
		end

feature -- Constants

	separators: LINKED_LIST [INTEGER] is
			-- separators position in the format toolbar
		once
			create Result.make
		end

	tool: EB_OBJECT_TOOL

end -- class EB_OBJECT_FORMATTER_LIST
