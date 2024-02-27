note
	description: "Summary description for {ES_CLOUD_MODULE}."
	date: "$Date$"
	revision: "$Revision$"

class
	ES_CLOUD_MODULE

inherit
	CMS_MODULE_WITH_SQL_STORAGE
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

	CMS_HOOK_MENU_SYSTEM_ALTER

	CMS_HOOK_RESPONSE_ALTER

	CMS_HOOK_FORM_ALTER

	CMS_HOOK_BLOCK

	CMS_HOOK_BLOCK_HELPER

	SHOP_HOOK
		redefine
			commit_cart
		end

	CMS_HOOK_USER_MANAGEMENT

--	STRIPE_HOOK

create
	make

feature {NONE} -- Initialization

	make
		do
			version := "1.8"
			description := "ES Cloud"
			package := "EiffelStudio"
			add_optional_dependency ({SHOP_MODULE})
--			add_optional_dependency ({STRIPE_MODULE})
			add_optional_dependency ({CMS_AUTHENTICATION_MODULE})
			add_optional_dependency ({CMS_ADMIN_MODULE})
		end

feature -- Access

	name: STRING = "es_cloud"

feature {CMS_MODULE} -- Access control

	permissions: LIST [READABLE_STRING_8]
			-- <Precursor>
		do
			Result := Precursor
			Result.force (perm_manage_es_accounts)
			Result.force (perm_view_es_accounts)
			Result.force (perm_view_es_licenses)
			Result.force (perm_view_es_installations)
			Result.force (perm_discard_own_installations)
			Result.force (perm_update_own_installations)
			Result.force (perm_view_any_es_activities)
			Result.force (perm_view_es_sessions)
			Result.force (perm_buy_es_license)
			Result.force (perm_access_es_stats)
			Result.force (perm_view_cloud_profiles)
		end

feature -- Access control

	perm_manage_es_accounts: STRING = "manager es accounts"
	perm_view_es_accounts: STRING = "view es accounts"
	perm_view_es_licenses: STRING = "view es licenses"
	perm_view_es_installations: STRING = "view es installations"
	perm_view_any_es_activities: STRING = "view any es activities"
	perm_view_es_sessions: STRING = "view es sessions"
	perm_discard_own_installations: STRING = "discard own installations"
	perm_update_own_installations: STRING = "update own installations"
	perm_manage_es_licenses: STRING = "manager es licenses"
	perm_buy_es_license: STRING = "buy es licenses"
	perm_access_es_stats: STRING = "access es stats"
	perm_view_cloud_profiles: STRING = "view cloud profiles"

feature {CMS_API} -- Module Initialization			

	initialize (api: CMS_API)
			-- <Precursor>
		local
			l_es_cloud_api: like es_cloud_api
		do
			Precursor (api)
			if es_cloud_api = Void then
				create l_es_cloud_api.make (Current, api)
				es_cloud_api := l_es_cloud_api
			end
		end

feature {CMS_API} -- Module management

	install (api: CMS_API)
		local
			pl: ES_CLOUD_PLAN
			l_es_cloud_api: like es_cloud_api
		do
			Precursor {CMS_MODULE_WITH_SQL_STORAGE} (api)
			if is_installed (api) then
				create l_es_cloud_api.make (Current, api)
				es_cloud_api := l_es_cloud_api
				create pl.make ("trial")
				pl.set_title ("Trial")
				pl.trial_period_in_days := 15
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

feature {CMS_API, CMS_MODULE_API, CMS_MODULE} -- Access: API

	es_cloud_api: detachable ES_CLOUD_API
			-- <Precursor>

