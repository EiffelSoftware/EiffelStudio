note
	description: "Helpers routine for feed xml parsers."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	FEED_PARSER_UTILITIES

feature -- Access

	xml_element_text (a_parent: XML_ELEMENT; a_name: READABLE_STRING_GENERAL): detachable READABLE_STRING_32
		do
			if attached a_parent.element_by_name (a_name) as elt then
				if attached elt.text as t then
					t.left_adjust
					t.right_adjust
					Result := t
				end
			end
		end

	xml_attribute_text (a_elt: XML_ELEMENT; a_att_name: READABLE_STRING_GENERAL): detachable READABLE_STRING_32
		do
			if attached a_elt.attribute_by_name (a_att_name) as att then
				Result := att.value
			end
		end

	xml_element_code (elt: XML_ELEMENT): STRING_32
		local
			xprinter: XML_NODE_PRINTER
		do
			create xprinter.make
			create Result.make_empty
			xprinter.set_output (create {XML_STRING_32_OUTPUT_STREAM}.make (Result))
			xprinter.process_element (elt)
		end

	links_from_xml (elt: XML_ELEMENT; a_link_elt_name: READABLE_STRING_GENERAL): detachable ARRAYED_LIST [FEED_LINK]
		local
			x_link: XML_ELEMENT
			lnk: FEED_LINK
		do
			if attached elt.elements_by_name (a_link_elt_name) as x_links then
				create Result.make (0)
				across
					x_links as ic
				loop
					x_link := ic.item
					if attached xml_attribute_text (x_link, "href") as l_href and then
						l_href.is_valid_as_string_8
					then
						create lnk.make (l_href.as_string_8)
						lnk.set_relation (xml_attribute_text (x_link, "rel"))
						lnk.set_type (xml_attribute_text (x_link, "type"))
						Result.force (lnk)
					elseif attached x_link.text as l_url and then not l_url.is_whitespace then
						create lnk.make (l_url)
						Result.force (lnk)
					end
				end
			end
		end

	element_by_prefixed_name (elt: XML_ELEMENT; a_ns_prefix: READABLE_STRING_GENERAL; a_name: READABLE_STRING_GENERAL): detachable XML_ELEMENT
		do
			across
				elt as ic
			until
				Result /= Void
			loop
				if attached {XML_ELEMENT} ic.item as x_item then
					if
						attached x_item.ns_prefix as l_ns_prefix and then a_ns_prefix.same_string (l_ns_prefix) and then
						a_name.same_string (x_item.name)
					then
						Result := x_item
					end
				end
			end
		end

end
