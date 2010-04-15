note
	description: "Callbacks to build the associated XML_DOCUMENT"
	date: "$Date$"
	revision: "$Revision$"

class
	XML_CALLBACKS_TREE

inherit
	XML_CALLBACKS
		redefine
			has_resolved_namespaces
		end

create
	make

feature {NONE} -- Initialization

	make
		do
			create document.make
			create namespace_cache.make (0)
		end

feature -- Element change

	set_source_parser (a_parser: XML_PARSER)
			-- Set `source_parser' to `a_parser'
		do
			source_parser := a_parser
		end

feature -- Result

	document: XML_DOCUMENT
			-- Resulting document	

feature -- Document

	on_start
			-- Called when parsing starts.
		do
			create document.make
			current_element := Void

			namespace_cache.wipe_out
			namespace_cache.compare_objects
		end

	on_finish
			-- Called when parsing finished.
		do
		end

	on_xml_declaration (a_version: STRING; a_encoding: detachable STRING; a_standalone: BOOLEAN)
			-- XML declaration.
		do
			debug
				print ("[debug] on_xml_declaration: version=" + a_version + " encoding=" + text (a_encoding, "") + "%N")
			end
		end

feature -- Errors

	on_error (a_message: STRING)
			-- Event producer detected an error.
		do
			debug
				print ("[debug] on_error: message=" + a_message + "%N")
			end
		end

feature -- Meta

	on_processing_instruction (a_name: STRING; a_content: STRING)
			-- Processing instruction.
		local
			xml: XML_PROCESSING_INSTRUCTION
		do
			if attached current_element as curr then
				create xml.make_last (curr, a_name, a_content)
			else
				create xml.make_last_in_document (document, a_name, a_content)
			end
			handle_position (xml)
		end

	on_comment (a_content: STRING)
			-- Processing a comment.
		local
			xml: XML_COMMENT
		do
			if attached current_element as curr then
				create xml.make_last (curr, a_content)
			else
				create xml.make_last_in_document (document, a_content)
			end
			handle_position (xml)
		end

feature -- Tag

	on_start_tag (a_namespace: STRING; a_ns_prefix: STRING; a_local_part: STRING)
			-- Start of start tag.
		local
			an_element: XML_ELEMENT
		do
			if attached current_element as curr then
					-- This is not the first element in the parent.
				create an_element.make_last (curr, a_local_part, new_namespace (a_namespace, a_ns_prefix))
			else
					-- This is the first element in the document.
				create an_element.make_root (document, a_local_part, new_namespace (a_namespace, a_ns_prefix))
			end
			current_element := an_element
			handle_position (an_element)
		ensure then
			element_not_void: current_element /= Void
		end

	on_attribute (a_namespace: STRING; a_prefix: STRING; a_local_part: STRING; a_value: STRING)
			-- Start of attribute.
		local
			xml: XML_ATTRIBUTE
		do
			if attached current_element as curr then
				create xml.make_last (a_local_part, new_namespace (a_namespace, a_prefix), a_value, curr)
				handle_position (xml)
			else
				report_error ("on_attribute::missing current_element in " + generator)
			end
		end

	on_start_tag_finish
			-- End of start tag.
		do
		end

	on_end_tag (a_namespace: STRING; a_prefix: STRING; a_local_part: STRING)
			-- End tag.
		do
			if attached current_element as curr then
				if attached curr.parent as curr_parent and then curr_parent.is_root_node then
					current_element := Void
				else
					current_element := curr.parent_element
				end
			else
				report_error ("on_end_tag::missing current_element in " + generator)
			end
		end

feature -- Content

	on_content (a_content: STRING)
			-- Text content.
			-- NOT atomic: two on_content events may follow each other
			-- without a markup event in between.
		local
			xml: XML_CHARACTER_DATA
		do
			if attached current_element as curr then
				create xml.make_last (curr, a_content)
			else
					-- Content on the root level, should we ignore it?
				create xml.make_last (document.root_element, a_content)
			end
			handle_position (xml)
		end

feature -- Events mode

	has_resolved_namespaces: BOOLEAN
			-- Namespaces required
		do
			Result := True
		end

feature {NONE} -- Formatter

	text (s: detachable STRING; dft: STRING): STRING
			-- String representation of `s'
			-- if `s' is Void return `dft'
		do
			if s = Void then
				Result := dft
			else
				Result := s
			end
		end

feature {NONE} -- Implementation

	current_element: detachable XML_ELEMENT
			-- Current element

	source_parser: detachable XML_PARSER
			-- Source parser

	namespace_cache: HASH_TABLE [XML_NAMESPACE, XML_NAMESPACE]
			-- namespace cache

feature {NONE} -- Implementation

	report_error (a_msg: STRING)
			-- Report error `a_msg' to the `source_parser'
		do
			if attached source_parser as parser then
				parser.report_error_from_callback (a_msg)
			end
		end

	handle_position (a_node: XML_NODE)
			-- If desired, store position information of
			-- node `a_node' in position table.
		require
			a_node_not_void: a_node /= Void
		do
			-- Not Yet Implemented
		end

	new_namespace (a_uri, a_prefix: STRING): XML_NAMESPACE
			-- Create namespace object.	
		do
			create Result.make (a_prefix, a_uri)

			-- share namespace nodes
			check cache_initialised: namespace_cache /= Void end
			-- XML_NAMESPACE is hashable/equal on uri only,
			-- so we must explicitely check if the cached namespace
			-- has the same prefix
			if
				namespace_cache.has (Result) and then
				attached namespace_cache.item (Result) as cached_prefix and then
				cached_prefix.same_prefix (Result)
			then
				Result := cached_prefix
			else
				namespace_cache.force (Result, Result)
			end
		ensure
			result_not_void: Result /= Void
		end

note
	copyright: "Copyright (c) 1984-2010, Eiffel Software and others"
	license:   "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
