note
	description: "API to handle ES Cloud api."
	date: "$Date$"
	revision: "$Revision$"

class
	ES_CLOUD_API

inherit
	ES_CLOUD_ACCOUNT_API_I

	ES_CLOUD_SUBSCRIPTION_API_I

	CMS_MODULE_API
		rename
			make as make_api
		redefine
			initialize
		end

	REFACTORING_HELPER

create
	make

feature {NONE} -- Initialization

	make (a_module: ES_CLOUD_MODULE; a_api: CMS_API)
		do
			module := a_module
			cms_api := a_api
			initialize
		end

	initialize
			-- <Precursor>
		do
			Precursor
			create config.make
			if attached cms_api.module_configuration_by_name ({ES_CLOUD_MODULE}.name, "config") as cfg then
				if attached cfg.resolved_text_item ("api.secret") as s then
					config.set_api_secret (s)
				end
				if attached cfg.resolved_text_item ("shop.provider_name") as s then
					config.set_shop_provider_name (s)
				end
				if attached cfg.resolved_text_item ("shop.additional_notification_email") as s then
					config.set_additional_notification_email (s)
				end
				if attached cfg.resolved_text_item ("session.expiration_delay") as s then
					config.session_expiration_delay := s.to_integer
				end
				if
					attached cfg.resolved_text_item ("license.auto_trial") as s and then
					s.is_case_insensitive_equal_general ("yes")
				then
					config.enable_auto_trial (cfg.resolved_text_item ("license.auto_trial_plan"))
				end
			end

				-- Storage initialization
			if attached cms_api.storage.as_sql_storage as l_storage_sql then
				create {ES_CLOUD_STORAGE_SQL} es_cloud_storage.make (l_storage_sql)
			else
					-- FIXME: in case of NULL storage, should Current be disabled?
				create {ES_CLOUD_STORAGE_NULL} es_cloud_storage
			end
		end

feature {CMS_MODULE} -- Access nodes storage.

	es_cloud_storage: ES_CLOUD_STORAGE_I

feature -- Settings

	module: ES_CLOUD_MODULE

	config: ES_CLOUD_CONFIG

feature -- Access: users

	active_user: detachable ES_CLOUD_USER
		do
			if attached cms_api.user as u then
				create Result.make (u)
			end
		end

	cloud_user (a_user_id: READABLE_STRING_GENERAL): detachable ES_CLOUD_USER
		do
			if attached cms_api.user_api.user_by_id_or_name (a_user_id) as u then
				Result := u
			end
		end

	cloud_user_profile (a_user: ES_CLOUD_USER): detachable ES_CLOUD_USER_PROFILE
		do
			if attached cms_api.user_api.user_profile (a_user.cms_user) as uprof then
				create Result.make (a_user)
				if attached uprof[".cloud.about(wikitext)"] as wk then
					Result.set_about_wikitext (wk)
				end
			end
		end

	save_cloud_user_profile (a_prof: ES_CLOUD_USER_PROFILE)
		local
			uprof: CMS_USER_PROFILE
		do
			uprof := cms_api.user_api.user_profile (a_prof.cms_user)
			if uprof = Void then
				create uprof.make
			end
			uprof[".cloud.about(wikitext)"] := a_prof.about_wikitext
			cms_api.user_api.save_user_profile (a_prof.cms_user, uprof)
		end

feature -- Access: plans

	plans: LIST [ES_CLOUD_PLAN]
		do
			Result := es_cloud_storage.plans
		end

	sorted_plans: LIST [ES_CLOUD_PLAN]
		do
			Result := plans
			plans_sorter.sort (Result)
		end

	plans_sorter: SORTER [ES_CLOUD_PLAN]
		local
			comp: AGENT_EQUALITY_TESTER [ES_CLOUD_PLAN]
		do
			create comp.make (agent (u,v: ES_CLOUD_PLAN): BOOLEAN
					do
						if u.weight /= v.weight then
							Result := u.weight < v.weight
						elseif attached u.name as u_name then
							if attached v.name as v_name then
								Result := u_name < v_name
							else
								Result := True
							end
						else
							Result := u.id < v.id
						end
					end
				)
			create {QUICK_SORTER [ES_CLOUD_PLAN]} Result.make (comp)
		end

	default_plan: detachable ES_CLOUD_PLAN
		do
			if attached sorted_plans as lst and then not lst.is_empty then
				Result := lst.first
			end
		end

	plan (a_plan_id: INTEGER): detachable ES_CLOUD_PLAN
		do
			Result := es_cloud_storage.plan (a_plan_id)
		end

	plan_by_name (a_name: READABLE_STRING_GENERAL): detachable ES_CLOUD_PLAN
		do
			across
				plans as ic
			until
				Result /= Void
			loop
				Result := ic.item
				if not a_name.is_case_insensitive_equal (Result.name) then
					Result := Void
				end
			end
		end

feature -- Access: tokens

	redeem_tokens (a_plan: ES_CLOUD_PLAN; a_version: detachable READABLE_STRING_GENERAL): LIST [ES_CLOUD_REDEEM_TOKEN]
		do
			create {ARRAYED_LIST [ES_CLOUD_REDEEM_TOKEN]} Result.make (0)
			Result := es_cloud_storage.redeem_tokens (a_plan, a_version)
		end

	unused_redeem_tokens_count (a_plan: ES_CLOUD_PLAN): INTEGER
		do
			Result := es_cloud_storage.unused_redeem_tokens_count (a_plan)
		end

	redeem_token (a_token_name: READABLE_STRING_GENERAL): detachable ES_CLOUD_REDEEM_TOKEN
		do
			-- TODO
			Result := es_cloud_storage.redeem_token (a_token_name)
		end

	create_redeem_tokens (nb: INTEGER; a_plan: ES_CLOUD_PLAN; a_opt_version, a_origin: detachable READABLE_STRING_GENERAL; a_token_prefix: detachable READABLE_STRING_8; a_notes: detachable READABLE_STRING_GENERAL; a_new_tokens: detachable LIST [ES_CLOUD_REDEEM_TOKEN])
			-- Create `nb` new redeem tokens for plan `a_plan`, limited to `a_opt_version` (or not).
			-- The tokens are generated for seller `origin`, and prefixed (or not) by `a_token_prefix`.
			-- `a_notes` can be used for internal purpose.
			-- If `a_new_tokens` is set, it will contain the newly created tokens
		local
			i: INTEGER
			k: STRING_8
			tok: ES_CLOUD_REDEEM_TOKEN
		do
			from
				i := 1
			until
				i > nb
			loop
				k := cms_api.new_random_identifier (24, once "ABCDEFGHJKMNPQRSTUVW23456789") -- Without I O L 0 1 , which are sometime hard to distinguish!
				if a_token_prefix /= Void then
					k.prepend_string (a_token_prefix)
				end
				if a_opt_version /= Void and then a_opt_version.is_valid_as_string_8 then
					create tok.make (k, a_plan.name, a_opt_version.to_string_8)
				else
					create tok.make (k, a_plan.name, Void)
				end
				tok.set_origin (a_origin)
				tok.set_notes (a_notes)
				save_new_redeem_token (tok)
				if a_new_tokens /= Void then
					a_new_tokens.force (tok)
				end
				i := i + 1
			end
			if a_origin /= Void then
				cms_api.log ({ES_CLOUD_MODULE}.name, "Created " + nb.out + " tokens on plan " + utf_8_encoded (a_plan.title_or_name) + " for [" + utf_8_encoded (a_origin), {CMS_LOG}.level_notice, Void)
			else
				cms_api.log ({ES_CLOUD_MODULE}.name, "Created " + nb.out + " tokens on plan " + utf_8_encoded (a_plan.title_or_name), {CMS_LOG}.level_notice, Void)
			end
		end

	save_new_redeem_token (a_token: ES_CLOUD_REDEEM_TOKEN)
		do
			es_cloud_storage.create_redeem_token (a_token)
		end

	save_redeem_token (a_token: ES_CLOUD_REDEEM_TOKEN)
		do
			es_cloud_storage.save_redeem_token (a_token)
		end

	redeem (a_redeem_token: ES_CLOUD_REDEEM_TOKEN; a_user: ES_CLOUD_USER)
		require
			not a_redeem_token.is_redeemed
			a_redeem_token.license_key = Void
		do
			if
				attached plan_by_name (a_redeem_token.plan_name) as pl and then
				attached new_license_for_plan (pl) as l_new_lic
			then
				if attached a_redeem_token.version as v then
					l_new_lic.set_version (v)
				end
				extend_license_with_duration (l_new_lic, 1, 0, 0)
				save_new_license (l_new_lic, a_user)
				a_redeem_token.assign_license (l_new_lic)
				save_redeem_token (a_redeem_token)
				cms_api.log ({ES_CLOUD_MODULE}.name, "Redeem token " + utf_8_encoded (a_redeem_token.name) + " for user " + a_user.id.out, {CMS_LOG}.level_notice, Void)
				notify_redeemed_license (a_user, Void, l_new_lic, a_redeem_token)
			end
		end

