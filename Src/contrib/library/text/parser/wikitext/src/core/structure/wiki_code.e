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
	make_from_3backticks_source,
	make_from_single_backtick_source,
	make_from_double_backtick_source,
	make_from_tag

feature {NONE} -- Initialization

	make (a_tag, s: READABLE_STRING_8)
			-- <Precursor>
		do
			Precursor (a_tag, s)
			set_is_inline (text.is_single_line and not original_text_has_new_line)
		end

	make_from_source (s: READABLE_STRING_8)
			-- <Precursor>
		do
			Precursor (s)
			set_is_inline (text.is_single_line and not original_text_has_new_line)
		end

	make_from_tag (a_tag: WIKI_TAG)
		do
			make (a_tag.tag, a_tag.text.text)
		end

	make_from_3backticks_source (s: READABLE_STRING_8)
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
				l_lang := s.substring (i + 3, j - 1).to_string_8
				l_lang.left_adjust
				l_lang.right_adjust
				create l_source.make (s.count + 15) -- = (14 - 3) + (7 - 3)
				if l_lang.is_whitespace then
					l_source.append ("<code>%N")
				else
					l_source.append ("<code lang=%"" + l_lang + "%">%N")
				end
				i := j + 1
			else
				create l_source.make (s.count + 4) -- = 7 - 3
			end
			l_source.append_substring (s, i, s.count - 3)
			l_source.append ("</code>")
			make_from_source (l_source)
		end

	make_from_single_backtick_source (s: READABLE_STRING_8)
			-- Create wiki code from `s' using the single backtick syntax.
			-- ie: "`....`%N"
		require
			has_expected_backticks: s.starts_with_general ("`") and s.ends_with_general ("`")
			is_inline: not s.has ('%N')
		local
			l_source: STRING
		do
			create l_source.make_from_string ("<code>")
			l_source.append_substring (s, 2, s.count - 1)
			l_source.append ("</code>")
			make_from_source (l_source)
			set_is_inline (True)
		end

	make_from_double_backtick_source (s: READABLE_STRING_8)
			-- Create wiki code from `s' using the single backtick syntax.
			-- ie: "`` ....``%N", usually this is to escape single backtick.
		require
			has_expected_backticks: s.starts_with_general ("``") and s.ends_with_general ("``")
			is_inline: not s.has ('%N')
		local
			l_source: STRING
		do
			create l_source.make_from_string ("<code>")
			l_source.append_substring (s, 3, s.count - 2)
			l_source.append ("</code>")
			make_from_source (l_source)
			set_is_inline (True)
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
	copyright: "2011-2019, Jocelyn Fiat and Eiffel Software"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Jocelyn Fiat
			Contact: http://about.jocelynfiat.net/
		]"
end
