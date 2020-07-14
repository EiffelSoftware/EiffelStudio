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
			setup_hooks,
			initialize,
			install,
			wish_list_api,
			permissions
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
			l_wish_list_storage: CMS_MOTION_LIST_STORAGE_I
		do
			Precursor (a_api)

				-- Storage initialization
			if attached {CMS_STORAGE_SQL_I} a_api.storage as l_storage_sql then
				create {CMS_WISH_LIST_STORAGE_SQL} l_wish_list_storage.make (l_storage_sql)
			else
				-- FIXME: in case of NULL storage, should Current be disabled?
				create {CMS_MOTION_LIST_STORAGE_NULL} l_wish_list_storage
			end

				-- API initialization
			create {CMS_WISH_LIST_API} l_wish_list_api.make_with_storage (a_api, l_wish_list_storage)
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

	wish_list_api: detachable CMS_MOTION_API
			-- <Precursor>		

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

	configure_web (a_api: CMS_API; a_wish_list_api: CMS_MOTION_API; a_router: WSF_ROUTER)
		local
			l_wish_handler: CMS_MOTION_LIST_HANDLER
			l_wish_detail_handler: CMS_MOTION_DETAIL_HANDLER
			l_wish_form_handler: CMS_MOTION_FORM_HANDLER
			l_wish_interaction_form_handler: CMS_MOTION_INTERACTION_FORM_HANDLER
			l_wish_file_download_handler: CMS_MOTION_FILE_DOWNLOAD_HANDER
			l_categories_handler: CMS_MOTION_CATEGORIES_HANDLER
			l_category_handler: CMS_MOTION_CATEGORY_HANDLER
			l_uri_mapping: WSF_URI_MAPPING
			l_vote_handler: CMS_MOTION_VOTE_HANDLER

		do

				-- Wish list
			create l_wish_handler.make (a_api, a_wish_list_api)
			a_router.handle ("/resources/wish_list", l_wish_handler, a_router.methods_head_get)


				-- Wish Download
			create l_wish_file_download_handler.make (a_api, a_wish_list_api)
			a_router.handle ("/resources/wish/{wish_id}/download/{filename}", l_wish_file_download_handler, a_router.methods_get)
			a_router.handle ("/resources/wish/{wish_id}/interaction/{id}/download/{filename}", l_wish_file_download_handler, a_router.methods_get)


				-- Wish Form
			create l_wish_form_handler.make (a_api, a_wish_list_api)
			a_router.handle ("/resources/wish/form", l_wish_form_handler, a_router.methods_get_post)
			a_router.handle ("/resources/wish/{id}/form", l_wish_form_handler, a_router.methods_get_post)

				-- Wish Interaction Form
			create l_wish_interaction_form_handler.make (a_api, a_wish_list_api)
			a_router.handle ("/resources/wish/detail/{wish_id}/interaction_form", l_wish_interaction_form_handler, a_router.methods_get_post)
			a_router.handle ("/resources/wish/detail/{wish_id}/interaction_form/{id}", l_wish_interaction_form_handler, a_router.methods_get_post)


				-- Wish details
			create l_wish_detail_handler.make (a_api, a_wish_list_api)
			a_router.handle ("/resources/wish/{id}/detail", l_wish_detail_handler, a_router.methods_get_post)
			a_router.handle ("/resources/wish/detail/{?search}", l_wish_detail_handler, a_router.methods_get_post)


				-- Wish Category Administrator
			create l_categories_handler.make (a_api, a_wish_list_api)
			create l_uri_mapping.make_trailing_slash_ignored ("/resources/wish/categories", l_categories_handler)
			a_router.map (l_uri_mapping, a_router.methods_get_post)


			create l_category_handler.make (a_api, a_wish_list_api)
			a_router.handle ("/resources/wish/add/category", l_category_handler, a_router.methods_get_post)
			a_router.handle ("/resources/wish/category/{id}", l_category_handler, a_router.methods_get)
			a_router.handle ("/resources/wish/category/{id}/edit", l_category_handler, a_router.methods_get_post)
--			a_router.handle ("/resources/wish/category/{id}/delete", l_category_handler, a_router.methods_get_post)

			create l_vote_handler.make (a_api, a_wish_list_api)
			a_router.handle ("/resources/wish/{id}/like", l_vote_handler, a_router.methods_get_post)
			a_router.handle ("/resources/wish/{id}/not_like", l_vote_handler, a_router.methods_get_post)
		end


feature -- Security

	permissions: LIST [READABLE_STRING_8]
			-- List of permission ids, used by this module, and declared.
		do
			Result := Precursor
			Result.force ("create wish")
			Result.force ("view own wish")
			Result.force ("view any wish")
			Result.force ("edit own wish")
			Result.force ("edit any wish")
			Result.force ("delete own wish")
			Result.force ("delete any wish")
			Result.force ("update any wish status")
			Result.force ("update own wish status")
			Result.force ("update any wish category")
			Result.force ("update own wish category")
			Result.force ("admin wish category")
		end

feature -- Hooks configuration

	setup_hooks (a_hooks: CMS_HOOK_CORE_MANAGER)
			-- Module hooks configuration.
		do
			auto_subscribe_to_hooks (a_hooks)
		end

	response_alter (a_response: CMS_RESPONSE)
			-- <Precursor>
		do
			if a_response.location.starts_with_general ("resources/wish") then
				a_response.add_style (a_response.module_resource_url (Current, "/files/css/wish_list.css", Void), Void)
				a_response.add_javascript_url (a_response.module_resource_url (Current, "/files/js/jquery.tooltipster.min.js", Void))
				a_response.add_javascript_url (a_response.module_resource_url (Current, "/files/js/wish_list.js", Void))
			end
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
