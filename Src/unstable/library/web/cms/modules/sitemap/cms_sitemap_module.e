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
			l_xml: STRING
			l_cache: CMS_FILE_STRING_8_CACHE
		do
			create {GENERIC_VIEW_CMS_RESPONSE} r.make (req, res, api)
			create l_cache.make (api.files_location.extended ("modules").extended ("sitemap").extended ("sitemap.xml"))
			if
				l_cache.exists and then
				not l_cache.expired (Void, 7*24*60*60) and then
				attached l_cache.item as l_cached_xml
			then
				create mesg.make ({HTTP_STATUS_CODE}.ok)
				mesg.header.put_content_type ("application/xml")
				mesg.set_payload (l_cached_xml)
				res.send (mesg)
			elseif attached sitemap (r) as l_sitemap then
				create l_xml.make (1_024)
				l_xml.append ("<?xml version=%"1.0%" encoding=%"utf-8%"?>%N")
				l_xml.append ("<?xml-stylesheet type=%"text/xsl%" href=%"" + r.absolute_url ("/module/" + name + "/files/sitemap.xsl", Void) + "%"?>%N")
				l_xml.append ("<urlset xmlns=%"http://www.sitemaps.org/schemas/sitemap/0.9%">%N")
				across
					l_sitemap as ic
				loop
					l_xml.append ("  <url>%N")
					l_xml.append ("    <loc>" + r.absolute_url (ic.item.link.location, Void) + "</loc>%N")
					l_xml.append ("    <lastmod>"); append_date_output (ic.item.date, l_xml); l_xml.append ("</lastmod>%N")
					l_xml.append ("    <changefreq>" + ic.item.change_frequency + "</changefreq>%N")
					l_xml.append ("    <priority>" + ic.item.priority.out + "</priority>%N")
					l_xml.append ("  </url>%N")
				end
				l_xml.append ("</urlset>%N")
				l_cache.put (l_xml)

				create mesg.make ({HTTP_STATUS_CODE}.ok)
				mesg.header.put_content_type ("application/xml")
				mesg.header.put_header ("Accept-Ranges: bytes")
				mesg.header.put_header ("Vary: Accept-Encoding,User-Agent")
				mesg.set_payload (l_xml)
				res.send (mesg)
			else
				create {NOT_FOUND_ERROR_CMS_RESPONSE} r.make (req, res, api)
				r.execute
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
