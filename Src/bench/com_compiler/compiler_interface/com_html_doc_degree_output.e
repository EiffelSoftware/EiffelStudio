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

create
	make
	
feature {NONE} -- Initialization

	make is
			-- Initialize structure.
		do
			create callbacks.make
		end

feature

	add_callback (interface: IEIFFEL_HTMLDOC_EVENTS_INTERFACE) is
			-- add a interface to the list of callback interfaces
		do
			callbacks.extend (interface)
		end
		
	
	remove_callback (interface: IEIFFEL_HTMLDOC_EVENTS_INTERFACE) is
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
			--
		do
			from 
				callbacks.start
			until
				callbacks.after
			loop
				callbacks.item.put_header (displayed_version_number)
				callbacks.forth
			end
		end
		
	put_string (s: STRING) is
			--
		do
			from 
				callbacks.start
			until
				callbacks.after
			loop
				callbacks.item.put_string (s)
				callbacks.forth
			end
		end

	put_start_documentation (total_num: INTEGER; type: STRING) is
			-- 
		do
			put_string ("Starting Documentation")
			total_number := total_num
		end
		

	put_initializing_documentation is
			-- 
		do
			from 
				callbacks.start
			until
				callbacks.after
			loop
				callbacks.item.put_initializing_documentation
				callbacks.forth
			end
		end
		
	put_class_document_message (c: CLASS_C) is
			-- Put the class name to the output
		do
			from 
				callbacks.start
			until
				callbacks.after
			loop
				callbacks.item.put_class_document_message (c.name_in_upper)
				processed := processed + 1
				if total_number >0 then
					callbacks.item.put_percentage_completed (((processed * 100) / (total_number)).floor)	
				end
				callbacks.forth
			end
		end
		
	put_case_class_message (c: CLASS_C) is
			--
		do
			put_class_document_message (c)	
		end
		
		
feature {NONE} -- Implementation

	callbacks: LINKED_LIST [IEIFFEL_HTMLDOC_EVENTS_INTERFACE]
		-- list of clients to notify
			
	
end -- class COM_HTML_DOC_DEGREE_OUTPUT
