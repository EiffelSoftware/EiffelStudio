note
	description: "Summary description for {REPOSITORY_DATA_VIEW}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	REPOSITORY_DATA_VIEW

inherit
	HASHABLE

create
	make,
	make_with_filter

feature {NONE} -- Initialization

	make (a_repo: like repo)
		do
			repo := a_repo
		end

	make_with_filter (a_repo: like repo; a_filter: like filter)
		do
			make (a_repo)
			filter := a_filter
		end

feature -- Status report

	hash_code: INTEGER
			-- Hash code value
		do
			Result := repo.hash_code
		end

feature -- Access

	repo: REPOSITORY_DATA

	filter: detachable REPOSITORY_LOG_FILTER

feature -- Element change

	set_filter (v: like filter)
		do
			filter := v
		end

end
