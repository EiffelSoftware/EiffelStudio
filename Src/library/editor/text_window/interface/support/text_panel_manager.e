note
	description: "Basic manager for TEXT_PANEL"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class
	TEXT_PANEL_MANAGER

feature -- Access

	panels: ARRAYED_LIST [TEXT_PANEL]
			--
		once
			create Result.make (2)
		end

feature -- Command

	refresh_all
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

	add_panel (a_panel: TEXT_PANEL)
			-- Add new panel
		require
			panel_not_void: a_panel /= Void
		do
			panels.extend (a_panel)
		ensure
			panel_added: panels.has (a_panel)
		end

	remove_panel (a_panel: TEXT_PANEL)
			-- Remove new panel
		require
			a_panel_not_void: a_panel /= Void
		do
			panels.prune_all (a_panel)
		ensure
			panel_removed: not panels.has (a_panel)
		end

note
	copyright:	"Copyright (c) 1984-2017, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"




end
