indexing
	description:	"Skeleton for inheritance clause parser"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date:				"$date$"
	revision: 		"$revision$"

deferred class
	CODE_INHERITANCE_CLAUSE_PARSER_SKELETON

inherit

	YY_NEW_PARSER_SKELETON
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

	Initial_feature_list_size: INTEGER is 4;
				-- Size of export clause feature list when initially created

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"


end -- class CODE_INHERITANCE_CLAUSE_PARSER_SKELETON

--+--------------------------------------------------------------------
--| Eiffel CodeDOM Provider
--| Copyright (C) 2001-2004 Eiffel Software
--| Eiffel Software Confidential
--| All rights reserved. Duplication and distribution prohibited.
--|
--| Eiffel Software
--| 356 Storke Road, Goleta, CA 93117 USA
--| http://www.eiffel.com
--+--------------------------------------------------------------------