indexing
	description:
		"HTML generation. This class may be used as ancestor by classes %
		%needing its facilities"

	status: "See notice at end of class"
	date: "$Date$"
	revision: "$Revision$"

class
	HTML_GENERATOR

inherit
	HTML_CONSTANTS
	SHARED_STDOUT

feature -- Miscellaneous

	put_bold (text: STRING) is
			-- Put `text' in bold face.
		require
			text_not_Void: text /= Void
		do
			put_basic (Bold_start)
			put_basic (text)
			put_basic (Bold_end)
		end

	put_glossary_start is
			-- Start glossary list.
		do
			put_basic (Glossary_start)
		end

	put_glossary_end is
			-- End glossary list.
		do
			put_basic (Glossary_end)
		end

	put_glossary_term (text: STRING) is
			-- Put `text' as glossary term.
		require
			text_not_Void: text /= Void
		do
			put_basic (Glossary_term)
			put_basic (text)
		end

	put_glossary_definition is
			-- Put glossary definition tag.
		do
			put_basic (Glossary_definition)
		end

	put_header1 (title: STRING) is
			-- Put `title' as level 1 header.
		require
			title_not_Void: title /= Void
		do
			put_basic (H1_start)
			put_basic (title)
			put_basic (H1_end)
			put_basic ("%N")
		end

	put_header2 (title: STRING) is
			-- Put `title' as level 2 header.
		require
			title_not_Void: title /= Void
		do
			put_basic (H2_start)
			put_basic (title)
			put_basic (H2_end)
			put_basic ("%N")
		end

	put_header3 (title: STRING) is
			-- Put `title' as level 3 header.
		require
			title_not_Void: title /= Void
		do
			put_basic (H3_start)
			put_basic (title)
			put_basic (H3_end)
			put_basic ("%N")
		end

	put_header4 (title: STRING) is
			-- Put `title' as level 4 header.
		require
			title_not_Void: title /= Void
		do
			put_basic (H4_start)
			put_basic (title)
			put_basic (H4_end)
			put_basic ("%N")
		end

	put_header5 (title: STRING) is
			-- Put `title' as level 5 header.
		require
			title_not_Void: title /= Void
		do
			put_basic (H5_start)
			put_basic (title)
			put_basic (H5_end)
			put_basic ("%N")
		end

	put_header6 (title: STRING) is
			-- Put `title' as level 6 header.
		require
			title_not_Void: title /= Void
		do
			put_basic (H6_start)
			put_basic (title)
			put_basic (H6_end)
			put_basic ("%N")
		end

	put_horizontal_rule is
			-- Put a horizontal rule.
		do
			put_basic (Horizontal_rule)
			put_basic ("%N")
		end

	put_italic (text: STRING) is
			-- Put `text' in italic.
		require
			text_not_Void: text /= Void
		do
			put_basic (Italic_start)
			put_basic (text)
			put_basic (Italic_end)
		end

	put_line_break is
			-- Put line break.
		do
			put_basic (Line_break)
		end

	put_link (url, anchor: STRING) is
			-- Attach text `anchor' to `url'
		require
			anchor_not_Void: anchor /= Void;
			url_not_Void: url /= Void
		do
			put_basic ("<A HREF=%"")
			put_basic (url)
			put_basic ("%">")
			put_basic (anchor)
			put_basic ("</A>")
		end

	put_list_item_start is
			-- Put list item start tag.
		do
			put_basic (List_item_start)
		end

	put_list_item_end is
			-- Put list item end tag.
		do
			put_basic (List_item_end)
		end

	put_ordered_list_start is
			-- Start ordered list.
		do
			put_basic (Ordered_list_start)
		end

	put_ordered_list_end is
			-- End ordered list.
		do
			put_basic (Ordered_list_end)
		end

	put_paragraph_start is
			-- Start paragraph.
		do
			put_basic (Paragraph_start)
		end

	put_paragraph_end is
			-- End paragraph
		do
			put_basic (Paragraph_end)
		end

	put_preformatted (text: STRING) is
			-- Put preformatted text `text'.
		require
			text_not_Void: text /= Void
		do
			put_basic (Preformatted_start)
			put_basic (text)
			put_basic (Preformatted_end)
			put_basic ("%N")
		end

	put_unordered_list_start is
			-- Start unordered list.
		do
			put_basic (Unordered_list_start)
		end

	put_unordered_list_end is
			-- End unordered list.
		do
			put_basic (Unordered_list_end)
		end

feature -- Transformation

	put_basic (s: STRING) is
			-- Write `s' to medium.
		require
			string_not_Void: s /= Void
		do
			stdout.putstring (s)
		end

end -- class HTML_GENERATOR


--|----------------------------------------------------------------
--| EiffelWeb: library of reusable components for ISE Eiffel.
--| Copyright (C) 1986-2001 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building
--| 360 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support: http://support.eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

