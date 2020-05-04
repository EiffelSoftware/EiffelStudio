note
	description: "Summary description for {ES_CLOUD_ORG_LICENSE}."
	date: "$Date$"
	revision: "$Revision$"

class
	ES_CLOUD_ORG_LICENSE

inherit
	ES_CLOUD_LICENSE
		rename
			entity_id as organization_id
		end

create
	make

feature {NONE} -- Creation

	make (org: ES_CLOUD_ORGANIZATION; a_plan: ES_CLOUD_PLAN)
		do
			organization := org
			plan := a_plan
			create creation_date.make_now_utc
		end

feature -- Access

	organization: ES_CLOUD_ORGANIZATION

	organization_id: INTEGER_64
		do
			Result := organization.id
		end

end
