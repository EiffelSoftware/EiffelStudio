indexing
	description: "Redirects output to COM interface"
	date: "$Date$"
	revision: "$Revision$"

class
	COM_HTML_DOC_DEGREE_OUTPUT
	
inherit
	DEGREE_OUTPUT
		redefine
			put_string,
			put_header,
			put_class_document_message,
			put_case_class_message,
			put_start_documentation,
			put_initializing_documentation
		end
		
	ERROR_HANDLER
		rename
			make as make_error
		end

create
	make
	
feature {NONE} -- Initialization

	make (a_callback: like callback) is
			-- Initialize structure.
		do
			make_error
			callback := a_callback
		ensure
			callback_set: callback = a_callback
		end

feature -- Access

	interrupted: BOOLEAN
			-- was generation interrupted?		

feature -- Start output features

	put_header (displayed_version_number: STRING) is
			-- output header
		do
			callback.event_output_header (displayed_version_number)
		end
		
	put_string (s: STRING) is
			-- output string `s'
		do
			callback.event_output_string (s)
		end

	put_start_documentation (total_num: INTEGER; type: STRING) is
			-- output start documentation message
		do
			put_string ("Starting Documentation")
			total_number := total_num
		end
		

	put_initializing_documentation is
			-- output initializing message
		do
			callback.event_notify_initalizing_documentation
		end
		
	put_class_document_message (c: CLASS_C) is
			-- Put the class name to the output
		do
			callback.event_notify_percentage_complete (((processed * 100) / (total_number)).floor)	
		end
		
	put_case_class_message (c: CLASS_C) is
			-- output class name
		do
			put_class_document_message (c)	
		end
		
feature {NONE} -- Implementation

	callback: CEIFFEL_HTML_DOCUMENTATION_GENERATOR_COCLASS
		-- client to notify

	interrupt is
			-- interrupts generation of HTML documentation
		do
			interrupted := True
			insert_interrupt_error (False)
			put_string ("Generation interrupted!")
		ensure
			is_interrupted: interrupted
		end
		
invariant
	callback_not_void: callback /= Void
	
end -- class COM_HTML_DOC_DEGREE_OUTPUT
