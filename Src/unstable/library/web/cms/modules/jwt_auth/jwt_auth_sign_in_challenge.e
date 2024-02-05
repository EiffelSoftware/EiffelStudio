note
	description: "Summary description for {JWT_AUTH_CHALLENGE}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	JWT_AUTH_SIGN_IN_CHALLENGE

create
	make,
	make_with_expiration

feature {NONE} -- Initialization

	make (a_client: READABLE_STRING_GENERAL; apps: detachable LIST [READABLE_STRING_GENERAL]; a_challenge: READABLE_STRING_GENERAL; a_expiration: DATE_TIME)
		do
			client := a_client
			set_applications (apps)
			challenge := a_challenge
			expiration_date := a_expiration
			status := status_normal
		end

	make_with_expiration (a_client: READABLE_STRING_GENERAL; apps: detachable LIST [READABLE_STRING_GENERAL]; a_challenge: READABLE_STRING_GENERAL; a_expiration_in_seconds: INTEGER_32)
		local
			dt: DATE_TIME
		do
			create dt.make_now_utc
			dt.second_add (a_expiration_in_seconds)
			make (a_client, apps, a_challenge, dt)
		end

feature -- Access

	client: IMMUTABLE_STRING_32

	information: detachable IMMUTABLE_STRING_32

	challenge: IMMUTABLE_STRING_32

	expiration_date: DATE_TIME

	applications: detachable LIST [READABLE_STRING_GENERAL]
			-- Applications accepting this `challenge`

	applications_as_csv: detachable STRING_32
			-- `applications` list as comma separated value.
		do
			if attached applications as apps and then not apps.is_empty then
				create Result.make_empty
				across
					apps as ic
				loop
					if not Result.is_empty then
						Result.append_character (',')
					end
					Result.append_string_general (ic.item)
				end
			end
		end

feature -- Status report

	status: INTEGER

	user_id: like {CMS_USER}.id

	is_valid (dt: DATE_TIME): BOOLEAN
		do
			Result := status = status_normal and then not is_expired (dt)
		end

	is_expired (dt: DATE_TIME): BOOLEAN
		do
			if is_marked_expired then
				Result := True
			elseif dt > expiration_date then
				mark_expired
				Result := True
			end
		end

	is_approved: BOOLEAN
		do
			Result := status = status_approved
		end

	is_denied: BOOLEAN
		do
			Result := status = status_denied
		end

	is_marked_expired: BOOLEAN
		do
			Result := status = status_expired
		end

	is_discarded: BOOLEAN
		do
			Result := status = status_discarded
		end

feature -- Constants

	status_normal: INTEGER = 0

	status_approved: INTEGER = 1

	status_denied: INTEGER = 2

	status_expired: INTEGER = 3

	status_discarded: INTEGER = 4

feature -- Element change

	approve (u: CMS_USER)
		require
			status = status_normal
		do
			user_id := u.id
			status := status_approved
		end

	deny
		require
			status = status_normal
		do
			status := status_denied
		end

	mark_expired
		do
			status := status_expired
		end

	discard
		require
			status /= status_approved
		do
			status := status_discarded
		end

	set_information (inf: detachable READABLE_STRING_GENERAL)
		do
			if inf /= Void and then not inf.is_whitespace then
				information := inf
			else
				information := Void
			end
		end

	set_applications_from_csv (apps: detachable READABLE_STRING_GENERAL)
		do
			if apps /= Void and then not apps.is_whitespace then
				set_applications (apps.split (','))
			else
				applications := Void
			end
		end

	set_applications (apps: detachable LIST [READABLE_STRING_GENERAL])
		do
			applications := Void
			if apps /= Void and then not apps.is_empty then
				across
					apps as ic
				loop
					set_application (ic.item)
				end
			end
		end

	set_application (app: READABLE_STRING_GENERAL)
		local
			lst: like applications
			s: STRING_32
		do
			lst := applications
			if lst = Void then
				create {ARRAYED_LIST [READABLE_STRING_GENERAL]} lst.make (1)
				applications := lst
			end
			s := app.as_string_32
			s.left_adjust
			s.right_adjust
			lst.force (s)
		end

	unset_application (app: READABLE_STRING_GENERAL)
		local
			lst: like applications
		do
			lst := applications
			if lst /= Void and then not lst.is_empty then
				from
					lst.start
				until
					lst.after
				loop
					if app.is_case_insensitive_equal (lst.item) then
						lst.remove
					else
						lst.forth
					end
				end
			end
		end

feature {JWT_AUTH_STORAGE_I} -- Element change

	is_valid_status (st: INTEGER_32): BOOLEAN
		do
			Result := st = status_normal
				or st = status_approved
				or st = status_denied
				or st = status_discarded
				or st = status_expired
		end

	set_status (st: INTEGER)
		require
			is_valid_status: is_valid_status (st)
		do
			status := st
		ensure
			is_valid_status (status)
		end

	set_user_id (uid: like user_id)
		do
			user_id := uid
		end


end
