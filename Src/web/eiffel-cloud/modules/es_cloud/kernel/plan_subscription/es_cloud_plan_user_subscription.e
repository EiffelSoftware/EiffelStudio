note
	description: "Summary description for {ES_CLOUD_PLAN_USER_SUBSCRIPTION}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ES_CLOUD_PLAN_USER_SUBSCRIPTION

inherit
	ES_CLOUD_PLAN_SUBSCRIPTION
		rename
			entity_id as user_id
		end

create
	make

feature {NONE} -- Creation

	make (u: ES_CLOUD_USER; a_plan: ES_CLOUD_PLAN)
		do
			user := u
			plan := a_plan
			create creation_date.make_now_utc
		end

feature -- Access

	user: ES_CLOUD_USER

	user_id: INTEGER_64
		do
			Result := user.id
		end

end
