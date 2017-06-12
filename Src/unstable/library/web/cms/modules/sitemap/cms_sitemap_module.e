note
	description: "CMS module that brings support for recent changes."
	date: "$Date$"
	revision: "$Revision$"

class
	CMS_SITEMAP_MODULE

inherit
	CMS_MODULE
		rename
			module_api as sitemap_api
		redefine
			permissions
		end

create
	make

feature {NONE} -- Initialization

	make
			-- Create Current module, disabled by default.
		do
			version := "1.0"
			description := "Service to build sitemap"
			package := "seo"
		end

feature -- Access

	name: STRING = "sitemap"

	permissions: LIST [READABLE_STRING_8]
			-- List of permission ids, used by this module, and declared.
		do
			Result := Precursor
			Result.force ("admin sitemap")
		end

feature -- Access: router

	setup_router (a_router: WSF_ROUTER; a_api: CMS_API)
			-- <Precursor>
		do
			a_router.handle ("/sitemap.xml", create {WSF_URI_AGENT_HANDLER}.make (agent handle_sitemp_xml (a_api, ?, ?)), a_router.methods_head_get)
		end

feature -- Hook		

	sitemap (a_response: CMS_RESPONSE): CMS_SITEMAP
		do
			create Result.make (create {DATE_TIME}.make_now_utc)
			if attached a_response.api.hooks.subscribers ({CMS_SITEMAP_HOOK}) as lst then
				across
					lst as ic
				loop
					if attached {CMS_SITEMAP_HOOK} ic.item as h then
						h.populate_sitemap (Result)
					end
				end
			end
		end

feature -- Handler

	handle_sitemp_xml (api: CMS_API; req: WSF_REQUEST; res: WSF_RESPONSE)
		local
			r: CMS_RESPONSE
			mesg: CMS_CUSTOM_RESPONSE_MESSAGE
			l_cache: CMS_FILE_STRING_8_CACHE
			l_not_modified: BOOLEAN
			l_sitemap_xml: detachable STRING
			l_last_modified: detachable DATE_TIME
			d: HTTP_DATE
		do
			create {GENERIC_VIEW_CMS_RESPONSE} r.make (req, res, api)
			create l_cache.make (api.cache_location.extended (name).extended ("sitemap.xml"))
			if
				l_cache.exists and then
				not l_cache.expired (Void, 24*60*60) -- 1 day
			then
				l_last_modified := l_cache.cache_date_time
				if attached req.http_if_modified_since as l_http_if_modified_since then
					create d.make_from_string (l_http_if_modified_since)
					if not d.has_error then
						if d.date_time >= l_last_modified then
								-- Not Modified!
							l_not_modified := True
						end
					end
				end

				if l_not_modified then
					res.set_status_code ({HTTP_STATUS_CODE}.not_modified)
					res.header.put_content_type ("application/xml")
					res.header.put_last_modified (l_last_modified)
					res.flush
				else
					l_sitemap_xml := l_cache.item
				end
			else
				create l_last_modified.make_now_utc
			end
			if l_not_modified then
					-- response sent!
			else
				if l_sitemap_xml = Void then
					l_sitemap_xml := new_sitemap_xml (r)
					if l_sitemap_xml /= Void then
						l_cache.put (l_sitemap_xml)
					else
						l_cache.delete
					end
				end
				if l_sitemap_xml /= Void then
					create mesg.make ({HTTP_STATUS_CODE}.ok)
					mesg.header.put_content_type ("application/xml")
					mesg.header.put_header ("Accept-Ranges: bytes")
					mesg.header.put_header ("Vary: Accept-Encoding,User-Agent")
					mesg.header.put_last_modified (l_last_modified)
	--				mesg.header.put_cache_control ("max-age=" + (24*60*60).out)
					mesg.set_payload (l_sitemap_xml)
					res.send (mesg)
				else
					api.response_api.send_not_found (Void, req, res)
				end
			end
		end

	new_sitemap_xml (r: CMS_RESPONSE): detachable STRING
		do
			if attached sitemap (r) as l_sitemap then
				create Result.make (1_024)
				Result.append ("<?xml version=%"1.0%" encoding=%"utf-8%"?>%N")
				Result.append ("<?xml-stylesheet type=%"text/xsl%" href=%"" + r.absolute_url ("/module/" + name + "/files/sitemap.xsl", Void) + "%"?>%N")
				Result.append ("<urlset xmlns=%"http://www.sitemaps.org/schemas/sitemap/0.9%">%N")
				across
					l_sitemap as ic
				loop
					Result.append ("  <url>%N")
					Result.append ("    <loc>" + r.absolute_url (ic.item.link.location, Void) + "</loc>%N")
					Result.append ("    <lastmod>"); append_date_output (ic.item.date, Result); Result.append ("</lastmod>%N")
					Result.append ("    <changefreq>" + ic.item.change_frequency + "</changefreq>%N")
					Result.append ("    <priority>" + ic.item.priority.out + "</priority>%N")
					Result.append ("  </url>%N")
				end
				Result.append ("</urlset>%N")
			end
		end

	append_date_output (dt: DATE_TIME; a_output: STRING)
			--| 2017-02-07T21:09:21+00:00
		do
			a_output.append_integer (dt.year)
			a_output.append_character ('-')
			append_two_digits_integer (dt.month, a_output)
			a_output.append_character ('-')
			append_two_digits_integer (dt.day, a_output)
			a_output.append_character ('T')
			append_two_digits_integer (dt.hour, a_output)
			a_output.append_character (':')
			append_two_digits_integer (dt.minute, a_output)
			a_output.append_character (':')
			append_two_digits_integer (dt.second, a_output)
			a_output.append_string ("+00:00")
		end

	append_two_digits_integer (i: INTEGER; s: STRING_8)
		do
			if i < 10 then
				s.append_character ('0')
			end
			s.append_integer (i)
		end

end
