indexing
	description: "Displays Color Palette, History and ... on the Main Window"
	author: "pascalf"
	date: "$Date$"
	revision: "$Revision$"

class
	MISC_COMPONENT
inherit
	GRAPHICAL_COMPONENT[CLUSTER_DATA]
		redefine
			make,
			update
		end

	ONCES

	CONSTANTS

creation
	make

feature -- Initialization

	make (cont: EV_CONTAINER; caller: MAIN_WINDOW) is
			-- Initialize
		local
			v1: EV_VERTICAL_BOX
			h1: EV_HORIZONTAL_BOX
			com: EV_ROUTINE_COMMAND
			noteb: EV_NOTEBOOK
		do
			precursor(cont, caller)
			main_window ?= caller

			if main_window /= Void then
				entity := main_window.entity
			end

			!! v1.make(cont)
			v1.set_homogeneous(FALSE)
			v1.set_minimum_width(200)	
	
			!! noteb.make(v1)
			!! history_page.make(noteb)
			!! palette_page.make(noteb)
			!! view_page.make(noteb,2)
		end

feature -- Updates

	update is
		do
			if main_window /= Void then
				if entity /= main_window.entity then
					set_entity (main_window.entity)
				end
			end
			view_page.update
			palette_page.update
			history_page.update
		end

	update_from(cluster: CLUSTER_DATA) is
			-- Update Current with cluster 'cluster'.
		require else
			cluster_exists: cluster /= Void
		do
		end

	clear is 
		-- Clear the tree.
		do 

		end

feature {NONE} -- Implementation

	main_window: MAIN_WINDOW

	history_page: HISTORY_PAGE

	palette_page: PALETTE_PAGE

	view_page: VIEW_PAGE

end -- class MISC_COMPONENT
