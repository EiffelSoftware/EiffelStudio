indexing
	description: "Help topic"
	date: "$Date$"
	revision: "$Revision$"

class
	HELP_TOPIC

inherit	
	ARRAYED_LIST [HELP_TOPIC]
		rename 
			make as make_list,
			has as has_in_list
		undefine
			copy,
			is_equal
		end

	TABLE_OF_CONTENTS_CONSTANTS
	
	UTILITY_FUNCTIONS
	
create
	make,
	make_from_url

feature -- Creation

	make (title: STRING) is
			-- Make with `title'
		require
			title_not_void: title /= Void
			title_not_empty: not title.is_empty
		do
			entry_title := title
		end
		
	make_from_url (title: STRING; a_url: STRING) is
			-- Make new topic with `title' and `a_url'
		require
			title_not_void: title /= Void
			title_not_empty: not title.is_empty
			url_not_void: a_url /= Void
			url_not_empty: not a_url.is_empty
		do
			entry_title := title
			url := a_url
		end
		
	make_from_node (a_node: EV_TREE_NODE) is
			-- Make with `a_node' as top node
		require
			node_not_void: a_node /= Void
		local
			l_toc_data: DOCUMENT_TOC_DATA
			l_url_data, l_location: STRING
		do
			make_list (5)	
			is_from_node := True
			l_toc_data ?= a_node.data
			if l_toc_data /= void then			
				l_location := l_toc_data.relative_location
				if l_location /= Void then
					l_location.prepend (Shared_constants.Application_constants.Temporary_help_directory)
					l_location.append (".html")
				end
				make_from_url (l_toc_data.title, l_location)
			else
				l_location := Shared_constants.Application_constants.Temporary_help_directory
				make_from_url ("Unknown Title", l_location)					
			end					
			process_node (a_node)
		end			
		
feature -- Access

	entry_title: STRING
			-- Entry title for topic display
			
	file: PLAIN_TEXT_FILE
			-- File associated with topic
			
	url: STRING
			-- Path to current
			
	relative_url: STRING is
			-- Url relative to structure
		do
			Result := clone (url)
			Result.replace_substring_all (Shared_constants.Application_constants.Temporary_help_directory, "")
		end		

	is_allowed: BOOLEAN is
			-- Is Current `url' representative of an acceptable file
			-- type for display in the associated TOC?
		do
			if url /= Void then
				Result := topic_file_types.has (file_type (short_name (url)))
			end
		end

feature {NONE} -- Implementation

	process_node (a_node: EV_TREE_NODE) is
			-- Process `a_node' as root node recursively to build TOC tree
		require
			node_not_void: a_node /= Void
		local
			l_node: EV_TREE_ITEM
			l_folder: HELP_TOPIC_FOLDER
			l_file: HELP_TOPIC_FILE
		do
			from
				start				
				a_node.start
			until
				a_node.after
			loop
				l_node ?= a_node.item
				if l_node /= Void then
					if l_node.is_empty then
						create l_file.make_from_node (l_node)
						extend (l_file)
					else
						create l_folder.make_from_node (l_node)
						extend (l_folder)
					end
				end
				a_node.forth
			end
		end

	is_from_node: BOOLEAN
			-- Is Current created from tree node?

invariant
	has_title: entry_title /= Void
	has_valid_title: not entry_title.is_empty

end -- class HELP_TOPIC
