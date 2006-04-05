indexing
	description: "Table of contents node in XML representation."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	XML_TABLE_OF_CONTENTS_NODE

inherit
	XM_ELEMENT		
	
	TABLE_OF_CONTENTS_CONSTANTS
		undefine
			is_equal,
			copy
		end			

	UTILITY_FUNCTIONS
		undefine
			is_equal,
			copy
		end

	HASHABLE
		undefine
			is_equal,
			copy
		end

create
	make,
	make_root

feature -- Creation

	make (a_id: INTEGER; a_parent: XM_ELEMENT; a_url, a_title: STRING; is_parent: BOOLEAN) is
			-- New node
		require
			valid_id: a_id > 0
			parent_not_void: a_parent /= Void
			title_not_void: a_title /= Void
		do
			id := a_id
			if a_url /= Void then
				url := a_url				
			end
			if is_parent then
				make_child (a_parent, Folder_string, Void)
			else
				make_child (a_parent, File_string, Void)
			end
			title := a_title
			put_last (create {XM_ATTRIBUTE}.make (Id_string, Void, a_id.out, Current))
			put_last (create {XM_ATTRIBUTE}.make (Title_string, Void, title, Current))
			if url /= Void then
				put_last (create {XM_ATTRIBUTE}.make (Url_string, Void, url, Current))
			end			
		ensure
			has_valid_id: attribute_by_name (Id_string).value.to_integer > 0
			has_title: has_attribute_by_name (Title_string)
		end	

feature -- Retrieval

	element_by_title_location (a_titles: ARRAY [STRING]): like Current is
			-- Element at title location of `titles'.  Loop through elements
			-- of Current and match title strings.  
		require
			titles_not_void: a_titles /= Void
			titles_not_empty: not a_titles.is_empty
		local
			cnt: INTEGER
			l_curr_el,
			l_par_el: like Current
			l_elements: DS_LIST [XM_ELEMENT]
			l_matches: ARRAYED_LIST [like Current]
			l_new_titles: like a_titles
			l_first_item: STRING
		do						
			from
				l_elements := elements
				create l_matches.make (a_titles.count)
				l_first_item := a_titles.item (a_titles.lower)
				l_elements.start				
			until
				l_elements.after
			loop				
				l_curr_el ?= l_elements.item_for_iteration
				if 
					l_curr_el.has_attribute_by_name (Title_string) and then							
					l_curr_el.attribute_by_name (Title_string).value.is_equal (l_first_item)
				then
					l_matches.extend (l_curr_el)
				end
				l_elements.forth
			end
			if not l_matches.is_empty then		
				create l_new_titles.make_from_array (a_titles.subarray (a_titles.lower + 1, a_titles.upper))
						-- Limitation:  currently only take the FIRST match, so won't work
						-- where nodes have same titles on same level
				if not l_new_titles.is_empty then
					Result := l_matches.first.element_by_title_location  (l_new_titles)
				else
					Result := l_matches.first
				end
			end
		end
		
feature -- Query		
	
	is_index: BOOLEAN is
			-- Is index node?
		local
			l_att: XM_ATTRIBUTE
			l_att_value: STRING
		do
			l_att := clone (attribute_by_name (Url_string))
			if l_att /= Void then
				l_att_value := l_att.value
				if l_att_value /= Void and then not l_att_value.is_empty then
					Result := short_name (l_att_value).is_equal (Default_url)
				end
			end			
		end
		
	is_file: BOOLEAN is
			-- Represents existing file node?
		do
			Result := name.is_equal (File_string)	
		end
		
	is_directory: BOOLEAN is
			-- Represent physcial directory?
		do
			if url /= Void then
				Result := (create {DIRECTORY}.make (url)).exists	
			end				
		end			
		
	has_child: BOOLEAN is
			-- Does Current have a child file OR folder node?
		do
			Result := not elements.is_empty	
		end		
		
	has_file: BOOLEAN is
			-- Does element contain a child file node?
		local
			l_el: like Current
			l_elements: DS_LIST [XM_ELEMENT] 
		do
			from
				l_elements := elements
				l_elements.start
			until
				l_elements.after or Result
			loop
				l_el ?= l_elements.item_for_iteration
				Result := l_el.is_file
				l_elements.forth
			end	
		end
		
	has_index: BOOLEAN is
			-- Does element contain a child index node?
		local
			l_el: like Current
			l_elements: DS_LIST [XM_ELEMENT]
		do
			from 
				l_elements := elements
				l_elements.start
			until
				l_elements.after or Result
			loop
				l_el ?= l_elements.item_for_iteration
				Result := l_el.is_index
				l_elements.forth
			end	
		end	

	url_exists: BOOLEAN is
			-- Does `url' represent an existing file?
		do
			if url /= Void then
				Result := (create {PLAIN_TEXT_FILE}.make (url)).exists
			end			
		end

feature {XML_TABLE_OF_CONTENTS} -- Status Setting
	
	set_url (a_url: STRING) is
			-- Set `url'
		require
			url_not_void: a_url /= Void			
		do
			url := a_url
			attribute_by_name (Url_string).set_value (a_url)
		ensure
			url_set: url = a_url and attribute_by_name (Url_string).value.is_equal (a_url)
		end
		
	set_title (a_title: STRING) is
			-- Set `title'
		require
			title_not_void: a_title /= Void			
		do
			title := a_title
			attribute_by_name (Title_string).set_value (a_title)
		ensure
			title_set: title = a_title and attribute_by_name (Title_string).value.is_equal (a_title)
		end

feature -- Access
	
	id: INTEGER
			-- Identifier
	
	url: STRING
			-- Url attribute
			
	title: STRING
			-- Title attribute
	
feature {NONE} -- Implementation

	hash_code: INTEGER is
			-- Hash Code
		do
			Result := id	
		end		
	
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
end -- class XML_TABLE_OF_CONTENTS_NODE