feature -- Access: licenses

	licenses: LIST [TUPLE [license: ES_CLOUD_LICENSE; user: detachable ES_CLOUD_USER; email: detachable READABLE_STRING_8; org: detachable ES_CLOUD_ORGANIZATION]]
			-- Licenses
		do
			Result := es_cloud_storage.licenses
		end

	licenses_for_plan (a_plan: ES_CLOUD_PLAN): like licenses
		do
			Result := es_cloud_storage.licenses_for_plan (a_plan)
		end

	license (a_license_id: INTEGER_64): detachable ES_CLOUD_LICENSE
		do
			Result := es_cloud_storage.license (a_license_id)
		end

	license_by_key (a_license_key: READABLE_STRING_GENERAL): detachable ES_CLOUD_LICENSE
		do
			Result := es_cloud_storage.license_by_key (a_license_key)
		end

	user_for_license (a_license: ES_CLOUD_LICENSE): detachable ES_CLOUD_USER
		local
			uid: INTEGER_64
		do
			uid := es_cloud_storage.user_id_for_license (a_license)
			if uid /= 0 and then attached cms_api.user_api.user_by_id (uid) as u then
				create Result.make (u)
			end
		end

	user_has_license (a_user: ES_CLOUD_USER; a_license_id: INTEGER_64): BOOLEAN
		do
			Result := es_cloud_storage.user_has_license (a_user, a_license_id)
		end

	user_licenses (a_user: ES_CLOUD_USER): LIST [ES_CLOUD_USER_LICENSE]
		do
			Result := es_cloud_storage.user_licenses (a_user)
		end

	email_for_license (a_license: ES_CLOUD_LICENSE): detachable READABLE_STRING_8
		do
			Result := es_cloud_storage.email_for_license (a_license)
		end

	email_license (a_license: ES_CLOUD_LICENSE): detachable ES_CLOUD_EMAIL_LICENSE
		do
			Result := es_cloud_storage.email_license (a_license)
		end

	email_licenses (a_email: READABLE_STRING_8): LIST [ES_CLOUD_EMAIL_LICENSE]
		do
			Result := es_cloud_storage.email_licenses (a_email)
		end

feature -- Limitations		

	license_limitations_string (lic: ES_CLOUD_LICENSE): detachable READABLE_STRING_8
			-- Plan limitations JSON string.
		do
			if attached lic.plan.usage_limitations_data as l_lims then
				Result := l_lims
			end
		end

feature -- Access trial		

	trial_user_licenses (a_user: ES_CLOUD_USER): detachable ARRAYED_LIST [ES_CLOUD_USER_LICENSE]
			-- Existing trial license for user `a_user` or email `a_email` if any.
		local
			lic: ES_CLOUD_USER_LICENSE
		do
			if attached trial_plan as pl then
				create Result.make (1)
				across
					user_licenses (a_user) as ic
				loop
					lic := ic.item
					if pl.same_plan (lic.license.plan) then
						Result.force (lic)
					end
				end
			end
		end

	trial_plan: detachable ES_CLOUD_PLAN
		do
			if config.auto_trial_enabled then
				if attached config.auto_trial_plan_name as pl_name then
					Result := plan_by_name (pl_name)
				end
				if Result = Void then
					Result := default_plan
				end
			end
		end

	is_eligible_to_trial_extension (lic: ES_CLOUD_LICENSE): BOOLEAN
			-- Is `lic` eligible to receive a trial extension approval?
		local
			dt, l_creation: DATE_TIME
			nb: INTEGER
		do
			nb := lic.plan.trial_max_period_in_days.to_integer_32
			if nb > 0 then
				l_creation := lic.creation_date
				create dt.make_now_utc
				dt.day_add (- nb)
				Result := dt < l_creation
			end
		end

	potential_trial_extension_days (lic: ES_CLOUD_LICENSE): NATURAL
			-- Maximum days `lic` could be potentially extended for the trial period.
		local
			nb: NATURAL
			n: NATURAL
		do
			nb := lic.plan.trial_max_period_in_days
			if nb > 0 then
				n := lic.duration_in_days
				if n < nb then
					Result := (nb - n).min (lic.plan.trial_period_in_days)
				end
			end
		end

