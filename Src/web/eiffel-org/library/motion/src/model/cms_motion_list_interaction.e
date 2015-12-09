note
	description: "Summary description for {WISH_LIST_INTERACTION}."
	date: "$Date$"
	revision: "$Revision$"

class
	CMS_MOTION_LIST_INTERACTION

inherit

	CMS_IDEABLE

create
	make_empty

feature  {NONE} -- Initialization

	make_empty
		do

		end

feature -- Access

	id: INTEGER_64
			-- Interaction id.

	wish_id: INTEGER_64
			-- Associated wish item.

	contact: detachable CMS_USER
			-- User

	content: detachable READABLE_STRING_32
			-- Interaction content.

	content_encoded: detachable READABLE_STRING_32
			--

	attachments: detachable LIST [CMS_MOTION_FILE]
			-- associated attachments.

	date: detachable DATE_TIME
			-- interaction date.

	date_output: detachable STRING
			-- formatted date as dd mmm yyyy.		


feature -- Element change

	set_id (a_id: INTEGER_64)
		do
			id := a_id
		end

	set_wish_id (a_id: INTEGER_64)
		do
			wish_id := a_id
		ensure
			wish_id_set: wish_id = a_id
		end

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


feature -- Output

	string_8: STRING_8
			-- String Represenation.
		do
			create Result.make_from_string ("(" + id.out + ")")
--			Result.append (" #" + report.number.out)
--			if attached contact as u then
--				Result.append (" by " + u.name)
--			end
--			if private then
--				Result.append (" [Private]")
--			end
--			if attached content as t then
--				Result.append ("%N")
--				Result.append (create {STRING_8}.make_filled ('-', 78))
--				Result.append ("%N")
--				Result.append (indented_text ("%T", t.as_string_8))
--				Result.append ("%N")
--			end
--			if attached attachments as ats then
--				if ats.count > 1 then
--					Result.append (ats.count.out + " attachment(s):%N")
--				else
--					-- Result.append ("One attachment:%N")
--				end
--				across
--					ats as c
--				loop
--					Result.append ("%T- " + c.item.name + " (" + c.item.bytes_count.out + " bytes)%N")
--				end
--			end
		end

end
