note
	description: "Splits an input stream into two parts: a xml only text and a list of tags"
	date: "$Date$"
	revision: "$Revision$"

class
	XB_PREPROCESSOR

create
	make

feature {NONE} -- Initialization

	make
			-- Initialization for `Current'.
		do
			xml := ""
			create tag_list.make
			is_correct := False
		end


feature {NONE} -- Constants

	Start_tag: STRING = "<%%"
		-- the string defining the start of a tag

	End_tag: STRING = "%%>"
		-- the stirng defining the end of a tag


feature -- Access

	tag_list: LINKED_LIST[STRING]
		--a list of strings containing all tag elements

	xml: STRING
		--the xml text without the tags

--	servlet_elements: LINKED_LIST[SERVLET_ELEMENTS]


feature -- Status Report	

	is_correct: BOOLEAN
		-- defines if the parser could successfully parse the input


feature -- Features yet to be named

	parse_from_stream (a_stream: KI_CHARACTER_INPUT_STREAM)
			-- Parse document from input stream.
		require
			a_stream_not_void: a_stream /= Void
			is_open_read: a_stream.is_open_read
		local
			buf: STRING
				--contains to characters to test if its a <% or %>
			xml_buf: STRING
				--contains parsed input with removed <% %>-tags
			tag_buf: STRING
				--contains tags	
			c: CHARACTER
				--to read one character from stream
			state: INTEGER
				--can be 0: reading xml text
				--can be 1: reading tag	text
		do
			xml_buf := ""
			tag_buf := ""
			buf := ""
			state := 0


			from
			--	a_stream.rewind
			until
				a_stream.end_of_input
			loop
				a_stream.read_character
				c := a_stream.last_character

				buf.append_character (c)

				if buf.count >= 2 then

					if buf.is_equal (Start_tag) then
						state := 1
						buf.wipe_out
						is_correct := false

					elseif	buf.is_equal (End_tag) 	then
						state := 0
						buf.wipe_out
						is_correct := true
						tag_list.put_right (tag_buf.twin)
						tag_buf.wipe_out
					end


					if not buf.is_empty then
						if state = 1 then
							tag_buf.append_character (buf.item (1))
						elseif state = 0 then
							xml_buf.append_character (buf.item (1))
						end
						buf.remove_head (1)
					end
				end

			end

			print ("XML: '" + xml_buf + "'%NTAG: '" + tag_buf + "'%N")

			xml.append(xml_buf.twin)
		end





--	find_all (input: STRING; other: STRING): LIST[INTEGER]
--			-- returns a list with position of all occurences of 'other' in 'input'.
--		local
--			l: LINKED_LIST[INTEGER]
--			i: INTEGER
--		do
--			create l.make

--			from
--				i := 1
--			until
--				i = 0
--			loop
--				i := input.substring_index (other, i)

--				l.put_right (i)
--			end


--			Result := l
--		end




feature -- Measurement

feature -- Status report

feature -- Status setting

feature -- Cursor movement

feature -- Element change

feature -- Removal

feature -- Resizing

feature -- Transformation

feature -- Conversion

feature -- Duplication

feature -- Miscellaneous

feature -- Basic operations

feature -- Obsolete

feature -- Inapplicable

feature {NONE} -- Implementation

invariant
	Start_tag_not_empty: not Start_tag.is_empty
	End_tag_not_empty: not End_tag.is_empty
	Start_tag_size_ok: Start_tag.count = 2
	End_tag_size_ok:  End_tag.count = 2
	Start_tag_not_equals_End_tag: not Start_tag.is_equal (End_tag)

end