feature -- Access: router

	setup_router (a_router: WSF_ROUTER; a_api: CMS_API)
			-- <Precursor>
		local
			h: ES_CLOUD_HANDLER
			h_prof: ES_CLOUD_PROFILE_HANDLER
			h_profs: ES_CLOUD_PROFILES_HANDLER
			h_forms: ES_CLOUD_FORMS_HANDLER
			h_stats: ES_CLOUD_STATISTICS_HANDLER
			h_act: ES_CLOUD_ACTIVITIES_HANDLER
			h_lic: ES_CLOUD_LICENSES_HANDLER
			h_inst: ES_CLOUD_INSTALLATIONS_HANDLER
			h_redeem: ES_CLOUD_REDEEM_TOKEN_HANDLER
		do
			if attached es_cloud_api as l_mod_api then
				create h.make (l_mod_api)
				a_router.handle ("/" + root_location, h, a_router.methods_get)

				create h_prof.make (Current, l_mod_api)
				a_router.handle ("/" + cloud_profile_location + "{account_id}", h_prof, a_router.methods_get_post)

				create h_profs.make (Current, l_mod_api)
				a_router.handle ("/" + cloud_profiles_location, h_profs, a_router.methods_get)

				create h_stats.make (Current, l_mod_api)
				a_router.handle ("/" + statistics_location, h_stats, a_router.methods_get)

				create h_forms.make (Current, l_mod_api)
				a_router.handle ("/" + cloud_forms_location + "{form_id}", h_forms, a_router.methods_get_post)

				create h_act.make (l_mod_api)
				a_router.handle ("/" + activities_location, h_act, a_router.methods_get)
				a_router.handle ("/" + activities_location + "{license_key}", h_act, a_router.methods_get)

				create h_lic.make (Current, l_mod_api)
				a_router.handle ("/" + licenses_location, h_lic, a_router.methods_get_post)
				a_router.handle ("/" + licenses_location + "{license_key}", h_lic, a_router.methods_get)
				a_router.handle ("/" + licenses_location + "{license_key}/billing/", h_lic, a_router.methods_get)
				a_router.handle ("/" + licenses_location + "_/{action}", h_lic, a_router.methods_get_post)
				a_router.handle ("/" + licenses_location + "_/{action}/", h_lic, a_router.methods_get_post)

				create h_inst.make (Current, l_mod_api)
				a_router.handle ("/" + installations_location + "{installation_id}", h_inst, a_router.methods_get)
				a_router.handle ("/" + installations_location, h_inst, a_router.methods_get)

				create h_redeem.make (Current, l_mod_api)
				a_router.handle ("/" + redeem_location, h_redeem, a_router.methods_get_post)
				a_router.handle ("/" + redeem_location + "{redeem}", h_redeem, a_router.methods_get_post)
			end
		end

	root_location: STRING = "cloud/"

	cloud_profile_location: STRING = "cloud/profile/"

	cloud_profiles_location: STRING = "cloud/profiles/"

	cloud_forms_location: STRING = "cloud/forms/"

	activities_location: STRING = "activities/"

	statistics_location: STRING = "statistics/"

	licenses_location: STRING = "licenses/"

	installations_location: STRING = "installations/"

	redeem_location: STRING = "redeem/"

	license_activities_location (lic: ES_CLOUD_LICENSE): STRING
		do
			Result := activities_location + url_encoded (lic.key)
		end

	license_location (lic: ES_CLOUD_LICENSE): STRING
		do
			Result := licenses_location + url_encoded (lic.key)
		end

	installation_location (inst: ES_CLOUD_INSTALLATION): STRING
		do
			Result := installations_location + url_encoded (inst.id)
		end

	user_cloud_profile_location (u: ES_CLOUD_USER): STRING
		do
			Result := cloud_profile_location + url_encoded (u.cms_user.name)
		end

feature -- Hooks configuration

	setup_hooks (a_hooks: CMS_HOOK_CORE_MANAGER)
			-- Module hooks configuration.
		do
			a_hooks.subscribe_to_form_alter_hook (Current)
			a_hooks.subscribe_to_menu_system_alter_hook (Current)
			a_hooks.subscribe_to_response_alter_hook (Current)
			a_hooks.subscribe_to_hook (Current, {SHOP_HOOK})
			a_hooks.subscribe_to_hook (Current, {CMS_HOOK_USER_MANAGEMENT})
--			a_hooks.subscribe_to_hook (Current, {STRIPE_HOOK})
		end

