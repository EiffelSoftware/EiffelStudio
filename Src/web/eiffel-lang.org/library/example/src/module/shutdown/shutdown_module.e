note
	description: "Summary description for {SHUTDOWN_MODULE}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	SHUTDOWN_MODULE

inherit
	CMS_MODULE
		redefine
			permissions
		end

	CMS_HOOK_MENU_ALTER

create
	make

feature {NONE} -- Initialization

	make
		do
			name := "shutdown"
			version := "1.0"
			description := "Shutdown the service if this is EWF Nino or FCGI"
			package := "server"
		end

feature {CMS_SERVICE} -- Registration

	service: detachable CMS_SERVICE

	register (a_service: CMS_SERVICE)
		do
			a_service.map_uri ("/admin/shutdown/", agent handle_shutdown)

			a_service.add_menu_alter_hook (Current)
			service := a_service
		end

feature -- Hooks

	permissions (a_service: CMS_SERVICE): LIST [CMS_PERMISSION]
		do
			Result := Precursor (a_service)
			Result.extend ("shutdown")
		end

	menu_alter (a_menu_system: CMS_MENU_SYSTEM; a_execution: CMS_EXECUTION)
		local
			lnk: CMS_LOCAL_LINK
		do
			create lnk.make ("Shutdown", "/admin/shutdown/")
			lnk.set_permission_arguments (<<"shutdown">>)
			a_menu_system.management_menu.extend (lnk)
		end

	handle_shutdown (req: WSF_REQUEST; res: WSF_RESPONSE)
		do
			if attached service as l_service then
				(create {SHUTDOWN_CMS_EXECUTION}.make (req, res, l_service)).execute ;
			else
				res.set_status_code ({HTTP_STATUS_CODE}.expectation_failed)
			end
		end

end
