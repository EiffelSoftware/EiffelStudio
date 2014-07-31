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
	make

feature {NONE} -- Initialization

	make (a_tag: STRING; s: STRING)
		local
			i,j: INTEGER
		do
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

			text := s
		end

feature -- Access

	tag: STRING

	tag_name: STRING

	text: WIKI_STRING

feature -- Status report

	is_empty: BOOLEAN
			-- Is empty text?
		do
			Result := tag.is_empty and text.is_empty
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
	copyright: "2011-2014, Jocelyn Fiat and Eiffel Software"
	license: "Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Jocelyn Fiat
			Contact: http://about.jocelynfiat.net/
		]"
end
