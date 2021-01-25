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
			trial_period_in_days := default_trial_period_in_days -- Default
			trial_max_period_in_days := 0
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

	has_price: BOOLEAN
			-- Has a price (as opposed to free).

	installations_limit: NATURAL
			-- Maximum number of installation for the same plan.
			-- `0` means no limit

	platforms_limit: NATURAL
			-- Maximum number of different platforms for the same plan.
			-- `0` means no limit

	concurrent_sessions_limit: NATURAL
			-- Maximum number of concurrent sessions for the same plan.
			-- `0` means no limit

	usage_limitations_data: detachable READABLE_STRING_8
			-- Usage limitations for current plan, mostly related to IDE tools and services.

	additional_data: detachable STRING_TABLE [detachable READABLE_STRING_GENERAL]
			-- Other data not (yet) mapped to any specific attribute.

feature -- Constant

	default_trial_period_in_days: NATURAL = 30

feature -- Access: private

	heartbeat: NATURAL
			-- Delay between each ping in seconds
			-- `0` means no constraint.

	weight: INTEGER
			-- Weight of Current plan among other plans
			-- used to sort list of plans.

	trial_period_in_days: NATURAL assign set_trial_period_in_days
			-- Trial period in days.

	trial_max_period_in_days: NATURAL assign set_trial_max_period_in_days
			-- Max trial period in days.

	data: detachable IMMUTABLE_STRING_32
		local
			s: STRING_32
		do
			create s.make (50)
			s.append ("install.limit="); s.append_natural_32 (installations_limit)
			s.append (";platforms.limit="); s.append_natural_32 (platforms_limit)
			s.append (";session.limit="); s.append_natural_32 (concurrent_sessions_limit)
			s.append (";session.heartbeat="); s.append_natural_32 (heartbeat)
			s.append (";order.weight="); s.append_integer (weight)
			s.append (";trial.days="); s.append_natural_32 (trial_period_in_days)
			s.append (";trial.max_days="); s.append_natural_32 (trial_max_period_in_days)
			s.append (";price=")
			if has_price then
				s.append ("yes")
			else
				s.append ("no")
			end
			s.append (";public=")
			if is_public then
				s.append ("yes")
			else
				s.append ("no")
			end
			if attached additional_data as o then
				across
					o as ic
				loop
					s.append (";")
					s.append (ic.key)
					s.append ("=")
					if attached ic.item as v then
						s.append (v)
					end
				end
			end
			create Result.make_from_string_32 (s)
		end

	data_names: ITERABLE [READABLE_STRING_GENERAL]
		do
			Result := <<
					"install.limit", "platforms.limit", "session.limit",
					"platforms.heartbeat",
					"order.weight",
					"trial.days", "trial.max_days",
					"price", "public"
				>>
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
			sess,inst,platfs,l_heartbeat, l_trial_days, l_max_trial_days: NATURAL
			l_weight: INTEGER
			s,k,v: READABLE_STRING_GENERAL
			p: INTEGER
		do
			sess := 0
			inst := 0
			platfs := 0
			l_heartbeat := 0
			l_weight := 0
			l_trial_days := 0
			l_max_trial_days := 0
			additional_data := Void
			if a_data /= Void then
				across
					a_data.split (';') as ic
				loop
					s := ic.item
					p := s.index_of ('=', 1)
					if p = 0 then
							-- Skip ...
					else
						k := s.head (p - 1)
						v := s.substring (p + 1, s.count)
						if k.starts_with ("install.limit") then
							inst := v.to_natural
						elseif s.starts_with ("platforms.limit") then
							platfs := v.to_natural
						elseif s.starts_with ("session.limit") then
							sess := v.to_natural
						elseif s.starts_with ("session.heartbeat") then
							l_heartbeat := v.to_natural
						elseif s.starts_with ("order.weight") then
							l_weight := v.to_integer
						elseif s.starts_with ("trial.days") then
							l_trial_days := v.to_natural
						elseif s.starts_with ("trial.max_days") then
							l_max_trial_days := v.to_natural
						elseif s.starts_with ("price") then
							has_price := v.is_case_insensitive_equal ("yes")
						elseif s.starts_with ("public") then
							is_public := v.is_case_insensitive_equal ("yes")
						else
							record_additional_data (v, k)
						end
					end
				end
			end
			installations_limit := inst
			platforms_limit := platfs
			concurrent_sessions_limit := sess
			heartbeat := l_heartbeat
			if l_trial_days = 0 then
				l_trial_days := default_trial_period_in_days
			end
			trial_period_in_days := l_trial_days
			if l_max_trial_days > l_trial_days then
				trial_max_period_in_days := l_max_trial_days
			end
			weight := l_weight
		end

	record_additional_data (V, K: READABLE_STRING_GENERAL)
		local
			l_others: like additional_data
		do
			l_others := additional_data
			if l_others = Void then
				create l_others.make_caseless (1)
				additional_data := l_others
			end
			l_others.force (v, k)
		end

	set_trial_period_in_days (n: NATURAL)
		do
			trial_period_in_days := n
		end

	set_trial_max_period_in_days (n: NATURAL)
		do
			trial_max_period_in_days := n
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

	set_usage_limitations_data (s: detachable READABLE_STRING_GENERAL)
		do
			if s /= Void then
				usage_limitations_data := {UTF_CONVERTER}.utf_32_string_to_utf_8_string_8 (s)
			else
				usage_limitations_data := Void
			end
		end

feature {CMS_STORAGE_SQL_I} -- Element change		

	update_id (a_id: like id)
		do
			id := a_id
		end

end
