indexing

	description:
		"Tags of subset of the HTML language. This class may be used as %
		%ancestor by classes needing its facilities"

	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class
	HTML_CONSTANTS

feature -- Constants

	Bold_start: STRING is "<B>"
			-- Bold face start tag.

	Bold_end: STRING is "</B>"
			-- Bold face end tag.

	Glossary_start: STRING is "<DL>"
			-- Glossary list start tag.

	Glossary_end: STRING is "</DL>"
			-- Glossary list end tag.

	Glossary_term: STRING is "<DT>"
			-- Glossary list term.

	Glossary_definition: STRING is "<DD>"
			-- Glossary list definition.

	H1_start: STRING is "<H1>"
			-- Header level 1 start tag.

	H1_end: STRING is "</H1>"
			-- Header level 1 end tag.

	H2_start: STRING is "<H2>"
			-- Header level 2 start tag.

	H2_end: STRING is "</H2>"
			-- Header level 2 end tag.

	H3_start: STRING is "<H3>"
			-- Header level 3 start tag.

	H3_end: STRING is "</H3>"
			-- Header level 3 end tag.

	H4_start: STRING is "<H4>"
			-- Header level 4 start tag.

	H4_end: STRING is "</H4>"
			-- Header level 4 end tag.

	H5_start: STRING is "<H5>"
			-- Header level 5 start tag.

	H5_end: STRING is "</H5>"
			-- Header level 5 end tag.

	H6_start: STRING is "<H6>"
			-- Header level 6 start tag.

	H6_end: STRING is "</H6>"
			-- Header level 6 end tag.

	Horizontal_rule: STRING is "<HR>"
			-- Horizontal rule tag.

	Italic_start: STRING is "<I>"
			-- Italic start tag.

	Italic_end: STRING is "</I>"
			-- Italic end tag.

	Line_break: STRING is "<BR>"
			-- Line break tag.

	List_item_start: STRING is "<LI>"
			-- List item start tag.

	List_item_end: STRING is "</LI>"
			-- List item end tag.

	Ordered_list_start: STRING is "<OL>"
			-- Ordered list start tag.

	Ordered_list_end: STRING is "</OL>"
			-- Ordered list end tag.

	Paragraph_start: STRING is "<P>"
			-- Paragraph start tag.

	Paragraph_end: STRING is "</P>"
			-- Paragraph end tag.

	Preformatted_start: STRING is "<PRE>"
			-- Preformatted text start tag.

	Preformatted_end: STRING is "</PRE>"
			-- Preformatted text end tag.

	Unordered_list_start: STRING is "<UL>"
			-- Unordered list start tag.

	Unordered_list_end: STRING is "</UL>"
			-- Unordered list end tag.

end -- class HTML_CONSTANTS

--|----------------------------------------------------------------
--| EiffelWeb: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-1998 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 2nd floor
--| 270 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