feature -- Element change license

	auto_assign_trial_to (a_user: ES_CLOUD_USER)
		local
			pl: ES_CLOUD_PLAN
			lic: ES_CLOUD_LICENSE
		do
			if config.auto_trial_enabled then
				if attached config.auto_trial_plan_name as pl_name then
					pl := plan_by_name (pl_name)
				end
				if pl = Void then
					pl := default_plan
				end
				if pl /= Void then
					lic := new_license_for_plan (pl)
					lic.set_remaining_days (pl.trial_period_in_days)
					save_new_license (lic, a_user)
					if
						attached a_user.cms_user as l_cms_user and then
						attached l_cms_user.email as l_email
					then
						if l_email /= Void then
							send_new_license_mail (l_cms_user, l_cms_user.profile_name, l_email, lic, Void, Void)
						end
						notify_new_license (l_cms_user, l_cms_user.profile_name, l_email, lic, Void)
					end
				end
			end
		end

	new_license_for_plan (a_plan: ES_CLOUD_PLAN): ES_CLOUD_LICENSE
		local
			k: STRING_32
		do
			k := cms_api.new_random_identifier (16, once "ABCDEFGHJKMNPQRSTUVW23456789") -- Without I O L 0 1 , which are sometime hard to distinguish!
			create Result.make (k, a_plan)
			es_cloud_storage.save_license (Result)
		end

	save_license_with_duration_extension (lic: ES_CLOUD_LICENSE; nb_years, nb_months, nb_days: INTEGER)
			-- Extend and save the license `lic` life duration by
			--  `nb_years` year(s)
			--  `nb_months` month(s)
			--  `nb_days` day(s)

		do
			extend_license_with_duration (lic, nb_years, nb_months, nb_days)
			save_license (lic)

			cms_api.log_debug ({ES_CLOUD_MODULE}.name, "Extended license " + utf_8_encoded (lic.key) + " with " + nb_days.out + " days, " + nb_months.out + " months, " + nb_years.out + " years", create {CMS_LOCAL_LINK}.make (Void, module.license_location (lic)) )
		end

	extend_license_with_duration (lic: ES_CLOUD_LICENSE; nb_years, nb_months, nb_days: INTEGER)
			-- Extend the license `lic` life duration by
			--  `nb_years` year(s)
			--  `nb_months` month(s)
			--  `nb_days` day(s)
		local
			dt: DATE_TIME
			d: DATE
			y,mo: INTEGER
			orig: DATE_TIME
		do
			orig := lic.expiration_date
			if orig = Void then
				orig := lic.creation_date
				create orig.make_by_date_time (orig.date, orig.time)
				if lic.days_remaining > 0 then
					orig.day_add (lic.days_remaining)
				end
			end
			create dt.make_by_date_time (orig.date, orig.time)
			y := dt.year + nb_years
			mo := dt.month + nb_months
			if mo > 12 then
				y := y + mo // 12
				mo := mo \\ 12
			end
			create d.make (y, mo, dt.day)
			d.day_add (nb_days)
			create dt.make_by_date_time (d, dt.time)
			lic.set_expiration_date (dt)
		end

	save_new_license (a_license: ES_CLOUD_LICENSE; a_user: detachable ES_CLOUD_USER)
		do
			es_cloud_storage.save_license (a_license)
			if a_user /= Void then
				assign_license_to_user (a_license, a_user)
			end
		end

	save_license (a_license: ES_CLOUD_LICENSE)
		do
			es_cloud_storage.save_license (a_license)
		end

	update_license (a_license: ES_CLOUD_LICENSE; a_user: detachable ES_CLOUD_USER)
		require
			existing_license: license (a_license.id) /= Void
		do
			if a_user /= Void and then not user_has_license (a_user, a_license.id) then
				assign_license_to_user (a_license, a_user)
			end
			es_cloud_storage.save_license (a_license)
		end

	discard_license (a_license: ES_CLOUD_LICENSE)
		require
			existing_license: license (a_license.id) /= Void
		do
			-- FIXME: to implement!
		end

	suspend_license (a_license: ES_CLOUD_LICENSE)
		require
			existing_license: license (a_license.id) /= Void
		do
			a_license.suspend
			es_cloud_storage.save_license (a_license)
		end

	resume_license (a_license: ES_CLOUD_LICENSE)
		require
			existing_license: license (a_license.id) /= Void
			is_suspended: a_license.is_suspended
		do
			a_license.resume
			es_cloud_storage.save_license (a_license)
		end

	remove_expiration_date (a_license: ES_CLOUD_LICENSE)
		require
			existing_license: license (a_license.id) /= Void
		do
			a_license.set_expiration_date (Void)
			es_cloud_storage.save_license (a_license)
		end

	assign_license_to_user (a_license: ES_CLOUD_LICENSE; a_user: ES_CLOUD_USER)
		require
			a_license.has_id
		do
			es_cloud_storage.assign_license_to_user (a_license, a_user)
		end

	move_email_license_to_user (a_email_license: ES_CLOUD_EMAIL_LICENSE; a_user: ES_CLOUD_USER)
		require
			a_email_license.license.has_id
		do
			es_cloud_storage.move_email_license_to_user (a_email_license, a_user)
		end

	assign_license_to_email (a_license: ES_CLOUD_LICENSE; a_email: READABLE_STRING_8)
		require
			a_license.has_id
		do
			es_cloud_storage.assign_license_to_email (a_license, a_email)
		end

	converted_license_from_user_subscription (a_sub: ES_CLOUD_PLAN_SUBSCRIPTION; a_installation: detachable ES_CLOUD_INSTALLATION): detachable ES_CLOUD_LICENSE
		local
			inst: ES_CLOUD_INSTALLATION
		do
			if attached {ES_CLOUD_PLAN_USER_SUBSCRIPTION} a_sub as sub then
				Result := new_license_for_plan (sub.plan)
				Result.set_creation_date (sub.creation_date)
				if attached sub.expiration_date as exp then
					Result.set_expiration_date (exp)
				else
					Result.set_remaining_days (sub.plan.trial_period_in_days)
				end
				if a_installation /= Void then
					Result.set_platforms_restriction (a_installation.platform)
					Result.set_version (a_installation.product_version)
				end
				save_new_license (Result, sub.user)
				es_cloud_storage.discard_user_subscription (sub)
					-- HACK: previously installation tables included the uid, now we have license id `lid`
				if attached es_cloud_storage.license_installations (sub.user_id) as lst then
					across
						lst as ic
					loop
						inst := ic.item
						inst.update_license_id (Result.id)
						es_cloud_storage.save_installation (inst)
					end
				end
				if
					attached sub.user.cms_user as l_cms_user and then
					attached l_cms_user.email as l_email
				then
					if l_email /= Void then
						send_new_license_mail (l_cms_user, l_cms_user.profile_name, l_email, Result, Void, Void)
					end
					notify_new_license (l_cms_user, l_cms_user.profile_name, l_email, Result, Void)
				end
			end
		end

feature -- Emailing

	send_message_to_expired_licenses (a_licenses: ITERABLE [ES_CLOUD_LICENSE])
		local
			lic: ES_CLOUD_LICENSE
			l_user_lic: ES_CLOUD_USER_LICENSE
		do
			across
				a_licenses as ic
			loop
				lic := ic.item
				if lic.is_expired and not lic.is_suspended then
					if attached user_for_license (lic) as u then
						create l_user_lic.make (u, lic)
						send_message_to_expired_user_license (l_user_lic, Void)
					end
				end
			end
		end

	send_message_to_expired_user_license (lic: ES_CLOUD_USER_LICENSE; vars: detachable STRING_TABLE [detachable READABLE_STRING_GENERAL])
		local
			e: CMS_EMAIL
			res: PATH
			msg: READABLE_STRING_8
			sub: STRING_8
			p: INTEGER
			l_license: ES_CLOUD_LICENSE
			l_user: CMS_USER
		do
			l_user := lic.user.cms_user
			l_license := lic.license
			if attached cms_api.user_api.user_email (l_user) as l_user_email then
				create res.make_from_string ("templates")
				sub := "Your " + utf_8_encoded (l_license.plan.title_or_name) + " EiffelStudio license " + utf_8_encoded (l_license.key) + "is EXPIRED"
				if attached cms_api.module_theme_resource_location (module, res.extended ("email_license_expired.tpl")) as loc and then attached cms_api.resolved_smarty_template (loc) as tpl then
					tpl.set_value (l_license, "license")
					tpl.set_value (l_license.plan.name, "license_plan_name")
					tpl.set_value (l_license.plan.title_or_name, "license_plan_title")
					tpl.set_value (l_license.key, "license_key")
					tpl.set_value (module.license_location (l_license) , "license_key_url")
					if vars /= Void then
						across
							vars as ic
						loop
							if attached ic.item as v then
								tpl.set_value (v, ic.key)
							end
						end
					end
					tpl.set_value (l_user, "user")
					tpl.set_value (l_user_email, "user_email")
					tpl.set_value (l_user.name, "user_name")
					tpl.set_value (cms_api.user_display_name (l_user), "customer_name")
	--				if a_customer_name /= Void then
	--					tpl.set_value (html_encoded (a_customer_name), "customer_name")
	--				end
					msg := tpl.string
					if msg.starts_with_general ("Subject:") then
						p := msg.index_of ('%N', 1)
						if p > 0 then
							sub := msg.head (p - 1).to_string_8
							msg := msg.substring (p + 1, msg.count)
							sub.right_adjust
							sub.remove_head (("Subject:").count)
							sub.left_adjust
						end
					end

					e := cms_api.new_html_email (l_user_email, sub, msg)
					cms_api.process_email (e)
				end
			end
		end

	send_message_to_licenses_expiring_soon (a_licenses: ITERABLE [ES_CLOUD_LICENSE])
		local
			nb: INTEGER
			lic: ES_CLOUD_LICENSE
			l_user_lic: ES_CLOUD_USER_LICENSE
		do
			across
				a_licenses as ic
			loop
				lic := ic.item
				if lic.is_expired then
				elseif
					lic.expiration_date /= Void
				then
					nb := lic.days_remaining
					if nb > 0 then
						if attached user_for_license (lic) as u then
							create l_user_lic.make (u, lic)
							send_message_to_user_license_expiring_soon (l_user_lic, nb, Void)
						end
					end
				end
			end
		end

	send_message_to_user_license_expiring_soon (lic: ES_CLOUD_USER_LICENSE; a_days_remaining: INTEGER; vars: detachable STRING_TABLE [detachable READABLE_STRING_GENERAL])
		require
			a_days_remaining > 0
		local
			e: CMS_EMAIL
			res: PATH
			msg: READABLE_STRING_8
			sub: STRING_8
			p: INTEGER
			l_license: ES_CLOUD_LICENSE
			l_user: CMS_USER
		do
			l_user := lic.user.cms_user
			l_license := lic.license
			if attached cms_api.user_api.user_email (l_user) as l_user_email then
				create res.make_from_string ("templates")
				sub := "Your " + utf_8_encoded (l_license.plan.title_or_name) + " EiffelStudio license " + utf_8_encoded (l_license.key) + "is expiring in " + a_days_remaining.out + "day(s)"
				if attached cms_api.module_theme_resource_location (module, res.extended ("email_license_expiration_coming.tpl")) as loc and then attached cms_api.resolved_smarty_template (loc) as tpl then
					tpl.set_value (a_days_remaining, "days_remaining")
					tpl.set_value (l_license, "license")
					tpl.set_value (l_license.plan.name, "license_plan_name")
					tpl.set_value (l_license.plan.title_or_name, "license_plan_title")
					tpl.set_value (l_license.key, "license_key")
					tpl.set_value (module.license_location (l_license) , "license_key_url")
					if vars /= Void then
						across
							vars as ic
						loop
							if attached ic.item as v then
								tpl.set_value (v, ic.key)
							end
						end
					end
					tpl.set_value (l_user, "user")
					tpl.set_value (l_user_email, "user_email")
					tpl.set_value (l_user.name, "user_name")
					tpl.set_value (cms_api.user_display_name (l_user), "customer_name")
	--				if a_customer_name /= Void then
	--					tpl.set_value (html_encoded (a_customer_name), "customer_name")
	--				end
					msg := tpl.string
					if msg.starts_with_general ("Subject:") then
						p := msg.index_of ('%N', 1)
						if p > 0 then
							sub := msg.head (p - 1).to_string_8
							msg := msg.substring (p + 1, msg.count)
							sub.right_adjust
							sub.remove_head (("Subject:").count)
							sub.left_adjust
						end
					end

					e := cms_api.new_html_email (l_user_email, sub, msg)
					cms_api.process_email (e)
				end
			end
		end

