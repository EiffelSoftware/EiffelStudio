note
	description: "[
			Module that provides Search Engine Optimization.
		]"
	date: "$Date$"
	revision: "$Revision$"

class
	CMS_SEO_MODULE

inherit
	CMS_MODULE
		redefine
			setup_hooks
		end

	CMS_HOOK_AUTO_REGISTER

	CMS_HOOK_RESPONSE_ALTER

	REFACTORING_HELPER

create
	make

feature {NONE} -- Initialization

	make
			-- Create current module
		do
			version := "1.0"
			description := "Search Engine Optimization"
			package := "misc"
		end

feature -- Access

	name: STRING = "seo"
			-- <Precursor>

feature -- Router

	setup_router (a_router: WSF_ROUTER; a_api: CMS_API)
			-- Router configuration.
		do
		end

feature -- Hooks configuration

	setup_hooks (a_hooks: CMS_HOOK_CORE_MANAGER)
			-- Module hooks configuration.
		do
			auto_subscribe_to_hooks (a_hooks)
			a_hooks.subscribe_to_response_alter_hook (Current)
		end

feature -- Hook

	response_alter (a_response: CMS_RESPONSE)
		local
			l_siteurl: STRING
			l_title, l_desc: detachable READABLE_STRING_32
			dt: detachable DATE_TIME
			l_props: CMS_RESPONSE_METADATA
			l_is_article: BOOLEAN
			api: CMS_API
			setup: CMS_SETUP
			v: READABLE_STRING_32
			tb: STRING_TABLE [READABLE_STRING_32]
		do
			api := a_response.api
			setup := api.setup
			l_siteurl := a_response.absolute_url (a_response.request.percent_encoded_path_info, Void)

				-- Get site properties
			tb := api.setup.site_properties
			if a_response.is_front and then attached api.setup.site_front_page_properties as front_tb then
				if tb = Void then
					tb := front_tb
				else
					tb := tb.twin
					across
						front_tb as ic
					loop
						tb.force (ic.item, ic.key)
					end
				end
			end

				-- Build metadata
			create l_props.make (5)
			l_props.put (l_siteurl, "url")
			l_props.put (api.setup.site_name, "site_name")
			if tb /= Void then
					-- Include the site properties as metadata.
				across
					tb as ic
				loop
					v := ic.item
					if v.count > 2 and then v[1] = '[' and v[v.count-1] = ']' then
						l_props.remove (ic.key)
						across
							api.list_from_csv_string (v.substring (2, v.count - 1)) as csv_ic
						loop
							l_props.add (csv_ic.item, ic.key)
						end
					else
						l_props.force (ic.item, ic.key)
					end
				end
			end

			l_title := a_response.title
			if l_title /= Void then
				l_props.force (l_title, "og:title")
			end

			l_desc := a_response.description
			if l_desc /= Void then
				l_props.force (l_desc, "og:description")
			end

			if attached a_response.metadata as md then
					-- Merge metadata from the response!
				if md.has_key ("article:tag") then
						-- Override tags!
					l_props.remove ("article:tag")
				end
				l_props.merge (md)
			end

			if attached l_props.item ("og:type") as l_prop_type then
				l_is_article := l_prop_type.same_string ("article")
			elseif attached l_props.item ("type") as l_prop_type then
				l_is_article := l_prop_type.same_string ("article")
				l_props.remove ("type")
				l_props.force (l_prop_type, "og:type")
			else
				l_props.force ("website", "og:type")
			end

			if l_is_article then
				if attached a_response.keywords as lst_keywords then
					l_props.remove ("article:tag")
					across
						lst_keywords as ic
					loop
						l_props.add (ic.item, "article:tag")
					end
				end

		        dt := a_response.publication_date
		        if dt /= Void then
			        l_props.put (date_to_yyyy_mm_dd_string (dt), "article:published_time")
		        end
	   	        dt := a_response.modification_date
				if dt /= Void then
			        l_props.put (date_to_yyyy_mm_dd_string (dt), "article:modified_time")
				end
			end

	        a_response.add_additional_head_line ("<link rel=%"profile%" href=%"http://gmpg.org/xfn/11%" />", False)
	        if l_desc /= Void then
		        a_response.add_additional_head_line ("<meta name=%"description%" content=%"" + api.html_encoded (l_desc) + "%" />", False)
	        end
	        if attached a_response.keywords as l_keywords then
        		a_response.add_additional_head_line ("<meta name=%"keywords%" content=%"" + api.html_encoded (api.list_to_csv_string (l_keywords)) + "%" />", False)
        	end

				-- Meta properties
			if not l_props.is_empty then
				if not l_props.has_keys (<<"og:image", "image">>) then
					l_props.force (api.absolute_url ("/favicon.ico", Void), "og:image")
				end
	        	across
	        		l_props as ic
	        	loop
        			a_response.add_additional_head_line ("<meta property=%"" + html_encoded (ic.item.key) + "%" content=%"" + api.html_encoded (ic.item.value) + "%" />", False)
	        	end
			end
			a_response.add_additional_head_line ("<link rel='canonical' href='" + l_siteurl + "' />", False)
			a_response.add_additional_head_line ("<link rel='shortlink' href='" + l_siteurl + "' />", False)
		end

feature -- Helpers: date

	date_to_yyyy_mm_dd_string (dt: DATE_TIME): STRING
				-- Date to YYYY-mm-dd format.
		do
			create Result.make (10)
			Result.append_integer (dt.year)
			Result.append_character ('-')
			if dt.month < 10 then
				Result.append_character ('0')
			end
			Result.append_integer (dt.month)
			Result.append_character ('-')
			if dt.day < 10 then
				Result.append_character ('0')
			end
			Result.append_integer (dt.day)
		end

end
