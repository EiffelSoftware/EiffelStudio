note
	description: "Template shared common features to all the templates"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	TEMPLATE_SHARED

inherit

	ESA_TEMPLATE_PAGE

feature --

	add_host (a_host: READABLE_STRING_GENERAL)
			-- Add value `a_host' to `host'
		do
			template.add_value (a_host, "host")
		end


	add_user (a_user: detachable ANY)
			-- Add value `a_host' to `host'
		do
			if attached a_user then
				template.add_value (a_user,"user")
			end
		end
end
