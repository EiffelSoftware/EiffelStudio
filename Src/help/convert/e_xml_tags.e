indexing
	description: "Objects that represent the help-format XML tags in English."
	author: "Vincent Brendel"
	date: "$Date$"
	revision: "$Revision$"

class
	E_XML_TAGS

feature -- Constants

	eiffel_document_tag: STRING is
			-- The document-start-tag.
		once
			Result := "EIFFEL_DOCUMENT"
		end

	topic_tag: STRING is
			-- The topic-tag. Has 2 attributes: location and id.
		once
			Result := "TOPIC"
		end

	topic_location_attr: STRING is
			-- The location attribute of topic.
		once
			Result := "LOCATION"
		end

	topic_id_attr: STRING is
			-- The location attribute of topic.
		once
			Result := "ID"
		end

	text_tag: STRING is
			-- The paragraph tag.
		once
			Result := "TEXT"
		end

	head: STRING is
			-- The topic-title tag.
		once
			Result := "HEAD"
		end

	font_tag: STRING is
			-- The font properties tag. Has 3 attributes: color, name and size.
		once
			Result := "FONT"
		end

	font_color_attr: STRING is
			-- The color attribute of font.
		once
			Result := "COLOR"
		end

	font_name_attr: STRING is
			-- The name attribute of font.
		once
			Result := "NAME"
		end

	font_size_attr: STRING is
			-- The size attribute of font.
		once
			Result := "SIZE"
		end

	line_break_tag: STRING is
			-- The line-break tag. Recommended use: single tag.
		once
			Result := "BR"
		end

	anchor_tag: STRING is
			-- The anchor tag. Has 1 attribute: topic_id.
		once
			Result := "A"
		end

	anchor_topic_id_attr: STRING is
			-- The topic_id attribute of anchor.
		once
			Result := "TOPIC_ID"
		end

	list_item_tag: STRING is
			-- The bulleted list-item tag.
		once
			Result := "LI"
		end

	list_tag: STRING is
			-- The unnumbered list tag.
		once
			Result := "UL"
		end

	bold_tag: STRING is
			-- The bold-tag.
		once
			Result := "B"
		end

	italics_tag: STRING is
			-- The italics-tag.
		once
			Result := "I"
		end

	underlined_tag: STRING is
			-- The underlined-tag.
		once
			Result := "U"
		end

	keyword_tag: STRING is
			-- The keyword-tag. Words between keyword tags are added to the index.
		once
			Result := "IMP"
		end

end -- class E_XML_TAGS
