note
	description: "Summary description for {REPORT}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	REPORT

inherit
	STRING_HELPER

create
	make

feature {NONE} -- Initialization

	make (a_number: INTEGER; a_synopsis: READABLE_STRING_32; a_confidential: BOOLEAN)
		do
			number := a_number
			synopsis := a_synopsis
			confidential := a_confidential
		end

feature -- Access

	id: INTEGER

	number: INTEGER

	synopsis: READABLE_STRING_32

	confidential: BOOLEAN

	status: detachable REPORT_STATUS

	contact: detachable USER

	submission_date: detachable DATE_TIME

feature -- Optional

	release: detachable READABLE_STRING_32

	priority: detachable REPORT_PRIORITY

	severity: detachable REPORT_SEVERITY

	category: detachable REPORT_CATEGORY

	report_class: detachable REPORT_CLASS

	environment: detachable READABLE_STRING_32

	description: detachable READABLE_STRING_32

	to_reproduce: detachable READABLE_STRING_32

	description_encode: detachable READABLE_STRING_32
			-- workaround to support json encode

	to_reproduce_encode: detachable READABLE_STRING_32
			-- workaround to support json encode


	assigned: detachable USER


feature -- Element change

	set_number (v: like number)
		do
			number := v
		end

	set_synopsis (v: like synopsis)
		do
			synopsis := v
		end

	set_status (v: like status)
		do
			status := v
		end

	set_contact (v: like contact)
		do
			contact := v
		end

	set_release (v: like release)
		do
			release := v
		end

	set_priority (v: like priority)
		do
			priority := v
		end

	set_severity (v: like severity)
		do
			severity := v
		end

	set_report_class (v: like report_class)
		do
			report_class := v
		end

	set_environment (v: like environment)
		do
			if is_blank (v) then
				environment := Void
			else
				environment := v
			end
		end

	set_description (v: like description)
		do
			if is_blank (v) then
				description := Void
			else
				description := v
				if attached v as l_v then
					description_encode := json_encode (l_v)
				end
			end
		end

	set_to_reproduce (v: like to_reproduce)
		do
			if is_blank (v) then
				to_reproduce := Void
			else
				to_reproduce := v
				if attached v as l_v then
					to_reproduce_encode := json_encode (l_v)
				end
			end
		end

	set_submission_date (a_date: like submission_date)
		do
			submission_date := a_date
		end

	set_report_category (a_category: report_category)
		do
			category := a_category
		end

feature -- Filled data

	interactions: detachable LIST [REPORT_INTERACTION]

feature -- Fill

	set_interactions (v: like interactions)
		do
			interactions := v
		end


feature --JSON encode


feature -- Output

	string_8: STRING_8
		do
			create Result.make_from_string ("(" + id.out + ")")
			Result.append (" #" + number.out + ":")
			Result.append (synopsis.as_string_8)
			Result.append_character ('%N')
			if attached status as st then
				Result.append ("  " + st.string)
			end
			if attached priority as p then
				Result.append (" " + p.string)
			end
			if attached severity as s then
				Result.append (" " + s.string)
			end
			if attached report_class as c then
				Result.append (" " + c.string)
			end
			if confidential then
				Result.append (" Confidential")
			else
				Result.append (" Public")
			end
			if attached contact as u then
				Result.append ("%N  Reported by " + u.name)
			end
			if attached release as rel then
				Result.append ("%N  Release: " + rel)
			end
			if attached environment as env then
				Result.append ("%N  Environment: " + env)
			end
			if attached description as d then
				Result.append ("%N  Description:%N" + indented_text ("%T", d) + "%N")
			end
			if attached to_reproduce as t then
				Result.append ("%N  To-Reproduce:%N" + indented_text ("%T", t) + "%N")
			end

			if attached submission_date as l_date then
				Result.append ("%N Submission date:" + l_date.out)
			end

			if attached status as l_status then
				Result.append ("%N Status: " + l_status.string)
			end
		end

end
