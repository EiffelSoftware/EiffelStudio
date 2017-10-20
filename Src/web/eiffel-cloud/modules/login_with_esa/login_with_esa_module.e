note
	description: "Summary description for {LOGIN_WITH_ESA_MODULE}."
	date: "$Date$"
	revision: "$Revision$"

class
	LOGIN_WITH_ESA_MODULE

inherit
	CMS_MODULE
		rename
			module_api as login_with_esa_api
		redefine
			permissions,
			initialize,
			install,
			filters,
			login_with_esa_api
		end

	CMS_WITH_WEBAPI

create
	make

feature {NONE} -- Initialization

	make
		do
			version := "1.0"
			description := "Login with ESA account"
			package := "auth"
		end

feature -- Access

	name: STRING = "login_with_esa"

	permissions: LIST [READABLE_STRING_8]
			-- List of permission ids, used by this module, and declared.
		do
			Result := Precursor
			Result.force (perm_use_login_with_esa)
		end

	perm_use_login_with_esa: STRING = "use login_with_esa"

feature {CMS_API} -- Module Initialization			

	initialize (api: CMS_API)
			-- <Precursor>
		do
			Precursor (api)
			create login_with_esa_api.make (api)
		end

feature {CMS_API} -- Module management

	install (api: CMS_API)
		do
				-- Schema
			if attached api.storage.as_sql_storage as l_sql_storage then
				l_sql_storage.sql_execute_file_script (api.module_resource_location (Current, (create {PATH}.make_from_string ("scripts")).extended ("install.sql")), Void)
				if l_sql_storage.has_error then
					api.logger.put_error ("Could not initialize database for module [" + name + "]", generating_type)
				else
					Precursor {CMS_MODULE} (api)
				end
			end
		end

feature {CMS_EXECUTION} -- Administration

	webapi: LOGIN_WITH_ESA_MODULE_WEBAPI
		do
			create Result.make (Current)
		end

feature {CMS_API, LOGIN_WITH_ESA_MODULE_WEBAPI} -- Access: API

	login_with_esa_api: detachable LOGIN_WITH_ESA_API
			-- <Precursor>

feature -- Access: router

	setup_router (a_router: WSF_ROUTER; a_api: CMS_API)
			-- <Precursor>
		do
		end

feature -- Access: filter

	filters (a_api: CMS_API): detachable LIST [WSF_FILTER]
			-- Possibly list of Filter's module.
		do
			if attached login_with_esa_api as l_api then
				create {ARRAYED_LIST [WSF_FILTER]} Result.make (1)
				Result.extend (create {LOGIN_WITH_ESA_FILTER}.make (a_api, l_api))
			end
		end



end
