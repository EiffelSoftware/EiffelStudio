note
	description: "Context parameter for a wikidocs change."
	date: "$Date$"
	revision: "$Revision$"

class
	WDOCS_CHANGE_CONTEXT

feature -- Access

	user: detachable CMS_USER

	username: detachable READABLE_STRING_32
		do
			if attached user as u then
				Result := u.name
			end
		end

	log: detachable READABLE_STRING_32

feature -- Element change

	set_user (u: like user)
		do
			user := u
		end

	set_log (a_log: detachable READABLE_STRING_GENERAL)
		do
			if a_log = Void then
				log := Void
			else
				create {STRING_32} log.make_from_string_general (a_log)
			end
		end

end
