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
		redefine
			make
		end

create
	make
	
feature {NONE} -- Initialization

	make is
			-- Initialize structure.
		do
			Precursor {ERROR_HANDLER}
			create callbacks.make
		end

feature -- Access

	interrupted: BOOLEAN
			-- was generation interrupted?

feature -- Basic Operations

	add_callback (interface: IEIFFEL_HTML_DOCUMENTATION_EVENTS_INTERFACE) is
			-- add a interface to the list of callback interfaces
		do
			callbacks.extend (interface)
		end
		
	
	remove_callback (interface: IEIFFEL_HTML_DOCUMENTATION_EVENTS_INTERFACE) is
			-- remove an interface from the list of callback interfaces
			-- removes only the last occurance (FILO) of 'interface'
		local
			removed: BOOLEAN
		do
			from
				callbacks.finish
			until
				callbacks.before or removed
			loop
				if callbacks.item.is_equal (interface) then
					callbacks.remove
					removed := true
				else
					callbacks.back
				end
			end
		end
		

feature -- Start output features

	put_header (displayed_version_number: STRING) is
			-- output header
		local
			l_bool: BOOLEAN_REF
		do
			from 
				callbacks.start
				l_bool := False
			until
				callbacks.after or l_bool.item
			loop
				callbacks.item.output_header (displayed_version_number)
				callbacks.item.should_continue (l_bool)
				callbacks.forth
			end
			if not l_bool.item then
				interrupt
			end
		end
		
	put_string (s: STRING) is
			-- output string `s'
		local
			l_bool: BOOLEAN_REF
		do
			from 
				callbacks.start
				l_bool := False
			until
				callbacks.after or l_bool.item
			loop
				callbacks.item.output_string (s)
				callbacks.item.should_continue (l_bool)
				callbacks.forth
			end
			if not l_bool.item then
				interrupt
			end
		end

	put_start_documentation (total_num: INTEGER; type: STRING) is
			-- output start documentation message
		do
			put_string ("Starting Documentation")
			total_number := total_num
		end
		

	put_initializing_documentation is
			-- output initializing message
		local
			l_bool: BOOLEAN_REF
		do
			from 
				callbacks.start
				l_bool := False
			until
				callbacks.after or l_bool.item
			loop
				callbacks.item.notify_initalizing_documentation
				callbacks.item.should_continue (l_bool)
				callbacks.forth
			end
			if not l_bool.item then
				interrupt
			end
		end
		
	put_class_document_message (c: CLASS_C) is
			-- Put the class name to the output
		local
			l_bool: BOOLEAN_REF
		do
			from 
				callbacks.start
				l_bool := False
			until
				callbacks.after or l_bool.item
			loop
				callbacks.item.output_class_document_message (c.name_in_upper)
				processed := processed + 1
				if total_number >0 then
					callbacks.item.notify_percentage_complete (((processed * 100) / (total_number)).floor)	
				end
				callbacks.item.should_continue (l_bool)
				callbacks.forth
			end
			if not l_bool.item then
				interrupt
			end
		end
		
	put_case_class_message (c: CLASS_C) is
			-- output class name
		do
			put_class_document_message (c)	
		end
		
feature {NONE} -- Implementation

	callbacks: LINKED_LIST [IEIFFEL_HTML_DOCUMENTATION_EVENTS_INTERFACE]
		-- list of clients to notify

	interrupt is
			-- interrupts generation of HTML documentation
		do
			interrupted := True
			insert_interrupt_error (False)
			put_string ("Generation interrupted!")
		ensure
			is_interrupted: interrupted
		end
		
	
end -- class COM_HTML_DOC_DEGREE_OUTPUT
