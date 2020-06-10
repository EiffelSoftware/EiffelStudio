note
	description: "Handle Logoff for Basic Authentication."
	date: "$Date$"
	revision: "$Revision$"

class
	ESA_LOGOFF_SESSION_HANDLER

inherit

	ESA_ABSTRACT_HANDLER
		rename
			set_esa_config as make
		end

	WSF_URI_HANDLER
		rename
			execute as uri_execute,
			new_mapping as new_uri_mapping
		end

	WSF_RESOURCE_HANDLER_HELPER
		redefine
			do_get
		end

	REFACTORING_HELPER

create
	make

feature -- execute

	execute (req: WSF_REQUEST; res: WSF_RESPONSE)
			-- Execute request handler.
		do
			execute_methods (req, res)
		end

	uri_execute (req: WSF_REQUEST; res: WSF_RESPONSE)
			-- Execute request handler.
		do
			execute_methods (req, res)
		end

feature -- HTTP Methods

	do_get (req: WSF_REQUEST; res: WSF_RESPONSE)
			-- <Precursor>
		local
			l_rhf: ESA_REPRESENTATION_HANDLER_FACTORY
			l_cookie: WSF_COOKIE
		do
			create l_rhf
			if attached current_media_type (req) as l_type then
				debug
					log.write_information(generator + ".do_get Processing logoff")
				end
				if
					attached {WSF_STRING} req.cookie (esa_session_token) as l_cookie_token and then
					attached current_user (req) as l_user
				then
						-- Logout Session
					create l_cookie.make (esa_session_token, "") -- FIXME: unicode issue?
					l_cookie.set_path ("/")
					l_cookie.set_max_age (0)
					l_cookie.set_expiration_date (create {DATE_TIME}.make_from_epoch (0))
					res.add_cookie (l_cookie)
					req.unset_execution_variable ("user")
					l_rhf.new_representation_handler (esa_config, l_type, media_type_variants (req)).logout_page (req, res)
				else
					l_rhf.new_representation_handler (esa_config, l_type, media_type_variants (req)).logout_page (req, res)
				end
			else
				log.write_alert (generator +".do_get Processing not acceptable")
				l_rhf.new_representation_handler (esa_config, Empty_string, media_type_variants (req)).logout_page (req, res)
			end
		end

end
