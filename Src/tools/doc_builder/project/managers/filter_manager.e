indexing
	description: "Manager for document filtering."
	legal: "See notice at end of class."
	status: "See notice at end of class."
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
			initialize
		end		

	initialize is
			-- Load default filters
		local
			l_filter: OUTPUT_FILTER
		do			
			create l_filter.make_with_default_flag (unfiltered_flag, unfiltered)
			add_filter (l_filter)
			set_filter (l_filter) -- (Default filter)
		end	

feature -- Access

	filter: DOCUMENT_FILTER
			-- Current filter type

	filters: HASH_TABLE [DOCUMENT_FILTER, STRING]
			-- Loaded filters hashed by description

	filtered_document (a_doc: DOCUMENT): FILTERED_DOCUMENT is
			-- Filtered document generated from `filter' and `a_doc'
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

	output_filter_by_primary_flag (a_flag: STRING): OUTPUT_FILTER is
			-- Select filter to one matching `a_flag', if any
		local
			l_filter: OUTPUT_FILTER
			done: BOOLEAN
		do
			from
				filters.start
			until
				filters.after or done
			loop
				l_filter ?= filters.item_for_iteration
				if l_filter /= Void then
					if l_filter.primary_output_flag /= Void and then l_filter.primary_output_flag.is_equal (a_flag) then
						Result := l_filter
						done := True
					end
				end
				filters.forth
			end
		end

feature {PREFERENCES_DIALOG, DOCUMENT_PROJECT_PREFERENCES} -- Status setting

	add_filter (a_filter: OUTPUT_FILTER) is
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
			l_parser: XM_EIFFEL_PARSER
			l_html_filter: HTML_FILTER
			l_file: KL_STRING_INPUT_STREAM
			l_string: STRING
		do
			if not retried then
				l_string := a_doc.text.twin
				if not l_string.is_empty then
					create l_file.make (l_string)
					create l_html_filter.make
					l_html_filter.set_filename (a_doc.name)
					l_html_filter.clear
					create l_parser.make
					l_parser.set_callbacks (l_html_filter)
					l_parser.parse_from_stream (l_file)
					check
						ok_parsing: l_parser.is_correct
					end
					Result := l_html_filter.output_string.twin
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

	unique_id: INTEGER
			-- Identifier used for filters	

	filtered_documents: HASH_TABLE [FILTERED_DOCUMENT, STRING] is
			-- Hash of filtered documents by file name
		once
			create Result.make (5)
			Result.compare_objects
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
end -- class FILTER_MANAGER
