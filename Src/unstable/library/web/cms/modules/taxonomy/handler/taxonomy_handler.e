note
	description: "[
			Request handler related to 
				/taxonomy/term/{termid}
			]"
	date: "$Date$"
	revision: "$revision$"

class
	TAXONOMY_HANDLER

inherit
	CMS_MODULE_HANDLER [CMS_TAXONOMY_API]
		rename
			module_api as taxonomy_api
		end

	WSF_URI_HANDLER
		rename
			execute as uri_execute,
			new_mapping as new_uri_mapping
		end

	WSF_URI_TEMPLATE_HANDLER
		rename
			execute as uri_template_execute,
			new_mapping as new_uri_template_mapping
		select
			new_uri_template_mapping
		end

	WSF_RESOURCE_HANDLER_HELPER
		redefine
			do_get
		end

	REFACTORING_HELPER

	CMS_API_ACCESS

create
	make

feature -- execute

	execute (req: WSF_REQUEST; res: WSF_RESPONSE)
			-- Execute request handler for any kind of mapping.
		do
			execute_methods (req, res)
		end

	uri_execute (req: WSF_REQUEST; res: WSF_RESPONSE)
			-- Execute request handler for URI mapping.
		do
			execute (req, res)
		end

	uri_template_execute (req: WSF_REQUEST; res: WSF_RESPONSE)
			-- Execute request handler for URI-template mapping.
		do
			execute (req, res)
		end

feature -- HTTP Methods	

	do_get (req: WSF_REQUEST; res: WSF_RESPONSE)
			-- <Precursor>
		local
			l_page: CMS_RESPONSE
			tid: INTEGER_64
			l_entity: detachable READABLE_STRING_32
			s: STRING
			l_contents: CMS_TAXONOMY_ENTITY_CONTAINER
			ct: CMS_CONTENT
		do
			if
				attached {WSF_STRING} req.path_parameter ("termid") as p_termid and then
				p_termid.is_integer
			then
				tid := p_termid.value.to_integer_64
			end

			if tid > 0 then
				if attached taxonomy_api.term_by_id (tid) as t then
						-- Responding with `main_content_html (l_page)'.
					create {GENERIC_VIEW_CMS_RESPONSE} l_page.make (req, res, api)
					l_page.set_title (t.text)
					create s.make_empty
					if
						attached taxonomy_api.entities_associated_with_term (t) as l_entity_type_lst and then
						not l_entity_type_lst.is_empty
					then
						create l_contents.make (l_entity_type_lst, 25, create {DATE_TIME}.make_now_utc, Void)
						if attached api.hooks.subscribers ({CMS_TAXONOMY_HOOK}) as lst then
							across
								lst as ic
							loop
								if attached {CMS_TAXONOMY_HOOK} ic.item as h then
									h.populate_content_associated_with_term (t, l_contents)
								end
							end
							l_contents.sort
							s.append ("<ul class=%"taxonomy-entities%">")
							across
								l_contents as ic
							loop
								ct := ic.item.content
								s.append ("<li class=%""+ ct.content_type +"%">")
								if attached ct.link as lnk then
									l_page.append_link_to_html (lnk.title, lnk.location, Void, s)
								end
								if attached api.content_type_webform_manager_by_name (ct.content_type) as l_wfm then
									l_wfm.append_content_as_html_to (ct, True, s, l_page)
								end
								s.append ("</li>%N")
							end
							s.append ("</ul>%N")
						end
						if not l_contents.taxonomy_info.is_empty then
							check all_taxo_handled: False end
							s.append ("<ul class=%"error%">Item(s) with unknown content type!")
							across
								l_contents.taxonomy_info as ic
							loop
									-- FIXME: for now basic implementation .. to be replaced by specific hook !
								if attached ic.item.entity as e and then e.is_valid_as_string_8 then
									l_entity := e
									s.append ("<li>Entity %"")
									s.append (api.html_encoded (e))
									s.append ("%"")
									if attached ic.item.typename as l_type and then l_type.is_valid_as_string_8 then
										s.append (" {" + api.html_encoded (l_type) + "}")
									end
									s.append ("</li>")
								end
							end
							s.append ("</ul>%N")
						end
					else
						if taxonomy_api.error_handler.has_error then
							l_page.add_error_message ({STRING_32} "Query error: " + taxonomy_api.error_handler.as_string_representation)
						end
						s.append ("No entity found.")
					end
					l_page.set_main_content (s)
				else
						-- Responding with `main_content_html (l_page)'.
					create {NOT_FOUND_ERROR_CMS_RESPONSE} l_page.make (req, res, api)
				end
				l_page.execute
			else
					-- Responding with `main_content_html (l_page)'.
				create {BAD_REQUEST_ERROR_CMS_RESPONSE} l_page.make (req, res, api)
				l_page.execute
			end
		end

end
