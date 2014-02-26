note
	description: "XMl utility routines"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	XML_ROUTINES

inherit
	XML_CALLBACKS_FILTER_FACTORY
		export
			{NONE} all
		end

	EW_SHARED_OBJECTS

feature -- Access

	deserialize_text (a_text: STRING): detachable XML_DOCUMENT
			-- Retrieve xml document from content of `a_text'.
			-- If deserialization fails, return Void.
		require
			text_void: a_text /= Void
		local
			l_parser: XML_LITE_STOPPABLE_PARSER
			l_tree: XML_CALLBACKS_NULL_FILTER_DOCUMENT
			l_concatenator: XML_CONTENT_CONCATENATOR
		do
			create l_parser.make
			create l_tree.make_null
			create l_concatenator.make_null
			l_parser.set_callbacks (standard_callbacks_pipe (<<l_concatenator, l_tree>>))
			l_parser.parse_from_string (a_text)
			if l_parser.is_correct then
				Result := l_tree.document
			end
		end

	document_text (a_doc: XML_DOCUMENT): STRING
			-- Full text of `a_doc', including all tags and content.
		require
			doc_not_void: a_doc /= Void
		local
			retried: BOOLEAN
			l_formatter: XML_FORMATTER
			l_output: XML_STRING_8_OUTPUT_STREAM
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
