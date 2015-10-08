note
	description: "[
				ATOM Parser.
				
				Warning: the implementation may not support the full ATOM specification.
		]"
	date: "$Date$"
	revision: "$Revision$"
	EIS: "name=ATOM at wikipedia", "protocol=URI", "src=https://en.wikipedia.org/wiki/Atom_(standard)"
	EIS: "name=RSS at wikipedia", "protocol=URI", "src=https://en.wikipedia.org/wiki/RSS"
	EIS: "name=ATOM 1.0 RFC4287", "protocol=URI", "src=https://tools.ietf.org/html/rfc4287"

class
	ATOM_FEED_PARSER

inherit
	FEED_PARSER

feature -- Access

	name: STRING = "atom1"
			-- Associated name.	

	is_detected (xdoc: XML_DOCUMENT): BOOLEAN
			-- Is `xdoc' an ATOM feed representation?
		do
			Result := attached {XML_ELEMENT} xdoc.element_by_name ("feed") as x_feed and then
					(
						not attached xml_attribute_text (x_feed, "xmlns") as l_xmlns
						or else l_xmlns.same_string ("http://www.w3.org/2005/Atom")
					)
		end

	feed (xdoc: XML_DOCUMENT): detachable FEED
			-- Feed from `xdoc' XML document.
		local
			l_title: READABLE_STRING_32
			x_entry, x_link: detachable XML_ELEMENT
			e: FEED_ITEM
			l_author: FEED_AUTHOR
			lnk: FEED_LINK
			s: STRING_32
		do
			if
				attached xdoc.element_by_name ("feed") as x_feed and then
--				(not attached xml_attribute_text (x_feed, "xmlns") as l_xmlns or else l_xmlns.same_string ("http://www.w3.org/2005/Atom"))				
				attached xml_element_text (x_feed, "title") as t
			then
				l_title := t
				create Result.make (l_title)
				Result.set_description (xml_element_text (x_feed, "subtitle"), "plain")
				Result.set_id (xml_element_text (x_feed, "id"))
				Result.set_updated_date_with_text (xml_element_text (x_feed, "updated"))
				if attached links_from_xml (x_feed, "link") as l_links then
					across
						l_links as link_ic
					loop
						lnk := link_ic.item
						Result.links.force (lnk, lnk.relation)
					end
				end
				if attached x_feed.elements_by_name ("entry") as x_entries then
					across
						x_entries as ic
					loop
						x_entry := ic.item
						if attached xml_element_text (x_entry, "title") as e_title then
							create e.make (e_title)
							e.set_description (xml_element_text (x_entry, "summary"))
							e.set_id (xml_element_text (x_entry, "id"))
							e.set_updated_date_with_text (xml_element_text (x_entry, "updated"))

							if attached links_from_xml (x_entry, "link") as l_links then
								across
									l_links as link_ic
								loop
									lnk := link_ic.item
									e.links.force (lnk, lnk.relation)
								end
							end
							if attached x_entry.element_by_name ("content") as x_content then
								e.set_content (xml_element_code (x_content), xml_attribute_text (x_content, "type"))
							end
							if attached x_entry.element_by_name ("author") as x_author then
								if attached x_author.element_by_name ("name") as x_name and then
									attached x_name.text as l_author_name
								then
									create l_author.make (l_author_name)
									if attached x_author.element_by_name ("email") as x_email then
										l_author.set_email (x_email.text)
									end
									e.set_author (l_author)
								end
							end
							Result.extend (e)
						end
					end
				end
			end
		end



end
