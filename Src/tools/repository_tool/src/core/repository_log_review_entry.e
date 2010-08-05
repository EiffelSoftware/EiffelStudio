note
	description: "Summary description for {REPOSITORY_LOG_REVIEW_ENTRY}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	REPOSITORY_LOG_REVIEW_ENTRY

create
	make

feature {NONE} -- Initialization

	make (a_user: like user; a_status: like status)
		do
			user := a_user
			status := a_status
		end

feature -- Access

	user: STRING
	status: STRING
	comment: detachable STRING assign set_comment
	is_remote: BOOLEAN assign set_is_remote

feature -- Element change

	set_status (a_status: like status)
		require
			is_valid_status: is_valid_status (a_status.as_lower)
		do
			status := a_status
			status.to_lower
		ensure
			is_valid_status: is_valid_status (status)
		end

	set_comment (a_comment: like comment)
		do
			comment := a_comment
		end

	set_is_remote (a_is_remote: like is_remote)
		do
			is_remote := a_is_remote
		end

feature -- Status change

	discard
		do
			status := status_none
			comment := Void
			is_remote := False
		end

	approve
		do
			 status := status_approved
			 is_remote := False
		end

	refuse
		do
			 status := status_refused
			 is_remote := False
		end

	ask (c: like comment)
		do
			status := status_question
			comment := c
			is_remote := False
		end

feature -- Status report

	is_valid_status (s: STRING): BOOLEAN
		do
			Result := s.same_string_general (s.as_lower)
			if s.same_string_general (status_none) then
			elseif s.same_string_general (status_approved) then
			elseif s.same_string_general (status_refused) then
			elseif s.same_string_general (status_question) then
			else
				Result := False
			end
		end

	is_status (s: STRING): BOOLEAN
		do
			Result := status.is_case_insensitive_equal (s)
		end

	is_none_status: BOOLEAN
		do
			Result := status.is_empty
		ensure
			result_valid: result implies status.same_string_general (status_none)
		end

	is_approved_status: BOOLEAN
		local
			s: like status
		do
			s := status
			Result := s.count = 3 and then s.item (1) = 'y' and then s.item (2) = 'e' and then s.item (3) = 's'
		ensure
			result_valid: result implies status.same_string_general (status_approved)
		end

	is_refused_status: BOOLEAN
		local
			s: like status
		do
			s := status
			Result := s.count = 2 and then s.item (1) = 'n' and then s.item (2) = 'o'
		ensure
			result_valid: result implies status.same_string_general (status_refused)
		end

	is_question_status: BOOLEAN
		local
			s: like status
		do
			s := status
			Result := s.count = 8 and then s.item (1) = 'q' and then s.same_string_general (status_question)
		ensure
			result_valid: result implies status.same_string_general (status_question)
		end

feature {REPOSITORY_LOG_REVIEW} -- Status value

	status_none: STRING = ""
	status_approved: STRING = "yes"
	status_refused: STRING = "no"
	status_question: STRING = "question"

invariant
	status_lowercase: status.as_lower.same_string_general (status)

end
