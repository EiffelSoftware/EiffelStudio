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
			create parse_tags.make


			--------ADD TAGS HERE------

			

		end



feature -- Status Setting

	add_parse_tag (a_parse_tag: XB_PARSE_TAG)
			-- adds a parse to the list
		do
			parse_tags.put_right (a_parse_tag)
		end


feature {NONE} -- Access

--	Start_tag: STRING = "<%%"
--		-- the string defining the start of a tag, has to be of length 2

--	End_tag: STRING = "%%>"
--		-- the stirng defining the end of a tag, has to be of length 2


	parse_tags: LINKED_LIST[XB_PARSE_TAG]
		-- the list of tags to be parsed

feature -- Access

--	tag_list: LINKED_LIST[STRING]
		--a list of strings containing all tag elements

--	xml: STRING
		--the xml text without the tags

		--


feature -- Status Report	

--	is_correct: BOOLEAN
		-- defines if the parser could successfully parse the input


feature -- Features yet to be named




	parse_string (a_root: ROOT_SERVLET_ELEMENT; a_string: STRING)
			-- parses string with the list of parse tags.
		require
		local
			temp_string: STRING
		do
			from
				parse_tags.start
				temp_string := a_string
			until
				parse_tags.after
			loop
				temp_string := parse_tags.item.parse_string (a_root, temp_string)
				parse_tags.forth
			end
		end



--	parse_from_stream (root: ROOT_SERVLET_ELEMENT; a_stream: KI_CHARACTER_INPUT_STREAM)
--			-- Parse document from input stream.
--		require
--			a_stream_not_void: a_stream /= Void
--			is_open_read: a_stream.is_open_read
--		local
--			buf: STRING
--				--contains to characters to test if its a <% or %>
--			xml_buf: STRING
--				--contains parsed input with removed <% %>-tags
--			tag_buf: STRING
--				--contains tags	
--			c: CHARACTER
--				--to read one character from stream
--			state: INTEGER
--				--can be 0: reading xml text
--				--can be 1: reading tag	text
--		do

--			from
--				xml_buf := ""
--				tag_buf := ""
--				buf := ""
--				state := 0
--			until
--				a_stream.end_of_input
--			loop
--				a_stream.read_character
--				c := a_stream.last_character
--				buf.append_character (c)

--				if a_stream.end_of_input then
--						root.put_xhtml_elements (create {PLAIN_XHTML_ELEMENT}.make (xml_buf.twin))
--						print ("adding xml: '" + xml_buf + "'%N")
--						xml_buf.wipe_out
--				end

--				if buf.count >= 2 then
--					if buf.is_equal (Start_tag) then
--						state := 1
--						buf.wipe_out
--						is_correct := false
--						root.put_xhtml_elements (create {PLAIN_XHTML_ELEMENT}.make (xml_buf.twin))
--						print ("adding xml: '" + xml_buf + "'%N")
--						xml_buf.wipe_out

--					elseif	buf.is_equal (End_tag) 	then
--						state := 0
--						buf.wipe_out
--						is_correct := true
--						root.put_xhtml_elements (create {CALL_ELEMENT}.make (tag_buf.twin))
--						print ("adding tag: '" + tag_buf + "'%N")
--						tag_buf.wipe_out
--					end

--					if not buf.is_empty then
--						if state = 1 then
--							tag_buf.append_character (buf.item (1))
--						elseif state = 0 then
--							xml_buf.append_character (buf.item (1))
--						end
--						buf.remove_head (1)
--					end
--				end
--			end

--		end


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


end
