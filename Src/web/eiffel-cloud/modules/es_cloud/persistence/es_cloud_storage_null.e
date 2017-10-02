note
	description: "Interface for accessing JWT token from the database."
	date: "$Date$"
	revision: "$Revision$"

class
	ES_CLOUD_STORAGE_NULL

inherit
	ES_CLOUD_STORAGE_I

feature -- Error handler

	error_handler: ERROR_HANDLER
			-- Error handler.
		do
			create Result.make
		end

feature -- Access

	plans: LIST [ES_CLOUD_PLAN]
		do
			create {ARRAYED_LIST [ES_CLOUD_PLAN]} Result.make (0)
		end

	user_subscription (a_user: CMS_USER): detachable ES_CLOUD_PLAN_SUBSCRIPTION
		do
		end

	user_installations (a_user: CMS_USER): LIST [ES_CLOUD_INSTALLATION]
		do
			create {ARRAYED_LIST [ES_CLOUD_INSTALLATION]} Result.make (0)
		end

feature -- Change

	save_subscription (sub: ES_CLOUD_PLAN_SUBSCRIPTION)
		do
		end

	discard_subscription (sub: ES_CLOUD_PLAN_SUBSCRIPTION)
		do
		end

	save_installation (inst: ES_CLOUD_INSTALLATION)
		do
		end

	discard_installation (inst: ES_CLOUD_INSTALLATION)
		do
		end

note
	copyright: "2011-2017, Jocelyn Fiat, Javier Velilla, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
end
