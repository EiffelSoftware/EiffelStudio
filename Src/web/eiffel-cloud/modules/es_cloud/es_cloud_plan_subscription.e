note
	description: "Summary description for {ES_CLOUD_PLAN_SUBSCRIPTION}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ES_CLOUD_PLAN_SUBSCRIPTION

create
	make

feature {NONE} -- Creation

	make (u: CMS_USER; a_plan: ES_CLOUD_PLAN)
		do
			user := u
			plan := a_plan
			create creation_date.make_now_utc
		end

feature -- Access

	user: CMS_USER

	plan: ES_CLOUD_PLAN

	creation_date: DATE_TIME

	expiration_date: detachable DATE_TIME

	notes: detachable IMMUTABLE_STRING_32

feature -- Status report

	is_active: BOOLEAN
		do
			Result := days_remaining /= 0
		end

	days_remaining: INTEGER
			-- Number of days remaining.
			-- -1 when no experiation dates is given ..
		local
			now: DATE_TIME
			dur: DATE_TIME_DURATION
			secs: INTEGER_64
		do
			create now.make_now_utc
			if attached expiration_date as exp then
				if now > exp then
					Result := 0
				else
					secs := exp.relative_duration (now).seconds_count
					Result := (secs // (60 * 60 * 24)).to_integer_32
				end
			else
				Result := -1
			end
		end

feature -- Element change

	set_plan (p: like plan)
		do
			plan := p
		end

	set_creation_date (dt: like creation_date)
		do
			creation_date := dt
		end

	set_expiration_date (dt: like expiration_date)
		do
			expiration_date := dt
		end

	set_notes (nt: detachable READABLE_STRING_GENERAL)
		do
			if nt = Void then
				notes := Void
			else
				create notes.make_from_string_general (nt)
			end
		end

end
