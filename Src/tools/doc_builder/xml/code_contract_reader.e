indexing
	description: "Reader of Eiffel XML contract code file."
	date: "$Date$"
	revision: "$Revision$"

class
	CODE_CONTRACT_READER

inherit
	DOCUMENT_FILTER
		rename
			make as make_filter
		redefine			
			on_start_tag,
			on_end_tag,
			on_content,
			on_start_tag_finish
		end

	CODE_XML_READER_CONSTANTS

create
	make

feature -- Creation

	make is
			-- Create
		do
			make_filter
			create element_stack.make (2)
			element_stack.compare_objects
			create anchors.make (1)
		end

feature -- Tag

	on_start_tag (a_namespace, a_prefix, a_local_part: STRING) is
			-- Start tag
		do
			element_stack.extend (a_local_part)					
		end
	
	on_start_tag_finish is
		do
			next.on_start_tag_finish
		end

	on_end_tag (a_namespace, a_prefix, a_local_part: STRING) is
			-- End tag
		do							
			Element_stack.remove
		end	
		
	on_content (a_content: STRING) is
			-- Content
		local
			l_content,
			l_title,
			l_href,
			l_anchor: STRING
		do
			l_content := rt_output_escaped (a_content)
			l_anchor := l_content.substring (l_content.index_of ('#', 1), l_content.count)
			if current_tag.is_equal (Location_tag) then
				if l_content.occurrences ('#') > 0 then
					anchor.put (l_anchor, 2)
					in_anchor := True
				end
			elseif in_anchor and then current_tag.is_equal (Feature_tag) then
				l_title ?= l_content
				l_href ?= Anchor.item (2)
				if l_title /= Void and then l_href /= Void then
					anchors.extend (l_title, l_href)	
				end
				in_anchor := False
			end
		end

feature -- Access
	
	anchors: HASH_TABLE [STRING, STRING]
			-- List of anchors

feature {NONE} -- Tag
		
	current_tag: STRING is
			-- Current tag
		do
			Result := element_stack.item
		end

feature {NONE} -- Implementation

	in_anchor: BOOLEAN
			-- In anchor?

	element_stack: ARRAYED_STACK [STRING]
			-- Stack of element names
			
	anchor: TUPLE [STRING, STRING] is
			-- Anchor [feature name/title, location/href]
		once
			Result := ["", ""]
		end
			
end -- class CODE_XML_READER2
