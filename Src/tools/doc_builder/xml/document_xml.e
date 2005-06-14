indexing
	description: "XM_DOCUMENT for DOCUMENTs"
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

end -- class DOCUMENT_XML