feature -- Hook

	shop_provider_name: STRING = "es"

	fill_cart_item (a_cart: SHOPPING_CART; a_cart_item: SHOPPING_ITEM)
		local
			l_prov_name: READABLE_STRING_GENERAL
			d: SHOPPING_ITEM_DETAILS
			l_price, l_cents_price: NATURAL_32
			l_quantity: NATURAL_32
		do
			if
				attached es_cloud_api as api and then
				attached api.store (a_cart.currency, False) as l_store
			then
				l_prov_name := api.config.shop_provider_name
				if a_cart_item.provider.is_case_insensitive_equal_general (l_prov_name) then
					if
						attached l_store.item (a_cart_item.code) as l_store_item and then
						a_cart.is_currency_accepted (l_store_item.currency)
					then
						l_quantity := a_cart_item.quantity
--						l_price := l_store_item.price * l_quantity
--						l_cents_price := l_store_item.cents_price * l_quantity
--						if l_cents_price > 99 then
--							l_price := l_price + l_cents_price // 100
--							l_cents_price := l_cents_price \\ 100
--						end

						l_price := l_store_item.price
						l_cents_price := l_store_item.cents_price


						create d
						d.set_price (l_price, l_cents_price, l_store_item.currency)
						if l_store_item.is_yearly then
							d.set_yearly (1)
						elseif l_store_item.is_monthly then
							d.set_monthly (1)
						elseif l_store_item.is_weekly then
							d.set_weekly (1)
						elseif l_store_item.is_daily then
							d.set_daily (1)
						else
								-- Default
							d.set_onetime
						end
						d.set_title (l_store_item.title)
						a_cart_item.set_details (d)
					end
				end
			end
		end

	commit_cart (a_cart: SHOPPING_CART; a_order: SHOPPING_ORDER)
		local
			lic: ES_CLOUD_LICENSE
			l_email: READABLE_STRING_8
			l_user: CMS_USER
			l_is_cycle: BOOLEAN
		do
			if
				attached es_cloud_api as api and then
				attached a_order.reference_id as l_ref_id and then
				attached api.subscribed_licenses (l_ref_id) as l_licenses
			then
				api.cms_api.log_debug (name, "commit_cart (cart#" + a_cart.identifier + " order#" + a_order.name + ")", Void)

				l_email := a_cart.email
				if l_email = Void then
					l_email := a_order.email
				end
				if l_email /= Void then
					l_user := api.cms_api.user_api.user_by_email (l_email)
					if l_user = Void then
						l_user := api.cms_api.user_api.temp_user_by_email (l_email)
					end
				end

				check same_count: l_licenses.count.to_natural_32 = a_cart.count end
				across
					l_licenses as ic
				loop
					l_is_cycle := True
					lic := ic.item
					if a_cart.has_details then
						if a_cart.is_yearly then
							api.save_license_with_duration_extension (lic, 1, 0, 0)
						elseif a_cart.is_monthly then
							api.save_license_with_duration_extension (lic, 0, 1, 0)
						elseif a_cart.is_weekly then
							api.save_license_with_duration_extension (lic, 0, 0, 7)
						elseif a_cart.is_daily then
							api.save_license_with_duration_extension (lic, 0, 0, 1)
						elseif a_cart.is_onetime then
							l_is_cycle := False
						else
							check should_nor_occur: False end
								-- Missing information, but keep it as a cycle
								-- l_is_cycle := False

								-- FIXME: Assume it is monthly cycle
							api.save_license_with_duration_extension (lic, 0, 1, 0)

							api.cms_api.log_error ({ES_CLOUD_MODULE}.name, "ISSUE: Commit cart#" + utf_8_encoded (a_cart.identifier) + " (order#" + utf_8_encoded (a_order.name) + "): unable to determine nature (onetime, monthly,...)", Void)
							api.notify_error ("Issue with Commit cart#" + utf_8_encoded (a_cart.identifier) + " (order#" + utf_8_encoded (a_order.name) + "): unable to determine nature (onetime, monthly,...)", a_cart.out)
						end
					else
						if a_order.is_yearly (0) then
							api.save_license_with_duration_extension (lic, a_order.interval_count, 0, 0)
						elseif a_order.is_monthly (0) then
							api.save_license_with_duration_extension (lic, 0, a_order.interval_count, 0)
						elseif a_order.is_weekly (0) then
							api.save_license_with_duration_extension (lic, 0, 0, 7 * a_order.interval_count)
						elseif a_order.is_daily (0) then
							api.save_license_with_duration_extension (lic, 0, 0, a_order.interval_count)
						elseif a_cart.is_onetime then
							l_is_cycle := False
						else
							check should_nor_occur: False end
								-- Missing information, but keep it as a cycle
								-- l_is_cycle := False

								-- FIXME: Assume it is monthly cycle
							api.save_license_with_duration_extension (lic, 0, 1, 0)

							api.cms_api.log_error ({ES_CLOUD_MODULE}.name, "ISSUE: Commit order#" + utf_8_encoded (a_order.name) + "(cart#" + utf_8_encoded (a_cart.identifier) + "): unable to determine nature (onetime, monthly,...)", Void)
							api.notify_error ("Issue with Commit order#" + utf_8_encoded (a_order.name) + "(cart#" + utf_8_encoded (a_cart.identifier) + "): unable to determine nature (onetime, monthly,...)", a_order.out)
						end
					end
					if l_is_cycle then
						--FIXME: should we send notification to the user???
