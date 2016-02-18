note
	description: "[
		Handler for a CMS logs in the CMS interface.
	]"
	date: "$Date$"
	revision: "$Revision$"

class
	CMS_LOGS_HANDLER

inherit
	CMS_HANDLER

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

create
	make

feature -- execute

	execute (req: WSF_REQUEST; res: WSF_RESPONSE)
			-- Execute request handler
		do
			execute_methods (req, res)
		end

	uri_execute (req: WSF_REQUEST; res: WSF_RESPONSE)
			-- Execute request handler
		do
			execute (req, res)
		end

	uri_template_execute (req: WSF_REQUEST; res: WSF_RESPONSE)
			-- Execute request handler
		do
			execute (req, res)
		end

feature -- HTTP Methods

	do_get (req: WSF_REQUEST; res: WSF_RESPONSE)
			-- <Precursor>
		local
			l_logs: LIST [CMS_LOG]
			l_log: CMS_LOG
			r: CMS_RESPONSE
			l_cat: detachable READABLE_STRING_8
			l_lower: INTEGER
			l_count: INTEGER
			b: STRING
		do
			if api.has_permission ("view logs") then
				create {GENERIC_VIEW_CMS_RESPONSE} r.make (req, res, api)
				if attached {WSF_STRING} req.query_parameter ("category") as p_cat then
					l_cat := p_cat.value
				end
				if attached {WSF_STRING} req.query_parameter ("lower") as p_lower and then p_lower.is_integer then
					l_lower := p_lower.integer_value
				end
				if attached {WSF_STRING} req.query_parameter ("count") as p_count and then p_count.is_integer then
					l_count := p_count.integer_value
				end

				l_logs := api.logs (l_cat, l_lower, l_count)
				create b.make (100)
				b.append ("<ul class=%"logs%">%N")
				across
					l_logs as ic
				loop
					l_log := ic.item
					b.append ("<li class=%"log-level-"+ l_log.level.out +"%">")
					b.append ("[" + l_log.category + "] ")
					b.append (l_log.message)
					b.append ("%N<p>(date: " + l_log.date.out + ")")
					if attached l_log.link as lnk then
						b.append (" <a href=%"" + req.script_url (lnk.location) + "%">" + html_encoded (lnk.title) + "</a>")
					end
					b.append ("</p>%N")
					if attached l_log.info as l_info then
						b.append ("<pre>" + l_info + "</pre>%N")
					end
					b.append ("</li>%N")
				end
				b.append ("</ul>%N")
				r.set_main_content (b)
				r.set_page_title ("Logs ...")
				r.set_title ("Logs")
			else
				create {FORBIDDEN_ERROR_CMS_RESPONSE} r.make (req, res, api)
			end
			r.execute

		end

end
