indexing
	description: "Structure which receives the data contained in a XML file."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: "pascalf"
	date: "$Date$"
	revision: "$Revision$"

class
	RESOURCE_STRUCTURE

creation
	make

feature -- Initialization

	make(pars: XML_TREE_PARSER) is
			-- Initialize
		require
			parser_exists: pars /= Void
		do
			!! categories.make
			!! table.make(150)
			parser := pars
			!! error_message.make(20)
			initialize_structure
			create_structure
		ensure
			parser_set: parser = pars
		end

	initialize_structure is
			-- Initialize Current.
		do
			categories.wipe_out
			error_message := Void
			table.clear_all
		end

	create_structure is
			-- Create structure from the extraction of the parser.
		local
			category: RESOURCE_CATEGORY
			found: BOOLEAN
			cursor: DS_BILINKED_LIST_CURSOR[XML_NODE]
			node,category_node,doc: XML_ELEMENT
			s: STRING
			txt: XML_TEXT
		do
			!! error_message.make(20)
			if parser.root_element = Void then
				error_message.append("No root element%N")
			else
				doc := parser.root_element
				if not doc.name.is_equal("EIFFEL_DOCUMENT") then
					error_message.append("EIFFEL_DOCUMENT TAG missing%N")
				else
					cursor := doc.new_cursor
					from
						cursor.start
					until
						cursor.after or found
					loop
						node ?= cursor.item
						if node /= Void then
							if node.name.is_equal("TOPIC") then
								txt?= node.first
								if txt /= Void then
									io.putstring(txt.out)
								end
							end	
							if node.name.is_equal("HEAD") then
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
			else
				io.putstring(error_message)
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

feature -- Access

	has_category(s: STRING): BOOLEAN is
			-- Does Current has category pointed by 's'.
		require
			not_void: s /= Void
		do
			Result := (find_category_with_name(s,categories) /= Void)
		end

	find_category_with_name(s: STRING;l: LINKED_LIST [RESOURCE_CATEGORY]): RESOURCE_CATEGORY is
			-- Find the category corresponding to 's'.
			-- return Void if not found.
		require
			not_void: s /= Void
		do		
			s.prune_all('%R')
			s.prune_all('%T')
			s.prune_all('%N')
			if smart_search_item /= Void and then 
				smart_search_item.description.is_equal(s) then
				Result := smart_search_item
			else
				from
					l.start
				until
					l.after or Result/=Void 
				loop
					if l.item.description.is_equal(s) then
						Result := l.item
					else
						Result := find_category_with_name(s,l.item.categories)
					end
					l.forth
				end
				if Result /= Void then
					smart_search_item := Result
				end
			end
		end

feature {NONE} -- Smart 

	smart_search_item: RESOURCE_CATEGORY
		-- RESOURCE_CATEGORY

feature -- Implementation

	table: RESOURCES_TABLE
		-- Table of Resources , the key used is their "short" name.

	title: STRING
		-- Title of the structure.

	error_message: STRING
		-- Message containing possibly the error(s) encountered during the 
		-- parsing.

	parser: XML_TREE_PARSER
		-- XML parser.

	categories: LINKED_LIST [RESOURCE_CATEGORY]
		-- List of Resource Categories.

invariant
	RESOURCE_STRUCTURE_parser_exists: parser /= Void
	RESOURCE_STRUCTURE_categories_exists: categories /= Void
	RESOURCE_STRUCUTRE_error_exists: error_message /= Void
	RESOURCE_STRUCTURE_table_exists: table /= Void
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
end -- class RESOURCE_STRUCTURE