--						if not l_email /= Void then
--							api.send_extended_license_mail (l_user, l_email, lic)
--						end
						api.notify_extended_license (l_user, l_email, lic)
					else
						api.cms_api.log_error (name, "ISSUE: Expecting subscription cycle for license " + html_encoded (lic.key), Void)
						api.notify_new_license (l_user, if l_user /= Void then l_user.name else Void end, l_email, lic, Void)
					end
				end
			else
				Precursor (a_cart, a_order)
			end
		end

	commit_cart_item (a_cart: SHOPPING_CART; a_cart_item: SHOPPING_ITEM; a_order: SHOPPING_ORDER)
		local
			l_prov_name: READABLE_STRING_GENERAL
			l_quantity: NATURAL_32
			lic: ES_CLOUD_LICENSE
			l_email: detachable READABLE_STRING_8
			l_user: detachable CMS_USER
			l_trial_licences: detachable LIST [ES_CLOUD_USER_LICENSE]
			l_trial_lic: detachable ES_CLOUD_USER_LICENSE
		do
			if
				attached es_cloud_api as api and then
				attached api.store (a_cart.currency, False) as l_store
			then
				api.cms_api.log_debug (name, "commit_cart_item", Void)
				l_prov_name := api.config.shop_provider_name
				if a_cart_item.provider.is_case_insensitive_equal_general (l_prov_name) then
						-- TODO: check invoice email instead!!!
					l_email := a_cart.email
					if attached api.active_user as l_cloud_user then
						l_user := l_cloud_user
					end
					if l_user = Void then
						if l_email /= Void then
							l_user := api.cms_api.user_api.user_by_email (l_email)
							if l_user = Void then
								l_user := api.cms_api.user_api.temp_user_by_email (l_email)
							end
						end
					elseif l_email = Void then
						l_email := l_user.email
					end
					if
						(l_user /= Void or l_email /= Void) and then
						attached l_store.item (a_cart_item.code) as l_store_item and then
						a_cart.is_currency_accepted (l_store_item.currency)
					then
						if
							attached l_store_item.name as l_item_name and then
							attached api.plan_by_name (l_item_name) as l_plan
						then
							if l_user /= Void then
								l_trial_licences := api.trial_user_licenses (l_user)
							end
							from
								l_quantity := a_cart_item.quantity
							until
								l_quantity = 0
							loop
								if l_trial_licences /= Void and then not l_trial_licences.is_empty then
									l_trial_lic := l_trial_licences.first
									l_trial_licences.prune_all (l_trial_lic)
								else
									l_trial_lic := Void
								end
								if l_trial_lic /= Void then
									lic := l_trial_lic.license
									lic.set_plan (l_plan)
									lic.reset_date
									api.save_license (lic)
								else
									lic := api.new_license_for_plan (l_plan)
								end
								if lic /= Void then
									if l_store_item.is_onetime then
											-- By default, yearly
										api.save_license_with_duration_extension (lic, 0, l_store_item.onetime_month_duration.to_integer_32, 0)
										api.record_onetime_license_payment (lic, l_store_item.onetime_month_duration, a_order.reference_id)
									else
										if l_store_item.is_yearly then
											api.save_license_with_duration_extension (lic, 1, 0, 0)
											api.record_yearly_license_subscription (lic, a_order.reference_id)
										elseif l_store_item.is_monthly then
											api.save_license_with_duration_extension (lic, 0, 1, 0)
											api.record_monthly_license_subscription (lic, a_order.reference_id)
										elseif l_store_item.is_weekly then
											api.save_license_with_duration_extension (lic, 0, 0, 7)
											api.record_weekly_license_subscription (lic, a_order.reference_id)
										elseif l_store_item.is_daily then
											api.save_license_with_duration_extension (lic, 0, 0, 1)
											api.record_daily_license_subscription (lic, a_order.reference_id)
										else
											api.save_license (lic)
										end
									end
									if l_user /= Void then
										if l_trial_lic = Void then
											api.assign_license_to_user (lic, l_user)
										end
									elseif l_email /= Void then
										api.assign_license_to_email (lic, l_email)
									end
									if l_email /= Void then
										api.send_new_license_mail (l_user, Void, l_email, lic, l_trial_lic, Void)
									end
									api.notify_new_license (l_user, Void, l_email, lic, l_trial_lic)
								end
								l_quantity := l_quantity - 1
							end
						end
					end
				end
			end
		end

	response_alter (a_response: CMS_RESPONSE)
		do
			a_response.add_style (a_response.module_resource_url (Current, "/files/css/es_cloud.css", Void), Void)
			a_response.set_value (a_response.url ("/" + root_location, Void), "escloud_url")
			a_response.set_value (a_response.url ("/" + licenses_location, Void), "escloud_licenses_url")
		end

	menu_system_alter (a_menu_system: CMS_MENU_SYSTEM; a_response: CMS_RESPONSE)
			-- Hook execution on collection of menu contained by `a_menu_system'
			-- for related response `a_response'.
		local
			lnk: CMS_LOCAL_LINK
		do
			if attached a_response.user as u then
				create lnk.make (a_response.api.translation ("Your Profile", Void), user_cloud_profile_location (u))
				lnk.set_weight (88)
				a_menu_system.primary_menu.extend (lnk)

				create lnk.make (a_response.api.translation ("Licenses", Void), licenses_location)
				lnk.set_weight (10)
				a_menu_system.primary_menu.extend (lnk)
				if a_response.has_permission (perm_access_es_stats) then
					create lnk.make (a_response.api.translation ("Stats", Void), statistics_location)
					lnk.set_weight (20)
					a_menu_system.primary_menu.extend (lnk)
				end
			end
			create lnk.make (a_response.api.translation ("Downloads", Void), "downloads")
			lnk.set_weight (25)
			a_menu_system.primary_menu.extend (lnk)
		end

