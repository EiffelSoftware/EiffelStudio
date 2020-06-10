note
	description: "Object that represent a report interaction"
	date: "$Date$"
	revision: "$Revision$"

class
	REPORT_INTERACTION

inherit

	STRING_HELPER

create
	make

feature {NONE} -- Initialization

	make (a_id: INTEGER; a_report: REPORT; a_private: BOOLEAN)
			-- Create an object instance
			-- Set `id' to `a_id'
			-- Set `report' to `a_report'
			-- Set `private' to `a_private'.
		do
			id := a_id
			report := a_report
			private := a_private
		ensure
			id_set: id = a_id
			report_set: report = a_report
			private_set: private = a_private
		end

feature -- Access

	id: INTEGER
			-- Interaction id.

	report: REPORT
			-- Associated report.

	private: BOOLEAN
			-- Is the interaction private?

	contact: detachable USER
			-- User

	content: detachable READABLE_STRING_32
			-- Interaction content.

	content_truncated: detachable READABLE_STRING_32
			-- Truncated content to diplay an output truncated in the view.		

	content_encoded: detachable READABLE_STRING_32
			--

	attachments: detachable LIST [REPORT_ATTACHMENT]
			-- associated attachments.

	date: detachable DATE_TIME
			-- interaction date.

	date_output: detachable STRING
			-- formatted date as dd mmm yyyy.		

	status: detachable STRING_8
			-- assigned status.

feature -- Element change

	set_contact (u: like contact)
			-- Set `contact' to `u'.
		do
			contact := u
		ensure
			contact_set: contact = u
		end

	set_content (t: like content)
			-- Set `content' to `t'.
		local
			l_string: STRING_32
		do
			content := t
			if attached t as l_t then
				content_encoded := json_encode (l_t)
				if l_t.count > 1024 then
					l_string := l_t.head (1024)
					l_string.append_string ("%N....%N")
					l_string.append_string ("Output truncated, Click download to get the full message")
					content_truncated := l_string
				end
			end
		ensure
			content_set: content = t
		end

	set_attachments (v: like attachments)
			-- Set `attachments' to `v'.
		do
			attachments := v
		ensure
			attachments_set: attachments = v
		end

	set_date (a_date: like date)
			-- Set `date' to `a_date'.
		do
			date := a_date
			if a_date /= Void then
				date_output := a_date.formatted_out ("yyyy/[0]mm/[0]dd")
			end
		ensure
			date_set: date = a_date
		end

	set_status (a_status: like status)
			-- Set `status' to `a_status'.
		do
			status := a_status
		ensure
			status_set: status = a_status
		end

	set_private (a_private: like private)
			-- Set `private' to `a_private'.
		do
			private := a_private
		ensure
			private_set: private = a_private
		end

	set_id (a_id: like id)
			-- Set `id' to `a_id'.
		do
			id := a_id
		ensure
			id_set: id = a_id
		end

feature -- Output

	string_8: STRING_8
			-- String Represenation.
		do
			create Result.make_from_string ("(" + id.out + ")")
			Result.append (" #" + report.number.out)
			if attached contact as u then
				Result.append (" by " + {UTF_CONVERTER}.utf_32_string_to_utf_8_string_8 (u.name))
			end
			if private then
				Result.append (" [Private]")
			end
			if attached content as l_content then
				Result.append ("%N")
				Result.append (create {STRING_8}.make_filled ('-', 78))
				Result.append ("%N")
				Result.append (indented_text ("%T", {UTF_CONVERTER}.utf_32_string_to_utf_8_string_8 (l_content)))
				Result.append ("%N")
			end
			if attached attachments as ats then
				if ats.count > 1 then
					Result.append (ats.count.out + " attachment(s):%N")
				else
					-- Result.append ("One attachment:%N")
				end
				across
					ats as c
				loop
					Result.append ("%T- " + {UTF_CONVERTER}.utf_32_string_to_utf_8_string_8 (c.item.name) + " (" + c.item.bytes_count.out + " bytes)%N")
				end
			end
		end

end
