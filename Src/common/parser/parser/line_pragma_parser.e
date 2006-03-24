indexing
	description: "Parses source line declaring line pragma"
	date: "$Date$"
	revision: "$Revision$"

class
	LINE_PRAGMA_PARSER

feature -- Status Report

	is_pragma: BOOLEAN
			-- Was last text parsed with `parse' a line pragma?

feature -- Access

	line_number: INTEGER
			-- Line pragma virtual line number of last pragma parsed with `parse'

	document: STRING
			-- Line pragma path to document of last pragma parsed with `parse'

	is_default: BOOLEAN
			-- Was last pragma parsed with `parse' a 'default' pragma?
			-- i.e. a line pragma that resets line information to the default

	is_hidden: BOOLEAN
			-- Was last pragma parsed with `parse' a 'hidden' pragma?
			-- i.e. a line pragma that tells the compiler to stop generating debug information

feature -- Basic Operations

	parse (a_pragma: STRING) is
			-- Parse line pragma `a_pragma' and set queries accordingly.
		require
			attached_pragma: a_pragma /= Void
		local
			l_pp_count, i, l_count, l_offset: INTEGER
			l_parsed_text, l_line, l_document: STRING
			l_parsing_line, l_stop: BOOLEAN
			c: CHARACTER
		do
			is_pragma := False
			is_default := False
			is_hidden := False
			document := Void
			line_number := 0
			l_pp_count := Pragma_prefix.count
			l_parsed_text := a_pragma.as_lower
			from
				c := ' '
				i := 1
				l_count := l_parsed_text.count
			until
				not c.is_space or i > l_count
			loop
				c := l_parsed_text.item (i)
				if c = '%N' then
					l_offset := l_offset + 1
				end
				i := i + 1
			end
			l_parsed_text.left_adjust
			l_parsed_text.right_adjust
			if l_parsed_text.count > l_pp_count and then l_parsed_text.substring (1, l_pp_count).is_equal (Pragma_prefix) then
				l_parsed_text.keep_tail (l_parsed_text.count - l_pp_count)
				if l_parsed_text.is_equal ("default") then
					is_default := True
					is_pragma := True
				elseif l_parsed_text.is_equal ("hidden") then
					is_hidden := True
					is_pragma := True
				else
					create l_line.make (5)
					create l_document.make (240)
					from
						i := 1
						l_count := l_parsed_text.count
						l_parsing_line := True
					until
						i > l_count or l_stop
					loop
						c := l_parsed_text.item (i)
						if l_parsing_line then
							if c.is_digit then
								l_line.append_character (c)
							elseif c.is_space then
								l_parsing_line := False
							else
								l_stop := True -- Error!
							end
						else
							if c /= '"' then
								l_document.append_character (c)
							end
						end
						i := i + 1
					end
					if not l_stop then
						l_document.left_justify
						document := l_document
						line_number := l_line.to_integer - l_offset - 1
						is_pragma := True
					end
				end
			end
		ensure
			line_number_iff_document: (line_number > 0) = (document /= Void)
			info_iff_pragma: is_pragma = is_pragma_definition
			no_info_if_not_pragma: not is_pragma implies ((is_default = False) and (is_hidden = False) and (document = Void))
		end

feature {NONE} -- Implementation

	Pragma_prefix: STRING is "--#line "
			-- Prefix to all line pragmas

	is_pragma_definition: BOOLEAN is
			-- Definition for `is_pragam'.
		do
			Result := (is_default and not is_hidden and document = Void) or
				(is_hidden and not is_default and document = Void) or
				(document /= Void and not is_default and not is_hidden)
		end

invariant
	line_number_iff_document: (line_number > 0) = (document /= Void)
	info_iff_pragma: is_pragma = is_pragma_definition
	no_info_if_not_pragma: not is_pragma implies ((is_default = False) and (is_hidden = False) and (document = Void))

end -- class LINE_PRAGMA_PARSER
