indexing
	description: "Drawing Area a Cluster Window"
	author: "pascalf"
	date: "$Date$"
	revision: "$Revision$"

class
	DRAWING_COMPONENT

inherit

	GRAPHICAL_COMPONENT [CLUSTER_DATA]
		redefine
			make,
			update
		end

	ONCES

creation
	make

feature -- Initialization

	make (cont: EV_CONTAINER; caller: MAIN_WINDOW) is
		do
			precursor(cont, caller)

			main_window ?= caller

			!! drawing_area.make(cont, main_window)

			observer_management.add_observer (system, Current)
		end

feature -- Updates

	update is
		do
			if drawing_area /= Void then
				if main_window /= Void then
					drawing_area.set_cluster (main_window.entity)
				end
			end
		end

	Update_from (cluster: CLUSTER_DATA) is
			-- Update from 'ent'
		do
		end

	Clear is do end

feature -- Properties

	main_window: MAIN_WINDOW

	drawing_area: WORKAREA

end -- class DRAWING_COMPONENT
