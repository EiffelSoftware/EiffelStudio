note
	description: "Summary description for {ES_CLOUD_MODULE}."
	date: "$Date$"
	revision: "$Revision$"

class
	ES_CLOUD_MODULE

inherit
	CMS_MODULE
		rename
			module_api as es_cloud_api
		redefine
			initialize,
			install,
			setup_hooks,
			es_cloud_api,
			permissions
		end

	CMS_WITH_MODULE_ADMINISTRATION

	CMS_WITH_WEBAPI

	CMS_HOOK_AUTO_REGISTER

	CMS_HOOK_RESPONSE_ALTER

	CMS_HOOK_BLOCK

	CMS_HOOK_BLOCK_HELPER

	STRIPE_HOOK

create
	make

feature {NONE} -- Initialization

	make
		do
			version := "1.0"
			description := "ES Cloud"
			package := "EiffelStudio"
			add_optional_dependency ({STRIPE_MODULE})
		end

feature -- Access

	name: STRING = "es_cloud"

feature {CMS_MODULE} -- Access control

	permissions: LIST [READABLE_STRING_8]
			-- <Precursor>
		do
			Result := Precursor
			Result.force ("manager es accounts")
			Result.force ("view es account")
		end

feature {CMS_API} -- Module Initialization			

	initialize (api: CMS_API)
			-- <Precursor>
		local
			l_es_cloud_api: like es_cloud_api
		do
			Precursor (api)
			if es_cloud_api = Void then
				create l_es_cloud_api.make (api)
				es_cloud_api := l_es_cloud_api
			end
		end

feature {CMS_API} -- Module management

	install (api: CMS_API)
		local
			pl: ES_CLOUD_PLAN
			l_es_cloud_api: like es_cloud_api
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
			if is_installed (api) then
				create l_es_cloud_api.make (api)
				es_cloud_api := l_es_cloud_api
				create pl.make ("trial")
				pl.set_title ("Trial")
				l_es_cloud_api.save_plan (pl)

				if attached api.user_api.anonymous_user_role as l_anonymous_role then
						-- By default, add extra permissions to anonymous role.
					l_anonymous_role.add_permission ("use jwt_auth")
					api.user_api.save_user_role (l_anonymous_role)
				end
			end
		end

feature {NONE} -- Administration

	administration: ES_CLOUD_MODULE_ADMINISTRATION
		do
			create Result.make (Current)
		end

feature {NONE} -- Webapi

	webapi: ES_CLOUD_MODULE_WEBAPI
		do
			create Result.make (Current)
		end

feature {CMS_API, CMS_MODULE} -- Access: API

	es_cloud_api: detachable ES_CLOUD_API
			-- <Precursor>

feature -- Access: router

	setup_router (a_router: WSF_ROUTER; a_api: CMS_API)
			-- <Precursor>
		do
			if attached es_cloud_api as l_mod_api then
				a_router.handle ("/cloud", create {ES_CLOUD_HANDLER}.make (l_mod_api), a_router.methods_get)
			end
		end

feature -- Hooks configuration

	setup_hooks (a_hooks: CMS_HOOK_CORE_MANAGER)
			-- Module hooks configuration.
		do
--			a_hooks.subscribe_to_form_alter_hook (Current)
			a_hooks.subscribe_to_hook (Current, {STRIPE_HOOK})
		end

feature -- Hook

	prepare_payment (p: STRIPE_PAYMENT)
		do
			if p.category.is_case_insensitive_equal_general ("es_cloud") then
				if
					attached es_cloud_api as l_cloud_api and then
					attached l_cloud_api.store as l_store and then
					attached l_store.item (p.product_name) as l_store_item
				then
					p.set_price (l_store_item.price * 100 + l_store_item.cents_price, l_store_item.currency)
					p.set_business_name ("EiffelSoftware")
					if attached l_cloud_api.cms_api.user as u then
						p.set_customer_name (l_cloud_api.cms_api.user_display_name (u))
						p.set_customer_email (u.email)
					end
					p.mark_prepared
				end
			end
		end

	response_alter (a_response: CMS_RESPONSE)
		local
			b: CMS_CONTENT_BLOCK
		do
			if a_response.is_front then
				a_response.set_value (a_response.url ("/cloud", Void), "escloud_url")
--				create b.make_raw ("Welcome", Void, "<h1>Hello EiffelStudio users</h1><p><a href=%""+ a_response.url ("/cloud", Void) +"%">Go to Cloud page...</a>", Void)
--				a_response.add_block (b, "content")
			end
		end

feature -- Hooks: block

	block_list: detachable ITERABLE [like {CMS_BLOCK}.name]
			-- List of block names, managed by current object.
			-- If prefixed by "?", condition will be checked
			-- to determine if it should be displayed (and computed) or not.
		do
			Result := <<"?cloud_store">>
		end

	get_block_view (a_block_id: READABLE_STRING_8; a_response: CMS_RESPONSE)
			-- Get block object identified by `a_block_id` and associate with `a_response`.
			-- Warning: be carefully with caching, if get_block_view is altering `a_response`
			--		as linking with css, js ... It should be done in `setup_block_view`.
		do
			if attached es_cloud_api as l_cloud_api then
				if a_block_id.is_case_insensitive_equal_general ("cloud_store") then
					if a_response.request.is_get_request_method then
						a_response.add_block (new_store_block (l_cloud_api, a_response), "content")
						a_response.add_style (a_response.module_resource_url (Current, "/files/css/pricing.css", Void), Void)
					end
				else

				end
			end
		end

	new_store_block (api: ES_CLOUD_API; a_response: CMS_RESPONSE): CMS_CONTENT_BLOCK
		local
			l_html: STRING
			l_item: ES_CLOUD_STORE_ITEM
		do
			create l_html.make (1024)
			l_html.append ("<h1>Store</h1><div class=%"pricing%">")
			if
				attached api.store as l_store
			then
				l_html.append ("<div class=%"plans%">")
				across
					l_store.items as ic
				loop
					l_item := ic.item
					if attached api.plan_by_name (l_item.id) as pl then
						l_html.append ("<div class=%"plan "+ html_encoded (pl.name) +"%">")

						l_html.append ("<h2>"+ html_encoded (pl.title_or_name) + "</h2>")
						l_html.append ("<div class=%"prices%">")
						if l_item.is_free then
							l_html.append ("Free")
						else
							l_html.append (l_item.price.out + " " + l_item.currency.as_upper)
						end
						l_html.append ("</div>")
						l_html.append ("<div class=%"actions%">")
						if attached {STRIPE_MODULE} api.cms_api.module ({STRIPE_MODULE}) as l_stripe_module then
							l_html.append ("<a href=%"" + api.cms_api.location_url ("/try_now", Void) + "%">Try now</a>")
							if not l_item.is_free then
								l_html.append ("<a href=%""+ api.cms_api.location_url (l_stripe_module.payment_link ("es_cloud", pl.name), Void) + "%">Buy now</a>")
							end
						end
						l_html.append ("</div>")
						if attached pl.description as l_desc then
							l_html.append ("<div class=%"features%"><header>")
							l_html.append (html_encoded (l_desc))
							l_html.append ("</header></div>")
						end
						l_html.append ("</div>")
					end
				end
				l_html.append ("</div></div>")
			end
			create Result.make_raw ("cloud_store", "EiffelStudio plans", l_html, a_response.api.formats.full_html)
		end

end
