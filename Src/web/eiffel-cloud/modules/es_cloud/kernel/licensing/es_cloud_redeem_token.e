note
	description: "A redeem token, is a token to redeem for a real licence."
	date: "$Date$"
	revision: "$Revision$"

class
	ES_CLOUD_REDEEM_TOKEN

create
	make

feature {NONE} -- Creation

	make (a_name: READABLE_STRING_8; a_plan_name: READABLE_STRING_8; a_version: detachable READABLE_STRING_8)
		do
			create name.make_from_string (a_name)
			plan_name := a_plan_name
			set_version (a_version)
		end

feature -- Access

	name: IMMUTABLE_STRING_8

	plan_name: like {ES_CLOUD_PLAN}.name

	version: detachable IMMUTABLE_STRING_32
			-- Limited to `version` of the product, otherwise no limit.

	origin: detachable IMMUTABLE_STRING_32
			-- Notes about the origin (seller, ...)

	notes: detachable IMMUTABLE_STRING_32
			-- Notes about that redeem token

feature -- Access: license			

	license_key: detachable IMMUTABLE_STRING_32
			-- Associated license key, if already redeemed

	redeem_date: detachable DATE_TIME
			-- UTC

feature -- Query

	is_redeemed: BOOLEAN
		do
			Result := attached license_key as k and then not k.is_whitespace
		end

feature -- Element change

	assign_license (a_license: ES_CLOUD_LICENSE)
		require
			not is_redeemed
		do
			license_key := a_license.key
			create redeem_date.make_now_utc
		end

	set_license_key (a_license_key: detachable READABLE_STRING_GENERAL; dt: like redeem_date)
		require
			license_key = Void
		do
			if a_license_key = Void or else a_license_key.is_whitespace then
				license_key := Void
				redeem_date := Void
			else
				create license_key.make_from_string_general (a_license_key)
				if dt = Void then
					check has_date: False end
					create redeem_date.make_now_utc
				else
					redeem_date := dt
				end
			end
		end

	reset_license
		require
			is_redeemed
		do
			license_key := Void
			redeem_date := Void
		end

	set_version (s: detachable READABLE_STRING_8)
		do
			if s = Void or else s.is_whitespace then
				version := Void
			else
				create version.make_from_string (s)
			end
		end

	set_origin (v: detachable READABLE_STRING_GENERAL)
		do
			if v = Void or else v.is_whitespace then
				origin := Void
			else
				create origin.make_from_string_general (v)
			end
		end

	set_notes (a_notes: detachable READABLE_STRING_GENERAL)
		do
			if a_notes = Void or else a_notes.is_whitespace then
				notes := Void
			else
				create notes.make_from_string_general (a_notes)
			end
		end

end
