indexing
	description: 
		"Command corresponding to the main hole (ie target %
		%hole) in a cluster editor window."
	date: "$Date$";
	revision: "$Revision $"

class 
	CLUSTER_WIN_MAIN_HOLE_COM

inherit
	EDITOR_WINDOW_HOLE_COM
		redefine
			editor_window
			--process_cluster, stone, stone_type
		end

creation
	make

feature -- Properties

	editor_window: MAIN_WINDOW
			-- Associated cluster window

	stone: STONE is
			-- Stone that is to be dragged
		do
			if editor_window.entity /= Void then
				--Result := editor_window.entity.stone
			end
		end

	stone_type: INTEGER is
			-- Stone type that the hole associated to 
			-- Current command accepts
		do
			Result := Stone_types.cluster_type
		end;

	symbol: EV_PIXMAP is
			-- Symbol representing the button associated to Current command
		do
			if editor_window.entity = Void then
				Result := Pixmaps.cluster_pixmap
			else
				Result := Pixmaps.cluster_pixmap
			end
		end

feature -- Update

	process_cluster (cs: CLUSTER_STONE) is
			-- Update editor_window with dropped stone
			-- `cs' data.
		do
			set_entity (cs)
		end;

feature -- Execution

	execute (args: EV_ARGUMENT; data: EV_EVENT_DATA) is
		local
			pnd_event_data: EV_PND_EVENT_DATA

			cluster_window: MAIN_WINDOW
			cluster_data: CLUSTER_DATA
		do
			!! cluster_window.make_top_level

			pnd_event_data ?= data
			if pnd_event_data /= Void then
				cluster_data ?= pnd_event_data.data
				if cluster_data /= Void then
					cluster_window.set_entity (cluster_data)
				end
			else
				if editor_window /= Void then
					cluster_window.set_entity (editor_window.entity)
				end
			end
		end				


end -- class CLUSTER_WIN_MAIN_HOLE_COM
