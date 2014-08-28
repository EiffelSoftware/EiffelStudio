note
	description: "Summary description for {CMS_MODULE}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	DEMO_MODULE

inherit
	CMS_MODULE
		redefine
			links
		end

	CMS_HOOK_MENU_ALTER

	CMS_HOOK_AUTO_REGISTER

create
	make

feature {NONE} -- Initialization

	make
		do
			name := "demo"
			version := "1.0"
			description := "demo"
			package := "misc"
		end

feature {CMS_SERVICE} -- Registration

	service: detachable CMS_SERVICE

	register (a_service: CMS_SERVICE)
		do
			service := a_service
			a_service.map_uri_template ("/demo/widget{/args}", agent handle_widget_demo (a_service, ?, ?))
			a_service.map_uri_template ("/demo/date/{arg}", agent handle_date_time_demo (a_service, ?, ?))
			a_service.map_uri_template ("/demo/format/{arg}", agent handle_format_demo (a_service, ?, ?))
		end

	menu_alter (a_menu_system: CMS_MENU_SYSTEM; a_execution: CMS_EXECUTION)
		local
			lnk: CMS_LOCAL_LINK
--			opts: CMS_API_OPTIONS
		do
			create lnk.make ("Demo::widget", "/demo/widget/")
			a_menu_system.management_menu.extend (lnk)
		end

feature -- Hooks

	links: HASH_TABLE [CMS_MODULE_LINK, STRING]
			-- Link indexed by path
		local
			lnk: CMS_MODULE_LINK
		do
			Result := Precursor
			create lnk.make ("Date/time demo")
--			lnk.set_callback (agent process_date_time_demo, <<"arg">>)
--			Result["/demo/date/{arg}"] := lnk
		end

	handle_date_time_demo (cms: CMS_SERVICE; req: WSF_REQUEST; res: WSF_RESPONSE)
		do
			(create {ANY_CMS_EXECUTION}.make_with_text (req, res, cms, "<h1>Demo::date/time</h1>")).execute
		end

	handle_format_demo (cms: CMS_SERVICE; req: WSF_REQUEST; res: WSF_RESPONSE)
		do
			(create {ANY_CMS_EXECUTION}.make_with_text (req, res, cms, "<h1>Demo::format</h1>")).execute
		end

	handle_widget_demo (cms: CMS_SERVICE; req: WSF_REQUEST; res: WSF_RESPONSE)
		do
			(create {DEMO_WIDGET_CMS_EXECUTION}.make (req, res, cms)).execute
		end

end
