note
	description: "Summary description for {REPOSITORY_LOG_REVIEW}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	REPOSITORY_LOG_REVIEW

create
	make

feature {NONE} -- Initialization

	make
		do
			create {ARRAYED_LIST [like reviews.item]} reviews.make (10)
		end

feature -- Access

	reviews: LIST [like new_user_review]

	user_review_tuple (a_user: STRING; a_status: detachable STRING): detachable like new_user_review_tuple
		do
		end

	new_user_review_tuple (a_user: STRING): TUPLE [user: STRING; status: STRING; comment: detachable STRING; is_remote: BOOLEAN]
		do
			Result := [a_user, "", Void, False]
		end

	user_entries (a_user: STRING; a_status: detachable STRING): LIST [like new_user_review]
		local
			l_reviews: like reviews
			e: like new_user_review
		do
			create {ARRAYED_LIST [like new_user_review]} Result.make (1)
			l_reviews := reviews
			from
				l_reviews.start
			until
				l_reviews.after
			loop
				e := l_reviews.item
				if e.user.is_case_insensitive_equal (a_user) then
					if a_status = Void or else e.is_status (a_status) then
						Result.force (e)
					end
				end
				l_reviews.forth
			end
		end

	user_local_entries (a_user: STRING; a_status: detachable STRING): LIST [like new_user_review]
		local
			l_reviews: like reviews
			e: like new_user_review
		do
			create {ARRAYED_LIST [like new_user_review]} Result.make (1)
			l_reviews := reviews
			from
				l_reviews.start
			until
				l_reviews.after
			loop
				e := l_reviews.item
				if
					not e.is_remote and then
					e.user.is_case_insensitive_equal (a_user)
				then
					if a_status = Void or else e.is_status (a_status) then
						Result.force (e)
					end
				end
				l_reviews.forth
			end
		end

	user_review (a_user: STRING; a_status: detachable STRING): detachable like new_user_review
		local
			l_reviews: like reviews
		do
			l_reviews := reviews
			from
				l_reviews.start
			until
				l_reviews.after or Result /= Void
			loop
				Result := l_reviews.item
				if Result.user.is_case_insensitive_equal (a_user) then
					if a_status /= Void and then not a_status.is_case_insensitive_equal (Result.status) then
						Result := Void
					end
				else
					Result := Void
				end
				l_reviews.forth
			end
		end

	new_user_review (a_user: STRING): REPOSITORY_LOG_REVIEW_ENTRY
		do
			create Result.make (a_user, "")
			reviews.extend (Result)
		end

feature -- Basic operations

	approve (a_user: STRING)
		local
			l_rdata: like {REPOSITORY_LOG_REVIEW}.user_review
		do
			l_rdata := user_review (a_user, Void)
			if l_rdata = Void then
				l_rdata := new_user_review (a_user)
			end
			l_rdata.approve
		end

	refuse (a_user: STRING)
		local
			l_rdata: like {REPOSITORY_LOG_REVIEW}.user_review
		do
			l_rdata := user_review (a_user, Void)
			if l_rdata = Void then
				l_rdata := new_user_review (a_user)
			end
			l_rdata.refuse
		end

	question (a_user: STRING; q: detachable STRING)
		local
			l_rdata: like {REPOSITORY_LOG_REVIEW}.user_review
		do
			l_rdata := user_review (a_user, {REPOSITORY_LOG_REVIEW_ENTRY}.status_question)
			if l_rdata = Void then
				l_rdata := new_user_review (a_user)
			end
			l_rdata.ask (q)
		end

	unapprove (a_user: STRING)
		do
			if attached user_review (a_user, {REPOSITORY_LOG_REVIEW_ENTRY}.status_approved) as l_rdata then
				check l_rdata.is_approved_status end
				l_rdata.discard
				reviews.prune (l_rdata)
			end
		end

	unrefuse (a_user: STRING)
		do
			if attached user_review (a_user, {REPOSITORY_LOG_REVIEW_ENTRY}.status_refused) as l_rdata then
				check l_rdata.is_refused_status end
				l_rdata.discard
				reviews.prune (l_rdata)
			end
		end

	unquestion (a_user: STRING)
		do
			if attached user_review (a_user, {REPOSITORY_LOG_REVIEW_ENTRY}.status_question) as l_rdata then
				check l_rdata.is_question_status end
				l_rdata.discard
				reviews.prune (l_rdata)
			end
		end

feature -- Status report

	stats: TUPLE [approved, refused, question: INTEGER]
		local
			n_refused: INTEGER
			n_approved: INTEGER
			n_question: INTEGER
			e: like user_review
		do
			if attached reviews as l_reviews then
				from
					l_reviews.start
				until
					l_reviews.after
				loop
					e := l_reviews.item
					if e.is_none_status then
					elseif e.is_approved_status then
						n_approved := n_approved + 1
					elseif e.is_refused_status then
						n_refused := n_refused + 1
					elseif e.is_question_status then
						n_question := n_question + 1
					end
					l_reviews.forth
				end
			end
			Result := [n_approved, n_refused, n_question]
		end

	has_approval: BOOLEAN
		local
			st: like stats
		do
			st := stats
			Result := st.approved > 0
		end

	has_refusal: BOOLEAN
		local
			st: like stats
		do
			st := stats
			Result := st.refused > 0
		end

	has_question: BOOLEAN
		local
			st: like stats
		do
			st := stats
			Result := st.question > 0
		end

end
