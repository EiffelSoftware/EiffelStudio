note
	description: "Summary description for {CMS_LOG}."
	date: "$Date$"
	revision: "$Revision$"

class
	CMS_LOG

create
	make

feature {NONE} -- Initialization

	make (a_category: like category; a_message: like message; a_level: like level; a_date: detachable like date)
		do
			category := a_category
			message := a_message
			set_level (a_level)
			if a_date = Void then
				create date.make_now_utc
			else
				date := a_date
			end
		end

	 make_with_id (a_id: like id; a_category: like category; a_message: like message; a_level: like level; a_date: detachable like date)
		do
			id := a_id
			make (a_category, a_message, a_level, a_date)
		end

feature -- Access

	id: INTEGER_64
			-- Unique identifier of Current.

	category: READABLE_STRING_8
			-- Associated title (optional).

	message: READABLE_STRING_8
			-- Log message

	level: INTEGER
			-- Severity level

	level_name: STRING
		do
			Result := level_to_string (level)
		end

	info: detachable READABLE_STRING_8

	link: detachable CMS_LINK

	date: DATE_TIME

feature -- status report

	has_id: BOOLEAN
		do
			Result := id > 0
		end

feature -- Change

	set_id (a_id: like id)
		require
			not has_id
		do
			id := a_id
		end

	set_level (a_level: like level)
		do
			if a_level = 0 then
				level := level_notice
			else
				level := a_level
			end
		end

	set_link (lnk: like link)
		do
			link := lnk
		end

	set_info (inf: like info)
		do
			info := inf
		end

feature -- Constants

	level_from_string (s: READABLE_STRING_GENERAL): INTEGER
		do
			if s.is_case_insensitive_equal ("emergency") then
				Result := level_emergency
			elseif s.is_case_insensitive_equal ("alert") then
				Result := level_alert
			elseif s.is_case_insensitive_equal ("critical") then
				Result := level_critical
			elseif s.is_case_insensitive_equal ("error") then
				Result := level_error
			elseif s.is_case_insensitive_equal ("warning") then
				Result := level_warning
			elseif s.is_case_insensitive_equal ("notice") then
				Result := level_notice
			elseif s.is_case_insensitive_equal ("info") then
				Result := level_info
			elseif s.is_case_insensitive_equal ("debug") then
				Result := level_debug
			else
				Result := s.substring (6, s.count).to_integer
			end
		ensure
			instance_free: class
		end

	level_to_string (a_level: INTEGER): STRING
		do
			inspect a_level
			when level_emergency then
				Result := "emergency"
			when level_alert then
				Result := "alert"
			when level_critical then
				Result := "critical"
			when level_error then
				Result := "error"
			when level_warning then
				Result := "warning"
			when level_notice then
				Result := "notice"
			when level_info then
				Result := "info"
			when level_debug then
				Result := "debug"
			else
				Result := "level-" + a_level.out
			end
		ensure
			instance_free: class
		end

	level_emergency: INTEGER = 1
	level_alert: INTEGER = 2
	level_critical: INTEGER = 3
	level_error: INTEGER = 4
	level_warning: INTEGER = 5
	level_notice: INTEGER = 6
	level_info: INTEGER = 7
	level_debug: INTEGER = 8
	

note
	copyright: "2011-2018, Javier Velilla, Jocelyn Fiat, Eiffel Software and others"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
end
