indexing
	description: "Command that print the selected format in the system tool"
	author: "pascalf"
	date: "$Date$"
	revision: "$Revision$"

class
	SELECT_PAGE_NOTEBOOK

inherit
	
	EV_COMMAND

	CONSTANTS

creation
	make

feature -- Initialization

	make (n : like notebook) is
			-- Initialize
		do
			notebook := n
		end

feature -- Implementation
	
	notebook : EV_NOTEBOOK

feature -- Execution
	
	execute (args: EV_ARGUMENT1 [INTEGER]; data: EV_EVENT_DATA) is
		-- execution of current command 
		do
			if notebook /= Void then
				notebook.set_current_page (args.first)
			end
		end

end -- class PRINT_SYSTEM_COM
