indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	XML_FORMAT_FILTER

inherit
	DOCUMENT_FILTER
		rename
			make as make_filter
		redefine				
			on_start_tag,
			on_end_tag,
			on_attribute,
			on_content
		end
		
	XM_MARKUP_CONSTANTS
	
	XML_ROUTINES

	GRAPHICAL_CONSTANTS

create
	make

feature -- Creation

	make (a_rich_text: EV_RICH_TEXT) is
			-- Make
		do
			rich_text := a_rich_text
			rich_text_font := rich_text.font
			create internal_background_color.make_with_rgb (1.0, 1.0, 1.0)	
		end		

feature -- Access

	rich_text: EV_RICH_TEXT
			-- Rich text control
			
	rich_text_font: EV_FONT

feature {NONE} -- Processing

	on_start_tag (a_namespace: STRING; a_prefix: STRING; a_local_part: STRING) is
			-- Process `e'
		do
			if in_attribute then
				rich_text.buffered_append (stag_end, tag_format)
			end
			rich_text.buffered_append (stag_start, tag_format)
			rich_text.buffered_append (a_local_part, element_format)
			in_attribute := True
		end

	on_end_tag (a_namespace: STRING; a_prefix: STRING; a_local_part: STRING) is
			-- Process `e'
		do
			if in_attribute then
				rich_text.buffered_append (stag_end, tag_format)
				in_attribute := False
			end
			rich_text.buffered_append (etag_start, tag_format)
			rich_text.buffered_append (a_local_part, element_format)
			rich_text.buffered_append (etag_end, tag_format)
		end

	on_attribute (a_namespace: STRING; a_prefix: STRING; a_local_part: STRING; a_value: STRING) is
			-- Process `att'
		do
			in_attribute := True
			rich_text.buffered_append (space_s + a_local_part, attribute_format)
			rich_text.buffered_append (eq_s + quot_s, tag_format)
			rich_text.buffered_append (a_value, content_format)
			rich_text.buffered_append (quot_s, tag_format)
		end	
		
	on_content (a_content: STRING) is
			-- Process `c'
		local
			l_content: STRING
		do
			if in_attribute then
				rich_text.buffered_append (stag_end, tag_format)
				in_attribute := False
			end
			l_content := output_escaped (a_content)	
			rich_text.buffered_append (l_content, content_format)
		end

feature -- Constants

	background_color: EV_COLOR is
			-- Background color
		local
			l_r, l_g, l_b: REAL
		do
			l_r := internal_background_color.red
			l_g := internal_background_color.green
			l_b := internal_background_color.blue
			create Result.make_with_rgb (l_r, l_g, l_b)
		end

	tag_format: EV_CHARACTER_FORMAT is
			-- Tag format
		do
			create Result.make_with_font_and_color (rich_text_font, tag_color, background_color)
		end		

	element_format: EV_CHARACTER_FORMAT is
			-- Element format
		do
			create Result.make_with_font_and_color (rich_text_font, element_color, background_color)
		end
		
	attribute_format: EV_CHARACTER_FORMAT is
			-- Tag format
		do
			create Result.make_with_font_and_color (rich_text_font, attribute_color, background_color)
		end

	content_format: EV_CHARACTER_FORMAT is
			-- Content format
		local
			l_font: EV_FONT
		do
			create l_font.make_with_values (rich_text_font.family, 8, rich_text_font.shape, rich_text_font.height)
			create Result.make_with_font_and_color (l_font, content_color, background_color)
		end
		
feature {NONE} -- Implementation	

	internal_background_color: like background_color
			-- Internal background color

	in_attribute: BOOLEAN	
		
end -- class XML_FORMAT_FILTER