feature -- Hooks: user management

	new_user (a_user: CMS_USER)
		local
			lic: ES_CLOUD_EMAIL_LICENSE
			u: ES_CLOUD_USER
		do
			if attached es_cloud_api as l_es_cloud_api then
				if
					attached a_user.email as l_email and then
					attached l_es_cloud_api.email_licenses (l_email) as l_licenses
				then
					u := a_user
					across
						l_licenses as ic
					loop
						lic := ic.item
						l_es_cloud_api.move_email_license_to_user (lic, u)
						if not l_es_cloud_api.has_error then
							l_es_cloud_api.send_new_license_mail (a_user, Void, l_email, lic.license, Void, Void)
						end
					end
				end
			end
		end

feature -- Hooks: forms alter

	form_alter (a_form: CMS_FORM; a_form_data: detachable WSF_FORM_DATA; a_response: CMS_RESPONSE)
			-- Hook execution on form `a_form' and its associated data `a_form_data',
			-- for related response `a_response'.
		local
			wtxt: WSF_WIDGET_TEXT
		do
			if
				attached es_cloud_api as l_cloud_api and then
				attached a_form.id as l_form_id
			then
				if l_form_id.same_string ({CMS_AUTHENTICATION_MODULE}.view_account_form_id) then
					create wtxt.make_with_text ("<hr/><div class=%"user-view-cloud-box%"><a href=%"" + a_response.api.location_url ("/" + licenses_location, Void) + "%">View your licenses</a>.</div>")
					a_form.prepend (wtxt)
				end
			end
		end

feature -- Hooks: block

	block_list: detachable ITERABLE [like {CMS_BLOCK}.name]
			-- List of block names, managed by current object.
			-- If prefixed by "?", condition will be checked
			-- to determine if it should be displayed (and computed) or not.
		do
			Result := <<"?cloud_account_summary", "?cloud_store", "?cloud_buy">>
		end

	get_block_view (a_block_id: READABLE_STRING_8; a_response: CMS_RESPONSE)
			-- Get block object identified by `a_block_id` and associate with `a_response`.
			-- Warning: be carefully with caching, if get_block_view is altering `a_response`
			--		as linking with css, js ... It should be done in `setup_block_view`.
		do
			if attached es_cloud_api as l_cloud_api then
				if a_block_id.is_case_insensitive_equal_general ("cloud_account_summary") then
					if attached l_cloud_api.cms_api.user as u then
						a_response.add_block (new_account_summary_block (create {ES_CLOUD_USER}.make (u), l_cloud_api, a_response), "content")
					end
				elseif a_block_id.is_case_insensitive_equal_general ("cloud_store") then
					if a_response.request.is_get_request_method then
						a_response.add_block (new_store_block (l_cloud_api, a_response), "content")
						a_response.add_style (a_response.module_resource_url (Current, "/files/css/pricing.css", Void), Void)
					end
				elseif a_block_id.is_case_insensitive_equal_general ("cloud_buy") then
					if a_response.request.is_get_request_method then
						if l_cloud_api.cms_api.has_permission ({ES_CLOUD_MODULE}.perm_buy_es_license) then
							a_response.add_block (new_buy_block (l_cloud_api, a_response), "content")
							a_response.add_style (a_response.module_resource_url (Current, "/files/css/es_cloud.css", Void), Void)
						end
					end
				end
			end
		end

	new_account_summary_block (a_user: CMS_USER; api: ES_CLOUD_API; a_response: CMS_RESPONSE): CMS_CONTENT_BLOCK
		local
			l_html: STRING
			l_active_count: INTEGER
			lic: ES_CLOUD_LICENSE
		do
			create l_html.make (1024)
			l_html.append ("<div class=%"es_summary%">")
			if
				attached api.user_licenses (a_user) as lst and then
				not lst.is_empty
			then
				across
					lst as ic
				loop
					lic := ic.item.license
					if lic.is_active then
						l_active_count := l_active_count + 1
					end
					api.append_short_license_view_to_html (lic, a_user, Current, l_html)
				end
			end
			if l_active_count = 0 then
				l_html.append ("<a href=%"" + a_response.location_url (licenses_location, Void) + "%">No active license...</a>")
			end
			l_html.append ("<div class=%"es-installations%">")
			l_html.append ("<a href=%"" + a_response.location_url (installations_location, Void) + "%">Your installations ...</a>")
			l_html.append ("</div>")
			l_html.append ("</div><!-- es_summary -->%N")

			create Result.make_raw ("cloud_account_summary", Void, l_html, a_response.api.formats.full_html)
		end

	new_buy_block (api: ES_CLOUD_API; a_response: CMS_RESPONSE): CMS_BLOCK
		local
			s: STRING_8
		do
			if attached smarty_template_block (Current, "cloud_buy", a_response.api) as l_tpl_block then
				l_tpl_block.set_value (a_response.url ("/" + root_location, Void), "escloud_url")
				l_tpl_block.set_value (a_response.url ("/" + licenses_location, Void), "escloud_licenses_url")
				Result := l_tpl_block
			else
				s := "<div class=%"es-new-license%"><form action=%""+ a_response.location_url ({ES_CLOUD_MODULE}.licenses_location + "_/buy/", Void) +"%" method=%"post%"><input type=%"submit%" class=%"button%" title=%"Buy a new license%" name=%"op%" value=%"Buy a license%"></input></form></div>"
				create {CMS_CONTENT_BLOCK} Result.make_raw ("cloud_buy", Void, s, a_response.api.formats.full_html)
			end
		end

	new_store_block (api: ES_CLOUD_API; a_response: CMS_RESPONSE): CMS_CONTENT_BLOCK
		local
			l_html: STRING
			l_item: ES_CLOUD_STORE_ITEM
			tb: STRING_TABLE [ARRAYED_LIST [ES_CLOUD_STORE_ITEM]]
			lst: ARRAYED_LIST [ES_CLOUD_STORE_ITEM]
			l_plan_name: READABLE_STRING_GENERAL
			l_interval_type: READABLE_STRING_8
			l_int_id: STRING_8
			l_is_first: BOOLEAN
			l_intervals: STRING_TABLE [INTEGER]
		do
			create l_html.make (1024)
			l_html.append ("<div class=%"pricing%"><form action=%"%">")
			if
				attached api.store (Void, False) as l_store
			then
				create tb.make_caseless (3)
				across
					l_store.items as ic
				loop
					l_item := ic.item
					if
						l_item.is_published and then
						attached l_item.name as l_name
					then
						lst := tb [l_name]
						if lst = Void then
							create lst.make (1)
							tb [l_name] := lst
						end
						lst.force (l_item)
					end
				end

				create l_intervals.make_caseless (2)
				l_html.append ("<div class=%"empty%"></div>")
--				l_html.append ("<div class=%"plans_header%">")
				l_is_first := True
				across
					l_store.items as ic
				loop
					l_item := ic.item
					if attached store_item_interval_name (l_item) as l_interval_name then
						create l_int_id.make_from_string (html_encoded (l_interval_name))
						l_int_id.replace_substring_all (" ", "-")
						if not l_intervals.has (l_int_id) then
							l_intervals.force (1, l_int_id)
							l_html.append ("<input type=%"radio%" name=%"interval%" id=%"" + l_int_id + "%" class=%"" + l_int_id + "%" value=%"" + l_int_id + "%"")
							if l_is_first then
								l_html.append (" checked=%"checked%"")
							end
							l_html.append ("/>")


							l_html.append ("<label for=%"" + l_int_id + "%">")
							if attached store_item_interval_title (l_item) as l_interval_title then
								l_html.append (html_encoded (l_interval_title))
							else
								l_html.append (html_encoded (l_interval_name))
							end
							l_html.append ("</label>%N")
							l_is_first := False

						else
							l_intervals.force (l_intervals [l_int_id] + 1, l_int_id)
						end
					end
				end
				if attached {CMS_SMARTY_TEMPLATE_BLOCK} smarty_template_block (Current, "side_header", api.cms_api) as tpl then
					across
						a_response.values as tb_ic
					loop
						tpl.set_value (tb_ic.item, tb_ic.key)
					end
					tpl.set_value (a_response.url ("/" + root_location, Void), "escloud_url")
					tpl.set_value (a_response.url ("/" + licenses_location, Void), "escloud_licenses_url")
					tpl.append_to_html (a_response.theme, l_html)
				end
--				l_html.append ("</div>")
				l_html.append ("<div class=%"plans%">")
				across
					tb as tb_ic
				loop
					l_plan_name := tb_ic.key
					if attached api.plan_by_name (l_plan_name) as pl then
						l_html.append ("<div class=%"plan "+ html_encoded (pl.name) +"%">%N")
						l_html.append ("<h2>"+ html_encoded (pl.title_or_name) + "</h2>")
						across
							tb_ic.item as ic
						loop
							l_item := ic.item
							l_interval_type := store_item_interval_name (l_item)

							l_html.append ("<div class=%"option ")
							if attached store_item_interval_name (l_item) as l_interval_name then
								create l_int_id.make_from_string (html_encoded (l_interval_name))
								l_int_id.replace_substring_all (" ", "-")
								l_html.append (l_int_id)
								l_html.append ("%" ")
								l_html.append ("data-interval=%"")
								l_html.append (l_int_id)
							end
							l_html.append ("%">%N")
							l_html.append ("<div class=%"prices%">")
							if l_item.is_free then
								l_html.append ("Free")
							else
								l_html.append (html_encoded (l_item.price_as_string))
								if l_item.is_onetime then
									if attached l_item.price_title as l_price_title then
										l_html.append (" <span class=%"price-title%">")
										l_html.append (html_encoded (l_price_title))
										l_html.append ("</span>")
									elseif l_item.onetime_month_duration = 12 then
--										l_html.append (" for one year")
									elseif l_item.onetime_month_duration = 1 then
--										l_html.append (" for one month")
									elseif l_item.onetime_month_duration > 1 then
										l_html.append (" for " + l_item.onetime_month_duration.out + " months")
									end
								elseif l_interval_type /= Void then
									l_html.append (" /" + l_interval_type)
								end
							end
							l_html.append ("</div>%N")
							l_html.append ("<div class=%"actions%">")
							if attached {SHOP_MODULE} api.cms_api.module ({SHOP_MODULE}) as l_shop_module then
								if not l_item.is_free then
									l_html.append ("<button formmethod=%"post%" formaction=%""+ api.cms_api.location_url (l_shop_module.submit_single_item_link (api.config.shop_provider_name, l_item.id), Void)
											 + "%" type=%"submit%" class=%"buy%">Buy now</button>")
								end
							end
							l_html.append ("</div>%N") -- actions
							l_html.append ("</div>%N") -- option
						end
						if attached pl.description as l_desc then
							l_html.append ("<div class=%"features%"><header>")
							l_html.append (utf_8_encoded (l_desc))
							l_html.append ("</header></div>")
						end
--						l_html.append ("<div class=%"actions%">")
--						l_html.append ("<button formmethod=%"post%" formaction=%""+ api.cms_api.location_url ("/try_now", Void)
--							 + "%" type=%"submit%" class=%"try%">Try now</button>")
----						l_html.append ("<a href=%"" + api.cms_api.location_url ("/try_now", Void) + "%">Try now</a>")
--						l_html.append ("</div>") -- actions
						l_html.append ("</div>") -- plan
					end
				end
				l_html.append ("</div>") -- plans
			end
			l_html.append ("</form></div>") -- pricings
			create Result.make_raw ("cloud_store", Void, l_html, a_response.api.formats.full_html)
		end

	store_item_interval_name (a_item: ES_CLOUD_STORE_ITEM): detachable STRING
		do
			if a_item.is_monthly then
				Result := "month"
			elseif a_item.is_yearly then
				Result := "year"
			elseif a_item.is_weekly then
				Result := "week"
			elseif a_item.is_daily then
				Result := "day"
			else
				Result := "onetime"
			end
		end

	store_item_interval_title (a_item: ES_CLOUD_STORE_ITEM): detachable STRING
		do
--			if attached store_item_interval_name (a_item) as l_sub_name then
--				Result := "per " + l_sub_name
			if a_item.is_monthly then
				Result := "Monthly payment"
			elseif a_item.is_yearly then
				Result := "Yearly payment"
			elseif a_item.is_weekly then
				Result := "Weekly payment"
			elseif a_item.is_daily then
				Result := "Daily payment"
			elseif a_item.is_onetime then
				if a_item.onetime_month_duration = 12 then
					Result := "One-time payment"
				end
			end
		end


end
