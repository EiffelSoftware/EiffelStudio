indexing

	description: "Feature clause comments.";
	date: "$Date$";
	revision: "$Revision $"

class FEATURE_CLAUSE_COMMENT_DATA

inherit

	FREE_TEXT_INFO
		redefine
			generate
		end

creation

	make, make_from_storer

feature -- Properties

	stone (data: DATA): ELEMENT_STONE is
		do
			-- %%%%%%%%%% dummy stuff to compile. Update it.
		end

	stone_type: INTEGER is
		do
			Result := Stone_types.comment_type
		end

feature -- Output

	generate (text_area: TEXT_AREA; data: FEATURE_CLAUSE_DATA ) is
			-- Generate Current to `text_area'
		local
			i, minus_one: INTEGER
		do
			if not empty then
				if count = 1 then
					text_area.append_character (' ')
					text_area.start_comment				
					text_area.append_comment_string ("-- ")
					text_area.append_comment_string (i_th(1))
					text_area.end_comment (stone (data))
				else
					from
						start
						i := 1
						minus_one := count - 1
						text_area.append_character (' ')
						text_area.start_comment				
						text_area.append_comment_string ("-- ")
						text_area.append_comment_string (item)
						forth
						i := i + 1
						text_area.new_line
						text_area.indent
						text_area.indent
					variant
						remaining_elements: count - i
					until
						i > minus_one
					loop
						text_area.append_comment_string ("-- ")
						text_area.append_comment_string (item)
						text_area.new_line
						forth
						i := i + 1
					end
					text_area.append_comment_string ("-- ")
					text_area.append_comment_string (item)
					text_area.end_comment (stone (data))
					text_area.exdent
					text_area.exdent
				end
			end
		end

	comment_raw_string: STRING is
			-- String containing the comments (without --)
		do
			from
				Result := ""
				start
			until
				after
			loop
				Result.append (item)
				Result.extend ('%N')
				forth
			end
			if not Result.empty then
				Result.head (Result.count - 1)
			end
		end

	comment_string: STRING is
			-- String containing the comments (with --)
		do
			from
				Result := ""
				start
			until
				after
			loop
				Result.append ("-- ")
				Result.append (item)
				Result.extend ('%N')
				forth
			end
			if not Result.empty then
				Result.head (Result.count - 1)
			end
		end

end -- class FEATURE_CLAUSE_COMMENT_DATA
