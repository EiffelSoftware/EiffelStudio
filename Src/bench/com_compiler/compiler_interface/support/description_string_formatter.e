indexing
	description: "Process a structured text and put result in a string for descriptions"
	date: "$Date$"
	revision: "$Revision$"

class
	DESCRIPTION_STRING_FORMATTER

inherit
	STRING_FORMATTER
		redefine
			make,
			put_comment,
			put_indent,
			put_keyword,
			process_indentation
		end

create
	make

feature {NONE} -- Initialization

	make is
		do
			Precursor {STRING_FORMATTER}
			first_comment := True
		end

feature -- Output

	put_comment (str: STRING) is
			-- Put `str' as representation of a comment.
		local
			l_str: STRING
		do
			if not comments_ended then
				if not str.is_equal (comment) then
					l_str := str.twin
					l_str.prune_all_leading (' ')
					put_string (l_str)
				elseif first_comment then
					put_new_line
					first_comment := False	
				end
			else
				Precursor {STRING_FORMATTER} (str)
			end
		end
		
	put_indent (nbr_of_tabs: INTEGER) is
			-- Put indent of `nbr_of_tabs'.
		do
		end

	put_keyword (str: STRING) is
			-- Put `str' as representation of quoted text.
		do
			if str.is_equal (require_keyword) or str.is_equal (ensure_keyword) then
					-- Add extra description line break
				put_new_line
				comments_ended := True
			end
			put_string (str)
		end

	process_indentation (text: INDENT_TEXT) is
			-- Process indentation `t'.
		do
			if comments_ended then
				put_string (text.image)	
			end		
		end

feature {NONE} -- Implementation			
			
	first_comment: BOOLEAN
			-- Is comment the first?
			
	comments_ended: BOOLEAN
			-- Is formatter in comment?
			
	require_keyword: STRING is "require"
			-- require keyword

	ensure_keyword: STRING is "ensure"
			-- require keyword
			
	comment: STRING is "--"
			-- comment marker

end -- class DESCRIPTION_STRING_FORMATTER
