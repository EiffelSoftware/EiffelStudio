indexing
	description: "Command that print the selected format in the system tool"
	author: "pascalf"
	date: "$Date$"
	revision: "$Revision$"

class
	PRINT_SYSTEM_COM

inherit
	
	EV_COMMAND

	CONSTANTS

creation
	make

feature -- Initialization

	make(s : like system_w ) is
			-- Initialize
		do
			system_w := s
		end

feature -- Implementation
	
	system_w : EC_SYSTEM_WINDOW

	pr : EC_PRINT_WINDOW
feature -- Execution
	
	execute (args: EV_ARGUMENT; data: EV_EVENT_DATA) is
		-- execution of current command 
	--	local
		--	ff2 : SHOW_MODIFIED_CLASSES
		--	ff3 : SHOW_COMPONENTS
		do
			--ff2 ?= system_w.Current_format
		--	ff3 ?= system_w.Current_format
		--	if ff2=Void and ff3 = Void then
				if pr=Void then
					!! pr.make (system_w)
				end
				pr.set_title (Environment.documentation_directory)
				pr.show		--	end
		end

end -- class PRINT_SYSTEM_COM
