note
	description: "Wiki text from file."
	date: "$Date$"
	revision: "$Revision$"

class
	WIKI_FILE_TEXT

inherit
	WIKI_TEXT

create
	make_from_path

feature -- Initialization	

	make_from_path (a_path: PATH)
		do
			path := a_path
			internal_structure := Void
		end

feature -- Access

	path: PATH

	content: detachable STRING
		local
			f: RAW_FILE
			s: STRING
		do
			create f.make_with_path (path)
			if f.exists and f.is_readable then
				create Result.make (f.count)
				f.open_read
				from
				until
					f.exhausted or f.end_of_file
				loop
					f.read_stream_thread_aware (1_024)
					s := f.last_string
					s.prune_all ('%R')
					Result.append (s)
				end
				f.close
			end
		end

	structure: WIKI_STRUCTURE
			-- Associated wiki structure.
		local
			l_internal_structure: detachable WIKI_STRUCTURE
		do
			l_internal_structure := internal_structure
			if l_internal_structure = Void then
				if attached content as t then
					create l_internal_structure.make (t)
				else
					create l_internal_structure.make ("!!ERROR!!")
				end
				internal_structure := l_internal_structure
			end
			Result := l_internal_structure
		end

feature {NONE} -- Implementation

	internal_structure: detachable like structure
			-- Internal structure value.

invariant

note
	copyright: "2011-2014, Jocelyn Fiat and Eiffel Software"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Jocelyn Fiat
			Contact: http://about.jocelynfiat.net/
		]"
end
