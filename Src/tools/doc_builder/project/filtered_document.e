indexing
	description: "Filtered document."
	date: "$Date$"
	revision: "$Revision$"

class
	FILTERED_DOCUMENT

inherit
	DOCUMENT
		rename
			title as default_title
		redefine
			set_text
		end

create
	make

feature {FILTER_MANAGER} -- Creation

	make (a_doc: DOCUMENT; a_filter: DOCUMENT_FILTER) is
			-- Make from filter
		require
			filter_not_void: a_filter /= Void
		local
			retried: BOOLEAN
		do
			set_text ("")
			if not retried then
				if a_doc.is_persisted then
					make_from_file (a_doc.file)
				else
					make_new (a_doc.name)
				end			
				filter := a_filter				
				set_text (filter_text)
				
				if not filter.description.is_equal (shared_constants.output_constants.unfiltered) then
					filter_document
				end
			else
				print ("%NUnable to filter " + a_doc.name)
			end			
		ensure
			has_filter: filter /= Void
		rescue			
			retried := True
			retry			
		end

feature -- Access

	title: STRING is
			-- Title	
		do		
			if filter.description.is_equal (Output_constants.Studio_desc) then
				Result := filter_tag_value ("studio_title")
			elseif filter.description.is_equal (Output_constants.Envision_desc) then
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
			if filter.description.is_equal (Output_constants.Studio_desc) then
				Result := filter_tag_value ("studio_location")
			elseif filter.description.is_equal (Output_constants.Envision_desc) then
				Result := filter_tag_value ("envision_location")				
			end
		end	

	pseudo_name: STRING is
			-- Pseudo name used for alphabetical ordering
		do
			if filter.description.is_equal (Output_constants.Studio_desc) then
				Result := filter_tag_value ("studio_pseudo_name")
			elseif filter.description.is_equal (Output_constants.Envision_desc) then
				Result := filter_tag_value ("envision_pseudo_name")				
			end
		end		

feature -- Status Setting

	set_text (a_text: STRING) is
			-- Set `text'
		do
			text := a_text		
		end

feature {NONE} -- Commands

	filter_document is
			-- Filter Current and put filtered text into `text'
		local
			retried: BOOLEAN
			l_parser: XM_EIFFEL_PARSER
			l_file: KL_STRING_INPUT_STREAM
		do
			if not retried then
				if text.is_empty then
					-- error
				else
					create l_file.make (text)
					filter.clear
					create l_parser.make
					l_parser.set_callbacks (standard_callbacks_pipe (<<filter>>))
					l_parser.parse_from_stream (l_file)
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
	
	filter_text: STRING is
			-- Filter text
		do
			if True then
					-- TODO: put options here for custom xml formatting
				xml.pre_process
				Result := xml.text.twin												
			else
				Result := xml.text
			end
		end
			
	filter_tag_value (tag_name: STRING): STRING is
			-- For filter `tag_name' retrieve tag content
		local
			l_element, l_toc_element: XM_ELEMENT
		do
			if xml /= Void then
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
		end

	output_constants: OUTPUT_CONSTANTS is
			-- Output constants
		once
			Result := Shared_constants.Output_constants	
		end		

invariant
	has_filter: filter /= Void

end -- class FILTERED_DOCUMENT
