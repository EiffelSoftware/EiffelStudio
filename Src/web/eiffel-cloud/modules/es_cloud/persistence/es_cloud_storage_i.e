note
	description: "Interface for accessing JWT token from the database."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	ES_CLOUD_STORAGE_I

feature -- Error Handling

	error_handler: ERROR_HANDLER
			-- Error handler.
		deferred
		end

feature -- Access

	plans: LIST [ES_CLOUD_PLAN]
		deferred
		end

	user_subscription (a_user: CMS_USER): detachable ES_CLOUD_PLAN_SUBSCRIPTION
		deferred
		end

	user_installations (a_user: CMS_USER): LIST [ES_CLOUD_INSTALLATION]
		deferred
		end

	user_installation (a_user: CMS_USER; a_install_id: READABLE_STRING_GENERAL): detachable ES_CLOUD_INSTALLATION
		deferred
		end

	user_sessions (a_user: CMS_USER; a_install_id: detachable READABLE_STRING_GENERAL; a_only_active: BOOLEAN): detachable LIST [ES_CLOUD_SESSION]
		deferred
		end

	user_session (a_user: CMS_USER; a_install_id, a_session_id: READABLE_STRING_GENERAL): detachable ES_CLOUD_SESSION
		deferred
		end

feature -- Change

	save_plan (a_plan: ES_CLOUD_PLAN)
		deferred
		end

	save_subscription (sub: ES_CLOUD_PLAN_SUBSCRIPTION)
		deferred
		end

	discard_subscription (sub: ES_CLOUD_PLAN_SUBSCRIPTION)
		deferred
		end

	save_installation (inst: ES_CLOUD_INSTALLATION)
		deferred
		end

	discard_installation (inst: ES_CLOUD_INSTALLATION)
		deferred
		end

	save_session (a_session: ES_CLOUD_SESSION)
		deferred
		end


note
	copyright: "2011-2017, Jocelyn Fiat, Javier Velilla, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
end
