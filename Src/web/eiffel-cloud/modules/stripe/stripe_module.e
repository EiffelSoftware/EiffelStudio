note
	description: "Summary description for {STRIPE_MODULE}."
	date: "$Date$"
	revision: "$Revision$"

class
	STRIPE_MODULE

inherit
	CMS_MODULE_WITH_SQL_STORAGE
		rename
			module_api as stripe_api
		redefine
			initialize,
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
			l_is_livemode: BOOLEAN
			l_pub,l_sec, l_sign_sec: detachable READABLE_STRING_8
		do
			Precursor (api)
			if stripe_api = Void then
				if
					attached api.module_configuration_by_name ({STRIPE_MODULE}.name, "config") as l_cfg
				then
					if attached l_cfg.resolved_text_item ("stripe.livemode") as s then
						l_is_livemode := s.is_case_insensitive_equal_general ("yes")
					elseif attached l_cfg.resolved_text_item ("stripe.testing") as s then
						l_is_livemode := not s.is_case_insensitive_equal_general ("no")
					else
						l_is_livemode := False -- by default, livemode is False
					end

					if l_is_livemode then
						l_pub := l_cfg.utf_8_text_item ("stripe.live_public_key")
						l_sec := l_cfg.utf_8_text_item ("stripe.live_secret_key")
						l_sign_sec := l_cfg.utf_8_text_item ("stripe.live_signing_secret")
					else
						l_pub := l_cfg.utf_8_text_item ("stripe.test_public_key")
						l_sec := l_cfg.utf_8_text_item ("stripe.test_secret_key")
						l_sign_sec := l_cfg.utf_8_text_item ("stripe.test_signing_secret")
					end
					if l_pub = Void and l_sec = Void then
							-- Backward compatible
						l_pub := l_cfg.utf_8_text_item ("stripe.public_key")
						l_sec := l_cfg.utf_8_text_item ("stripe.secret_key")
						l_sign_sec := l_cfg.utf_8_text_item ("stripe.signing_secret")
					end
					if
						l_pub /= Void and then
						l_sec /= Void
					then
						create cfg.make (l_pub, l_sec)
						if l_is_livemode then
							cfg.enable_live_mode
						else
							cfg.disable_live_mode
						end
						if attached l_cfg.utf_8_text_item ("stripe.base_path") as l_base_path then
							if l_base_path.starts_with_general ("/") then
								cfg.set_base_path (l_base_path)
							else
								cfg.set_base_path ("/" + l_base_path)
							end
						end
						create stripe_api.make (api, cfg)
						if l_sign_sec /= Void then
							cfg.set_signing_secret (left_right_adjusted (l_sign_sec))
						end
					end
				end
			end
		end

	left_right_adjusted (s: READABLE_STRING_8): STRING_8
		do
			create Result.make_from_string (s)
			Result.left_adjust
			Result.right_adjust
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

feature {CMS_API, CMS_MODULE_API, CMS_MODULE} -- Access: API

	stripe_api: detachable STRIPE_API
			-- <Precursor>

feature -- Access: router

	setup_router (a_router: WSF_ROUTER; a_api: CMS_API)
			-- <Precursor>
		do
			if attached stripe_api as l_mod_api then
				a_router.handle (l_mod_api.config.base_path + "/not_available", create {WSF_URI_AGENT_HANDLER}.make (agent handle_not_available (?,?, a_api)), a_router.methods_get)
				a_router.handle (l_mod_api.config.base_path + "/subscribe/{category}/{checkout}", create {STRIPE_SUBSCRIPTION_HANDLER}.make (Current, l_mod_api, l_mod_api.config.base_path), a_router.methods_post)

				a_router.handle (l_mod_api.config.base_path + "/pay/{category}/{checkout}", create {STRIPE_PAYMENT_HANDLER}.make (Current, l_mod_api, l_mod_api.config.base_path), a_router.methods_get_post)
				a_router.handle (l_mod_api.config.base_path + "/pay/{category}/{checkout}/terms", create {STRIPE_PAYMENT_HANDLER}.make (Current, l_mod_api, l_mod_api.config.base_path), a_router.methods_get)
			end
		end

