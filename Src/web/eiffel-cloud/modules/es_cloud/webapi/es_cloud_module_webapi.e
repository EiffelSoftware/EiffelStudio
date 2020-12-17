note
	description: "Summary description for {ES_CLOUD_MODULE}."
	date: "$Date$"
	revision: "$Revision$"

class
	ES_CLOUD_MODULE_WEBAPI

inherit
	CMS_MODULE_WEBAPI [ES_CLOUD_MODULE]
		redefine
			setup_hooks
		end

	CMS_HOOK_WEBAPI_RESPONSE_ALTER

	CMS_HOOK_AUTO_REGISTER

create
	make

feature {NONE} -- Router/administration

	setup_webapi_router (a_router: WSF_ROUTER; a_api: CMS_API)
			-- <Precursor>
		local
			l_root: ES_CLOUD_ROOT_WEBAPI_HANDLER
			l_plans: ES_CLOUD_PLANS_WEBAPI_HANDLER
			l_account: ES_CLOUD_ACCOUNT_WEBAPI_HANDLER
			l_inst_hlr: ES_CLOUD_INSTALLATIONS_WEBAPI_HANDLER
			l_lic_hlr: ES_CLOUD_LICENSES_WEBAPI_HANDLER
		do
			if attached module.es_cloud_api as l_mod_api then
				create l_root.make (l_mod_api)
				a_router.handle ("/cloud", l_root, a_router.methods_get)
					-- FIXME: switch earlier for version. Using WSF_ROUTING_HANDLER.
				a_router.handle ("/cloud/{version}/", l_root, a_router.methods_get)
				create l_plans.make (l_mod_api)
				a_router.handle ("/cloud/{version}/plan/", l_plans, a_router.methods_get)
				a_router.handle ("/cloud/{version}/plan/{pid}", l_plans, a_router.methods_get)
				create l_account.make (l_mod_api)
				a_router.handle ("/cloud/{version}/account/", l_account, a_router.methods_get)
				a_router.handle ("/cloud/{version}/account/{uid}", l_account, a_router.methods_get)

				create l_lic_hlr.make (l_mod_api)
				a_router.handle ("/cloud/{version}/account/{uid}/licenses/", l_lic_hlr, a_router.methods_get) --_post)
				a_router.handle ("/cloud/{version}/account/{uid}/licenses/{license_id}", l_lic_hlr, a_router.methods_get)
				create l_inst_hlr.make (l_mod_api)
				a_router.handle ("/cloud/{version}/account/{uid}/installations", l_inst_hlr, a_router.methods_get_post)
				a_router.handle ("/cloud/{version}/account/{uid}/installations/{installation_id}", l_inst_hlr, a_router.methods_get_put_delete)
				a_router.handle ("/cloud/{version}/account/{uid}/installations/{installation_id}/session/", l_inst_hlr, a_router.methods_get)
				a_router.handle ("/cloud/{version}/account/{uid}/installations/{installation_id}/session/{session_id}", l_inst_hlr, a_router.methods_get)
			end
		end

feature -- Hooks configuration

	setup_hooks (a_hooks: CMS_HOOK_CORE_MANAGER)
			-- Module hooks configuration.
		do
			a_hooks.subscribe_to_webapi_response_alter_hook (Current)
			module.setup_hooks (a_hooks)
		end

feature -- Hook

	webapi_response_alter (rep: WEBAPI_RESPONSE)
		do
			if
				attached {HM_WEBAPI_RESPONSE} rep as hm and then
				rep.is_root
			then
				hm.add_link ("es:cloud", Void, rep.api.webapi_path ("cloud"))
			end
		end

note
	copyright: "2011-2017, Jocelyn Fiat, Javier Velilla, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
end
