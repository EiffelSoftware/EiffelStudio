indexing
	description:	"A tree based XML Parser"
	status:			"See notice at end of class."
	author:			"Andreas Leitner"
	note:				"Although it is not DOM (Level 1) conforming, it has %
						%been writen with DOM in mind. I prefer to have this %
						%parser follow the Eiffel design guide lines";
class
	XML_TREE_PARSER

inherit
	XML_PARSER
		undefine
			out
		redefine
			on_start_tag,
			on_content,
			on_end_tag
		end
	XML_DOCUMENT
creation
	make

feature -- call backs
	on_start_tag (start_tag: XML_START_TAG) is
			-- called whenever the parser findes a start element
		local
			element: XML_ELEMENT
		do
			check
				document_not_finished: root_element /= Void implies current_open_element /= Void
			end
			if 
				root_element = Void
			then
					-- this is the first element in the document
				element := start_tag.element (Void)
				
				root_element := element
			else
					-- this is not the first element in the document
				element := start_tag.element (current_open_element)
				current_open_element.force_last (element)
			end
			check
				element_not_void: element /= Void
			end
			current_node := element
			current_open_element := element
		end

	on_content (content: XML_CONTENT) is
			-- called whenever the parser findes character data
		local
			text: XML_TEXT
		do
			check
				not_finished: current_open_element /= Void
			end
			!! text.make_from_content (current_open_element, content)
			current_open_element.force_last (text)
			current_node := text
		end

	on_end_tag (end_tag: XML_END_TAG) is
			-- called whenever the parser findes an end element
		do
			check
				open_element_exists: current_open_element /= Void
			end

			current_open_element := next_open_element (current_open_element)
			current_node := current_node.parent
		end

feature {NONE} -- Implementation
	current_node: XML_NODE
	current_open_element: XML_ELEMENT

	next_open_element (element: XML_ELEMENT): XML_ELEMENT is
		require
			element /= Void
		do
			Result := element.parent
		end

invariant
	--TODO:
	--inv1: (root_element /= Void) implies (current_node /= Void)
	--inv2: (current_open_element = Void) implies (current_node = root_element)
	--inv3: ((root_element /= Void) and then (current_node = root_element)) implies current_node.is_root
end -- class XML_TREE_PARSER
--|-------------------------------------------------------------------------
--| eXML, Eiffel XML Parser Toolkit
--| Copyright (C) 1999  Andreas Leitner
 and others
--| See the file forum.txt included in this package for licensing info.
--|
--| Comments, Questions, Additions to this library? please contact:
--|
--| Andreas Leitner
--| Arndtgasse 1/3/5
--| 8010 Graz
--| Austria
--| email: andreas.leitner@chello.at
--| www: http://exml.dhs.org
--|-------------------------------------------------------------------------