indexing
	description: "System Help Manager"
	date: "$Date$"
	revision: "$Revision$"

class
	HELP_MANAGER

feature -- Commands

	show_help is
			-- Show help
		do
			show (url_prefix + default_page_url)			
		end
		
feature -- Access

	last_show_successful: BOOLEAN is
			-- Was last call to `show' successful?
		do
			Result := help_window_handle /= 0
		end

feature {NONE} -- Implementation

	help_window_handle: INTEGER
			-- Handle to help window

	show (a_chm_url: STRING) is
			-- Display help page with url `a_chm_url'.
		do			
		end

	url_prefix: STRING is 
			-- URL prefix for $EiffelGraphicalCompiler$ help files
		once
			Result := (create {APPLICATION_CONSTANTS}).documentation_directory.out + ""
		end
	
	default_page_url: STRING is 
			-- URL default page when opening help
		once
			Result := "index.html"
		end

end -- class HELP_MANAGER
