note
	description: "Summary description for {SHARED_ORDER_REPOSITORY}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	SHARED_ORDER_REPOSITORY

feature
	order_repo : ORDER_REPOSITORY
		once
			create Result.make
		end
end
