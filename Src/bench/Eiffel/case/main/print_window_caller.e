indexing

	description: "Abstract class for descendents that wants to print documents.";
	date: "$Date$";
	revision: "$Revision $"

deferred class PRINT_WINDOW_CALLER

feature -- Output
	
	print_document (target: STRING; 
			filter_format: STRING; 
			print_graphics: BOOLEAN) is
			-- Print document to `target' `to_disk'
			-- with filter `filter_format'.
		deferred
		end

end -- class PRINT_WINDOW_CALLER
