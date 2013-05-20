note
	description: "Summary description for {FILTER_HANDLER_CONTEXT}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	FILTER_HANDLER_CONTEXT

inherit
	WSF_HANDLER_CONTEXT

create
	make

feature -- Access

	user: detachable USER
			-- Authenticated user

feature -- Element change

	set_user (a_user: USER)
			-- Set `user' to `a_user'
		do
			user := a_user
		ensure
			user_set: user = a_user
		end

note
	copyright: "2011-2012, Olivier Ligot, Jocelyn Fiat and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
end
