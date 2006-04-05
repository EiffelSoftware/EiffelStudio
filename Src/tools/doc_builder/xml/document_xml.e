indexing
	description: "XM_DOCUMENT for DOCUMENTs"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	DOCUMENT_XML

inherit
	XM_DOCUMENT
		rename
			text as xm_text
		end
		
	XML_ROUTINES
		undefine
			copy,
			is_equal,
			string_
		end
	
create
	make_from_file,
	make_from_text,
	make_from_document
	
feature {DOCUMENT} -- Creation

	make_from_file (a_filename: STRING) is
			-- Create from `a_filename'
		require
			filename_not_void: a_filename /= Void
		local
			l_xml: XM_DOCUMENT
		do
			make
			name := a_filename
			l_xml := deserialize_document (a_filename)
			if l_xml /= Void and then not l_xml.is_empty then
				set_root_element (l_xml.root_element)
				valid := True
			end				
		ensure
			has_name: name /= Void
		end

	make_from_text (a_text: STRING) is
			-- Create from `a_text'
		require
			text_not_void: a_text /= Void
		local
			l_xml: XM_DOCUMENT
		do
			make
			l_xml := deserialize_text (a_text)
			if l_xml /= Void and then not l_xml.is_empty then
				set_root_element (l_xml.root_element)
				valid := True
			end	
		end
	
	make_from_document (a_doc: DOCUMENT) is
			-- Make from a document
		require
			document_not_void: a_doc /= Void
		do
			document := a_doc
			name := document.name
			make_from_text (a_doc.text)						
		ensure
			has_name: name /= Void
		end		
	
feature -- Access

	document: DOCUMENT
			-- Document, if any

	text: STRING is
			-- Text
		do
			Result := document_text (Current)	
		end		
		
	valid: BOOLEAN
			-- Valid XML?
	
	name: STRING
			-- Filename
	
feature {DOCUMENT} -- Status Setting

	pre_process is
			-- Pre-process Current
		local
			l_processor: XML_PRE_PROCESSOR
		do			
			create l_processor.make (Current)
			l_processor.process
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
end -- class DOCUMENT_XML
