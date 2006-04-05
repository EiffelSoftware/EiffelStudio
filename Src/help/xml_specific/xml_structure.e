indexing
	description: "Structure which receives data contained in a xml document."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: "pascalf"
	date: "$Date$"
	revision: "$Revision$"

class
	XML_STRUCTURE[G ->XML_RESOURCE create make end]

feature -- Building

	make(pars: XML_TREE_PARSER) is
			-- Initialize
		require
			parser_exists: pars /= Void
		local
			l: G
		do
			parser := pars
			!! error_message.make(20)
			initialize_structure
			create_structure
		ensure
			parser_set: parser = parser
		end

	initialize_structure is 
			-- Initialize Current.
		do
			categories.wipe_out
			error_message := Void
		end

	create_structure is
			-- Create structure from the extraction of the parser.
		local
			category: RESOURCE_CATEGORY[G] 
			found: BOOLEAN
			cursor: DS_BILINKED_LIST_CURSOR[XML_NODE]
			node,category_node,doc: XML_ELEMENT
			s: STRING
			txt: XML_TEXT
		do
			!! error_message.make(20)
			doc := parser.root_element
			if not doc.name.is_equal("DOCUMENT") then
				error_message.append("DOCUMENT TAG missing%N")
			else
				cursor := doc.new_cursor
				from
					cursor.start
				until
					cursor.after or found
				loop
					node ?= cursor.item
					if node /= Void then
						if node.name.is_equal("TITLE") then
							txt?= node.first
							if txt /= Void then
								set_title(txt.out)
							end
						end	
						if node.name.is_equal("BODY") then
							txt?= node.first
							if txt /= Void then
								found := TRUE
							end
						else
							cursor.forth
						end	
					else
						cursor.forth
					end
				end
			end
			if found and then error_message.empty then
				category_node := node
				cursor := category_node.new_cursor
				from
					cursor.start
				until
					cursor.after
				loop
					node ?= cursor.item
					if node /= Void and then node.name.is_equal("TOPIC") then
							!! category.make(node, Current)
							categories.extend(category)
					end
					cursor.forth
				end			
			end
		end

feature -- Settings

	set_title(s: STRING) is
			-- Give a title to Current.
		require
			not_void: s/= VOid
		do
			title := clone(s)
		end

	set_error(s: STRING) is
			-- Add an error message to 'error_message'.
		require
			not_void: s/= Void
		do
			error_message.append("%N")
			error_message.append(s)
		end

feature -- Implementation

	title: STRING
		-- Title of the structure.

	error_message: STRING
		-- Message containing possibly the error(s) encountered during the 
		-- parsing.

	parser: XML_TREE_PARSER
		-- XML parser.

	categories: LINKED_LIST [RESOURCE_CATEGORY[G]]
		-- List of Resource Categories.

invariant
	RESOURCE_STRUCTURE_parser_exists: parser /= Void
	RESOURCE_STRUCTURE_categories_exists: categories /= Void
	RESOURCE_STRUCUTRE_error_exists: error_message /= Void
indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"
end -- class XML_STRUCTURE
