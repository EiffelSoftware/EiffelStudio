note
	description: "[
				RSS 2.0 Parser.
				
				Warning: the implementation may not support the full RSS 2.0 specification.
			]"
	date: "$Date$"
	revision: "$Revision$"
	EIS: "name=RSS at wikipedia", "protocol=URI", "src=https://en.wikipedia.org/wiki/RSS"
	EIS: "name=RDF Site Summary (RSS) 1.0", "protocol=URI", "src=http://purl.org/rss/1.0/spec"

class
	RSS_2_FEED_PARSER

inherit
	FEED_PARSER

feature -- Access

	name: STRING = "rss2"
			-- Associated name.

	is_detected (xdoc: XML_DOCUMENT): BOOLEAN
			-- Is `xdoc' an ATOM feed representation?
		do
			if attached {XML_ELEMENT} xdoc.element_by_name ("rss") as x_rss then
				if attached xml_attribute_text (x_rss, "version") as l_version and then
					l_version.starts_with ("2.")
				then
					Result := True
				else
						-- Let's default to RSS 2.0 for now.
					Result := True
				end
			end
		end

	feed (xdoc: XML_DOCUMENT): detachable FEED
			-- Feed from `xdoc' XML RSS 2.0 document.
		local
			lnk: FEED_LINK
			x_item, x_content, x_author: detachable XML_ELEMENT
			e: FEED_ITEM
			l_author: FEED_AUTHOR
		do
			if attached xdoc.element_by_name ("rss") as x_rss then
				if
					attached xml_attribute_text (x_rss, "version") as l_version and then
					l_version.starts_with ("2.")
				then
					if attached x_rss.element_by_name ("channel") as x_channel then
						if attached xml_element_text (x_channel, "title") as x_title then
							create Result.make (x_title)
							Result.set_description (xml_element_text (x_channel, "description"), "xhtml")
							Result.set_date_with_text (xml_element_text (x_channel, "lastBuildDate"))
							if attached links_from_xml (x_channel, "link") as l_links then
								across
									l_links as link_ic
								loop
									lnk := link_ic.item
									Result.links.force (lnk, lnk.relation)
								end
							end
							if attached x_channel.elements_by_name ("item") as x_items then
								across
									x_items as ic
								loop
									x_item := ic.item
									if attached xml_element_text (x_item, "title") as e_title then
										create e.make (e_title)
										e.set_description (xml_element_text (x_item, "description"))
										e.set_date_with_text (xml_element_text (x_item, "pubDate"))

										e.set_id (xml_element_text (x_item, "guid"))

										x_author := x_item.element_by_name ("creator")
										if x_author = Void then
											x_author := element_by_prefixed_name (x_item, "dc" , "creator")
										end

										if
											x_author /= Void and then
											attached x_author.text as l_author_name
										then
											create l_author.make (l_author_name)
											e.set_author (l_author)
										end

										if attached links_from_xml (x_item, "link") as l_links then
											across
												l_links as link_ic
											loop
												lnk := link_ic.item
												e.links.force (lnk, lnk.relation)
											end
										end
										if attached x_item.elements_by_name ("category") as x_categories then
											across
												x_categories as cats
											loop
												if attached cats.item.text as cat then
													e.set_category (cat)
												end
											end
										end
										x_content := x_item.element_by_name ("content")
										if x_content = Void then
											x_content := element_by_prefixed_name (x_item, "content" , "encoded")
											if x_content /= Void then
												e.set_content (x_content.text, Void)
											end
										else
											e.set_content (xml_element_code (x_content), Void)
										end
										Result.extend (e)
									end
								end
							end
						end
					end
				end
			end
		end

end
