note
	description: "Interface for accessing installation from the database."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	ES_CLOUD_INSTALLATION_STORAGE_I

feature -- Error Handling

	error_handler: ERROR_HANDLER
			-- Error handler.
		deferred
		end

feature -- Access: installations		

	user_installations (a_user: ES_CLOUD_USER): LIST [ES_CLOUD_INSTALLATION]
		deferred
		end

	all_user_installations: LIST [ES_CLOUD_INSTALLATION]
		deferred
		end

	installation (a_install_id: READABLE_STRING_GENERAL; a_license_id: like {ES_CLOUD_LICENSE}.id): detachable ES_CLOUD_INSTALLATION
		deferred
		end

	installations (a_install_id: READABLE_STRING_GENERAL): detachable LIST [ES_CLOUD_INSTALLATION]
		deferred
		end

	license_installations (a_license_id: like {ES_CLOUD_LICENSE}.id): LIST [ES_CLOUD_INSTALLATION]
		deferred
		end

feature -- Access: sessions

	last_user_session (a_user: ES_CLOUD_USER; a_installation: detachable ES_CLOUD_INSTALLATION): detachable ES_CLOUD_SESSION
			-- Last user session, and only for installation `a_installation` is provided.
		deferred
		end

	last_license_session (a_license: ES_CLOUD_LICENSE): detachable ES_CLOUD_SESSION
		deferred
		end

	user_sessions (a_user: ES_CLOUD_USER; a_install_id: detachable READABLE_STRING_GENERAL; a_only_active: BOOLEAN): detachable LIST [ES_CLOUD_SESSION]
		deferred
		end

	user_session (a_user: ES_CLOUD_USER; a_install_id, a_session_id: READABLE_STRING_GENERAL): detachable ES_CLOUD_SESSION
		deferred
		end

	installation_sessions (a_install_id: READABLE_STRING_GENERAL; a_only_active: BOOLEAN): detachable LIST [ES_CLOUD_SESSION]
		deferred
		end

feature -- Change

	save_installation (inst: ES_CLOUD_INSTALLATION)
		deferred
		end

	discard_installation (inst: ES_CLOUD_INSTALLATION; a_user: detachable ES_CLOUD_USER)
		deferred
		end

	save_session (a_session: ES_CLOUD_SESSION)
		deferred
		end

note
	copyright: "2011-2017, Jocelyn Fiat, Javier Velilla, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
end