feature -- License subscription

	subscribed_licenses (a_order_ref: READABLE_STRING_GENERAL): detachable LIST [ES_CLOUD_LICENSE]
		do
			Result := es_cloud_storage.subscribed_licenses (a_order_ref)
		end

	record_yearly_license_subscription (a_license: ES_CLOUD_LICENSE; a_sub_ref: detachable READABLE_STRING_GENERAL)
		local
			sub: ES_CLOUD_LICENSE_SUBSCRIPTION
		do
			create sub.make_yearly (a_license)
			if a_sub_ref /= Void then
				sub.set_subscription_reference (a_sub_ref)
			end
			es_cloud_storage.save_license_subscription (sub)
		end

	record_monthly_license_subscription (a_license: ES_CLOUD_LICENSE; a_sub_ref: detachable READABLE_STRING_GENERAL)
		local
			sub: ES_CLOUD_LICENSE_SUBSCRIPTION
		do
			create sub.make_monthly (a_license)
			if a_sub_ref /= Void then
				sub.set_subscription_reference (a_sub_ref)
			end
			es_cloud_storage.save_license_subscription (sub)
		end

	record_weekly_license_subscription (a_license: ES_CLOUD_LICENSE; a_sub_ref: detachable READABLE_STRING_GENERAL)
		local
			sub: ES_CLOUD_LICENSE_SUBSCRIPTION
		do
			create sub.make_weekly (a_license)
			if a_sub_ref /= Void then
				sub.set_subscription_reference (a_sub_ref)
			end
			es_cloud_storage.save_license_subscription (sub)
		end

	record_daily_license_subscription (a_license: ES_CLOUD_LICENSE; a_sub_ref: detachable READABLE_STRING_GENERAL)
		local
			sub: ES_CLOUD_LICENSE_SUBSCRIPTION
		do
			create sub.make_daily (a_license)
			if a_sub_ref /= Void then
				sub.set_subscription_reference (a_sub_ref)
			end
			es_cloud_storage.save_license_subscription (sub)
		end

	record_onetime_license_payment (a_license: ES_CLOUD_LICENSE; a_nb_months: NATURAL_32; a_payment_ref: detachable READABLE_STRING_GENERAL)
		local
			sub: ES_CLOUD_LICENSE_SUBSCRIPTION
		do
			create sub.make (a_license, {ES_CLOUD_LICENSE_SUBSCRIPTION}.onetime, a_nb_months)
			if a_payment_ref /= Void then
				sub.set_payment_reference (a_payment_ref)
			end
			es_cloud_storage.save_license_subscription (sub)
		end

feature -- Billings

	license_subscription (a_license: ES_CLOUD_LICENSE): detachable ES_CLOUD_LICENSE_SUBSCRIPTION
		do
			Result := es_cloud_storage.license_subscription (a_license)
		end

	license_billings (a_license: ES_CLOUD_LICENSE): detachable SHOPPING_BILLS
		do
			if
				attached license_subscription (a_license) as l_sub and then
				attached l_sub.subscription_reference as ref
			then
				if
					attached {SHOP_MODULE} cms_api.module ({SHOP_MODULE}) as l_shop_module and then
					attached l_shop_module.shop_api as l_shop_api
				then
					Result := l_shop_api.billings (ref)
				end
			end
		end

feature -- Access: store

	store_to_json (a_store: ES_CLOUD_STORE): STRING
		local
			jo, j: JSON_OBJECT
			vis: JSON_PRETTY_STRING_VISITOR
			l_store_item: ES_CLOUD_STORE_ITEM
		do
			create jo.make_with_capacity (a_store.items.count)
			across
				a_store.items as ic
			loop
				l_store_item := ic.item
				create j.make_with_capacity (7)
				if attached l_store_item.name as l_name then
					j.put_string (l_name, "plan")
				end
				if attached l_store_item.title as l_title then
					j.put_string (l_title, "title")
				end
				j.put_natural (l_store_item.price, "price")
				if l_store_item.cents_price > 0 then
					j.put_natural (l_store_item.cents_price, "price.cents")
				end
				j.put_string (l_store_item.currency, "currency")
				if l_store_item.is_onetime then
					j.put_string ("onetime", "interval")
					if l_store_item.onetime_month_duration > 0 then
						j.put_natural (l_store_item.onetime_month_duration, "duration")
					end
				elseif attached l_store_item.interval as l_interval then
					j.put_string (l_interval, "interval")
				end
				if l_store_item.is_published then
					j.put_string ("published", "status")
				else
					j.put_string ("test", "status")
				end
				jo.put (j, l_store_item.id)
			end

			create Result.make_empty
			create vis.make (Result)
			vis.visit_json_object (jo)
		end

	json_to_store (a_json: READABLE_STRING_8; a_currency: detachable READABLE_STRING_8; a_include_all: BOOLEAN): detachable ES_CLOUD_STORE
		do
			Result := config_to_store (create {JSON_CONFIG}.make_from_string (a_json), a_currency, a_include_all)
		end

	config_to_store (cfg: CONFIG_READER; a_currency: detachable READABLE_STRING_8; a_include_all: BOOLEAN): detachable ES_CLOUD_STORE
		local
			l_item: ES_CLOUD_STORE_ITEM
			l_cents: NATURAL_32
			l_visible: BOOLEAN
		do
			if a_currency = Void then
				create Result.make
			else
				create Result.make_with_currency (a_currency)
			end
			if attached cfg.table_keys ("") as lst then
				across
					lst as ic
				loop
					if
						attached cfg.text_table_item (ic.item) as tb and then
						attached tb.item ("plan") as l_plan and then
						attached tb.item ("price") as l_price and then
						attached tb.item ("currency") as l_currency
					then
						if attached tb.item ("status") as l_status then
							if
								l_status.is_case_insensitive_equal ("published")
							then
								l_visible := True
							else
								l_visible := False
							end
						else
							l_visible := True
						end
						if l_visible or a_include_all then
							if attached tb.item ("price.cents") as l_cents_price then
								l_cents := l_cents_price.to_natural_32
							else
								l_cents := 0
							end
							create l_item.make (ic.item)
							l_item.set_price (l_price.to_natural_32, l_cents, l_currency.to_string_8, tb.item ("interval"))
							l_item.set_title (tb.item ("title"))
							l_item.set_price_title (tb.item ("price.title"))
							l_item.set_name (l_plan)
							l_item.set_is_published (l_visible)
							if
								l_item.is_onetime and then
								attached tb.item ("duration") as l_duration and then
								l_duration.is_natural_32
							then
								l_item.set_onetime_month_duration (l_duration.to_natural_32)
							end
							Result.extend (l_item)
						end
					end
				end
			end
		end

	save_store (a_store: ES_CLOUD_STORE)
		do
			cms_api.storage.set_custom_value ("cloud.store." + a_store.currency, store_to_json (a_store), module.name_for_resource)
		end

	store (a_currency: detachable READABLE_STRING_8; a_include_all: BOOLEAN): ES_CLOUD_STORE
		do
			Result := internal_store (a_currency)
			if Result = Void then
				if a_currency = Void then
					create Result.make
				else
					create Result.make_with_currency (a_currency)
				end
				if
					attached cms_api.storage.custom_value ("cloud.store." + Result.currency, module.name_for_resource) as l_store_json and then
					attached json_to_store ({UTF_CONVERTER}.utf_32_string_to_utf_8_string_8 (l_store_json), Result.currency, a_include_all) as l_store
				then
					Result := l_store
					set_internal_store (Result)
				elseif
					attached cms_api.module_configuration_by_name ({ES_CLOUD_MODULE}.name, "store-" + Result.currency) as cfg and then
					attached config_to_store (cfg, Result.currency, a_include_all) as l_store
				then
					Result := l_store
					set_internal_store (Result)
				end
			end
		end

	internal_store (a_currency: detachable READABLE_STRING_8): detachable ES_CLOUD_STORE
		local
			l_currency: READABLE_STRING_8
		do
			l_currency := a_currency
			if l_currency = Void then
				l_currency := {ES_CLOUD_STORE}.default_currency
			end
			if attached internal_store_by_currency as tb then
				Result := tb.item (l_currency)
			end
		end

	set_internal_store (a_store: ES_CLOUD_STORE)
		local
			tb: like internal_store_by_currency
		do
			tb := internal_store_by_currency
			if tb = Void then
				create tb.make_caseless (1)
				internal_store_by_currency := tb
			end
			tb [a_store.currency] := a_store
		end

	internal_store_by_currency: detachable STRING_TABLE [ES_CLOUD_STORE]

