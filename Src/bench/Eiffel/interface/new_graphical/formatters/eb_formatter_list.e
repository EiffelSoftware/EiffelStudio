indexing
	description: "Objects that ..."
	description: "List of formatters with its tree representation"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	EB_FORMATTER_LIST

inherit
	LINKED_LIST [EB_FORMATTER]
		rename
			make as make_list
		end

feature {NONE} -- Initialization

	make (a_tool: like tool) is
		do
			make_list
			tool := a_tool
		end

feature -- Access

	default_format: EB_FORMATTER is
		deferred
		end

feature -- Constants

	separators: LINKED_LIST [INTEGER] is
			-- separators position in the format toolbar
		deferred
		end

	tool: EB_EDITOR
 
feature -- Adding a formatter

	add_formatter (a_formatter: EB_FORMATTER) is
			-- Add `a_formatter' to the list of all formatters.
		require
			a_formatter_not_void: a_formatter /= Void
		do
			extend (a_formatter)
		ensure
			formatter_in_list: has (a_formatter)
		end

end -- class EB_FORMATTER_LIST
