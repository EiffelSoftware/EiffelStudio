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

feature -- Settings

	default_count: INTEGER = 50

feature -- HTTP Methods

	do_get (req: WSF_REQUEST; res: WSF_RESPONSE)
			-- <Precursor>
		local
			l_logs: LIST [CMS_LOG]
			l_log: CMS_LOG
			r: CMS_RESPONSE
			l_cat: detachable READABLE_STRING_32
			l_level: INTEGER
			l_offset: INTEGER
			l_count: INTEGER
			b: STRING
			params: CMS_DATA_QUERY_PARAMETERS
		do
			if api.has_permission ("view logs") then
				create {GENERIC_VIEW_CMS_RESPONSE} r.make (req, res, api)
				if attached {WSF_STRING} req.query_parameter ("category") as p_cat then
					l_cat := p_cat.value
				end
				if attached {WSF_STRING} req.query_parameter ("level") as p_level then
					if p_level.is_integer then
						l_level := p_level.integer_value
					else
						l_level := {CMS_LOG}.level_from_string (p_level.value)
					end
				end
				if attached {WSF_STRING} req.query_parameter ("offset") as p_offset and then p_offset.is_integer then
					l_offset := p_offset.integer_value
				end
				if attached {WSF_STRING} req.query_parameter ("count") as p_count and then p_count.is_integer then
					l_count := p_count.integer_value
				else
					l_count := default_count
				end

				if l_count > 0 or l_offset > 0 then
					create params.make (l_offset.to_natural_64, l_count.to_natural_32)
				end
				l_logs := api.logs (l_cat, l_level, params)
				create b.make (100)
				b.append ("<ul class=%"logs%">%N")
				across
					l_logs as ic
				loop
					l_log := ic.item
					b.append ("<li class=%"log-level-"+ l_log.level.out +" log-" + l_log.level_name + "%">")
					b.append ("<div class=%"log-header%">")
					b.append ("<div class=%"log-name%">")
					b.append (html_encoded (l_log.level_name))
					b.append ("</div>")
					b.append ("<div class=%"log-category%">")
					b.append ("[" + html_encoded (l_log.category) + "]")
					b.append ("</div>")
					b.append ("</div>")
					b.append ("<div class=%"log-message%">")
					b.append (l_log.message)
					b.append ("</div>")
					b.append ("<div class=%"log-date%">(date: " + l_log.date.out + ")</div>")
					if attached l_log.link as lnk then
						b.append ("<div class=%"log-link%">")
						b.append (" <a href=%"" + req.script_url (lnk.location) + "%">" + html_encoded (lnk.title) + "</a>")
						b.append ("</div>%N")
					end
					if attached l_log.info as l_info then
						b.append ("<pre>" + l_info + "</pre>%N")
					end
					b.append ("</li>%N")
				end
				b.append ("</ul>%N")
				if l_count > 0 then
					b.append ("<p>")
					if l_offset > 0 then
						b.append (logs_link (" << ", l_cat, l_level.out, l_offset - l_count, l_count))
					end
					b.append ("[" + (l_offset + 1).out + " -&gt; " + (l_offset + l_count - 1).out + "]")

					b.append (logs_link (" >> ", l_cat, l_level.out, l_offset + l_count, l_count))
					b.append ("</p>")
				end

				r.set_main_content (b)
				r.set_page_title ("Logs ...")
				r.set_title ("Logs")
				r.execute
			else
				send_access_denied (req, res)
			end
		end

	logs_link (a_title: READABLE_STRING_GENERAL; a_category, a_level: detachable READABLE_STRING_GENERAL; a_lower, a_count: INTEGER): STRING_8
		local
			lnk: CMS_LOCAL_LINK
		do
			lnk := api.administration_link (a_title, "logs")
			if a_category /= Void then
				lnk.add_query_parameter ("category", url_encoded (a_category))
			end
			if a_level /= Void then
				lnk.add_query_parameter ("level", url_encoded (a_level))
			end
			if a_lower > 0 and a_count > 0 then
				lnk.add_query_parameter ("lower", a_lower.out)
				lnk.add_query_parameter ("count", a_count.out)
			end
			Result := api.link (lnk.title, lnk.location, Void)
		end

end