feature -- Access: subscriptions

	default_concurrent_sessions_limit: NATURAL = 1
	 		-- Default, a unique concurrent session!

	default_heartbeat: NATURAL = 900 -- 15 * 60
	 		-- Default heartbeat in seconds	 		

	user_concurrent_sessions_limit (a_user: ES_CLOUD_USER): NATURAL
		do
			if attached user_subscription (a_user) as l_plan_sub then
				Result := l_plan_sub.concurrent_sessions_limit
			else
				Result := default_concurrent_sessions_limit
			end
		end

	discard_installation (inst: ES_CLOUD_INSTALLATION; a_user: detachable ES_CLOUD_USER)
		do
			es_cloud_storage.discard_installation (inst, a_user)
		end

	all_user_installations: LIST [ES_CLOUD_INSTALLATION]
		do
			Result := es_cloud_storage.all_user_installations
			user_installations_sorter.reverse_sort (Result)
		end

	user_installations (a_user: ES_CLOUD_USER): LIST [ES_CLOUD_INSTALLATION]
		do
			Result := es_cloud_storage.user_installations (a_user)
			user_installations_sorter.reverse_sort (Result)
		end

	installations_for (a_install_id: READABLE_STRING_GENERAL): detachable LIST [ES_CLOUD_INSTALLATION]
		do
			Result := es_cloud_storage.installations (a_install_id)
		end

	user_installation (a_user: ES_CLOUD_USER; a_install_id: READABLE_STRING_GENERAL): detachable ES_CLOUD_INSTALLATION
		do
			if attached user_installations_for (a_user, a_install_id) as lst and then not lst.is_empty then
				Result := lst.last
			end
		end

	user_installations_for (a_user: ES_CLOUD_USER; a_install_id: READABLE_STRING_GENERAL): detachable LIST [ES_CLOUD_INSTALLATION]
		do
			Result := installations_for (a_install_id)
			if Result /= Void then
				from
					Result.start
				until
					Result.off
				loop
					if user_has_license (a_user, Result.item.license_id) then
						Result.forth
					else
						Result.remove
					end
				end
				if Result.is_empty then
					Result := Void
				end
			end
		end

	installation (a_install_id: READABLE_STRING_GENERAL; a_license_id: like {ES_CLOUD_LICENSE}.id): detachable ES_CLOUD_INSTALLATION
		do
			Result := es_cloud_storage.installation (a_install_id, a_license_id)
		end

	license_installations (a_license: ES_CLOUD_LICENSE): LIST [ES_CLOUD_INSTALLATION]
		do
			Result := es_cloud_storage.license_installations (a_license.id)
		end

	user_installations_sorter: SORTER [ES_CLOUD_INSTALLATION]
		local
			comp: AGENT_EQUALITY_TESTER [ES_CLOUD_INSTALLATION]
		do
			create comp.make (agent (u,v: ES_CLOUD_INSTALLATION): BOOLEAN
					do
						if attached u.creation_date as u_cd then
							if attached v.creation_date as v_cd then
								Result := u_cd < v_cd
							else
								Result := u.id < v.id
							end
						elseif v.creation_date /= Void then
							Result := True
						else
							Result := u.id < v.id
						end
					end
				)
			create {QUICK_SORTER [ES_CLOUD_INSTALLATION]} Result.make (comp)
		end

	last_user_session (a_user: ES_CLOUD_USER; a_installation: detachable ES_CLOUD_INSTALLATION): detachable ES_CLOUD_SESSION
			-- Last user session, and only for installation `a_installation` is provided.
		do
			Result := es_cloud_storage.last_user_session (a_user, a_installation)
		end

	last_license_session (a_license: ES_CLOUD_LICENSE): detachable ES_CLOUD_SESSION
		do
			Result := es_cloud_storage.last_license_session (a_license)
		end

	user_session (a_user: ES_CLOUD_USER; a_install_id, a_session_id: READABLE_STRING_GENERAL): detachable ES_CLOUD_SESSION
		do
			Result := es_cloud_storage.user_session (a_user, a_install_id, a_session_id)
		end

	user_sessions (a_user: ES_CLOUD_USER; a_install_id: detachable READABLE_STRING_GENERAL; a_only_active: BOOLEAN): detachable LIST [ES_CLOUD_SESSION]
		do
			Result := es_cloud_storage.user_sessions (a_user, a_install_id, a_only_active)
			if Result /= Void then
				user_session_sorter.reverse_sort (Result)
			end
		end

	installation_sessions (a_install_id: READABLE_STRING_GENERAL; a_only_active: BOOLEAN): detachable LIST [ES_CLOUD_SESSION]
		do
			Result := es_cloud_storage.installation_sessions (a_install_id, a_only_active)
			if Result /= Void then
				user_session_sorter.reverse_sort (Result)
			end
		end

	user_active_concurrent_sessions (a_user: ES_CLOUD_USER; a_install_id: READABLE_STRING_GENERAL; a_current_session: ES_CLOUD_SESSION): detachable STRING_TABLE [LIST [ES_CLOUD_SESSION]]
			-- Active sessions indexed by installation id.
		local
			l_session: ES_CLOUD_SESSION
			lst, lst_by_installation: like user_sessions
		do
			lst := user_sessions (a_user, Void, True)
			if lst /= Void then
				from
					lst.start
				until
					lst.off
				loop
					l_session := lst.item
					if
						l_session.is_paused or else
						a_current_session.same_as (l_session) or else
						a_current_session.installation_id.same_string (l_session.installation_id)
					then
						lst.remove
					else
						lst.forth
					end
				end
				if lst.is_empty then
					lst := Void
				end
				if lst /= Void then
					create Result.make_caseless (2)
					from
						lst.start
					until
						lst.after
					loop
						l_session := lst.item
						lst_by_installation := Result [l_session.installation_id]
						if lst_by_installation = Void then
							create {ARRAYED_LIST [ES_CLOUD_SESSION]} lst_by_installation.make (3)
							Result [l_session.installation_id] := lst_by_installation
						end
						lst_by_installation.force (l_session)
						lst.forth
					end
				end
			end
		ensure
			only_concurrent_sessions: Result /= Void implies across Result as ic all not a_current_session.installation_id.is_case_insensitive_equal_general (ic.key) end
			not_empty: Result /= Void implies Result.count > 0
		end

	user_session_sorter: SORTER [ES_CLOUD_SESSION]
		local
			comp: AGENT_EQUALITY_TESTER [ES_CLOUD_SESSION]
		do
			create comp.make (agent (u_sess,v_sess: ES_CLOUD_SESSION): BOOLEAN
					do
						if u_sess.is_active then
							if v_sess.is_active then
								Result := u_sess.last_date < v_sess.last_date
							else
								Result := False
							end
						elseif v_sess.is_active then
							Result := True
						else
							Result := u_sess.last_date < v_sess.last_date
						end
					end
				)
			create {QUICK_SORTER [ES_CLOUD_SESSION]} Result.make (comp)
		end

