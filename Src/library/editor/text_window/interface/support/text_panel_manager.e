indexing
	description: "Basic manager for TEXT_PANEL"
	date: "$Date$"
	revision: "$Revision$"

class
	TEXT_PANEL_MANAGER

feature -- Access

	panels: ARRAYED_LIST [TEXT_PANEL] is
			-- 
		once
			create Result.make (2)
		end
		
feature -- Command
	
	refresh_all is
			-- Refresh all panels
		do
			from
				panels.start	
			until
				panels.after
			loop
				if panels.item /= Void then
					panels.item.refresh	
				end				
				panels.forth
			end			
		end		
		
feature -- Status Setting

	add_panel (a_panel: TEXT_PANEL) is
			-- Add new panel
		require
			panel_not_void: a_panel /= Void
		do
			panels.extend (a_panel)
		ensure
			panel_added: panels.has (a_panel)
		end

end
