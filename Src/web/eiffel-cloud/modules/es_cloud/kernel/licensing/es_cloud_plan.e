note
	description: "Summary description for {ES_CLOUD_PLAN}."
	date: "$Date$"
	revision: "$Revision$"

class
	ES_CLOUD_PLAN

create
	make,
	make_with_id_and_name

feature {NONE} -- Creation

	make (a_name: READABLE_STRING_8)
		do
			create name.make_from_string (a_name)
			trial_period_in_days := 15 -- Default
		end

	make_with_id_and_name (a_pid: INTEGER; a_name: READABLE_STRING_8)
		do
			id := a_pid
			make (a_name)
		end

feature -- Access

	has_id: BOOLEAN
		do
			Result := id > 0
		end

	id: INTEGER

	name: IMMUTABLE_STRING_8

	title: detachable IMMUTABLE_STRING_32

	description: detachable IMMUTABLE_STRING_32
			-- HTML description (could contain Unicode symbols)

	is_public: BOOLEAN

	installations_limit: NATURAL
			-- Maximum number of installation for the same plan.
			-- `0` means no limit

	concurrent_sessions_limit: NATURAL
			-- Maximum number of concurrent sessions for the same plan.
			-- `0` means no limit

feature -- Access: private

	heartbeat: NATURAL
			-- Delay between each ping in seconds
			-- `0` means no constraint.

	weight: INTEGER
			-- Weight of Current plan among other plans
			-- used to sort list of plans.

	trial_period_in_days: NATURAL assign set_trial_period_in_days
			-- Trial period in days.

	data: detachable IMMUTABLE_STRING_32
		local
			s: STRING_32
		do
			create s.make (50)
			s.append ("install.limit="); s.append_natural_32 (installations_limit)
			s.append (";session.limit="); s.append_natural_32 (concurrent_sessions_limit)
			s.append (";session.heartbeat="); s.append_natural_32 (heartbeat)
			s.append (";order.weight="); s.append_integer (weight)
			s.append (";trial.days="); s.append_natural_32 (trial_period_in_days)
			s.append (";public=")
			if is_public then
				s.append ("yes")
			else
				s.append ("no")
			end
			create Result.make_from_string_32 (s)
		end

feature -- Status report	

	same_plan (pl: detachable ES_CLOUD_PLAN): BOOLEAN
			-- Is Current same plan as `pl`?
		do
			if pl /= Void then
				if has_id then
					Result := id = pl.id
				else
					Result := name.same_string (pl.name)
				end
			end
		end

feature -- Query

	title_or_name: READABLE_STRING_32
		do
			if attached title as t then
				Result := t
			else
				Result := name.as_string_32
			end
		end

feature -- Element change

	set_data (a_data: detachable READABLE_STRING_GENERAL)
		local
			sess,inst,l_heartbeat, l_trial_days: NATURAL
			l_weight: INTEGER
			s: READABLE_STRING_GENERAL
		do
			sess := 0
			inst := 0
			l_heartbeat := 0
			l_weight := 0
			l_trial_days := 0
			if a_data /= Void then
				across
					a_data.split (';') as ic
				loop
					s := ic.item
					if s.starts_with ("install.limit=") then
						inst := s.substring (s.index_of ('=', 1) + 1, s.count).to_natural
					elseif s.starts_with ("session.limit=") then
						sess := s.substring (s.index_of ('=', 1) + 1, s.count).to_natural
					elseif s.starts_with ("session.heartbeat=") then
						l_heartbeat := s.substring (s.index_of ('=', 1) + 1, s.count).to_natural
					elseif s.starts_with ("order.weight=") then
						l_weight := s.substring (s.index_of ('=', 1) + 1, s.count).to_integer
					elseif s.starts_with ("trial.days=") then
						l_trial_days := s.substring (s.index_of ('=', 1) + 1, s.count).to_natural
					elseif s.starts_with ("public=") then
						s := s.substring (s.index_of ('=', 1) + 1, s.count)
						is_public := s.is_case_insensitive_equal ("yes")
					end
				end
			end
			installations_limit := inst
			concurrent_sessions_limit := sess
			heartbeat := l_heartbeat
			if l_trial_days = 0 then
				l_trial_days := 15
			end
			trial_period_in_days := l_trial_days
			weight := l_weight
		end

	set_trial_period_in_days (n: NATURAL)
		do
			trial_period_in_days := n
		end

	set_name (s: READABLE_STRING_8)
		do
			create name.make_from_string (s)
		end

	set_title (s: detachable READABLE_STRING_GENERAL)
		do
			if s = Void then
				title := Void
			else
				create title.make_from_string_general (s)
			end
		end

	set_description (d: detachable READABLE_STRING_GENERAL)
		do
			if d = Void then
				description := Void
			else
				create description.make_from_string_general (d)
			end
		end


feature {CMS_STORAGE_SQL_I} -- Element change		

	update_id (a_id: like id)
		do
			id := a_id
		end

end
