indexing
	description: "XML validator."
	date: "$Date$"
	revision: "$Revision$"

class
	XML_VALIDATOR

feature -- Access

	is_valid_xml_file (a_filename: STRING): BOOLEAN is
			-- Is 'a_filename' valid XML?
		require
			filename_not_void: a_filename /= Void
			a_filename_not_empty: not a_filename.is_empty
		local
			stream: XML_XML_TEXT_READER
			xml: XML_XML_DOCUMENT
			retried: BOOLEAN
			exception: XML_XML_EXCEPTION
			l_actions: ERROR_ACTIONS
		do
			if not retried then
				error_report := Void
				create stream.make_from_url (a_filename.to_cil)
				create xml.make
				xml.load_xml_reader (stream)
				Result := True
			else
				exception ?= feature {EXCEPTION_MANAGER}.last_exception
				if exception /= Void then
					if error_report /= Void then
						error_report.append_error (exception.message, exception.line_number, exception.line_position)	
					else
						create error_report.make ("Invalid XML", exception.message,
							exception.line_number, exception.line_position)
						create l_actions
						error_report.set_error_action (agent l_actions.highlight_error (?))
					end
				end
			end
			stream.close
		rescue
			retried := True
			retry
		end

	is_valid_xml_text (text: STRING): BOOLEAN is
			-- Is 'text' valid XML?
		require
			text_not_void: text /= Void
			text_not_empty: not text.is_empty
		local
			stream: STRING_READER
			xml: XML_XML_DOCUMENT
			retried: BOOLEAN
			exception: XML_XML_EXCEPTION
			l_actions: ERROR_ACTIONS
		do
			if not retried then
				error_report := Void
				create stream.make (text.to_cil)
				create xml.make
				xml.load_text_reader (stream)
				Result := True
			else
				exception ?= feature {EXCEPTION_MANAGER}.last_exception
				if exception /= Void then
					if error_report /= Void then
						error_report.append_error (exception.message, exception.line_number, exception.line_position)	
					else
						create error_report.make ("Invalid XML", exception.message,
							exception.line_number, exception.line_position)
						create l_actions
						error_report.set_error_action (agent l_actions.highlight_error (?))
					end
				end
			end
		rescue
			retried := True
			retry
		end

	error_report: ERROR_REPORT
			-- Error

end -- class XML_VALIDATOR
