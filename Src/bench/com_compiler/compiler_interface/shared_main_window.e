indexing
	description: "Shared main window"
	date: "$Date$"
	revision: "$Revision$"

class
	SHARED_MAIN_WINDOW
	

feature -- Access

	main_window: MAIN_WINDOW is
			-- main window of compiler
		once
			create Result.make_top ("Should not see me!")
		end
		
	html_doc_generator: CELL [HTML_DOC_GENERATOR] is
			-- 
		once
			create Result.put (Void)
		end
		
	
feature -- Status Setting

	set_html_doc_generator (item: HTML_DOC_GENERATOR) is
			-- set the item of the html doc generator
		do
			html_doc_generator.put (item)
		end
		

end -- class SHARED_MAIN_WINDOW
