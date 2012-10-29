note
	description: "Summary description for {XML_DECLARATION}."
	date: "$Date$"
	revision: "$Revision$"

class
	XML_DECLARATION

inherit
	XML_DOCUMENT_NODE

create
	make_in_document

feature {NONE} -- Initialization

	make_in_document (a_parent: XML_DOCUMENT; a_version: like version; a_encoding: detachable like encoding; a_standalone: BOOLEAN)
			-- Create a new xml declaration node.
			-- and add it to parent.
		require
			a_parent_not_void: a_parent /= Void
			a_version_not_void: a_version /= Void
			valid_version: a_version.is_valid_as_string_8
			valid_encoding: a_encoding /= Void implies a_encoding.is_valid_as_string_8
		do
			set_version (a_version)
			set_encoding (a_encoding)
			set_standalone (a_standalone)
			parent := a_parent
			a_parent.set_xml_declaration (Current)
		ensure
			parent_set: parent = a_parent
			in_parent: a_parent.xml_declaration = Current
			version_set: a_version.same_string (version)
		end

feature -- Access

	version: READABLE_STRING_32

	encoding: detachable READABLE_STRING_32

	standalone: BOOLEAN

feature -- Setting

	set_version (a_version: like version)
			-- Set version.
		require
			a_version_not_void: a_version /= Void
			valid_version: a_version.is_valid_as_string_8
		do
			version := a_version
		ensure
			set: a_version.same_string (version)
		end

	set_encoding (a_encoding: like encoding)
			-- Set encoding.
		require
			valid_encoding: a_encoding /= Void implies a_encoding.is_valid_as_string_8
		do
			encoding := a_encoding
		end

	set_standalone (a_standalone: like standalone)
			-- Set standalone
		do
			standalone := a_standalone
		end

feature -- Visitor processing

	process (a_processor: XML_NODE_VISITOR)
			-- Process current node with `a_processor'.
		do
			a_processor.process_xml_declaration (Current)
		end

invariant

	version_not_void: version /= Void

note
	copyright: "Copyright (c) 1984-2012, Eiffel Software and others"
	license:   "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
