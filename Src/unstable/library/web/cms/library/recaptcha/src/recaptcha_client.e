note
	description: "Summary description for {RECAPTCHA_CLIENT}."
	date: "$Date$"
	revision: "$Revision$"

class
	RECAPTCHA_CLIENT

create
	make

feature {NONE} -- Initialization

	make (cfg: RECAPTCHA_CONFIG; a_site_key: READABLE_STRING_8)
		do
			config := cfg
			site_key := a_site_key
		end

feature -- Access

	config: RECAPTCHA_CONFIG

	site_key: READABLE_STRING_8

feature -- Conversion

	client_html (a_action: READABLE_STRING_8): detachable STRING_8
		local
			cfg: like config
		do
			cfg := config
			if cfg.is_version_3 then
				Result := "%N<input type=%"hidden%" id=%"g-recaptcha-response%" name=%"g-recaptcha-response%">"
				Result := Result + "%N<script src=%"" + {RECAPTCHA_CONFIG}.recaptcha_base_uri + "/api.js?render=" + site_key + "%"></script>%N"
					+ "<script>%N%Tgrecaptcha.ready(function () {"
	            	+ "%N%T%T grecaptcha.execute('" + site_key + "', { action: '" + a_action +"' }).then(function (token) {"
	            	+ "%N%T%T%T var recaptchaResponse = document.getElementById('g-recaptcha-response');"
	            	+ "%N%T%T%T $(recaptchaResponse).val(token);"
	            	+ "%N%T });%N});%N</script>%N";
			else
				check is_v2: cfg.is_version_2 end
				Result := "<div class=%"g-recaptcha%" data-sitekey=%"" + site_key + "%"></div>"
			end
		end

;note
	copyright: "2011-2020 Javier Velilla, Jocelyn Fiat, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
