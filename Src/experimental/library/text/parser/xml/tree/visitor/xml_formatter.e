note

	description:
		"[
			Generators of XML documents from XML trees (wrapper for output filters)

			Note: the original code is from Gobo's XM library (http://www.gobosoft.com/)
		]"
	date: "$Date$"
	revision: "$Revision$"

class XML_FORMATTER

inherit
	XML_NODE_ITERATOR
		redefine
			process_document
		end

create

	make

feature {NONE} -- Initialization

	make
			-- Create a new XML formatter.
		do
			create {XML_NULL_OUTPUT_STREAM} last_output.make
		end

feature -- Access

	last_output: XML_OUTPUT_STREAM
			-- Output stream

	set_output_file (a_file: FILE)
			-- Set output stream based on `a_file'.
		require
			not_void: a_file /= Void
			is_open_write: a_file.is_open_write
		do
			set_output (create {XML_FILE_OUTPUT_STREAM}.make (a_file))
		end

	set_output (an_output: like last_output)
			-- Set output stream.
		require
			not_void: an_output /= Void
		do
			last_output := an_output
		end

feature -- Tree processor routines

	process_document (a_document: XML_DOCUMENT)
			-- Process document using xmlns generator and pretty print filters.
		local
			pretty_print: XML_PRETTY_PRINT_FILTER
			xmlns_generator: XML_XMLNS_GENERATOR
		do
			create pretty_print.make_null
			pretty_print.set_output_stream (last_output)
			create xmlns_generator.set_next (pretty_print)
			a_document.process_to_events (xmlns_generator)
		end

invariant

	last_output_not_void: last_output /= Void

note
	copyright: "Copyright (c) 1984-2012, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
