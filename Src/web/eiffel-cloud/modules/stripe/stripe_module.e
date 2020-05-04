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
			add_dependency ({CMS_AUTHENTICATION_MODULE})
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
				a_router.handle (l_mod_api.config.base_path + "/subscribe/{category}/{checkout}", create {STRIPE_SUBSCRIPTION_HANDLER}.make (Current, l_mod_api, l_mod_api.config.base_path), a_router.methods_get)

				a_router.handle (l_mod_api.config.base_path + "/pay/{category}/{checkout}", create {STRIPE_PAYMENT_HANDLER}.make (Current, l_mod_api, l_mod_api.config.base_path), a_router.methods_get)
				a_router.handle (l_mod_api.config.base_path + "/pay/{category}/{checkout}/terms", create {STRIPE_PAYMENT_HANDLER}.make (Current, l_mod_api, l_mod_api.config.base_path), a_router.methods_get)
				a_router.handle (l_mod_api.config.base_path + "/test", create {WSF_URI_AGENT_HANDLER}.make (agent handle_test (?,?, a_api)), a_router.methods_get_post)
			end
		end

feature -- Helper

	payment_link (a_category: READABLE_STRING_GENERAL; a_checkout: READABLE_STRING_GENERAL): READABLE_STRING_8
			-- Payment url for category `a_category` and checkout `a_checkout`.
		do
			if attached stripe_api as l_stripe_api and then l_stripe_api.config.is_valid then
				Result := l_stripe_api.config.base_path + "/pay/" + html_encoded (a_category) + "/" + html_encoded (a_checkout)
			else
				Result := {STRIPE_CONFIG}.default_base_path + "/not_available"
			end
		end

	subscription_checkout_link (a_category: READABLE_STRING_GENERAL; a_checkout: READABLE_STRING_GENERAL): READABLE_STRING_8
			-- Checkout url for checkout from category `a_category` and checkout `a_checkout`.
		do
			if attached stripe_api as l_stripe_api and then l_stripe_api.config.is_valid then
				Result := l_stripe_api.config.base_path + "/subscribe/" + html_encoded (a_category) + "/" + html_encoded (a_checkout)
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

	handle_test (req: WSF_REQUEST; res: WSF_RESPONSE; api: CMS_API)
			-- If stripe configuration is not valid, return not available response.
		local
			r: GENERIC_VIEW_CMS_RESPONSE
			l_html: STRING_8
			l_prod_name, l_plan_name: STRING_32
			l_product: STRIPE_PRODUCT
			l_plan: STRIPE_PLAN
			l_customer: STRIPE_CUSTOMER
			l_subscription: STRIPE_SUBSCRIPTION
			l_validation: STRIPE_PAYMENT_VALIDATION
		do
			create r.make (req, res, api)
			create l_html.make_empty
			l_html.append ("<h2>Testing stripe API</h2>")
			if attached stripe_api as l_stripe_api then
				if attached req.string_item ("valid_subscription") as l_sub_id then
					if
						attached l_stripe_api.subscription (l_sub_id) as l_sub and then
						attached l_stripe_api.subscription_customer (l_sub) as c
					then
						create l_validation.make_from_subscription (l_sub, c)
						l_stripe_api.invoke_validate_payment (l_validation)
					end
				else
					l_prod_name := "ES-perso"
					if attached l_stripe_api.product_by_name (l_prod_name) as prod then
						l_product := prod
						l_html.append ("<h3>Found product " + html_encoded (l_prod_name) + "</h3><pre>")
						l_html.append ("<pre>")
						l_html.append (prod.to_string)
						l_html.append ("</pre>")
					elseif attached l_stripe_api.new_service_product (l_prod_name) as prod then
						l_html.append ("<h3>New product "+ html_encoded (l_prod_name) +"</h3><pre>")
						l_html.append (prod.to_string)
						l_html.append ("</pre>")
						l_product := l_stripe_api.product (prod.id)
						if l_product /= Void then
							l_html.append ("<pre>")
							l_html.append (l_product.to_string)
							l_html.append ("</pre>")
						end
					end

					if l_product = Void then
						create l_product.make_service_with_name (l_prod_name)
					end
					l_plan_name := l_prod_name + "-mly"
					if attached l_stripe_api.plan_by_nickname (l_plan_name) as pl then
						l_plan := pl
						l_html.append ("<h3>Found plan " + html_encoded (l_plan_name) + "</h3><pre>")
						l_html.append ("<pre>")
						l_html.append (pl.to_string)
						l_html.append ("</pre>")
					elseif attached l_stripe_api.new_monthly_plan (99900, "usd", l_product, l_plan_name) as pl then
						l_html.append ("<h3>New plan "+ html_encoded (l_plan_name) +"</h3><pre>")
						l_html.append (pl.to_string)
						l_html.append ("</pre>")
						l_plan := l_stripe_api.plan (pl.id)
						if l_plan /= Void then
							l_html.append ("<pre>")
							l_html.append (l_plan.to_string)
							l_html.append ("</pre>")
						end
					end

					l_customer := l_stripe_api.customer_by_email ("jfiat+shop@eiffel.com")
					if l_customer = Void then
						create l_customer.make_with_email ("jfiat+shop@eiffel.com")
						l_customer.set_name ("Jocelyn Fiat-Testing")
						l_customer.set_description ("Testing stripe api")
						l_customer := l_stripe_api.new_customer (l_customer)
					end

					if l_customer /= Void and l_plan /= Void then
						l_subscription := l_stripe_api.new_subscription (Void, l_customer, l_plan, Void)
						if l_subscription /= Void then
							l_html.append ("<h3>New subscription ...</h3><ul>")
							l_html.append ("<li><pre>")
							l_html.append (l_subscription.to_string)
							l_html.append ("</pre></li>")
						end
					end

					if attached l_stripe_api.customers (0) as lst then
						l_html.append ("<h3>Customers ...</h3><ul>")
						across
							lst as ic
						loop
							l_html.append ("<li><pre>")
							l_html.append (ic.item.to_string)
							l_html.append ("</pre></li>")
						end
						l_html.append ("</ul>")
					end

					if attached l_stripe_api.products (0) as lst then
						l_html.append ("<h3>Products ...</h3><ul>")
						across
							lst as ic
						loop
							l_html.append ("<li><pre>")
							l_html.append (ic.item.to_string)
							l_html.append ("</pre></li>")
						end
						l_html.append ("</ul>")
					end
					if attached l_stripe_api.plans (Void, 0) as lst then
						l_html.append ("<h3>Plans ...</h3><ul>")
						across
							lst as ic
						loop
							l_html.append ("<li><pre>")
							l_html.append (ic.item.to_string)
							l_html.append ("</pre></li>")
						end
						l_html.append ("</ul>")
					end
				end
			end
			r.set_main_content (l_html)
			r.execute
		end

feature -- Hooks configuration

	setup_hooks (a_hooks: CMS_HOOK_CORE_MANAGER)
			-- Module hooks configuration.
		do
		end

end
