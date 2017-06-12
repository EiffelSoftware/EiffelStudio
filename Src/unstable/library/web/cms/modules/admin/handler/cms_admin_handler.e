note
	description: "[
			handler for CMS admin in the CMS interface.

			TODO: implement REST API.
		]"
	date: "$Date$"
	revision: "$Revision$"

class
	CMS_ADMIN_HANDLER

inherit
	CMS_HANDLER

	WSF_URI_HANDLER
		rename
			execute as uri_execute,
			new_mapping as new_uri_mapping
		end

	WSF_URI_TEMPLATE_HANDLER
		rename
			execute as uri_template_execute,
			new_mapping as new_uri_template_mapping
		select
			new_uri_template_mapping
		end

	WSF_RESOURCE_HANDLER_HELPER
		redefine
			do_get,
			do_post
		end

	REFACTORING_HELPER

create
	make

feature -- execute

	execute (req: WSF_REQUEST; res: WSF_RESPONSE)
			-- Execute request handler
		do
			execute_methods (req, res)
		end

	uri_execute (req: WSF_REQUEST; res: WSF_RESPONSE)
			-- Execute request handler
		do
			execute (req, res)
		end

	uri_template_execute (req: WSF_REQUEST; res: WSF_RESPONSE)
			-- Execute request handler
		do
			execute (req, res)
		end

feature -- HTTP Methods

	do_get (req: WSF_REQUEST; res: WSF_RESPONSE)
		local
			r: CMS_RESPONSE
		do
			if api.has_permission ("manage " + {CMS_ADMIN_MODULE}.name) then
				create {CMS_ADMIN_RESPONSE} r.make (req, res, api)
				r.execute
			else
				send_access_denied (req, res)
			end
		end

	do_post (req: WSF_REQUEST; res: WSF_RESPONSE)
		local
			r: CMS_RESPONSE
		do
			if api.has_permission ("manage " + {CMS_ADMIN_MODULE}.name) then
				create {CMS_ADMIN_RESPONSE} r.make (req, res, api)
				r.execute
			else
				send_access_denied (req, res)
			end
		end

end
