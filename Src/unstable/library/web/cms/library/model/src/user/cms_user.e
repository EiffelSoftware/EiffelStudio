note
	description: "[
				Interface representing a USER in the CMS system.
			]"
	date: "$Date$"
	revision: "$Revision$"

class
	CMS_USER

inherit
	DEBUG_OUTPUT

create
	make,
	make_with_id -- MAYBE: export to CMS_STORAGE

feature {NONE} -- Initialization

	make (a_name: READABLE_STRING_GENERAL)
			-- Create an object with name `a_name'.
		require
			a_name_not_empty: not a_name.is_whitespace
		do
			if attached {READABLE_STRING_32} a_name as n32 then
				name := n32
			else
				name := a_name.to_string_32
			end
			initialize
		ensure
			name_set: name.same_string_general (a_name)
			status_not_active: status = not_active
		end

	make_with_id (a_id: INTEGER_64)
		require
			a_id_valid: a_id > 0
		do
			id := a_id
			name := {STRING_32} ""
			initialize
		ensure
			id_set: id = a_id
			status_not_active: status = not_active
		end

	initialize
		do
			create creation_date.make_now_utc
			mark_not_active
		end

feature -- Access

	id: INTEGER_64
			-- Unique id.

	name: READABLE_STRING_32
			-- User name.

	profile_name: detachable READABLE_STRING_32
			-- Optional profile name.

	password: detachable READABLE_STRING_32
			-- User password (plain text password).

	hashed_password: detachable READABLE_STRING_8
			-- Hashed user password.

	email: detachable READABLE_STRING_8
			-- User email.

	creation_date: DATE_TIME
			-- Creation date.

	last_login_date: detachable DATE_TIME
			-- User last login.

	status: INTEGER
			-- Associated status for the current user.
			-- default:	not_active
			--			active
			--			trashed

feature -- Access: helper

	utf_8_name: STRING_8
			-- UTF-8 version of `name'.
		local
			utf: UTF_CONVERTER
		do
			Result := utf.utf_32_string_to_utf_8_string_8 (name)
		end

feature -- Roles

	roles: detachable LIST [CMS_USER_ROLE]
			-- If set, list of roles for current user.			

feature -- Status report

	has_id: BOOLEAN
		do
			Result := id > 0
		end

	has_email: BOOLEAN
		do
			Result := attached email as e and then not e.is_empty
		end

	debug_output: STRING_32
		do
			create Result.make_from_string (name)
			if has_id then
				Result.append_character (' ')
				Result.append_character ('<')
				Result.append_integer_64 (id)
				Result.append_character ('>')
			end
		end

	same_as (other: detachable CMS_USER): BOOLEAN
			-- Is Current same as `other'?
		do
			Result := other /= Void and then id = other.id
		end

	is_active: BOOLEAN
			-- is the current user active?
		do
			Result := status = {CMS_USER}.active
		end

feature -- Change element

	set_id (a_id: like id)
			-- Set `id' with `a_id'.
		do
			id := a_id
		ensure
			id_set: id = a_id
		end

	set_name (n: like name)
			-- Set `name' with `n'.
		do
			name := n
		ensure
			name_set: name = n
		end

	set_profile_name (pn: like profile_name)
			-- Set `profile_name' with `pn'.
		do
			profile_name := pn
		ensure
			profile_name_set: profile_name = pn
		end

	set_password (a_password: like password)
			-- Set `password' with `a_password'.
		do
			password := a_password
			hashed_password := Void
		ensure
			password_set: password = a_password
			hashed_password_void: hashed_password = Void
		end

	set_hashed_password (a_hashed_password: like hashed_password)
			-- Set `hashed_password' with `a_hashed_password'.
		do
			hashed_password := a_hashed_password
			password := Void
		ensure
			password_void: password = Void
			hashed_password_set: hashed_password = a_hashed_password
		end

	set_email (a_email: like email)
			-- Set `email' with `a_email'.
		do
			email := a_email
		ensure
			email_set: email = a_email
		end

	set_creation_date (dt: like creation_date)
		do
			creation_date := dt
		end

	set_last_login_date (dt: like last_login_date)
		do
			last_login_date := dt
		end

	set_last_login_date_now
		do
			set_last_login_date (create {DATE_TIME}.make_now_utc)
		end

feature -- Element change: roles

	set_roles (lst: like roles)
			-- Set `roles' to `lst'.
		do
			roles := lst
		end

feature -- Status change		

	mark_not_active
			-- Set status to not_active
		do
			set_status (not_active)
		ensure
			status_not_active: status = not_active
		end

	mark_active
			-- Set status to active.
		do
			set_status (active)
		ensure
			status_active: status = active
		end

	mark_trashed
			-- Set status to trashed.
		do
			set_status (trashed)
		ensure
			status_trash: status = trashed
		end

	set_status (a_status: like status)
			-- Assign `status' with `a_status'.
		do
			status := a_status
		ensure
			status_set:  status = a_status
		end

feature -- User status

	not_active: INTEGER = 0
			-- The user is not active.

	active: INTEGER = 1
			-- The user is active

	Trashed: INTEGER = -1
			-- The user is trashed (soft delete), ready to be deleted/destroyed from storage.

invariant

	id_or_name_set: id > 0 or else not name.is_whitespace

note
	copyright: "2011-2017, Javier Velilla, Jocelyn Fiat, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
end
