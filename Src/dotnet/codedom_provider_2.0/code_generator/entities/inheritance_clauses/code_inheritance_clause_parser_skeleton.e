indexing
	description:	"Skeleton for inheritance clause parser"
	date:				"$date$"
	revision: 		"$revision$"

deferred class
	CODE_INHERITANCE_CLAUSE_PARSER_SKELETON

inherit

	YY_PARSER_SKELETON
		rename
			parse as yyparse,
			make as make_parser
		redefine
			report_error
		end

	CODE_INHERITANCE_CLAUSE_SCANNER
		rename
			make as make_scanner
		end

feature {NONE} -- Initialization

	make is
			-- Initialize parser.
		do
			make_parser
			make_scanner
		end

feature -- Access

	parents: LIST [CODE_SNIPPET_PARENT]
			-- Parse results

	error_handler: ROUTINE [ANY, TUPLE [STRING]]
			-- Error handler

feature -- Element Settings

	set_error_handler (a_handler: like error_handler) is
			-- Set `error_handler' with `a_handler'.
		require
			non_void_handler: a_handler /= Void
		do
			error_handler := a_handler
		ensure
			handler_set: error_handler = a_handler
		end
		
feature -- Basic Operations

	parse (a_clause: STRING) is
			-- Parse inheritance clause text from `a_clause'.
			-- Make result available in `root_node'.
		local
			l_retried: BOOLEAN
		do
			if not l_retried then
				parents := Void
				create input_buffer.make (a_clause)
				yy_load_input_buffer
				yyparse
				reset
			else
				report_error ((create {EXCEPTIONS}).out)
			end
		rescue
			reset
			l_retried := True
			retry
		end

	report_error (a_message: STRING) is
				-- Log error if settings requires logging
		do
			if error_handler /= Void then
				error_handler.call ([a_message])
			end
		end

feature -- Private Access

	Initial_parent_list_size: INTEGER is 4
				-- Size of `parents' list when initially created

	Initial_clause_list_size: INTEGER is 4
				-- Size of inheritance clauses lists when initially created

	Initial_feature_list_size: INTEGER is 4
				-- Size of export clause feature list when initially created

end -- class CODE_INHERITANCE_CLAUSE_PARSER_SKELETON

--+--------------------------------------------------------------------
--| Eiffel CodeDOM Provider
--| Copyright (C) 2001-2006 Eiffel Software
--| Eiffel Software Confidential
--| All rights reserved. Duplication and distribution prohibited.
--|
--| Eiffel Software
--| 356 Storke Road, Goleta, CA 93117 USA
--| http://www.eiffel.com
--+--------------------------------------------------------------------