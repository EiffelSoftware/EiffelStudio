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

	filters: HASH_TABLE [DOCUMENT_FILTER, STRING]
			-- Loaded filters hased by description

	filtered_document (a_doc: DOCUMENT): FILTERED_DOCUMENT is
			-- Filtered document generated from `filter' and `a_doc'
		require
			valid_document: a_doc.is_valid_xml
		do
			create Result.make (a_doc, filter)
			add_filtered_document (Result)			
		end		

feature -- Status setting	
		
	set_filter (a_filter: DOCUMENT_FILTER) is
			-- Set current filter to `a_filter'.
		do
			filter := a_filter
		ensure
			filter_set: filter = a_filter
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

	filter_by_description (a_desc: STRING): DOCUMENT_FILTER is
			-- Select filter to one matching `a_desc', if any
		do
			if filters.has (a_desc) then
				Result := filters.item (a_desc)
			end
		end

feature {PREFERENCES_DIALOG} -- Status setting

	add_filter (a_filter: DOCUMENT_FILTER) is
			-- Add new filter
		require
			filter_not_void: a_filter /= Void
		do
			filters.extend (a_filter, a_filter.description.twin)
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
					create l_html_filter.make
					l_html_filter.set_filename (a_doc.name)
					l_html_filter.clear
					create l_parser.make
					l_parser.set_callbacks (l_html_filter)
					l_parser.set_string_mode_mixed
					l_parser.parse_from_string (l_string)
					check
						ok_parsing: l_parser.is_correct
					end
					Result := l_html_filter.output_string
				end
			else
				Result := "Could not produce HTML for document " + a_doc.name
				Result.append ("<BR><BR>Gobo Error description: " + l_parser.last_error_extended_description)
			end
		rescue
			retried := True
			retry		
		end		

feature {NONE} -- Implementation

	load_filters is
			-- Load default filters
		local
			l_unfiltered_filter,
			l_studio_output_filter,
			l_envision_output_filter: OUTPUT_FILTER
		do
			create l_unfiltered_filter.make (unfiltered_flag, unfiltered)		
			create l_studio_output_filter.make (Studio_flag, studio_desc)
			create l_envision_output_filter.make (Envision_flag, envision_desc)
			add_filter (l_unfiltered_filter)
			add_filter (l_studio_output_filter)
			add_filter (l_envision_output_filter)
			
					-- Set default filter
			set_filter (l_unfiltered_filter)
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
