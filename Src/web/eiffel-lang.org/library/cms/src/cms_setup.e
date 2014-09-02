note
	description: "Summary description for {CMS_SETUP}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	CMS_SETUP

feature -- Access

	configuration: CMS_CONFIGURATION

	base_url: detachable READABLE_STRING_8

	modules: LIST [CMS_MODULE]
		deferred
		end

	storage: CMS_STORAGE
			-- CMS persistent layer
		deferred
		end

	session_manager: WSF_SESSION_MANAGER
			-- CMS Session manager
		deferred
		end

	auth_engine: CMS_AUTH_ENGINE
			-- CMS Authentication engine		
		deferred
		end

	mailer: NOTIFICATION_MAILER
			-- CMS email engine
		deferred
		end

feature -- Change

	set_base_url (a_base_url: like base_url)
		do
			if a_base_url /= Void and then not a_base_url.is_empty then
				base_url := a_base_url
			else
				base_url := Void
			end
		end

	add_module (m: CMS_MODULE)
		deferred
		end

note
	copyright: "2011-2014, Jocelyn Fiat, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"
end
