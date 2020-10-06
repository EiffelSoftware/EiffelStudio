note
	description: "Summary description for {FEED_AGGREGATOR_MODULE_ADMINISTRATION}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	FEED_AGGREGATOR_MODULE_ADMINISTRATION

inherit
	CMS_MODULE_ADMINISTRATION [FEED_AGGREGATOR_MODULE]
		redefine
			setup_hooks,
			permissions
		end

	CMS_HOOK_RESPONSE_ALTER

	CMS_HOOK_MENU_SYSTEM_ALTER

	CMS_HOOK_CACHE

create
	make

feature -- Access

	permissions: LIST [READABLE_STRING_8]
			-- List of permission ids, used by this module, and declared.
		do
			Result := Precursor
			Result.force (permission__clear_feed_cache)
			Result.force (permission__manage_feed_aggregator)
		end

	permission__clear_feed_cache: STRING = "clear feed cache"

	permission__manage_feed_aggregator: STRING = "manage feed aggregator"

feature {NONE} -- Router/administration

	setup_administration_router (a_router: WSF_ROUTER; a_api: CMS_API)
		do
			a_router.handle ("/feed_aggregator/", create {WSF_URI_AGENT_HANDLER}.make (agent handle_feed_aggregator_admin (a_api, ?, ?)), a_router.methods_head_get_post)
		end

feature -- Handle

	handle_feed_aggregator_admin (a_api: CMS_API; req: WSF_REQUEST; res: WSF_RESPONSE)
		local
			nyi: NOT_IMPLEMENTED_ERROR_CMS_RESPONSE
		do
			create nyi.make (req, res, a_api)
			nyi.execute
		end

feature -- Hook

	setup_hooks (a_hooks: CMS_HOOK_CORE_MANAGER)
			-- Module hooks configuration.
		do
			a_hooks.subscribe_to_response_alter_hook (Current)
			a_hooks.subscribe_to_menu_system_alter_hook (Current)
			a_hooks.subscribe_to_cache_hook (Current)
		end

	clear_cache (a_cache_id_list: detachable ITERABLE [READABLE_STRING_GENERAL]; a_response: CMS_RESPONSE)
			-- <Precursor>.
		local
			p: PATH
			dir: DIRECTORY
		do
			if a_response.has_permissions (<<permission__clear_feed_cache, permission__manage_feed_aggregator>>) then
				if a_cache_id_list = Void then
						-- Clear all cache.
					p := a_response.api.cache_location.extended (name)
					create dir.make_with_path (p)
					if dir.exists then
						dir.recursive_delete
					end
					a_response.add_notice_message ("Cache cleared from " + name)
				end
			end
		end

	response_alter (a_response: CMS_RESPONSE)
		do
			module.response_alter (a_response)
		end

	menu_system_alter (a_menu_system: CMS_MENU_SYSTEM; a_response: CMS_RESPONSE)
			-- Hook execution on collection of menu contained by `a_menu_system'
			-- for related response `a_response'.
		do
			if a_response.is_authenticated then
				a_menu_system.navigation_menu.extend (create {CMS_LOCAL_LINK}.make ("Feeds", "feed_aggregation/"))
				if a_response.has_permission (permission__manage_feed_aggregator) then
					a_menu_system.management_menu.extend_into (a_response.api.administration_link ("Feeds (admin)", "feed_aggregator/"), "Admin", a_response.api.administration_path_location (""))
				end
			end
		end

end
