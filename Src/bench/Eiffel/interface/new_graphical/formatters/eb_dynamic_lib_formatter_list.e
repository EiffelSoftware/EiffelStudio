indexing
	description:
		"Implementation of EB_FORMAT_LIST for %
			%the EiffelBench Dynamic library Tool"
	date: "$Date$"
	revision: "$Revision$"

class
	EB_DYNAMIC_LIB_FORMATTER_LIST

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
			
			Create {EB_DYNAMIC_TEXT_FORMATTER} f.make (tool)
			add_formatter (f)
			Create {EB_DYNAMIC_CLICKABLE_FORMATTER} f.make (tool)
			add_formatter (f)
		end

feature -- Constants

	default_format: EB_FORMATTER is
		do
			Result := first
		end

	text_format: EB_FORMATTER is
		do
			Result := first
		end

feature -- Constants

	separators: LINKED_LIST [INTEGER] is
			-- separators position in the format toolbar
		once
			create Result.make
		end

	tool: EB_DYNAMIC_LIB_TOOL

end -- class EB_DYNAMIC_LIB_FORMATTER_LIST
