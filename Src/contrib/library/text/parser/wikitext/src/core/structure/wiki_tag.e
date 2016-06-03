note
	description: "Summary description for {WIKI_TAG}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	WIKI_TAG

inherit
	WIKI_STRING_ITEM

	DEBUG_OUTPUT

create
	make,
	make_from_source

feature {NONE} -- Initialization

	make (a_tag: STRING; s: STRING)
		local
			i,j: INTEGER
		do
			original_text_has_new_line := s.has ('%N')
			tag := a_tag
			tag_name := tag_name_from (a_tag)

			i := tag_name.index_of (' ', 1)
			j := tag_name.index_of ('%T', 1)
			if i = 0 then
				i := j
			elseif j /= 0 then
				i := i.min (j)
			end
			if i > 0 then
				tag_name := tag_name.substring (1, i - 1)
			else
--				tag_name := a_tag_name
			end

			create text.make (s)
		end

	make_from_source (s: STRING)
		require
			valid_code_string: s.starts_with_general ("<") and s.ends_with_general (">")
		local
			i,j,k,e: INTEGER
			l_end_tag, t,l_content: detachable STRING
		do
			original_text_has_new_line := s.has ('%N')
			i := s.index_of ('<', 1)
			e := s.index_of ('>', i + 1)
			if i = 0 or e = 0 then
				check s_is_valid: False end
				tag_name := default_tag_name
				tag := "<" + tag_name + ">"
				create text.make (s)
			else
				tag := s.substring (i, e)

				from
					j := i + 1
				until
					j >= e or s[j].is_space or s[j] = '/'
				loop
					j := j + 1
				end
				t := s.substring (i + 1, j - 1)
				t.left_adjust
				t.right_adjust
				tag_name := t
				if s[e-1] = '/' then
					create text.make ("")
				else
					l_end_tag := "</"+ t +">"
					j := s.substring_index (l_end_tag, j + 1)
					k := j
					from
					until
						j = 0
					loop
						j := s.substring_index (l_end_tag, k + 1)
						if j > 0 then
							k := j
						end
					end
					j := k

					if j > 0 then
						l_content := s.substring (e + 1, j - 1)
					else
						l_content := s.substring (e + 1, s.count)
					end
					if not l_content.is_empty then
						if l_content[1] = '%N' then
							l_content.remove_head (1)
						end
						if
							not l_content.is_empty and then
							l_content[l_content.count] = '%N'
						then
							l_content.remove_tail (1)
						end
					end
					create text.make (l_content)
				end
			end
		end

feature -- Access

	tag: STRING

	tag_name: STRING

	text: WIKI_STRING

	original_text_has_new_line: BOOLEAN
			-- Original tag content had new line?
			-- Could be used by visitor.

	default_tag_name: STRING
		do
			Result := "Missing-Tag-Name"
		end

feature -- Status report

	is_empty: BOOLEAN
			-- Is empty text?
		do
			Result := tag.is_empty and text.is_empty
		end

	is_open_close_tag: BOOLEAN
			-- Is tag a open-close tag such as <tag/>?
		do
			Result := tag.ends_with_general ("/>")
		end

feature -- Visitor

	process (a_visitor: WIKI_VISITOR)
		do
			a_visitor.visit_tag (Current)
		end

feature -- Help

	tag_name_from (s: READABLE_STRING_8): STRING_8
			-- Tag name from  inside of <...>
			--| for instance ' abc def="geh"' will return abc
		local
			i,n: INTEGER
		do
			i := s.index_of (' ', 2)
			n := s.index_of ('%T', 2)
			if i = 0 then
				i := n
			elseif n /= 0 then
				i := i.min (n)
			end
			if i > 0 then
				create Result.make_from_string (s.substring (2, i - 1))
			else
				create Result.make_from_string (s.substring (2, s.count - 1))
			end
			Result.left_adjust
			Result.right_adjust
		end

feature -- Status report

	debug_output: STRING
			-- String that should be displayed in debugger to represent `Current'.
		do
			Result := "<" + tag_name + ">..</" + tag_name + ">"
		end

note
	copyright: "2011-2016, Jocelyn Fiat and Eiffel Software"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Jocelyn Fiat
			Contact: http://about.jocelynfiat.net/
		]"
end
