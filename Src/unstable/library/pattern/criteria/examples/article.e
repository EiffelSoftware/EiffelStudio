note
	description: "Summary description for {ARTICLE}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class ARTICLE

inherit
	DEBUG_OUTPUT

create
	make

feature {NONE} -- Initialization

	make (a_title: STRING)
		do
			title := a_title
		end

feature -- Access

	title: STRING

	description: detachable STRING

	content: detachable STRING

	page_count: INTEGER

	published: BOOLEAN

feature -- Element change

	set_description (s: detachable STRING)
		do
			description := s
		end

	set_content (s: detachable STRING)
		do
			content := s
		end

	set_page_count (nb: INTEGER)
		do
			page_count := nb
		end

	mark_published
		do
			published := True
		end

feature -- Status report

	debug_output: STRING
			-- String that should be displayed in debugger to represent `Current'.
		do
			create Result.make (10)
			Result.append (title)
		end

end
