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
			l_title, l_desc, l_keywords: detachable READABLE_STRING_32
			l_now: DATE_TIME
			dt: detachable DATE_TIME
			l_props: STRING_TABLE [READABLE_STRING_32]
			api: CMS_API
			setup: CMS_SETUP
		do
			api := a_response.api
			setup := api.setup
			l_siteurl := a_response.absolute_url (a_response.request.percent_encoded_path_info, Void)

			create l_props.make_equal_caseless (5)
			l_props.put (l_siteurl, "url")
			l_props.put (api.setup.site_name, "site_name")
			if attached api.setup.site_properties as tb then
				across
					tb as ic
				loop
					if ic.key.same_string ("headline") then
						l_props.force (ic.item, "site_name")
					else
						l_props.put (ic.item, ic.key)
					end
				end
			end
			l_title := a_response.title
			if l_title /= Void then
				l_props.put (l_title, "title")
			end

			l_desc := a_response.description
			if l_desc = Void then
				l_desc := api.setup.site_description
			else
				l_props.put (l_desc, "description")
			end
			l_keywords := a_response.keywords
			if l_keywords = Void then
				l_keywords := api.setup.site_keywords
			else
				l_props.put (l_keywords, "keywords")
			end
	        create l_now.make_now_utc
	        dt := a_response.publication_date
	        if dt = Void then
				dt := l_now
	        end
	        l_props.put (date_to_yyyy_mm_dd_string (dt), "published_time")
   	        dt := a_response.modification_date
	        if dt = Void then
				dt := l_now
	        end
	        l_props.put (date_to_yyyy_mm_dd_string (dt), "modified_time")

	        a_response.add_additional_head_line ("<link rel=%"profile%" href=%"http://gmpg.org/xfn/11%" />", False)
	        if l_desc /= Void then
		        a_response.add_additional_head_line ("<meta name=%"description%" content=%"" + api.html_encoded (l_desc) + "%" />", False)
	        end
	        if l_keywords /= Void then
        		a_response.add_additional_head_line ("<meta name=%"keywords%" content=%"" + api.html_encoded (l_keywords) + "%" />", False)
        	end

				-- Meta properties
			a_response.add_additional_head_line ("<meta property=%"og:type%" content=%"article%" />", False)
        	across
        		l_props as ic
        	loop
				a_response.add_additional_head_line ("<meta property=%"og:" + ic.key + "%" content=%"" + api.html_encoded (ic.item) + "%" />", False)
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