feature -- Helper

	payment_link (a_category: READABLE_STRING_GENERAL; a_checkout: READABLE_STRING_GENERAL; a_email: READABLE_STRING_GENERAL): READABLE_STRING_8
			-- Payment url for category `a_category` and checkout `a_checkout`.
		do
			if attached stripe_api as l_stripe_api and then l_stripe_api.config.is_valid then
				Result := l_stripe_api.config.base_path + "/pay/" + html_encoded (a_category) + "/" + html_encoded (a_checkout) + "?contact_email=" + url_encoded (a_email)
			else
				Result := {STRIPE_CONFIG}.default_base_path + "/not_available"
			end
		end

	subscription_checkout_link (a_category: READABLE_STRING_GENERAL; a_checkout: READABLE_STRING_GENERAL; a_email: READABLE_STRING_GENERAL): READABLE_STRING_8
			-- Checkout url for checkout from category `a_category` and checkout `a_checkout`.
		do
			if attached stripe_api as l_stripe_api and then l_stripe_api.config.is_valid then
				Result := l_stripe_api.config.base_path + "/subscribe/" + html_encoded (a_category) + "/" + html_encoded (a_checkout) + "?contact_email=" + url_encoded (a_email)
			else
				Result := {STRIPE_CONFIG}.default_base_path + "/not_available"
			end
		end

	fill_payment_form (a_user: detachable CMS_USER; a_email: READABLE_STRING_GENERAL; a_form: CMS_FORM)
		local
			f_email: WSF_FORM_EMAIL_INPUT
			f_phone: WSF_FORM_TEL_INPUT
			f_name: WSF_FORM_TEXT_INPUT
			l_customer: STRIPE_CUSTOMER
			l_address: STRIPE_ADDRESS
			f_txt: WSF_FORM_TEXT_INPUT
			f_set: WSF_FORM_FIELD_SET
			f_countries: WSF_FORM_SELECT
			l_country: READABLE_STRING_GENERAL
			l_submit: WSF_WIDGET
		do
			if attached stripe_api as l_stripe_api then
				l_customer := l_stripe_api.customer_by_email (a_email)
				if l_customer /= Void then
					l_address := l_customer.address
					if l_address /= Void then
						l_country := l_address.country
					end
				end
			end
			if attached a_form.fields_by_name ("stripe-op") as lst and then not lst.is_empty then
				l_submit := lst.first
			end

			create f_set.make
			f_set.set_legend ("User Contact")
			if l_submit /= Void then
				a_form.insert_before (f_set, l_submit)
			else
				a_form.extend (f_set)
			end
			if
				attached a_form.fields_by_name ("contact_email") as lst and then lst.count = 1 and then
				attached {WSF_FORM_EMAIL_INPUT} lst.first as e
			then
				f_email := e
			else
				create f_email.make ("contact_email")
				f_set.extend (f_email)
			end
			f_email.set_text_value (a_email)
			f_email.set_label ("Email address")
			f_email.enable_required

			create f_name.make ("contact_name")
			f_name.set_label ("Name (first, last)")
			f_set.extend (f_name)
			if l_customer /= Void and then attached l_customer.name as l_name then
				f_name.set_text_value (l_name)
			elseif a_user /= Void then
				f_name.set_text_value (a_user.name)
			end

			create f_phone.make ("contact_phone")
			f_phone.set_label ("Phone (optional)")
			f_set.extend (f_phone)
			if l_customer /= Void and then attached l_customer.phone as l_phone then
				f_phone.set_text_value (l_phone)
			end

			create f_set.make
			f_set.set_legend ("User Information")
			if l_submit /= Void then
				a_form.insert_before (f_set, l_submit)
			else
				a_form.extend (f_set)
			end

			create f_txt.make ("contact_address_street1")
			f_txt.set_label ("Street address")
			f_txt.set_placeholder ("Street #1")
			f_set.extend (f_txt)
			if l_address /= Void then
				f_txt.set_text_value (l_address.line1)
			end

			create f_txt.make ("contact_address_street2")
			f_txt.set_placeholder ("Street #2")
			f_set.extend (f_txt)
			if l_address /= Void then
				f_txt.set_text_value (l_address.line2)
			end


			create f_txt.make ("contact_address_city")
			f_txt.set_label ("City")
			f_txt.set_placeholder ("City")
			f_set.extend (f_txt)
			if l_address /= Void then
				f_txt.set_text_value (l_address.city)
			end

			create f_txt.make ("contact_address_zip")
			f_txt.set_label ("Postal code/ZIP")
			f_txt.set_placeholder ("Postal code")
			f_set.extend (f_txt)
			if l_address /= Void then
				f_txt.set_text_value (l_address.postal_code)
			end

			create f_txt.make ("contact_address_state")
			f_txt.set_label ("State/Region")
			f_txt.set_placeholder ("State")
			f_set.extend (f_txt)
			if l_address /= Void then
				f_txt.set_text_value (l_address.state)
			end

			create f_countries.make ("contact_address_country")
			if l_country = Void then
				l_country := "US"
			end
			f_countries := new_country_field ("contact_address_country", l_country)
			f_countries.set_label ("Country")
			f_set.extend (f_countries)
		end

	new_country_field (a_field_name: READABLE_STRING_8; a_dft_country: detachable READABLE_STRING_GENERAL): WSF_FORM_SELECT
		local
			f_opt: WSF_FORM_SELECT_OPTION
		do
			create Result.make (a_field_name)
			across
				iso_countries as ic
			loop
				create f_opt.make (ic.key, ic.item)
				if a_dft_country /= Void and then a_dft_country.is_case_insensitive_equal (ic.key) then
					f_opt.set_is_selected (True)
				end
				Result.add_option (f_opt)
			end
		end

	iso_countries: STRING_TABLE [READABLE_STRING_32]
		once
			create Result.make (193)
			Result ["AF"] := "Afghanistan"
			Result ["AL"] := "Albania"
			Result ["DZ"] := "Algeria"
			Result ["AD"] := "Andorra"
			Result ["AO"] := "Angola"
			Result ["AG"] := "Antigua and Barbuda"
			Result ["AR"] := "Argentina"
			Result ["AM"] := "Armenia"
			Result ["AU"] := "Australia"
			Result ["AT"] := "Austria"
			Result ["AZ"] := "Azerbaijan"
			Result ["BS"] := "Bahamas"
			Result ["BH"] := "Bahrain"
			Result ["BD"] := "Bangladesh"
			Result ["BB"] := "Barbados"
			Result ["BY"] := "Belarus"
			Result ["BE"] := "Belgium"
			Result ["BZ"] := "Belize"
			Result ["BJ"] := "Benin"
			Result ["BT"] := "Bhutan"
			Result ["BO"] := "Bolivia (Plurinational State of)"
			Result ["BA"] := "Bosnia and Herzegovina"
			Result ["BW"] := "Botswana"
			Result ["BR"] := "Brazil"
			Result ["BN"] := "Brunei Darussalam"
			Result ["BG"] := "Bulgaria"
			Result ["BF"] := "Burkina Faso"
			Result ["BI"] := "Burundi"
			Result ["CV"] := "Cabo Verde"
			Result ["KH"] := "Cambodia"
			Result ["CM"] := "Cameroon"
			Result ["CA"] := "Canada"
			Result ["CF"] := "Central African Republic"
			Result ["TD"] := "Chad"
			Result ["CL"] := "Chile"
			Result ["CN"] := "China"
			Result ["CO"] := "Colombia"
			Result ["KM"] := "Comoros"
			Result ["CG"] := "Congo"
			Result ["CD"] := "Congo, Democratic Republic of the"
			Result ["CR"] := "Costa Rica"
			Result ["CI"] := "Côte d'Ivoire"
			Result ["HR"] := "Croatia"
			Result ["CU"] := "Cuba"
			Result ["CY"] := "Cyprus"
			Result ["CZ"] := "Czechia"
			Result ["DK"] := "Denmark"
			Result ["DJ"] := "Djibouti"
			Result ["DM"] := "Dominica"
			Result ["DO"] := "Dominican Republic"
			Result ["EC"] := "Ecuador"
			Result ["EG"] := "Egypt"
			Result ["SV"] := "El Salvador"
			Result ["GQ"] := "Equatorial Guinea"
			Result ["ER"] := "Eritrea"
			Result ["EE"] := "Estonia"
			Result ["SZ"] := "Eswatini"
			Result ["ET"] := "Ethiopia"
			Result ["FJ"] := "Fiji"
			Result ["FI"] := "Finland"
			Result ["FR"] := "France"
			Result ["GA"] := "Gabon"
			Result ["GM"] := "Gambia"
			Result ["GE"] := "Georgia"
			Result ["DE"] := "Germany"
			Result ["GH"] := "Ghana"
			Result ["GR"] := "Greece"
			Result ["GD"] := "Grenada"
			Result ["GT"] := "Guatemala"
			Result ["GN"] := "Guinea"
			Result ["GW"] := "Guinea-Bissau"
			Result ["GY"] := "Guyana"
			Result ["HT"] := "Haiti"
			Result ["HN"] := "Honduras"
			Result ["HU"] := "Hungary"
			Result ["IS"] := "Iceland"
			Result ["IN"] := "India"
			Result ["ID"] := "Indonesia"
			Result ["IR"] := "Iran (Islamic Republic of)"
			Result ["IQ"] := "Iraq"
			Result ["IE"] := "Ireland"
			Result ["IL"] := "Israel"
			Result ["IT"] := "Italy"
			Result ["JM"] := "Jamaica"
			Result ["JP"] := "Japan"
			Result ["JO"] := "Jordan"
			Result ["KZ"] := "Kazakhstan"
			Result ["KE"] := "Kenya"
			Result ["KI"] := "Kiribati"
			Result ["KP"] := "Korea (Democratic People's Republic of)"
			Result ["KR"] := "Korea, Republic of"
			Result ["KW"] := "Kuwait"
			Result ["KG"] := "Kyrgyzstan"
			Result ["LA"] := "Lao People's Democratic Republic"
			Result ["LV"] := "Latvia"
			Result ["LB"] := "Lebanon"
			Result ["LS"] := "Lesotho"
			Result ["LR"] := "Liberia"
			Result ["LY"] := "Libya"
			Result ["LI"] := "Liechtenstein"
			Result ["LT"] := "Lithuania"
			Result ["LU"] := "Luxembourg"
			Result ["MG"] := "Madagascar"
			Result ["MW"] := "Malawi"
			Result ["MY"] := "Malaysia"
			Result ["MV"] := "Maldives"
			Result ["ML"] := "Mali"
			Result ["MT"] := "Malta"
			Result ["MH"] := "Marshall Islands"
			Result ["MR"] := "Mauritania"
			Result ["MU"] := "Mauritius"
			Result ["MX"] := "Mexico"
			Result ["FM"] := "Micronesia (Federated States of)"
			Result ["MD"] := "Moldova, Republic of"
			Result ["MC"] := "Monaco"
			Result ["MN"] := "Mongolia"
			Result ["ME"] := "Montenegro"
			Result ["MA"] := "Morocco"
			Result ["MZ"] := "Mozambique"
			Result ["MM"] := "Myanmar"
			Result ["NA"] := "Namibia"
			Result ["NR"] := "Nauru"
			Result ["NP"] := "Nepal"
			Result ["NL"] := "Netherlands"
			Result ["NZ"] := "New Zealand"
			Result ["NI"] := "Nicaragua"
			Result ["NE"] := "Niger"
			Result ["NG"] := "Nigeria"
			Result ["MK"] := "North Macedonia"
			Result ["NO"] := "Norway"
			Result ["OM"] := "Oman"
			Result ["PK"] := "Pakistan"
			Result ["PW"] := "Palau"
			Result ["PA"] := "Panama"
			Result ["PG"] := "Papua New Guinea"
			Result ["PY"] := "Paraguay"
			Result ["PE"] := "Peru"
			Result ["PH"] := "Philippines"
			Result ["PL"] := "Poland"
			Result ["PT"] := "Portugal"
			Result ["QA"] := "Qatar"
			Result ["RO"] := "Romania"
			Result ["RU"] := "Russian Federation"
			Result ["RW"] := "Rwanda"
			Result ["KN"] := "Saint Kitts and Nevis"
			Result ["LC"] := "Saint Lucia"
			Result ["VC"] := "Saint Vincent and the Grenadines"
			Result ["WS"] := "Samoa"
			Result ["SM"] := "San Marino"
			Result ["ST"] := "Sao Tome and Principe"
			Result ["SA"] := "Saudi Arabia"
			Result ["SN"] := "Senegal"
			Result ["RS"] := "Serbia"
			Result ["SC"] := "Seychelles"
			Result ["SL"] := "Sierra Leone"
			Result ["SG"] := "Singapore"
			Result ["SK"] := "Slovakia"
			Result ["SI"] := "Slovenia"
			Result ["SB"] := "Solomon Islands"
			Result ["SO"] := "Somalia"
			Result ["ZA"] := "South Africa"
			Result ["SS"] := "South Sudan"
			Result ["ES"] := "Spain"
			Result ["LK"] := "Sri Lanka"
			Result ["SD"] := "Sudan"
			Result ["SR"] := "Suriname"
			Result ["SE"] := "Sweden"
			Result ["CH"] := "Switzerland"
			Result ["SY"] := "Syrian Arab Republic"
			Result ["TJ"] := "Tajikistan"
			Result ["TZ"] := "Tanzania, United Republic of"
			Result ["TH"] := "Thailand"
			Result ["TL"] := "Timor-Leste"
			Result ["TG"] := "Togo"
			Result ["TO"] := "Tonga"
			Result ["TT"] := "Trinidad and Tobago"
			Result ["TN"] := "Tunisia"
			Result ["TR"] := "Turkey"
			Result ["TM"] := "Turkmenistan"
			Result ["TV"] := "Tuvalu"
			Result ["UG"] := "Uganda"
			Result ["UA"] := "Ukraine"
			Result ["AE"] := "United Arab Emirates"
			Result ["GB"] := "United Kingdom of Great Britain and Northern Ireland"
			Result ["US"] := "United States of America"
			Result ["UY"] := "Uruguay"
			Result ["UZ"] := "Uzbekistan"
			Result ["VU"] := "Vanuatu"
			Result ["VE"] := "Venezuela (Bolivarian Republic of)"
			Result ["VN"] := "Viet Nam"
			Result ["YE"] := "Yemen"
			Result ["ZM"] := "Zambia"
			Result ["ZW"] := "Zimbabwe"
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
