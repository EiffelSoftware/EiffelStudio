note
	description: "Summary description for {ARTICLE}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class ARTICLE

create
	make

feature {NONE} -- Initialization

	make (a_title: STRING)
		do
			title := a_title
		end

feature -- Access

  title: STRING

  page_count: INTEGER

  published: BOOLEAN

feature -- Element change

	set_page_count (nb: INTEGER)
		do
			page_count := nb
		end

	mark_published
		do
			published := True
		end

end
