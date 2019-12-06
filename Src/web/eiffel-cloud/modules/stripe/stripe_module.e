note
	description: "Summary description for {STRIPE_MODULE}."
	date: "$Date$"
	revision: "$Revision$"

class
	STRIPE_MODULE

inherit
	CMS_MODULE
		rename
			module_api as stripe_api
		redefine
			initialize,
			install,
			setup_hooks,
			stripe_api,
			permissions
		end

	CMS_WITH_MODULE_ADMINISTRATION

	CMS_WITH_WEBAPI

	CMS_HOOK_AUTO_REGISTER

create
	make

feature {NONE} -- Initialization

	make
		do
			version := "1.0"
			description := "Stripe"
			package := "payment"
		end

feature -- Access

	name: STRING = "stripe"

feature {CMS_MODULE} -- Access control

	permissions: LIST [READABLE_STRING_8]
			-- <Precursor>
		do
			Result := Precursor
			Result.force ("manage stripe")
		end

feature {CMS_API} -- Module Initialization			

	initialize (api: CMS_API)
			-- <Precursor>
		local
			cfg: STRIPE_CONFIG
		do
			Precursor (api)
			if stripe_api = Void then
				if
					attached api.module_configuration_by_name ({STRIPE_MODULE}.name, "config") as l_cfg
				then
					if
						attached l_cfg.utf_8_text_item ("stripe.public_key") as l_pub and then
						attached l_cfg.utf_8_text_item ("stripe.secret_key") as l_sec
					then
						create cfg.make (l_pub, l_sec)
						if attached l_cfg.resolved_text_item ("stripe.testing") as s and then s.is_case_insensitive_equal_general ("yes") then
							cfg.enable_testing
						end
						if attached l_cfg.utf_8_text_item ("stripe.base_path") as l_base_path then
							if l_base_path.starts_with_general ("/") then
								cfg.set_base_path (l_base_path)
							else
								cfg.set_base_path ("/" + l_base_path)
							end
						end

						create stripe_api.make (api, cfg)
					end
				end

			end
		end

feature {CMS_API} -- Module management

	install (api: CMS_API)
		do
			Precursor (api)
		end

feature {NONE} -- Administration

	administration: STRIPE_MODULE_ADMINISTRATION
		do
			create Result.make (Current)
		end

feature {NONE} -- Webapi

	webapi: STRIPE_MODULE_WEBAPI
		do
			create Result.make (Current)
		end

feature {CMS_API, CMS_MODULE} -- Access: API

	stripe_api: detachable STRIPE_API
			-- <Precursor>

feature -- Access: router

	setup_router (a_router: WSF_ROUTER; a_api: CMS_API)
			-- <Precursor>
		do
			if attached stripe_api as l_mod_api then
				a_router.handle (l_mod_api.config.base_path + "/not_available", create {WSF_URI_AGENT_HANDLER}.make (agent handle_not_available (?,?, a_api)), a_router.methods_get)
				a_router.handle (l_mod_api.config.base_path + "/pay/{category}/{product}", create {STRIPE_HANDLER}.make (Current, l_mod_api, l_mod_api.config.base_path), a_router.methods_get)
				a_router.handle (l_mod_api.config.base_path + "/pay/{category}/{product}/terms", create {STRIPE_HANDLER}.make (Current, l_mod_api, l_mod_api.config.base_path), a_router.methods_get)
			end
		end

feature -- Helper

	payment_link (a_category: READABLE_STRING_GENERAL; a_product: READABLE_STRING_GENERAL): STRING
			-- Payment url for category `a_category` and product `a_product`.
		do
			if attached stripe_api as l_stripe_api and then l_stripe_api.config.is_valid then
				Result := l_stripe_api.config.base_path + "/pay/" + html_encoded (a_category) + "/" + html_encoded (a_product)
			else
				Result := {STRIPE_CONFIG}.default_base_path + "/not_available"
			end
		end

feature -- Routes

	handle_not_available (req: WSF_REQUEST; res: WSF_RESPONSE; api: CMS_API)
			-- If stripe configuration is not valid, return not available response.
		local
			r: GENERIC_VIEW_CMS_RESPONSE
		do
			create r.make (req, res, api)
			r.set_main_content ("<h2>Not available</h2>")
			r.execute
		end

feature -- Hooks configuration

	setup_hooks (a_hooks: CMS_HOOK_CORE_MANAGER)
			-- Module hooks configuration.
		do
		end

end
