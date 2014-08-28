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

	id: INTEGER
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

feature -- Conversion

	to_html (a_theme: WSF_THEME): STRING_8
		do
			Result := "<div class=%"log " + category + " " + level_name + "%" id=%"log-" + id.out + "%">"
			Result.append ("<div class=%"inner%">")
			Result.append (message)
			if attached info as l_info then
				Result.append ("<br/><strong>Information:</strong> ")
				Result.append (l_info)
			end
			if attached link as lnk then
				Result.append ("<br/><strong>Associated link:</strong> ")
				Result.append (a_theme.link (lnk.title, lnk.location, lnk.options))
			end
			Result.append ("</div>")
			Result.append ("<div class=%"description%">")
			Result.append ("(date: " + date.year.out + "/" + date.month.out + "/" + date.day.out + ")")
			Result.append ("</div>")

			Result.append ("</div>")
		end

feature -- Constants

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
		end

	level_emergency: INTEGER = 1
	level_alert: INTEGER = 2
	level_critical: INTEGER = 3
	level_error: INTEGER = 4
	level_warning: INTEGER = 5
	level_notice: INTEGER = 6
	level_info: INTEGER = 7
	level_debug: INTEGER = 8



end
