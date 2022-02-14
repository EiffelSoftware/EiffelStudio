note
	description: "Summary description for {ES_CLOUD_SESSION}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ES_CLOUD_SESSION

create
	make

feature {NONE} -- Initialization

	make (a_user: ES_CLOUD_USER; a_installation_id, a_session_id: READABLE_STRING_GENERAL; a_first: detachable DATE_TIME)
		local
			d: DATE_TIME
		do
			user := a_user
			create id.make_from_string_general (a_session_id)
			create installation_id.make_from_string_general (a_installation_id)
			d := a_first
			if d = Void then
				create d.make_now_utc
			end
			first_date := d
			last_date := d
		end

--	make_new (a_user: ES_CLOUD_USER; a_installation_id: READABLE_STRING_GENERAL; a_first: detachable DATE_TIME)
--		local
--			d: DATE_TIME
--		do
--			user := a_user
--			create id.make_from_string_general ((create {UUID_GENERATOR}).generate_uuid.out)
--			create installation_id.make_from_string_general (a_installation_id)
--			d := a_first
--			if d = Void then
--				create d.make_now_utc
--			end
--			first_date := d
--			last_date := d
--		end

feature -- Access

	user: ES_CLOUD_USER

	id: IMMUTABLE_STRING_32

	installation_id: IMMUTABLE_STRING_32

	title: detachable READABLE_STRING_32

	first_date: DATE_TIME
			-- Beginning time of the session (UTC)

	last_date: DATE_TIME
			-- Time of last know access "ping" (UTC).

	state: INTEGER
			-- State of the session.

	data: detachable READABLE_STRING_32
			-- Optional data (could be JSON content), mostly for debugging.

	data_item (a_name: READABLE_STRING_GENERAL): detachable READABLE_STRING_32
		local
			jp: JSON_PARSER
		do
			if attached data as l_data then
				create jp.make
				jp.parse_string (l_data)
				if
					attached jp.parsed_json_object as jo and then
					attached {JSON_STRING} (jo / a_name) as jv
				then
					Result := jv.unescaped_string_32
				end
			end
		end

	remote_address: detachable READABLE_STRING_32
		do
			Result := data_item ("remote_addr")
		end

feature -- Element change

	set_last_date (dt: detachable like last_date)
		require
			first_set: first_date /= Void
			last_after_first: dt /= Void implies dt >= first_date
		do
			if dt /= Void then
				last_date := dt
			else
				-- Keep previous value
			end
		end

	set_title (a_title: detachable READABLE_STRING_32)
		do
			title := a_title
		end

	set_state (a_state: INTEGER)
		require
			valid_state: is_valid_state (a_state)
		do
			state := a_state
		end

	set_data (a_data: detachable READABLE_STRING_32)
		do
			data := a_data
		end

	pause
		do
			set_state (state_paused_id)
		end

	resume
		do
			set_state (state_normal_id)
			create last_date.make_now_utc
		end

	stop
		do
			set_state (state_ended_id)
			create last_date.make_now_utc
		end

feature -- state

	is_valid_state (a_state: INTEGER): BOOLEAN
		do
			Result := 	a_state = state_normal_id
					or 	a_state = state_paused_id
					or 	a_state = state_ended_id
		end

	state_normal_id: INTEGER = 0

	state_paused_id: INTEGER = 1

	state_ended_id: INTEGER = 2

	same_as (other: ES_CLOUD_SESSION): BOOLEAN
		do
			Result := id.same_string (other.id) and then
				installation_id.same_string (other.installation_id) and then
				first_date.is_equal (other.first_date) and then
				state = other.state
		end

feature -- Status report

	is_active: BOOLEAN
		do
			Result := not is_ended --and not is_expired
		end

	is_expired (api: ES_CLOUD_API): BOOLEAN
		local
			now: DATE_TIME
			d: DATE_TIME_DURATION
		do
			if is_ended then
				Result := True
			else
				create now.make_now_utc
				check valid_first_date: now >= first_date end
				create d.make (0,0,0, 0, api.config.session_expiration_delay, 0)
				if attached last_date as a then
					Result := now > (a + d)
				else
					Result := now > (first_date + d)
				end
			end
		end

	is_ended: BOOLEAN
		do
			Result := state = state_ended_id
		end

	is_paused: BOOLEAN
		do
			Result := state = state_paused_id
		end

end
