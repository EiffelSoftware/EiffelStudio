note
	description: "Summary description for {XB_PARSE_TAG}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	XB_PARSE_TAG


feature -- Access

	start_tag: STRING
			-- The starting tag
		deferred
		ensure
			start_tag_not_empty: Result.count > 0
		end


	end_tag: STRING
			-- The ending tag
		deferred
			ensure
			start_tag_not_empty: Result.count > 0
		end

feature -- Processing

	process_inner (an_inner_string: STRING; a_root: ROOT_SERVLET_ELEMENT)
			--knows what to do with the string inside a tag.
		deferred
		end

	parse_string (a_root: ROOT_SERVLET_ELEMENT; a_string: STRING): STRING
			-- Extracts the specified tags from a string and returns
			-- the remaining string.
		local
			string: STRING
			i: INTEGER
			j: INTEGER
			found: BOOLEAN
			outer: STRING
			inner: STRING
		do
			string := a_string
			Result := ""
			outer := ""
			inner := ""


--		if string.count > (start_tag.count + end_tag.count) then

			from

			until
				not string.has_substring (start_tag)
			loop

				if not string.has_substring (end_tag) then
					print ("WARNING: Your code seems to have a start tag without an end tag!%N")
				end


				--	search for start tag
				i := string.index_of (start_tag.item (1), 1)
				from
					j := 1
					found := True
				until
					j > start_tag.count-1
				loop
					if string.item (i+j).is_equal (start_tag.item (j+1)) then
						found := True and found
					else
						found := False
					end
					j := j + 1
				end

				if found then
						--start tag found
					a_root.put_xhtml_elements (create {PLAIN_XHTML_ELEMENT}.make (string.substring (1, i-1)))
					outer.append (string.substring (1, i-1))
					string.remove_head (i + start_tag.count-1)

						--search for end tag
					i := string.index_of (end_tag.item (1), 1)
					from
						j := 1
						found := True
					until
						j > end_tag.count-1
					loop
						if string.item (i+j).is_equal (end_tag.item (j+1)) then
							found := True and found
						else
							found := False
						end
						j := j + 1
					end

					if found then
							--tag found
						process_inner (string.substring (1, i-1),a_root)
						inner.append (string.substring (1, i-1) )
						string.remove_head (i + end_tag.count-1)
					end
				end
			end
			a_root.put_xhtml_elements (create {PLAIN_XHTML_ELEMENT}.make (string))
			outer.append (string)

			if string.has_substring (end_tag) or string.has_substring (start_tag) then
				print ("WARNING: Your code seems to have a lonely tag!%N")
			end


			print ( "Outside tags: '" + outer + "'%NInside tags: '" + inner + "'%N")

			Result := outer
		end


feature {NONE} -- Implementation

		--substring_until_tag (

invariant
	tags_not_equal: not start_tag.is_equal(end_tag)


end
