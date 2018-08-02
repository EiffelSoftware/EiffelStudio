note
	description: "Summary description for {WDOCS_PAGE_NOT_FOUND_CMS_RESPONSE}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	WDOCS_PAGE_NOT_FOUND_CMS_RESPONSE

inherit
	NOT_FOUND_ERROR_CMS_RESPONSE
		rename
			make as make_not_found
		redefine
			initialize,
			process
		end

	CMS_API_ACCESS

create
	make

feature {NONE} -- Initialization

	make (req: WSF_REQUEST; res: WSF_RESPONSE; a_wdocs_api: like wdocs_api)
		do
			wdocs_api := a_wdocs_api
			make_not_found (req, res, a_wdocs_api.cms_api)
		end

	initialize
		do
			Precursor
			set_main_content ("Page not found")
			set_title ({STRING_32} "Wiki page not found!")
		end

feature -- Access

	wdocs_api: WDOCS_API

	wiki_page_id,
	wiki_book_id,
	wiki_version_id,
	wiki_uuid: detachable READABLE_STRING_GENERAL

feature -- Element change

	set_request_wiki_ids (a_wiki_id, a_book_id, a_version_id, a_wiki_uuid: detachable READABLE_STRING_GENERAL)
		do
			wiki_page_id := a_wiki_id
			wiki_book_id := a_book_id
			wiki_version_id := a_version_id
			wiki_uuid := a_wiki_uuid
		end

feature -- Execution

	process
			-- Computed response message.
		local
			s: detachable STRING
			pg_id: like wiki_page_id
			pg_uuid: like wiki_uuid
			pg: detachable like wdocs_api.wiki_page
			l_version_ids: ARRAYED_LIST [READABLE_STRING_GENERAL]
		do
			Precursor
			pg_id := wiki_page_id
			pg_uuid := wiki_uuid

			if pg_id /= Void or pg_uuid /= Void then
				across
					wdocs_api.available_versions (True) as ic
				loop
					if attached ic.item as vid then
						if pg_id /= Void then
							pg := wdocs_api.wiki_page (pg_id, wiki_book_id, vid)
						end
						if pg = Void and pg_uuid /= Void then
							pg := wdocs_api.wiki_page_by_uuid (pg_uuid, wiki_book_id, vid)
						end
						if pg /= Void then
							if l_version_ids = Void then
								create l_version_ids.make (1)
							end
							l_version_ids.force (vid)
						end
					end
				end
			end
			if l_version_ids /= Void and then not l_version_ids.is_empty then
				s := main_content
				if s = Void then
					create s.make_empty
				end
				s.append ("<p>Try:%N")
				wdocs_api.append_versions_to_xhtml (l_version_ids, Current, True, s, Void)
				s.append ("</p>")
				set_main_content (s)
			end
		end

end
