note
	description: "Summary description for {WIKI_CODE}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	WIKI_CODE

inherit
	WIKI_TAG
		redefine
			make,
			make_from_source,
			default_tag_name,
			process
		end

create
	make,
	make_from_source,
	make_from_3backticks_source

feature {NONE} -- Initialization

	make (a_tag, s: STRING_8)
			-- <Precursor>
		do
			Precursor (a_tag, s)
			set_is_inline (text.is_single_line and not s.has ('%N'))
		end

	make_from_source (s: STRING)
			-- <Precursor>
		do
			Precursor (s)
			set_is_inline (text.is_single_line and not s.has ('%N'))
		end

	make_from_3backticks_source (s: STRING)
			-- Create wiki code from `s' using the 3backticks syntax.
			-- ie: "```lang%N....%N```%N"
		require
			has_expected_backticks: s.starts_with_general ("```") and s.ends_with_general ("```")
		local
			i,j: INTEGER
			l_lang: STRING
			l_source: STRING
		do
			i := 1
			j := s.index_of ('%N', i)
			if j > i then
				l_lang := s.substring (i + 3, j - 1)
				l_lang.left_adjust
				l_lang.right_adjust
				create l_source.make (s.count + 15) -- = (14 - 3) + (7 - 3)
				create l_source.make_from_string ("<code lang=%"" + l_lang + "%">%N")
				i := j + 1
			else
				create l_source.make (s.count + 4) -- = 7 - 3
			end
			l_source.append_substring (s, i, s.count - 3)
			l_source.append ("</code>")
			make_from_source (l_source)
		end

feature -- Access

	default_tag_name: STRING
		do
			Result := "code"
		end

feature -- Status report

	is_inline: BOOLEAN

feature -- Element change

	set_is_inline (b: BOOLEAN)
			-- Set `is_inline' to `b'.
		do
			is_inline := b
		end

feature -- Visitor

	process (a_visitor: WIKI_VISITOR)
		do
			a_visitor.visit_code (Current)
		end

note
	copyright: "2011-2015, Jocelyn Fiat and Eiffel Software"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Jocelyn Fiat
			Contact: http://about.jocelynfiat.net/
		]"
end
