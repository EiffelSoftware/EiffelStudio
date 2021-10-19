note
	description: "CMS interface representing an email to be used with {CMS_API}.process_email (e: CMS_EMAIL)."
	date: "$Date$"
	revision: "$Revision$"

class
	CMS_EMAIL

inherit
	NOTIFICATION_EMAIL

create
	make

feature -- Access

	id: detachable IMMUTABLE_STRING_8
			-- Id, mostly for persistency purpose.

	to_user: detachable CMS_USER
			-- User who should received the current mail.

	from_user: detachable CMS_USER
			-- User who sent the current mail.

feature -- Status report

	has_id: BOOLEAN
		do
			Result := attached id as l_id and then not l_id.is_whitespace
		end

	is_sent: BOOLEAN
			-- Current Email is sent.

feature -- Element change

	set_id (a_id: READABLE_STRING_8)
		do
			if a_id = Void then
				id := Void
			else
				create id.make_from_string (a_id)
			end
		end

	set_to_user (u: like to_user)
		do
			to_user := u
		end

	set_from_user (u: like from_user)
		do
			from_user := u
		end

	set_is_sent (b: BOOLEAN)
		do
			is_sent := b
		end

note
	copyright: "2011-2021, Jocelyn Fiat, Javier Velilla, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
end
