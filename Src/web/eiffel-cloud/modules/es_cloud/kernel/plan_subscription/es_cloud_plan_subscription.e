note
	description: "Summary description for {ES_CLOUD_PLAN_SUBSCRIPTION}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	ES_CLOUD_PLAN_SUBSCRIPTION

feature -- Access

	entity_id: INTEGER_64
			-- Id of the user or organization entity.
		deferred
		end

	plan: ES_CLOUD_PLAN

	creation_date: DATE_TIME

	expiration_date: detachable DATE_TIME

	notes: detachable IMMUTABLE_STRING_32

feature -- Status report

	is_active: BOOLEAN
		do
			if attached expiration_date as l_exp_date then
				Result := l_exp_date >= (create {DATE_TIME}.make_now_utc)
			else
				Result := True
			end
		end

	is_expired: BOOLEAN
		do
			Result := not is_active
		end

	days_remaining: INTEGER
			-- Number of days remaining.
			-- Relevant only when `expiration_date` is set!
		local
			now: DATE_TIME
			secs: INTEGER_64
			is_neg: BOOLEAN
		do
			create now.make_now_utc
			if attached expiration_date as exp then
				secs := exp.relative_duration (now).seconds_count
				if secs < 0 then
					is_neg := True
					secs := -secs
				end
				Result := (secs // (60 * 60 * 24)).to_integer_32
				if is_neg then
					Result := - Result
				end
			else
				Result := 0
			end
		end

	concurrent_sessions_limit: NATURAL
		do
			Result := plan.concurrent_sessions_limit
		end

	installations_limit: NATURAL
		do
			Result := plan.installations_limit
		end

	platforms_limit: NATURAL
		do
			Result := plan.platforms_limit
		end

	heartbeat: NATURAL
		do
			Result := plan.heartbeat
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
