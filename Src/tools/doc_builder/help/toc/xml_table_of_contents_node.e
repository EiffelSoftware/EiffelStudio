indexing
	description: "Table of contents node in XMl representation."
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
	
end -- class XML_TABLE_OF_CONTENTS_NODE
