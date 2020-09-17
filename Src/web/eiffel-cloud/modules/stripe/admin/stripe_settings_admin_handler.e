note
	description: "Summary description for {STRIPE_SETTINGS_ADMIN_HANDLER}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	STRIPE_SETTINGS_ADMIN_HANDLER

inherit
	STRIPE_ADMIN_HANDLER

	WSF_URI_HANDLER

create
	make

feature -- Execution

	execute (req: WSF_REQUEST; res: WSF_RESPONSE)
		local
			r: like new_generic_response
			l_html: STRING
		do
			if api.has_permission ("manage stripe") then
				r := new_generic_response (req, res)
				create l_html.make (1024)
				l_html.append ("<h2>Stripe settings</h2>")
				l_html.append ("<li>public_key: " + html_encoded (stripe_api.config.public_key) + "</li>")
				l_html.append ("<li>secret_key: " + html_encoded (stripe_api.config.secret_key) + "</li>")
				if stripe_api.config.is_live_mode then
					l_html.append ("<li class=%"warning%">In %"LIVE%" mode.</li>")
				else
					l_html.append ("<li class=%"warning%">In %"TEST%" mode.</li>")
				end
				r.set_main_content (l_html)
				r.execute
			else
				send_access_denied (req, res)
			end
		end

end
