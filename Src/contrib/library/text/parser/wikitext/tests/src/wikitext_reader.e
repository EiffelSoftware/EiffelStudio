note
	description : "Objects that ..."
	author      : "$Author$"
	date        : "$Date$"
	revision    : "$Revision$"

class
	WIKITEXT_READER

create
	make

feature {NONE} -- Initialization

	make
			-- Initialize `Current'.
		local
			l_include_in_system: TUPLE [WIKI_NULL_VISITOR]
		do
--			read_folder ("data\eiffelstudio", "EiffelStudio")
			read_folder ("data\test", "Test")
			read_folder ("data\method", "Method")
		end

	read_folder (a_dir: STRING; a_name: STRING)
		local
			f: RAW_FILE
			fn: PATH
			wp: detachable WIKI_BOOK_PAGE
			wi: WIKI_INDEX
		do
			create fn.make_from_string (a_dir)
			fn := fn.extended ("book.index")
			create f.make_with_path (fn)
			if f.exists and f.is_readable then
				create wi.make (a_name, fn)
				wi.analyze
				if attached wi.book as wb then
					across
						wb.pages as c
					loop
						wp := c.item
						print ("[" + wp.key + "] ")
						print (wp.title)
						io.put_new_line
						print ("%Tfrom " + wp.src)
						io.put_new_line
					end
				end
			end
		end

feature -- Status

feature -- Access

feature -- Change

feature {NONE} -- Implementation

invariant
--	invariant_clause: True

note
	copyright: "2011-2012, Jocelyn Fiat"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Jocelyn Fiat
			Contact: http://about.jocelynfiat.net/
		]"
end
