note
	description: "[
			Comments module.
		]"
	date: "$Date$"
	revision: "$Revision$"

class
	CMS_COMMENTS_MODULE

inherit
	CMS_MODULE
		rename
			module_api as comments_api
		redefine
			setup_hooks,
			initialize,
			install,
			comments_api
		end

	CMS_HOOK_RESPONSE_ALTER

create
	make

feature {NONE} -- Initialization

	make
		do
			version := "1.0"
			description := "Comments"
			package := "content"
		end

feature -- Access

	name: STRING = "comments"

feature {CMS_API} -- Module Initialization			

	initialize (api: CMS_API)
			-- <Precursor>
		do
			Precursor (api)
			create comments_api.make (api)
		end

feature {CMS_API} -- Module management

	install (a_api: CMS_API)
		do
				-- Schema
			if attached a_api.storage.as_sql_storage as l_sql_storage then
				l_sql_storage.sql_execute_file_script (a_api.module_resource_location (Current, (create {PATH}.make_from_string ("scripts")).extended ("install.sql")), Void)

				if l_sql_storage.has_error then
					a_api.logger.put_error ("Could not initialize database for module [" + name + "]", generating_type)
				else
					Precursor {CMS_MODULE} (a_api)
				end
			end
		end

feature {CMS_API} -- Access: API

	comments_api: detachable CMS_COMMENTS_API
			-- <Precursor>

feature -- Access: router

	setup_router (a_router: WSF_ROUTER; a_api: CMS_API)
			-- <Precursor>
		do
		end

feature -- Hooks

	setup_hooks (a_hooks: CMS_HOOK_CORE_MANAGER)
		do
			a_hooks.subscribe_to_response_alter_hook (Current)
--			a_hooks.subscribe_to_form_alter_hook (Current)
		end

--	form_alter (a_form: CMS_FORM; a_form_data: detachable WSF_FORM_DATA; a_response: CMS_RESPONSE)
--			-- Hook execution on form `a_form' and its associated data `a_form_data',
--			-- for related response `a_response'.
--		do
--		end

	response_alter (a_response: CMS_RESPONSE)
		do
			a_response.add_style (a_response.url ("/module/" + name + "/files/css/comments.css", Void), Void)
		end

end
