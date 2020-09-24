note
	description: "Interface for accessing cloud data from the database."
	date: "$Date$"
	revision: "$Revision$"

class
	ES_CLOUD_STORAGE_SQL

inherit
	ES_CLOUD_ACCOUNT_STORAGE_SQL

	ES_CLOUD_INSTALLATION_STORAGE_SQL

	ES_CLOUD_PLAN_STORAGE_SQL

	ES_CLOUD_SUBSCRIPTION_STORAGE_SQL

	ES_CLOUD_STORAGE_I
		undefine
			organization
		end

	CMS_PROXY_STORAGE_SQL

	CMS_STORAGE_SQL_I

create
	make

note
	copyright: "2011-2020, Jocelyn Fiat, Javier Velilla, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
end
