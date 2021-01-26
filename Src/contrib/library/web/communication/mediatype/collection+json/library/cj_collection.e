note
	description: "[
				The Collection Object contains all the records in the representations. 
				This is a required object.
				Should have a version property.:
					- value MUST be set to 1.0, 
					- if there is no version property present, set it to 1.0.
				Should have an href property, it should contain a valid URI
	]"
	date: "$Date$"
	revision: "$Revision$"
	example: "[
		{
			"collection":
			{
			 "version": 1.0,
			 "href": URI,
			 "links": [ARRAY],
			 "items": [ARRAY],
			 "queries": [ARRAY],
			 "template": {OBJECT},
			 "error": {OBJECT}
			}
		}
	]"
	EIS: "name=Collection+JSON - Hypermedia Type", "protocol=URI", "src=http://www.amundsen.com/media-types/collection/", "tag=homepage, specification"

class
	CJ_COLLECTION

create
	make_empty,
	make_with_href,
	make_with_version,
	make_with_href_and_version

feature {NONE} -- Initialization

	make_empty
		do
			make_with_version (default_version)
		end

	make_with_href (a_href: like href)
		require
			valid_href: not a_href.is_empty
		do
			make_with_href_and_version (a_href, default_version)
		end

	make_with_href_and_version (a_href: like href; a_version: like version)
		require
			valid_version: not a_version.is_empty
		do
			version := a_version
			href := a_href
		end

	make_with_version (a_version: like version)
		require
			valid_version: not a_version.is_empty
		do
			make_with_href_and_version ("", a_version)
		end

feature -- Access

	version: READABLE_STRING_8
			-- The value should be set to `default_version' i.e: "1.0"

	href: READABLE_STRING_8
			-- Must contain a valid URI

	links: detachable ARRAYED_LIST [CJ_LINK]
			-- may have a links array

	items: detachable ARRAYED_LIST [CJ_ITEM]
			-- may have an items array

	queries: detachable ARRAYED_LIST [CJ_QUERY]
			-- may have a queries array

	template: detachable CJ_TEMPLATE
			-- may have a template object

	error: detachable CJ_ERROR
			-- may have an error object

feature -- Element Change

	set_version (a_version: READABLE_STRING_8)
		do
			version := a_version
		ensure
			version_set: version ~ a_version
		end

	set_href (a_href: READABLE_STRING_8)
		do
			href := a_href
		ensure
			href_set: href ~ a_href
		end

	add_link (a_link: CJ_LINK)
		local
			l_links: like links
		do
			l_links := links
			if l_links = Void then
				create l_links.make (1)
				links := l_links
			end
			l_links.force (a_link)
		end

	add_item (a_item: CJ_ITEM)
		local
			l_items: like items
		do
			l_items := items
			if l_items = Void then
				create l_items.make (1)
				items := l_items
			end
			l_items.force (a_item)
		end

	add_query (a_query: CJ_QUERY)
		local
			l_queries: like queries
		do
			l_queries := queries
			if l_queries = Void then
				create l_queries.make (1)
				queries := l_queries
			end
			l_queries.force (a_query)
		end

	set_template (a_template: CJ_TEMPLATE)
		do
			template := a_template
		end

	set_error (an_error: CJ_ERROR)
		do
			error := an_error
		end

feature -- Constants

	default_version: STRING = "1.0"

note
	copyright: "2011-2021, Javier Velilla, Jocelyn Fiat and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
end
