indexing
	description: "Implementation of EB_FORMAT_LIST for the EiffelBench Feature Tool"
	date: "$Date$"
	revision: "$Revision$"

class
	EB_FEATURE_FORMATTER_LIST

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
			Create {EB_FEATURE_FLAT_FORMATTER} f.make (tool)
			add_formatter (f)
			Create {EB_BREAKPOINTS_FORMATTER} f.make (tool)
			add_formatter (f)

			Create {EB_FEATURE_CALLERS_FORMATTER} f.make (tool)
			add_formatter (f)
			Create {EB_FEATURE_HISTORY_FORMATTER} f.make (tool)
			add_formatter (f)
			Create {EB_PAST_FORMATTER} f.make (tool)
			add_formatter (f)
			Create {EB_FUTURE_FORMATTER} f.make (tool)
			add_formatter (f)
			Create {EB_HOMONYMS_FORMATTER} f.make (tool)
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
			Result.extend (3)
		end

	tool: EB_FEATURE_TOOL

end -- class EB_FEATURE_FORMATTER_LIST
