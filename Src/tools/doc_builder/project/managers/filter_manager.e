indexing
	description: "Manager for document filtering."
	date: "$Date$"
	revision: "$Revision$"

class
	FILTER_MANAGER

inherit
	XM_CALLBACKS_FILTER_FACTORY
		export {NONE} all end

	OUTPUT_CONSTANTS

create
	make

feature {DOCUMENT_PROJECT} -- Creation

	make is
			-- Create
		do
			create filters.make (2)
			load_filters
		end		

feature -- Access

	filter: DOCUMENT_FILTER
			-- Current filter type

	filters: ARRAYED_LIST [DOCUMENT_FILTER]
			-- Loaded filters		

	filtered_document (a_doc: DOCUMENT): FILTERED_DOCUMENT is
			-- Filtered document generated from `filter' and `a_doc'
		require
			valid_document: a_doc.is_valid_xml
		do
			if filtered_documents.has (a_doc.name) then
				Result := filtered_documents.item (a_doc.name)
			else
				create Result.make (a_doc, filter)
				add_filtered_document (Result)			
			end
		end		

feature -- Status setting	
		
	set_filter (a_filter: DOCUMENT_FILTER) is
			-- Set current filter to `a_filter'.
		require
			valid_filter: filters.has (a_filter)
		do
			filter := a_filter
		ensure
			filter_set: filter = a_filter
		end		

	set_filter_by_description (a_desc: STRING) is
			-- Set filter to one match `a_desc'
		require
			a_desc_not_void: a_desc /= Void
			a_desc_not_empty: not a_desc.is_empty
		do
			from
				filters.start
			until
				filters.after
			loop
				if filters.item.description.is_equal (a_desc) then
					set_filter (filters.item)
				end
				filters.forth
			end				
		end	

	add_filtered_document (a_doc: FILTERED_DOCUMENT) is
			-- Add `a_doc' to `filtered_documents'
		require
			doc_not_void: a_doc /= Void
		do
			if not Filtered_documents.has (a_doc.name) then
				Filtered_documents.extend (a_doc, a_doc.name)
			end
		end		

	set_studio_filtered is
			-- Set EiffelStudio filtered
		local
			l_studio_filter: STUDIO_OUTPUT_FILTER
		do
			create l_studio_filter.make (next_unique_id, Studio_flag)
			set_filter (l_studio_filter)			
		end
		
	set_envision_filtered is
			-- Set ENViSioN! filtered
		local
			l_env_filter: ENVISION_OUTPUT_FILTER
		do
			create l_env_filter.make (next_unique_id, Envision_flag)
			set_filter (l_env_filter)			
		end

feature {NONE} -- Status setting

	add_filter (a_filter: DOCUMENT_FILTER) is
			-- Add new filter
		require
			filter_not_void: a_filter /= Void
		do
			filters.extend (a_filter)
		end	

feature -- Conversion

	convert_to_html (a_doc: FILTERED_DOCUMENT): STRING is
			-- Convert `a_doc' to HTML.  If unsuccessful return error string.
		local
			retried: BOOLEAN
			l_string: STRING
			l_parser: XM_EIFFEL_PARSER
			l_html_filter: HTML_FILTER
		do
			if not retried then
				l_string := a_doc.text
				if not l_string.is_empty then					
					create l_html_filter.make (next_unique_id)
					l_html_filter.clear
					create l_parser.make
					l_parser.set_callbacks (l_html_filter)
					l_parser.parse_from_string (l_string)
					check
						ok_parsing: l_parser.is_correct
					end
					Result := l_html_filter.output_string
					write_to_file (Result, False)
				end
			else
				Result := "Could not produce HTML for document " + a_doc.name
				Result.append ("<BR><BR>Gobo Error description: " + l_parser.last_error_extended_description)
				write_to_file (Result, True)
			end
		rescue
			retried := True
			retry		
		end		

	write_to_file (s: STRING; error: BOOLEAN) is
			-- 
		local
			f: PLAIN_TEXT_FILE
		do
			create f.make ("C:\no_html_convert.html")
			
			if not f.exists then
				f.create_read_write
				f.close
			end
			if error then
				f.open_append
			else
				f.open_write
			end
			
			f.put_string (s + "<br><br><br>")
			f.close
		end

feature {NONE} -- Implementation

	load_filters is
			-- Load default filters
		local
			l_unfiltered_filter: OUTPUT_FILTER
			l_studio_output_filter: STUDIO_OUTPUT_FILTER
			l_envision_output_filter: ENVISION_OUTPUT_FILTER
			l_html_filter: HTML_FILTER
		do
			create l_unfiltered_filter.make (next_unique_id, "")
			create l_html_filter.make (next_unique_id)
			create l_studio_output_filter.make (next_unique_id, Studio_flag)
			create l_envision_output_filter.make (next_unique_id, Envision_flag)
			add_filter (l_unfiltered_filter)
			add_filter (l_html_filter)
			add_filter (l_studio_output_filter)
			add_filter (l_envision_output_filter)
			
					-- Set default filter
			set_filter (l_unfiltered_filter)
		end

	next_unique_id: INTEGER is
			-- Produce a unique value for filter identification
		do
			Result := unique_id + 1
		end		

	unique_id: INTEGER
			-- Identifier used for filters	

	filtered_documents: HASH_TABLE [FILTERED_DOCUMENT, STRING] is
			-- Hash of filtered documents by file name
		once
			create Result.make (5)
			Result.compare_objects
		end

end -- class FILTER_MANAGER
