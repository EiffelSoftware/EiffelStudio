note
	description: "Summary description for {CMS_MOTION_LIST}."
	date: "$Date$"
	revision: "$Revision$"

class
	CMS_MOTION_LIST

inherit

	STRING_HELPER

create
	make_empty

feature {NONE} -- Initialization

	make_empty
		do
			set_synopsis ("")
			mark_motion
		end

feature -- Access

	id: INTEGER_64
			-- Unique id.

	synopsis: READABLE_STRING_32
			-- Motion synopsis.

	status: detachable CMS_MOTION_LIST_STATUS
			-- Motion list status.

	contact: detachable CMS_USER
			-- User who submit the motion

	submission_date: detachable DATE_TIME
			-- Submission date.

	submission_date_output: detachable STRING
			-- formatted date as dd mmm yyyy.

	votes: INTEGER
			-- Votes.		

	has_id: BOOLEAN
			-- Has unique identifier?
		do
			Result := id > 0
		end

	type: STRING
			-- motion, motion category, motion status.
			-- by default wish.	

feature -- Optional

	category: detachable CMS_MOTION_LIST_CATEGORY
			-- Assigned category.

	description: detachable READABLE_STRING_32
			-- Problem description.


feature -- Element change

	mark_motion
		do
			type := "motion"
		ensure
			type_set: type.same_string("motion")
		end

	mark_motion_category
		do
			type.append (" category")
		ensure
			type_set: type.ends_with (" category")
		end

	mark_wish_status
		do
			type.append (" status")
		ensure
			type_set: type.ends_with (" status")
		end

	set_id (a_id: like id)
		do
			id := a_id
		ensure
			id_set: id = a_id
		end

	set_synopsis (v: like synopsis)
			-- Set `synopsis' to `v'.
		do
			synopsis := v
		ensure
			synopsis_set: synopsis = v
		end

	set_status (v: like status)
			-- Set `status' to `v'.
		do
			status := v
		ensure
			status_set: status = v
		end

	set_contact (v: like contact)
			-- Set `contact' to `v'.
		do
			contact := v
		ensure
			contact_set: contact = v
		end

	set_description (v: like description)
			-- Set `description' to `v'
		do
			if is_blank (v) then
				description := Void
			else
				description := v
			end
		end

	set_submission_date (a_date: like submission_date)
			-- Set `submission_date' to `a_date'.
		do
			submission_date := a_date
			if a_date /= Void then
				submission_date_output := a_date.formatted_out ("yyyy/[0]mm/[0]dd")
			end
		ensure
			submission_date_set: submission_date = a_date
		end

	set_wish_list_category (a_category: CMS_MOTION_LIST_CATEGORY)
			-- Set `category' to `a_category'.
		do
			category := a_category
		ensure
			category_set: category = a_category
		end

	set_votes (a_vote: INTEGER)
			-- Set `votes' to `a_vote'.
		do
			votes := a_vote
		ensure
			vote_set: votes = a_vote
		end

	set_type (v: like type)
			-- Set `type' to `v'.
		do
			type := v
		ensure
			type_set: type = v
		end

feature -- Filled data

	interactions: detachable LIST [CMS_MOTION_LIST_INTERACTION]
			-- Motion interactions

	attachments: detachable LIST [CMS_MOTION_FILE]
			-- Possible list of attached files		


feature -- Fill

	set_interactions (v: like interactions)
			-- Set `interactions' to `v'.
		do
			interactions := v
		ensure
			interactions_set: interactions = v
		end

	set_attachments (v: like attachments)
			-- Set `attachments' to `v'.
		do
			attachments := v
		ensure
			attachments_set: attachments = v
		end

feature -- Output

	string_8: STRING_8
			-- String representation.
		do
			create Result.make_from_string ("%N(" + id.out + ")")
			Result.append (synopsis.as_string_8)
			Result.append_character ('%N')
			if attached status as st then
				Result.append ("  " + st.string)
			end
			if attached contact as u then
				Result.append ("%N  Reported by " + u.name)
			end
			if attached description as d then
				Result.append ("%N  Description:%N" + d + "%N")
			end
			if attached submission_date as l_date then
				Result.append ("%N Submission date:" + l_date.out)
			end
			if attached status as l_status then
				Result.append ("%N Status: " + l_status.string)
			end
		end

end