feature -- Change	

	save_plan (a_plan: ES_CLOUD_PLAN)
		do
			es_cloud_storage.save_plan (a_plan)
		end

	delete_plan (a_plan: ES_CLOUD_PLAN)
		do
			es_cloud_storage.delete_plan (a_plan)
		end

	ping_installation (a_user: ES_CLOUD_USER; a_session: ES_CLOUD_SESSION)
		do
			a_session.set_last_date (create {DATE_TIME}.make_now_utc)
			es_cloud_storage.save_session (a_session)
		end

	end_session (a_user: ES_CLOUD_USER; a_session: ES_CLOUD_SESSION)
		do
			a_session.stop
			es_cloud_storage.save_session (a_session)
		end

	pause_session (a_user: ES_CLOUD_USER; a_session: ES_CLOUD_SESSION)
		do
			if
				not a_session.is_paused
			then
				a_session.pause
				es_cloud_storage.save_session (a_session)
			end
		end

	resume_session (a_user: ES_CLOUD_USER; a_session: ES_CLOUD_SESSION)
		do
			if
				a_session.is_paused or a_session.is_ended
			then
				a_session.resume
				es_cloud_storage.save_session (a_session)
			end
		end

	register_installation (a_license: ES_CLOUD_LICENSE; a_install_id: READABLE_STRING_GENERAL; a_info: detachable READABLE_STRING_GENERAL)
		local
			ins: ES_CLOUD_INSTALLATION
		do
			create ins.make (a_install_id, a_license)
			ins.set_info (a_info)
			es_cloud_storage.save_installation (ins)
		end

