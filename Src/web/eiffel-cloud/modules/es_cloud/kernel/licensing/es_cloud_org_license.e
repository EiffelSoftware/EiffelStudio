note
	description: "Summary description for {ES_CLOUD_ORG_LICENSE}."
	date: "$Date$"
	revision: "$Revision$"

class
	ES_CLOUD_ORG_LICENSE

create
	make

convert
	license: {ES_CLOUD_LICENSE}

feature {NONE} -- Creation

	make (org: ES_CLOUD_ORGANIZATION; a_license: ES_CLOUD_LICENSE)
		do
			organization := org
			license := a_license
		end

feature -- Access

	license: ES_CLOUD_LICENSE

	organization: ES_CLOUD_ORGANIZATION

	organization_id: INTEGER_64
		do
			Result := organization.id
		end

end
