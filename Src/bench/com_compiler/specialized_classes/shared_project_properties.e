indexing
	description: "Shared compiler properties"
	date: "$Date$"
	revision: "$Revision$"

class
	SHARED_PROJECT_PROPERTIES
	
feature -- Access

	html_document_generator: CELL [HTML_DOC_GENERATOR] is
			-- html document generator for a project
		once
			create Result.put (Void)
		end
		
	main_window: MAIN_WINDOW is
			-- main windows for server
		once
			create Result.make_top ("Should not see me!")
		end
		
	generate_html_docs_msg: INTEGER is 0x500
		
feature -- Status Setting

	set_html_document_generator (agenerator: HTML_DOC_GENERATOR) is
			-- set the html_document_generator cell item with 'agenerator'
		require
			non_void_generator: agenerator /= Void
		do
			html_document_generator.put (agenerator)
		end
		

end -- class SHARED_PROJECT_PROPERTIES
