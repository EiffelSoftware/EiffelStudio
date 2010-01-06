note
	description: "XMl utility routines"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	XML_ROUTINES

inherit
	XM_CALLBACKS_FILTER_FACTORY
		export
			{NONE} all
		end
	
	SHARED_OBJECTS

feature -- Access

	deserialize_text (a_text: STRING): XM_DOCUMENT
			-- Retrieve xml document from content of `a_text'.
			-- If deserialization fails, return Void.
		require
			text_void: a_text /= Void
		local
			l_parser: XM_EIFFEL_PARSER
			l_tree_pipe: XM_TREE_CALLBACKS_PIPE
			l_xm_concatenator: XM_CALLBACKS_FILTER
		do
			create l_parser.make
			l_parser.set_string_mode_mixed
			create l_tree_pipe.make
			create l_xm_concatenator.make_null
			l_parser.set_callbacks (standard_callbacks_pipe (<<l_xm_concatenator, l_tree_pipe.start>>))
			l_parser.parse_from_string (a_text)
			if l_parser.is_correct then
				if not l_tree_pipe.error.has_error then
					Result := l_tree_pipe.document			
				end
			else
				Result := Void
			end
		end

	document_text (a_doc: XM_DOCUMENT): STRING
			-- Full text of `a_doc', including all tags and content.
		require
			doc_not_void: a_doc /= Void
		local
			retried: BOOLEAN
			l_formatter: XM_FORMATTER
			l_output: KL_STRING_OUTPUT_STREAM
		do				
			if not retried then
				create l_formatter.make
				create l_output.make_empty
				l_formatter.set_output (l_output)
				l_formatter.process_document (a_doc)
				Result := l_output.string
			end
		rescue
			retried := True
			output.append_error ("Unable to read file.", True)
			retry
		end

note
	copyright: "[
			Copyright (c) 1984-2007, University of Southern California and contributors.
			All rights reserved.
			]"
	license:   "Your use of this work is governed under the terms of the GNU General Public License version 2"
	copying: "[
			This file is part of the EiffelWeasel Eiffel Regression Tester.

			The EiffelWeasel Eiffel Regression Tester is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License version 2 as published
			by the Free Software Foundation.

			The EiffelWeasel Eiffel Regression Tester is
			distributed in the hope that it will be useful, but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the GNU General Public License version 2 for more details.

			You should have received a copy of the GNU General Public
			License version 2 along with the EiffelWeasel Eiffel Regression Tester
			if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA
		]"


end -- class XML_ROUTINES
