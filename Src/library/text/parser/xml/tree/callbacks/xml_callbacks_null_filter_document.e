note
	description: "[
			Callbacks to build the associated XML_DOCUMENT, conforming to CALLBACKS_FILTER ... without really implementing it
			
			This should be almost a duplication of {XML_CALLBACKS_DOCUMENT}, 
			except for the conformance to XML_CALLBACKS_FILTER
		]"
	date: "$Date$"
	revision: "$Revision$"

class
	XML_CALLBACKS_NULL_FILTER_DOCUMENT

inherit
	XML_CALLBACKS_FILTER
		undefine
			on_start,
			on_finish,
			on_xml_declaration,
			on_error,
			on_processing_instruction,
			on_content,
			on_comment,
			on_start_tag,
			on_start_tag_finish,
			on_end_tag,
			on_attribute,
			has_resolved_namespaces
		redefine
			make_null
		end

	XML_CALLBACKS_DOCUMENT
		redefine
			make_null
		end

create
	make_null

feature {NONE} -- Initialization

	make_null
			-- Instanciate current tree builder.
		do
			Precursor {XML_CALLBACKS_FILTER}
			Precursor {XML_CALLBACKS_DOCUMENT}
		end

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
