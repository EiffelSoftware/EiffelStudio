note
	description: "Summary description for {ES_CLOUD_ADMIN_HANDLER}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	ES_CLOUD_ADMIN_HANDLER

inherit
	CMS_HANDLER
		rename
			make as make_handler
		end

feature {NONE} -- Creation

	make (a_es_cloud_api: ES_CLOUD_API)
		do
			es_cloud_api := a_es_cloud_api
			make_handler (a_es_cloud_api.cms_api)
		end

	es_cloud_api: ES_CLOUD_API

feature -- Menu

	add_primary_tabs (r: like new_generic_response)
		do
			if api.has_permission ("manage es accounts") then
				r.add_to_primary_tabs (api.administration_link ("Available plans", "/cloud/plans/"))
				r.add_to_primary_tabs (api.administration_link ("ES Licenses", "/cloud/licenses/"))
				r.add_to_primary_tabs (api.administration_link ("ES Redeem", "/cloud/redeem/"))
				r.add_to_primary_tabs (api.administration_link ("ES Installations", "/cloud/installations/"))
				r.add_to_primary_tabs (api.administration_link ("ES Organizations", "/cloud/organizations/"))
				r.add_to_primary_tabs (api.administration_link ("ES Store", "/cloud/store/"))
			end
		end

end
