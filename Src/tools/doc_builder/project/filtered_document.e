indexing
	description: "Filtered document."
	date: "$Date$"
	revision: "$Revision$"

class
	FILTERED_DOCUMENT

inherit
	DOCUMENT
		rename
			text as file_text,
			title as default_title
		end		

create
	make

feature {FILTER_MANAGER} -- Creation

	make (a_doc: DOCUMENT; a_filter: DOCUMENT_FILTER) is
			-- Make from filter
		require
			filter_not_void: a_filter /= Void
		do		
			document := a_doc
			if document.is_persisted then
				make_from_file (document.file)
			else
				make_new (document.name)
			end			
			filter := a_filter
			if not filter.description.is_equal ("Unfiltered") then
				filter_document
			else
				text := file_text
			end
		ensure
			has_filter: filter /= Void
		end

feature -- Access

	document: DOCUMENT
			-- Unfiltered document

	text: STRING
			-- Text

	title: STRING is
			-- Title	
		do		
			if filter.description.is_equal ("EiffelStudio") then
				Result := filter_tag_value ("studio_title")
			elseif filter.description.is_equal ("ENViSioN!") then
				Result := filter_tag_value ("envision_title")				
			end
			if Result = Void or else Result.is_empty then
				Result := default_title
			end
		ensure
			has_result: Result /= Void
		end		

	toc_location: STRING is
			-- TOC location
		do
			if filter.description.is_equal ("EiffelStudio") then
				Result := filter_tag_value ("studio_location")
			elseif filter.description.is_equal ("ENViSioN!") then
				Result := filter_tag_value ("envision_location")				
			end
		end	

	pseudo_name: STRING is
			-- Pseudo name used for alphabetical ordering
		do
			if filter.description.is_equal ("EiffelStudio") then
				Result := filter_tag_value ("studio_pseudo_name")
			elseif filter.description.is_equal ("ENViSioN!") then
				Result := filter_tag_value ("envision_pseudo_name")				
			end
		end		

feature {NONE} -- Commands

	filter_document is
			-- Filter Current and put filtered text into `text'
		local
			retried: BOOLEAN
			l_string: STRING
			l_parser: XM_EIFFEL_PARSER
		do
			if not retried then
				l_string := file_text
				if l_string.is_empty then
					-- error
				else
					filter.clear
					create l_parser.make					
					l_parser.set_callbacks (standard_callbacks_pipe (<<filter>>))
					l_parser.parse_from_string (l_string)
					check
						ok_parsing: l_parser.is_correct
					end
					text := filter.output_string
				end
			end
		rescue
			retried := True
			retry
		end

feature {NONE} -- Implementation

	filter: DOCUMENT_FILTER
			-- Filter
			
	filter_tag_value (tag_name: STRING): STRING is
			-- For filter `tag_name' retrieve tag content
		local
			l_element, l_toc_element: XM_ELEMENT
		do
			l_element ?= xml.root_element.element_by_name ("meta_data")
			if l_element /= Void then
				l_element ?= l_element.element_by_name ("help")
				if l_element /= Void  then
					l_toc_element := l_element.element_by_name ("toc")
				end	
			end			
		
			if l_toc_element /= Void then
				l_element := l_toc_element.element_by_name (tag_name)
				if l_element /= Void then
					Result := l_element.text
				end			
			end
			
			if Result /= Void then
				Result.prune_all ('%N')
				Result.prune_all ('%T')
			end
		end

invariant
	has_source_document: document /= Void
	has_filter: filter /= Void

end -- class FILTERED_DOCUMENT
