note
	description: "Object that represent a report interaction"
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

	report: ESA_REPORT
			-- Associated report.

	private: BOOLEAN
			-- Is the interaction private?

	contact: detachable ESA_USER
			-- User

	content: detachable READABLE_STRING_32
			-- Interaction content.

	content_encoded: detachable READABLE_STRING_32
			--

	attachments: detachable LIST [ESA_REPORT_ATTACHMENT]
			-- associated attachments.

	date: detachable DATE_TIME
			-- interaction date.

	status: detachable STRING
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
		do
			content := t
			if attached t as l_t then
				content_encoded := json_encode (l_t)
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
