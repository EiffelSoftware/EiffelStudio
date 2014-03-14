note
	description: "Summary description for {REPORT_INTERACTION}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ESA_REPORT_INTERACTION

inherit
	STRING_HELPER

create
	make

feature {NONE} -- Initialization

	make (a_id: INTEGER; a_report: ESA_REPORT; a_private: BOOLEAN)
		do
			id := a_id
			report := a_report
			private := a_private
		end

feature -- Access

	id: INTEGER
	 	-- Interaction IS

	report: ESA_REPORT

	private: BOOLEAN

	contact: detachable ESA_USER

	content: detachable READABLE_STRING_32

	content_encoded: detachable READABLE_STRING_32

	attachments: detachable LIST [ESA_REPORT_ATTACHMENT]

	date: detachable DATE_TIME
		-- interaction date

	status: detachable STRING

feature -- Element change

	set_contact (u: like contact)
		do
			contact := u
		end

	set_content (t: like content)
		do
			content := t
			if attached t as l_t then
				content_encoded := json_encode (l_t)
			end
		end

	set_attachments (v: like attachments)
		do
			attachments := v
		end

	set_date (a_date: like date)
		do
			date := a_date
		end

	set_status (a_status: like status)
		do
			status := a_status
		end

	set_private (a_private: like private)
		do
			private := a_private
		end

feature -- Output

	string_8: STRING_8
		do
			create Result.make_from_string ("(" + id.out + ")")
			Result.append (" #" + report.number.out)
			if attached contact as u then
				Result.append (" by " + u.name)
			end
			if private then
				Result.append (" [Private]")
			end
			if attached content as t then
				Result.append ("%N")
				Result.append (create {STRING_8}.make_filled ('-', 78))
				Result.append ("%N")
				Result.append (indented_text ("%T", t.as_string_8))
				Result.append ("%N")
			end
			if attached attachments as ats then
				if ats.count > 1 then
					Result.append (ats.count.out + " attachment(s):%N")
				else
					Result.append ("One attachment:%N")
				end
				across
					ats as c
				loop
					Result.append ("%T- " + c.item.name + " (" + c.item.bytes_count.out + " bytes)%N")
				end
			end
		end
end
