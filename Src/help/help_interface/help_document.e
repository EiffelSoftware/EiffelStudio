indexing
	description: "A help document"
	author: "Parker Abercrombie"
	date: "$Date$"

class
	HELP_DOCUMENT

create
	make

feature -- Initialization

	make (root: XML_ELEMENT) is
			-- Create a document based on `root'.
		require
			root_not_void: root /= Void
		local
			cursor: DS_LINKED_TREE_CURSOR [XML_NODE]
			element: GENERIC_ELEMENT
		do
			root.join_text_nodes
			create document_tree.make

			create element.make (Void, "Document")

			document_tree.put_root (element)
			cursor := document_tree.new_cursor
			cursor.to_root
			generate_document_tree (root, cursor)
		end;

feature -- Access

	document_tree: DS_LINKED_TREE [XML_NODE]
		-- Tree structure of document.

feature -- Basic operations

	generate_document_tree (root_element: XML_ELEMENT; document_cursor: DS_LINKED_TREE_CURSOR [XML_NODE]) is
			-- Create a tree structure of `root_element'.
		require
			root_element_not_void: root_element /= Void
			document_cursor_not_void: document_cursor /= Void
		local
			section: GENERIC_ELEMENT
			element: XML_ELEMENT
			text_element: XML_TEXT
			first_node: BOOLEAN
			cursor: DS_LINKED_LIST_CURSOR [XML_NODE]
		do
			from
				cursor := root_element.new_cursor
				cursor.start
			until
				cursor.after
			loop
				text_element ?= cursor.item
				if text_element /= Void then  -- Text element is special case becuase text is not a named node.
					create {TEXT_ELEMENT} section.make (text_element.out, cursor.item.parent)
					document_tree.put_right_child (section, document_cursor)
					document_cursor.child_forth
				else
					element ?= cursor.item

					-- Determine type of element based on name.
					if element.name.is_equal ("title") then			-- Title element
						create {TITLE} section.make (element, element.name)
					elseif element.name.is_equal ("head") then		-- Topic Header
						create {HEADER} section.make (element, element.name)
					elseif element.name.is_equal ("b") then			-- Bold text
						create {BOLD_TEXT} section.make (element, element.name)
					elseif element.name.is_equal ("i") then			-- Italic text
						create {ITALIC_TEXT} section.make (element, element.name)
					elseif element.name.is_equal ("ek") then			-- Eiffel keyword
						create {EIFFEL_KEYWORD} section.make (element, element.name)
					elseif element.name.is_equal ("ec") then			-- Eiffel comment
						create {EIFFEL_COMMENT} section.make (element, element.name)
					elseif element.name.is_equal ("ecl") then		-- Eiffel class
						create {EIFFEL_CLASS} section.make (element, element.name)
					elseif element.name.is_equal ("ef") then			-- Eiffel text
						create {EIFFEL_FEATURE} section.make (element, element.name)
					elseif element.name.is_equal ("br") then			-- Line break
						create {LINE_BREAK} section.make (element, element.name)
					else											-- Generic element
						create section.make (element, element.name)
					end

					document_tree.put_right_child (section, document_cursor)
					document_cursor.child_forth

						-- process recursivly (one level deeper - child of current node)
					document_cursor.down
					generate_document_tree (element, document_cursor)
					document_cursor.up
				end

				cursor.forth
			end
		end

	display (target_display: EV_RICH_TEXT) is
			-- Display document in `target_display'.
		require
			target_display_exists: not target_display.destroyed
		local
			cursor: DS_LINKED_TREE_CURSOR [XML_NODE]
		do
			cursor := document_tree.new_cursor
			cursor.to_root

			io.put_boolean (target_display.character_format.is_bold)
			io.new_line

			display_elements (target_display, cursor)
		ensure
			document_displayed: target_display.text_length > 0
		end;

	display_elements (target_display: EV_RICH_TEXT; cursor: DS_LINKED_TREE_CURSOR [XML_NODE]) is
			-- Display document and all children in `target_display'.
		require
			target_display_exists: not target_display.destroyed
			cursor_not_void: cursor /= Void
		local
			element: GENERIC_ELEMENT
		do
			from
				cursor.child_start
			invariant
				not_off: not cursor.off
			until
				cursor.child_after
			loop
				element ?= cursor.child_item

				if (not cursor.off) and (element /= Void) then
					element.start_tag (target_display)

					cursor.down
					display_elements (target_display, cursor)
					cursor.up

					element.end_tag (target_display)
				end

				cursor.child_forth
			end
		end

end -- class HELP_DOCUMENT
