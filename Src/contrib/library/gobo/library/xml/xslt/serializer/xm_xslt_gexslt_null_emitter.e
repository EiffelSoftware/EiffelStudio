indexing

	description:

	"Emitters that write nothing at all - for performance mesurements."

library: "Gobo Eiffel XSLT Library"
copyright: "Copyright (c) 2005, Colin Adams and others"
license: "MIT License"
date: "$Date$"
revision: "$Revision$"

class XM_XSLT_GEXSLT_NULL_EMITTER

inherit

	XM_XSLT_EMITTER

create

	make

feature {NONE} -- Initialization

	make (a_serializer: XM_XSLT_SERIALIZER; some_output_properties: XM_XSLT_OUTPUT_PROPERTIES) is
			-- Establish invariant.
		require
			serializer_not_void: a_serializer /= Void
			output_properties_not_void: some_output_properties /= Void
		do
			serializer := a_serializer
			output_properties := some_output_properties
		ensure
			serializer_set: serializer = a_serializer
			outputter_properties_set: output_properties = some_output_properties
		end

feature -- Events

	open is
			-- Notify start of event stream.
		do
			is_open := True
		end

	start_document is
			-- New document
		do
			is_document_started := True
			--  The opening of the output
			--  file is deferred until some content is written to it.
		end

	end_document is
			-- Notify the end of the document
		do
			is_document_started := False
		end

	close is
			-- Notify end of event stream.
		do
			is_open := False
		end

	start_element (a_name_code: INTEGER; a_type_code: INTEGER; properties: INTEGER) is
			-- Notify the start of an element
		do
			mark_as_written
		end

	notify_namespace (a_namespace_code: INTEGER; properties: INTEGER) is
			-- Notify a namespace declaration.
		do
			mark_as_written
		end

	notify_attribute (a_name_code: INTEGER; a_type_code: INTEGER; a_value: STRING; properties: INTEGER) is
			-- Notify an attribute.
		do
			mark_as_written
		end
	

	start_content is
			-- Notify the start of the content, that is, the completion of all attributes and namespaces.
		do
			mark_as_written
		end

	end_element is
			-- Notify the end of an element.
		do
			mark_as_written
		end

	notify_characters (chars: STRING; properties: INTEGER) is
			-- Notify character data.
		do
			mark_as_written
		end

	notify_processing_instruction (a_name: STRING; a_data_string: STRING; properties: INTEGER) is
			-- Notify a processing instruction.
		do
			mark_as_written
		end

	notify_comment (a_content_string: STRING; properties: INTEGER) is
			-- Notify a comment.
		do
			mark_as_written
		end

end
	
