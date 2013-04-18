note
	description: "Authentication filter."
	date: "$Date$"
	revision: "$Revision$"

class
	IRON_REPO_AUTH_URI_TEMPLATE_FILTER_HANDLER

inherit
	IRON_REPO_AUTH_FILTER_HANDLER [WSF_URI_TEMPLATE_HANDLER]

	WSF_URI_TEMPLATE_FILTER_HANDLER

create
	make,
	make_with_next

note
	copyright: "2011-2013, Olivier Ligot, Jocelyn Fiat and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
end
