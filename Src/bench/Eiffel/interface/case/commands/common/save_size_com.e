indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	SAVE_SIZE_COM

inherit
	
	EV_COMMAND
	
	ONCES

	CONSTANTS

creation
	make

feature -- Initialization

	make ( savable : SIZE_SAVABLE ) is
			-- Initialize
		do
			window_resizable := savable
		end

feature -- Implementation

	window_resizable : SIZE_SAVABLE

feature -- Execution

	execute (args: EV_ARGUMENT; data: EV_EVENT_DATA) is
	local
		err : BOOLEAN
		comp : EV_WINDOW
	do
--		comp ?= window_resizable
--		if environment.preference_file_name /= Void then
--			if not err then
--				window_resizable.save_size
--				if comp/= Void then
--					Windows.message(comp,"Mak", void	)
--				else
--			--		Windows.message(Windows.main_graph_window,"Maj", void	)
--				end
--			else
--				if comp/= Void then
--					Windows.message(comp,"Mal", void	)
--				else
--			--		Windows.error(Windows.main_graph_window,"E47", void	) 
--				end
--			end	
--		else
--			Windows.message(comp,"Mg", void	)
--		end
--		rescue
--			err := TRUE
--			retry
	end
	
end -- class SAVE_SIZE_COM
