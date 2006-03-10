indexing
	description: "Process AST to text formatter."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	AST_OUTPUT_STRATEGY

inherit
	AST_VISITOR

feature -- Access

	text_formatter: TEXT_FORMATTER
			-- Handle text formatting.

end -- class AST_OUTPUT_STRATEGY