feature -- HTML factory

	account_url (u: ES_CLOUD_USER): STRING_8
		require
			u_with_id: u.has_id
		do
			Result := cms_api.location_url ("cloud/account/" + u.id.out, Void)
		end

	user_cloud_profile_link (u: ES_CLOUD_USER): STRING_8
		local
			t: READABLE_STRING_32
		do
			t := cms_api.real_user_display_name (u.cms_user)
			Result := cms_api.link (t, cms_api.url (user_cloud_profile_location (u), Void), Void)
		end

	user_cloud_profile_location (u: ES_CLOUD_USER): STRING
		do
			Result := {ES_CLOUD_MODULE}.cloud_profile_location + url_encoded (u.cms_user.name)
		end

	account_administration_url (u: ES_CLOUD_USER): STRING_8
		require
			u_with_id: u.has_id
		do
			Result := cms_api.administration_location_url ("cloud/account/" + u.id.out, Void)
		end

	account_html_administration_link (u: ES_CLOUD_USER): STRING_8
		require
			u_with_id: u.has_id
		local
			t: READABLE_STRING_32
		do
			t := cms_api.real_user_display_name (u.cms_user)
			Result := cms_api.link (t, cms_api.administration_path ("cloud/account/" + u.id.out), Void)
		end

	admin_licenses_web_location: STRING_8
		do
			Result := cms_api.administration_path_location ({ES_CLOUD_MODULE_ADMINISTRATION}.admin_licenses_location)
		end

	admin_license_web_location (lic: ES_CLOUD_LICENSE): STRING_8
		do
			Result := cms_api.administration_path_location ({ES_CLOUD_MODULE_ADMINISTRATION}.admin_licenses_location + url_encoded (lic.key))
		end

	append_one_line_license_view_to_html (lic: ES_CLOUD_LICENSE; u: detachable ES_CLOUD_USER; es_cloud_module: ES_CLOUD_MODULE; s: STRING_8)
		local
			l_plan: detachable ES_CLOUD_PLAN
			api: CMS_API
		do
			api := cms_api
			l_plan := lic.plan
			s.append ("<div class=%"es-license%">")
			s.append ("<span class=%"license-id%">License ID: </span><span class=%"id%">")
			s.append ("<a href=%"" + api.location_url (es_cloud_module.license_location (lic), Void) + "%">")
			s.append (html_encoded (lic.key))
			s.append ("</a>")
			s.append ("</span> ")
			if u /= Void then
				s.append ("<span class=%"user%">User %"")
				s.append (api.user_html_administration_link (u.cms_user))
				s.append ("%"</span> ")
			end
			s.append ("<span class=%"title%">Plan %"")
			s.append (html_encoded (l_plan.title_or_name))
			s.append ("%"</span> ")
			s.append ("<span class=%"details%">")
			if lic.is_active then
				if attached lic.expiration_date as exp then
					s.append ("<span class=%"expiration%">")
					s.append (lic.days_remaining.out)
					s.append (" days remaining")
					s.append ("</span>")
				else
					s.append ("<span class=%"status%">Active</span>")
				end
			elseif lic.is_fallback then
				s.append ("<span class=%"status%">Fallback license</span>")
			else
				s.append ("<span class=%"status warning%">Expired</span>")
			end
			s.append ("</div>")
		end

	append_short_license_view_to_html (lic: ES_CLOUD_LICENSE; u: ES_CLOUD_USER; es_cloud_module: ES_CLOUD_MODULE; s: STRING_8)
		local
			l_plan: detachable ES_CLOUD_PLAN
			api: CMS_API
		do
			api := cms_api
			l_plan := lic.plan
			s.append ("<div class=%"es-license%">")
			s.append ("<div class=%"header%">")
			s.append ("<div class=%"title%">")
			s.append (html_encoded (l_plan.title_or_name))
			s.append ("</div>")
			s.append ("<div class=%"details%">")
			if lic.is_active then
				if attached lic.expiration_date as exp then
					s.append (lic.days_remaining.out)
					s.append (" days remaining")
				else
					s.append ("Active")
				end
			elseif lic.is_fallback then
				s.append ("Fallback license")
			else
				s.append ("<span class=%"status warning%">Expired</span>")
			end
			s.append ("</div>")

			s.append ("<div class=%"license-id%">License ID: <span class=%"id%">")
			s.append ("<a href=%"" + api.location_url (es_cloud_module.license_location (lic), Void) + "%">")
			s.append (html_encoded (lic.key))
			s.append ("</a>")
			s.append ("</span></div>")
			if
				lic.plan.same_plan (trial_plan) and then
				lic.is_expired and then
				is_eligible_to_trial_extension (lic)
			then
				s.append ("<div class=%"action%">")
				s.append ("<a href=%"" + api.location_url (es_cloud_module.cloud_forms_location + {ES_CLOUD_FORMS_HANDLER}.trial_extension_form_id + "?license=" + url_encoded (lic.key), Void) + "%">Ask for extended " + html_encoded (lic.plan.title_or_name) + " license period</a>")
				s.append ("</div>")
			end
			s.append ("</div>") -- header
--			s.append ("<div class=%"details%"><ul>")
--			s.append ("</ul></div>")

			s.append ("</div>")
		end

	append_license_to_html (lic: ES_CLOUD_LICENSE; a_user: detachable ES_CLOUD_USER; es_cloud_module: detachable ES_CLOUD_MODULE; s: STRING_8)
		local
			l_plan: detachable ES_CLOUD_PLAN
			inst: ES_CLOUD_INSTALLATION
			api: CMS_API
		do
			api := cms_api
			l_plan := lic.plan
			s.append ("<div class=%"es-license%">")
			s.append ("<div class=%"header%">")
			s.append ("<div class=%"title%">")
			s.append (html_encoded (l_plan.title_or_name))
			s.append ("</div>")
			s.append ("<div class=%"license-id%">License ID: <span class=%"id%">")
			if es_cloud_module /= Void then
				s.append ("<a href=%"" + api.location_url (es_cloud_module.license_location (lic), Void) + "%">")
				s.append (html_encoded (lic.key))
				s.append ("</a>")
			else
				s.append (html_encoded (lic.key))
			end
			s.append ("</span></div>")
			s.append ("</div>") -- header
			s.append ("<div class=%"details%"><ul>")
			if a_user /= Void then
				s.append ("<li class=%"owner%"><span class=%"title%">Owner:</span> ")
				if api.has_permission ({CMS_CORE_MODULE}.perm_view_users) then
					s.append (api.user_html_link (a_user))
				else
					s.append (html_encoded (api.real_user_display_name (a_user)))
				end
				s.append ("</li>")
			end
			s.append ("<li class=%"creation%"><span class=%"title%">Started</span> ")
			s.append (api.date_time_to_string (lic.creation_date))
			s.append ("</li>")
			if lic.is_active then
				if attached lic.expiration_date as exp then
					s.append ("<li class=%"expiration%"><span class=%"title%">Renewal date</span> ")
					s.append (api.date_time_to_string (exp))
					s.append (" (")
					s.append (lic.days_remaining.out)
					s.append (" days remaining)")
					s.append ("</li>")
				else
					s.append ("<li class=%"status success%">ACTIVE</li>")
				end
			elseif lic.is_fallback then
				s.append ("<li class=%"status notice%">Fallback license</li>")
			elseif lic.is_suspended then
				s.append ("<li class=%"status warning%">SUSPENDED</li>")
			else
				s.append ("<li class=%"status warning%">EXPIRED</li>")
				if
					es_cloud_module /= Void and then
					lic.plan.same_plan (trial_plan) and then
					lic.is_expired and then
					is_eligible_to_trial_extension (lic)
				then
					s.append ("<li class=%"action%">")
					s.append ("<a href=%"" + api.location_url (es_cloud_module.cloud_forms_location + {ES_CLOUD_FORMS_HANDLER}.trial_extension_form_id + "?license=" + url_encoded (lic.key), Void) + "%">Ask for extended " + html_encoded (lic.plan.title_or_name) + " license period</a>")
					s.append ("</li>")
				end
			end
			if attached lic.platforms_as_csv_string as l_platforms then
				s.append ("<li class=%"limit%"><span class=%"title%">Limited to platform(s):</span> " + html_encoded (l_platforms) + "</li>")
			end
			if attached lic.version as l_product_version then
				s.append ("<li class=%"limit%"><span class=%"title%">Limited to version:</span> " + html_encoded (l_product_version) + "</li>")
			end
			if attached license_installations (lic) as lst and then not lst.is_empty then
				s.append ("<li class=%"limit%"><span class=%"title%">Installation(s):</span> " + lst.count.out)
				if l_plan.installations_limit > 0 then
					s.append (" / " + l_plan.installations_limit.out + " device(s)")
					if l_plan.installations_limit.to_integer_32 <= lst.count then
						s.append (" (<span class=%"warning%">No more installation available</span>)")
						s.append ("<p>To install on another device, please revoke one the previous installation(s):</p>")
					end
				end

				s.append ("<div class=%"es-installations%"><ul>")
				across
					lst as inst_ic
				loop
					inst := inst_ic.item
					if a_user /= Void then
						s.append ("<li class=%"es-installation discardable%" data-user-id=%"" + a_user.id.out + "%" data-installation-id=%"" + url_encoded (inst.id) + "%" >")
					else
						s.append ("<li class=%"es-installation discardable%">")
					end
					s.append (html_encoded (inst.id))
					s.append ("</li>%N")
				end
				s.append ("</ul></div>")
				s.append ("</li>")
			elseif l_plan.installations_limit > 0 then
				s.append ("<li class=%"limit warning%">Can be installed on: " + l_plan.installations_limit.out + " device(s)</li>")
			end
			if l_plan.platforms_limit > 0 then
				s.append ("<li class=%"limit%">Can be installed on "+ l_plan.platforms_limit.out +" different platforms</li> ")
			end

			if es_cloud_module /= Void then
				s.append ("<li><a href=%"" + api.location_url (es_cloud_module.license_activities_location (lic), Void) + "%">Associated activities...</a> ")
			end
			s.append ("</li>")

			s.append ("</ul></div>")
			s.append ("</div>")
		end

feature -- User Profile

	default_cloud_user_profile_about_content : STRING_32
		local
			res: PATH
		do
			create res.make_from_string ("templates")
			if attached cms_api.module_theme_resource_location (module, res.extended ("default_profile_about_text.tpl")) as loc and then attached cms_api.resolved_smarty_template (loc) as tpl then
				Result := {UTF_CONVERTER}.utf_8_string_8_to_string_32 (tpl.string)
			else
				Result := "[
						[[Image:https://github.com/eiffelhub/media/raw/master/logo/inline_powered_by_eiffel_logo/png_200x33/powered_by_Eiffel_Logo_inline_blue.png|width=20%]]
						== Bio ==
						'''Add a bio ...'
						== Projects ==
						* ...
						== Information ==
						* '''Company''': ...
						* '''Location''': ...
						* '''Contact-me''': email, messenger, ...
						* '''Website''': [https://...]
						* '''Social ids''': twitter, github, facebook, ...
					]"
			end
		end

feature -- Email processing

	send_new_license_mail (a_user: detachable CMS_USER; a_customer_name: detachable READABLE_STRING_GENERAL; a_email_addr: READABLE_STRING_8; a_license: ES_CLOUD_LICENSE; a_previous_trial_license: detachable ES_CLOUD_USER_LICENSE ; vars: detachable STRING_TABLE [detachable READABLE_STRING_GENERAL])
		local
			e: CMS_EMAIL
			res: PATH
			s: STRING_8
			msg: READABLE_STRING_8
			sub: STRING_8
			p: INTEGER
		do
			create res.make_from_string ("templates")

			sub := "New " + utf_8_encoded (a_license.plan.title_or_name) + " EiffelStudio license " + utf_8_encoded (a_license.key)
			if attached cms_api.module_theme_resource_location (module, res.extended ("new_license_email.tpl")) as loc and then attached cms_api.resolved_smarty_template (loc) as tpl then
				tpl.set_value (a_license, "license")
				tpl.set_value (a_license.plan.name, "license_plan_name")
				tpl.set_value (a_license.plan.title_or_name, "license_plan_title")
				tpl.set_value (a_license.key, "license_key")
				tpl.set_value (module.license_location (a_license) , "license_key_url")
				if vars /= Void then
					across
						vars as ic
					loop
						if attached ic.item as v then
							tpl.set_value (v, ic.key)
						end
					end
				end
				if a_user /= Void then
					tpl.set_value (a_user, "user")
					tpl.set_value (a_user.email, "user_email")
					tpl.set_value (a_user.name, "user_name")
					tpl.set_value (cms_api.user_display_name (a_user), "customer_name")
				else
					tpl.set_value (a_email_addr, "user_email")
				end
				if a_customer_name /= Void then
					tpl.set_value (html_encoded (a_customer_name), "customer_name")
				end

				msg := tpl.string
				if msg.starts_with_general ("Subject:") then
					p := msg.index_of ('%N', 1)
					if p > 0 then
						sub := msg.head (p - 1).to_string_8
						msg := msg.substring (p + 1, msg.count)
						sub.right_adjust
						sub.remove_head (("Subject:").count)
						sub.left_adjust
					end
				end
			else
				create s.make_empty;
				s.append ("New "+ html_encoded (a_license.plan.title_or_name) +" EiffelStudio license " + utf_8_encoded (a_license.key) + ".%N")
				if a_user = Void then
					s.append ("The license is associated with email %"" + a_email_addr + "%".%NPlease register a new account with that email at " + cms_api.site_url + " .%N")
				else
					s.append ("The license is associated with your account %"" + utf_8_encoded (cms_api.user_display_name (a_user)) + "%" (email %"" + a_email_addr + "%").%NPlease visit " + cms_api.site_url + " .%N")
				end
				msg := s
			end

			e := cms_api.new_html_email (a_email_addr, sub, msg)
			cms_api.process_email (e)
		end

	notify_new_license (a_user: detachable CMS_USER; a_customer_name: detachable READABLE_STRING_GENERAL; a_email_addr: detachable READABLE_STRING_8; a_license: ES_CLOUD_LICENSE; a_previous_trial: detachable ES_CLOUD_USER_LICENSE)
		local
			e: CMS_EMAIL
			res: PATH
			s: STRING_8
			msg: READABLE_STRING_8
			l_info: STRING_8
		do
			create res.make_from_string ("templates")
			if attached cms_api.module_theme_resource_location (module, res.extended ("notify_new_license_email.tpl")) as loc and then attached cms_api.resolved_smarty_template (loc) as tpl then
				tpl.set_value (a_license, "license")
				tpl.set_value (a_license.plan.name, "license_plan_name")
				tpl.set_value (a_license.plan.title_or_name, "license_plan_title")
				tpl.set_value (a_license.key, "license_key")
				tpl.set_value (module.license_location (a_license) , "license_key_url")
				if a_user /= Void then
					tpl.set_value (a_user, "user")
					tpl.set_value (a_user.email, "user_email")
					tpl.set_value (a_user.name, "user_name")
					tpl.set_value (cms_api.user_display_name (a_user), "customer_name")
					tpl.set_value (cms_api.user_display_name (a_user), "profile_name")
				else
					tpl.set_value (a_email_addr, "user_email")
				end
				if a_customer_name /= Void then
					tpl.set_value (html_encoded (a_customer_name), "customer_name")
					tpl.set_value (html_encoded (a_customer_name), "profile_name")
				end
				msg := tpl.string
			else
				create s.make_empty;
				s.append ("New "+ html_encoded (a_license.plan.title_or_name) +" EiffelStudio license " + utf_8_encoded (a_license.key) + ".%N")
				if a_user = Void then
					if a_email_addr /= Void then
						s.append ("The license is associated with email %"" + a_email_addr + "%".%N")
					else
						check should_not_occur: False end
						s.append ("The license is associated with no email and no user!%N")
					end
				else
					s.append ("The license is associated with account %"" + utf_8_encoded (cms_api.user_display_name (a_user)) + "%"")
					if a_email_addr /= Void then
						s.append ("(email %"" + a_email_addr + "%")")
					end
					s.append (".%N")
				end
				s.append ("Notification from site " + cms_api.site_url + " .%N")
				msg := s
			end
			create l_info.make_empty
			l_info.append_character (' ')
			if a_email_addr /= Void then
				l_info.append (a_email_addr)
			end
			e := cms_api.new_html_email (cms_api.setup.site_notification_email, "[NOTIF] New " + utf_8_encoded (a_license.plan.title_or_name) + " EiffelStudio license " + utf_8_encoded (a_license.key) + l_info, msg)
			cms_api.process_email (e)
			if attached config.additional_notification_email as l_addr then
				e := cms_api.new_html_email (l_addr, "[NOTIF] New " + utf_8_encoded (a_license.plan.title_or_name) + " EiffelStudio license " + utf_8_encoded (a_license.key) + l_info, msg)
				cms_api.process_email (e)
			end
		end

	notify_extended_license (a_user: detachable CMS_USER; a_email_addr: detachable READABLE_STRING_8; a_license: ES_CLOUD_LICENSE)
		local
			e: CMS_EMAIL
			res: PATH
			s: STRING_8
			msg: READABLE_STRING_8
		do
			create res.make_from_string ("templates")
			if attached cms_api.module_theme_resource_location (module, res.extended ("notify_extended_license_email.tpl")) as loc and then attached cms_api.resolved_smarty_template (loc) as tpl then
				tpl.set_value (a_license, "license")
				tpl.set_value (a_license.expiration_date, "expiration_date")
				tpl.set_value (a_license.key, "license_key")
				tpl.set_value (module.license_location (a_license) , "license_key_url")
				if a_user /= Void then
					tpl.set_value (a_user, "user")
					tpl.set_value (a_user.email, "user_email")
					tpl.set_value (a_user.name, "user_name")
					tpl.set_value (cms_api.user_display_name (a_user), "profile_name")
				else
					tpl.set_value (a_email_addr, "user_email")
				end
				msg := tpl.string
			else
				create s.make_empty;
				s.append ("EiffelStudio license " + utf_8_encoded (a_license.key) + ".%N")
				if attached a_license.expiration_date as dt then
					s.append ("Extended to date: " + cms_api.date_time_to_iso8601_string (dt) + " .%N")
				end
				if a_user = Void then
					if a_email_addr /= Void then
						s.append ("The license is associated with email %"" + a_email_addr + "%" .%N")
					else
						check should_not_occur: False end
						s.append ("The license is associated with no email and no user!%N")
					end
				else
					s.append ("The license is associated with account %"" + utf_8_encoded (cms_api.user_display_name (a_user)) + " %"")
					if a_email_addr /= Void then
						s.append ("(email %"" + a_email_addr + "%")")
					end
					s.append (" .%N")
				end
				s.append ("Notification from site " + cms_api.site_url + " .%N")
				msg := s
			end
			e := cms_api.new_html_email (cms_api.setup.site_notification_email, "[NOTIF] Extended EiffelStudio license " + utf_8_encoded (a_license.key), msg)
			cms_api.process_email (e)
			if attached config.additional_notification_email as l_addr then
				e := cms_api.new_html_email (l_addr, "[NOTIF] Extended EiffelStudio license " + utf_8_encoded (a_license.key), msg)
				cms_api.process_email (e)
			end
		end

	notify_redeemed_license (a_user: detachable CMS_USER; a_email_addr: detachable READABLE_STRING_8; a_license: ES_CLOUD_LICENSE; a_redeem_token: ES_CLOUD_REDEEM_TOKEN)
		local
			e: CMS_EMAIL
			res: PATH
			s: STRING_8
			msg: READABLE_STRING_8
		do
			create res.make_from_string ("templates")
			if attached cms_api.module_theme_resource_location (module, res.extended ("notify_redeemed_license_email.tpl")) as loc and then attached cms_api.resolved_smarty_template (loc) as tpl then
				tpl.set_value (a_license, "license")
				tpl.set_value (a_redeem_token, "redeem_token")
				tpl.set_value (a_license.expiration_date, "expiration_date")
				tpl.set_value (a_license.key, "license_key")
				tpl.set_value (module.license_location (a_license) , "license_key_url")
				if a_user /= Void then
					tpl.set_value (a_user, "user")
					tpl.set_value (a_user.email, "user_email")
					tpl.set_value (a_user.name, "user_name")
					tpl.set_value (cms_api.user_display_name (a_user), "profile_name")
				else
					tpl.set_value (a_email_addr, "user_email")
				end
				msg := tpl.string
			else
				create s.make_empty;
				s.append ("EiffelStudio license " + utf_8_encoded (a_license.key) + ".%N")
				s.append ("Redeem token: " + html_encoded (a_redeem_token.name))
				if attached a_redeem_token.origin as l_orig then
					s.append (" from [" + html_encoded (l_orig) + "]")
				end
				s.append (".%N")
				if attached a_license.expiration_date as dt then
					s.append ("Expiration date: " + cms_api.date_time_to_iso8601_string (dt) + " .%N")
				end

				if a_user = Void then
					if a_email_addr /= Void then
						s.append ("The license is associated with email %"" + a_email_addr + "%" .%N")
					else
						check should_not_occur: False end
						s.append ("The license is associated with no email and no user!%N")
					end
				else
					s.append ("The license is associated with account %"" + utf_8_encoded (cms_api.user_display_name (a_user)) + " %"")
					if a_email_addr /= Void then
						s.append ("(email %"" + a_email_addr + "%")")
					end
					s.append (" .%N")
				end
				s.append ("Notification from site " + cms_api.site_url + " .%N")
				msg := s
			end
			e := cms_api.new_html_email (cms_api.setup.site_notification_email, "[NOTIF] Redeemed EiffelStudio license " + utf_8_encoded (a_license.key), msg)
			cms_api.process_email (e)
			if attached config.additional_notification_email as l_addr then
				e := cms_api.new_html_email (l_addr, "[NOTIF] Redeemed EiffelStudio license " + utf_8_encoded (a_license.key), msg)
				cms_api.process_email (e)
			end
		end

	notify_error (a_error_title: READABLE_STRING_8; a_error_message: detachable READABLE_STRING_8)
		local
			e: CMS_EMAIL
			s: STRING_8
		do
			create s.make_empty;
			s.append ("ERROR: " + a_error_title + "%N")
			if a_error_message /= Void then
				s.append ("Description:%N")
				s.append (a_error_message)
				s.append ("%N")
			end
			s.append ("%NNotification from site " + cms_api.site_url + " .%N")
			e := cms_api.new_html_email (cms_api.setup.site_notification_email, "[ERROR] " + a_error_title, s)
			cms_api.process_email (e)
			if attached config.additional_notification_email as l_addr then
				e := cms_api.new_html_email (l_addr, "[ERROR] " + a_error_title, s)
				cms_api.process_email (e)
			end
		end

note
	copyright: "2011-2017, Jocelyn Fiat, Javier Velilla, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
end

