note

	description:

		"Objects that represent an XML document as an Eiffel STRING"

	library: "Gobo Eiffel XSLT Library"
	copyright: "Copyright (c) 2005-2015, Colin Adams and others"
	license: "MIT License"
	date: "$Date$"
	revision: "$Revision$"

class	XM_XSLT_STRING_SOURCE

inherit

	XM_XSLT_SOURCE

	XM_SHARED_CATALOG_MANAGER
		export {NONE} all end

	KL_IMPORTED_STRING_ROUTINES
		export {NONE} all end

		-- This class is NOT intended to be used for system-ids of the string: protocol
		--  (for that, use an XM_XSLT_URI_SOURCE). Rather it is designed for creating
		--  composite stylesheets (see XM_XSLT_TRANSFORMER_FACTORY)

create

	make

feature {NONE} -- Initialization

	make (a_system_id, a_source_text: STRING)
			-- Establish invariant.
		require
			system_id_not_void: a_system_id /= Void
			source_text_not_void: a_source_text /= Void
		local
			a_uri: UT_URI
		do
			create default_media_type.make ("application", "xslt+xml")
			create a_uri.make (a_system_id)
			system_id := a_uri.full_uri
			if a_uri.has_fragment then
				check attached a_uri.fragment_item as l_fragment_item then
					fragment_identifier := l_fragment_item.decoded_utf8
				end
			end
			source_text := a_source_text
		ensure
			system_id_set: fragment_identifier = Void implies STRING_.same_string (system_id, a_system_id)
			source_text_set: source_text = a_source_text
		end

feature -- Access

	system_id: STRING
			-- System-id of source

	fragment_identifier: detachable STRING
			-- Possible decoded fragment identifier

	default_media_type: UT_MEDIA_TYPE
			-- Default media type for stylesheet processing

	media_type: detachable UT_MEDIA_TYPE
			-- Media type of document entity

feature -- Events

	send (a_parser: XM_PARSER; a_receiver: XM_XPATH_RECEIVER; a_uri: UT_URI; is_stylesheet: BOOLEAN)
			-- Generate and send  events to `a_receiver'
		local
			l_locator: XM_XPATH_RESOLVER_LOCATOR
			l_uri: UT_URI
			l_error: like error
			l_content_emitter: like content_emitter
			l_namespace_resolver: like namespace_resolver
			l_attributes: like attributes
			l_content: like content
			l_xpointer_filter: like xpointer_filter
			l_start: like start
		do
			shared_catalog_manager.reset_pi_catalogs
			l_error := a_parser.new_stop_on_error_filter
			error := l_error
			create l_content_emitter.make (a_receiver, l_error)
			content_emitter := l_content_emitter
			create l_namespace_resolver.make_next (l_content_emitter)
			namespace_resolver := l_namespace_resolver
			l_namespace_resolver.set_forward_xmlns (True)
			create l_attributes.make_next (l_namespace_resolver)
			attributes := l_attributes
			l_attributes.set_next_dtd (l_content_emitter)
			create l_content.make_next (l_attributes)
			content := l_content
			create oasis_xml_catalog_filter.make_next (l_content, l_content_emitter)
			if attached {XM_URI_EXTERNAL_RESOLVER} a_parser.entity_resolver as l_resolver then
				check attached oasis_xml_catalog_filter as l_oasis_xml_catalog_filter then
					create l_xpointer_filter.make (" ", default_media_type, l_resolver, l_oasis_xml_catalog_filter, l_oasis_xml_catalog_filter)
					xpointer_filter := l_xpointer_filter
					if not attached fragment_identifier as l_fragment_identifier or else not is_stylesheet then
						l_xpointer_filter.set_no_filtering
					else
						l_xpointer_filter.set_xpointer (l_fragment_identifier)
						if are_media_type_ignored then
							l_xpointer_filter.ignore_media_types
						else
							l_xpointer_filter.allow_generic_xml_types (True)
							l_xpointer_filter.add_standard_media_types
						end
					end
					create l_start.make_next (l_xpointer_filter)
					start := l_start
					create l_locator.make (a_parser)
					a_receiver.set_document_locator (l_locator)
					a_parser.set_callbacks (l_start)
					a_parser.set_dtd_callbacks (l_xpointer_filter)
					if l_resolver /= Void then
						create l_uri.make (system_id)
						l_resolver.push_uri (l_uri)
					end
					a_parser.parse_from_string (source_text)
					media_type := l_xpointer_filter.media_type
				end
			end
		end

feature -- Element change

	set_system_id (a_system_id: STRING)
			-- Set `system_id'.
		do
			system_id := a_system_id
		end

feature {NONE} -- Implementation

	source_text: STRING
			-- Text of XML document

	xpointer_filter: detachable XM_XPOINTER_EVENT_FILTER
			-- Filter for fragment identifiers

	oasis_xml_catalog_filter: detachable XM_OASIS_XML_CATALOG_FILTER
			-- Filter for oasis-xml-catalog PIs

	content_emitter: detachable XM_XPATH_CONTENT_EMITTER
			-- Content emitter

	start: detachable XM_UNICODE_VALIDATION_FILTER
			-- Starting point for XM_CALLBACKS_SOURCE (e.g. parser)

	namespace_resolver: detachable XM_NAMESPACE_RESOLVER
			-- Namespace resolver

	attributes: detachable XM_ATTRIBUTE_DEFAULT_FILTER
			-- Set attribute defaults from the DTD

	content: detachable XM_CONTENT_CONCATENATOR
			-- Content concatenator

	error: detachable XM_PARSER_STOP_ON_ERROR_FILTER
			-- Error collector

invariant

	system_id_not_void: system_id /= Void
	source_text_not_void: source_text /= Void
	default_media_type_not_void: default_media_type /= Void

end

