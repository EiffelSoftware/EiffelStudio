note
	description: "[
			Request handler related to 
				/taxonomy/vocabulary/
				/taxonomy/vocabulary/{vocid}
			]"
	date: "$Date$"
	revision: "$revision$"

class
	TAXONOMY_VOCABULARY_HANDLER

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
			s: STRING
		do
			if attached {WSF_STRING} req.path_parameter ("vocid") as p_vocid then
				if p_vocid.is_integer then
					tid := p_vocid.value.to_integer_64
				end
			end
			if tid > 0 then
				if attached taxonomy_api.vocabulary (tid) as voc then
						-- Responding with `main_content_html (l_page)'.
					create {GENERIC_VIEW_CMS_RESPONSE} l_page.make (req, res, api)
					l_page.set_title (voc.name)
					taxonomy_api.fill_vocabularies_with_terms (voc)

					create s.make_empty
					s.append ("<ul class=%"taxonomy-terms%">")
					across
						voc as ic
					loop
						s.append ("<li>")
						s.append (l_page.link (ic.item.text, "taxonomy/term/" + ic.item.id.out, Void))
						if attached ic.item.description as l_desc then
							s.append (" : <em>")
							s.append (api.html_encoded (l_desc))
							s.append ("</em>")
						end
						s.append ("</li>")
					end
					s.append ("</ul>")
					l_page.set_main_content (s)
				else
						-- Responding with `main_content_html (l_page)'.
					create {NOT_FOUND_ERROR_CMS_RESPONSE} l_page.make (req, res, api)
				end
				l_page.execute
			else
					-- Responding with `main_content_html (l_page)'.
				create {GENERIC_VIEW_CMS_RESPONSE} l_page.make (req, res, api)
				create s.make_empty
				if attached taxonomy_api.vocabularies (0, 0) as lst then
					s.append ("<ul class=%"taxonomy-vocabularies%">")
					across
						lst as ic
					loop
						s.append ("<li>")
						s.append (l_page.link (ic.item.name, "taxonomy/vocabulary/" + ic.item.id.out, Void))
						s.append ("</li>")
					end
					s.append ("</ul>")
				else
					s.append ("No vocabulary!")
				end
				l_page.set_main_content (s)
				l_page.execute
			end
		end

end
