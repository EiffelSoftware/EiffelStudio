indexing
	description: "Command that print the selected format in the system tool"
	author: "pascalf"
	date: "$Date$"
	revision: "$Revision$"

class
	SELECT_PAGE_MENU
inherit
	
	EV_COMMAND

	CONSTANTS

creation
	make

feature -- Initialization

	make (n : like notebook; p: like print_window) is
			-- Initialize
		do
			notebook := n
			print_window := p
		end

feature -- Implementation
	
	notebook : EV_NOTEBOOK
	print_window: EC_PRINT_WINDOW

feature -- Execution
	
	execute (args: EV_ARGUMENT1 [INTEGER]; data: EV_EVENT_DATA) is
		-- execution of current command 
		local
			item: EV_RADIO_MENU_ITEM
		do
			if print_window /= Void then
				if notebook /= Void then
					inspect
						notebook.current_page
					when 1 then
						item := print_window.printer_i
						item.set_selected(true)
							-- The set_state of RADIO_MENU_ITEM should manage the peers
					when 2 then
						item := print_window.printer_i
						item.set_selected (true)
					end
				end
			end
		end

end -- class PRINT_SYSTEM_COM
