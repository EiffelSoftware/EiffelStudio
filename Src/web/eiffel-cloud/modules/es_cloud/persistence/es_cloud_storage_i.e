note
	description: "Interface for accessing JWT token from the database."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	ES_CLOUD_STORAGE_I

inherit
	ES_CLOUD_ACCOUNT_STORAGE_I

	ES_CLOUD_PLAN_STORAGE_I

	ES_CLOUD_SUBSCRIPTION_STORAGE_I

	ES_CLOUD_INSTALLATION_STORAGE_I

feature -- Error Handling

	error_handler: ERROR_HANDLER
			-- Error handler.
		deferred
		end

note
	copyright: "2011-2017, Jocelyn Fiat, Javier Velilla, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
end
