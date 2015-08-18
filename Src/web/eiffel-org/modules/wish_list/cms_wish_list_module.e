note
	description: "CMS Wish Module "
	date: "$Date$"
	revision: "$Revision$"

class
	CMS_WISH_LIST_MODULE

inherit
	CMS_MODULE
		rename
			module_api as wish_list_api
		redefine
			filters,
			register_hooks,
			initialize,
			install,
			wish_list_api
		end

	CMS_HOOK_AUTO_REGISTER

	SHARED_EXECUTION_ENVIRONMENT
		export
			{NONE} all
		end

	REFACTORING_HELPER

	CMS_HOOK_RESPONSE_ALTER

	SHARED_LOGGER

create
	make

feature {NONE} -- Initialization

	make
			-- Create current module
		do
			version := "1.0"
			description := "Wish List module"
			package := "wishlist"

			create root_dir.make_current
			cache_duration := 0
		end

feature -- Access

	name: STRING = "wish_list"

feature {CMS_API} -- Module Initialization			

	initialize (a_api: CMS_API)
			-- <Precursor>
		local
			l_wish_list_api: like wish_list_api
			l_wish_list_storage: CMS_WISH_LIST_STORAGE_I
		do
			Precursor (a_api)

				-- Storage initialization
			if attached {CMS_STORAGE_SQL_I} a_api.storage as l_storage_sql then
				create {CMS_WISH_LIST_STORAGE_SQL} l_wish_list_storage.make (l_storage_sql)
			else
				-- FIXME: in case of NULL storage, should Current be disabled?
				create {CMS_WISH_LIST_STORAGE_NULL} l_wish_list_storage
			end

				-- API initialization
			create l_wish_list_api.make_with_storage (a_api, l_wish_list_storage)
			wish_list_api := l_wish_list_api
		ensure then
			wish_list_api_set: wish_list_api /= Void
		end

feature {CMS_API} -- Module management

	install (api: CMS_API)
		do
				-- Schema
			if attached {CMS_STORAGE_SQL_I} api.storage as l_sql_storage then
				if not l_sql_storage.sql_table_exists ("wish_list") then
					--| Schema
					l_sql_storage.sql_execute_file_script (api.module_resource_location (Current, (create {PATH}.make_from_string ("scripts")).extended ("wish_list.sql")), Void)

					if l_sql_storage.has_error then
						api.logger.put_error ("Could not initialize database for wish_list module", generating_type)
					end
						-- TODO workaround.
					l_sql_storage.sql_execute_file_script (api.module_resource_location (Current, (create {PATH}.make_from_string ("scripts")).extended ("initialize_wish_list.sql")), Void)
				end
				Precursor {CMS_MODULE}(api)
			end
		end

feature {CMS_API} -- Access: API

	wish_list_api: detachable CMS_WISH_LIST_API
			-- <Precursor>		

feature -- Filters

	filters (a_api: CMS_API): detachable LIST [WSF_FILTER]
			-- Possibly list of Filter's module.
		do
			create {ARRAYED_LIST [WSF_FILTER]} Result.make (1)
		end

feature -- Access: docs

	root_dir: PATH

	cache_duration: INTEGER
			-- Caching duration
			--|  0: disable
			--| -1: cache always valie
			--| nb: cache expires after nb seconds.

	cache_disabled: BOOLEAN
		do
			Result := cache_duration = 0
		end

feature -- Router

	setup_router (a_router: WSF_ROUTER; a_api: CMS_API)
			-- <Precursor>
		do
			if attached wish_list_api as l_wish_list_api then
				configure_web (a_api, l_wish_list_api, a_router)
			end
		end

	configure_web (a_api: CMS_API; a_wish_list_api: CMS_WISH_LIST_API; a_router: WSF_ROUTER)
		local
			l_wish_handler: CMS_WISH_LIST_HANDLER
			l_wish_detail_handler: CMS_WISH_DETAIL_HANDLER
			l_wish_form_handler: CMS_WISH_FORM_HANDLER
			l_wish_interaction_form_handler: CMS_WISH_INTERACTION_FORM_HANDLER
			l_wish_file_download_handler: CMS_WISH_FILE_DOWNLOAD_HANDER
		do

				-- Wish Download
			create l_wish_file_download_handler.make (a_api, a_wish_list_api)
			a_router.handle ("/download/wish/{wish_id}/{filename}", l_wish_file_download_handler, a_router.methods_get)
			a_router.handle ("/download/wish/{wish_id}/interaction/{id}/{filename}", l_wish_file_download_handler, a_router.methods_get)

				-- Wish list
			create l_wish_handler.make (a_api, a_wish_list_api)
			a_router.handle ("/resources/wish_list", l_wish_handler, a_router.methods_head_get)

				-- Wish Form
			create l_wish_form_handler.make (a_api, a_wish_list_api)
			a_router.handle ("/resources/wish_form", l_wish_form_handler, a_router.methods_get_post)
			a_router.handle ("/resources/wish_form/{id}", l_wish_form_handler, a_router.methods_get_post)

				-- Wish Interaction Form
			create l_wish_interaction_form_handler.make (a_api, a_wish_list_api)
			a_router.handle ("/resources/wish_detail/{wish_id}/interaction_form", l_wish_interaction_form_handler, a_router.methods_get_post)
			a_router.handle ("/resources/wish_detail/{wish_id}/interaction_form/{id}", l_wish_interaction_form_handler, a_router.methods_get_post)


				-- Widh details
			create l_wish_detail_handler.make (a_api, a_wish_list_api)
			a_router.handle ("/resources/wish_detail/{id}", l_wish_detail_handler, a_router.methods_get_post)
			a_router.handle ("/resources/wish_detail/{?search}", l_wish_detail_handler, a_router.methods_get_post)


				-- Wish Interaction Form
			create l_wish_interaction_form_handler.make (a_api, a_wish_list_api)
			a_router.handle ("/resources/wish_detail/{wish_id}/interaction_form", l_wish_interaction_form_handler, a_router.methods_get_post)
			a_router.handle ("/resources/wish_detail/{wish_id}/interaction_form/{id}", l_wish_interaction_form_handler, a_router.methods_get_post)

		end

feature -- Hooks configuration

	register_hooks (a_response: CMS_RESPONSE)
			-- Module hooks configuration.
		do
			auto_subscribe_to_hooks (a_response)
		end

	response_alter (a_response: CMS_RESPONSE)
			-- <Precursor>
		do
			--TODO add javascript support
		end


note
	copyright: "Copyright (c) 1984-2013, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
