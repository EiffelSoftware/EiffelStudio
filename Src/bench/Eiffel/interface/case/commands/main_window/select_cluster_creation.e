indexing

	description: 
		"Command representing the format in which clusters may %
		%be created, in a cluster editor.";
	date: "$Date$";
	revision: "$Revision $"


class 
	SELECT_CLUSTER_CREATION 

inherit
	CLUSTER_WINDOW_FORMAT
		redefine
			make,
			stone
		end

creation

	make

feature {NONE} -- Initialization

	make (cw: like cluster_window) is
			-- Create Current command, `stone', and set `cluster_window' to  `cw'.
		do
			cluster_window := cw
		end

feature {EC_BUTTON, HOLE, SELECTABLE} -- Properties

	symbol: EV_PIXMAP is
			-- Symbol representing button to which Current 
			-- command is associated, in unselected state.      
		do
			Result := Pixmaps.normal_cluster_pixmap
		end;

	button: EV_TOOL_BAR_BUTTON

feature {DRAG_SOURCE} -- Drag and drop properties

	stone: NEW_CLUSTER_STONE is
			-- Stone to be dragged and dropped from
			-- associated drag source
		do
			--if cluster_window.draw_window.data /= Void then
			--	!! Result
			--end
		end

feature  {SELECTABLE} -- Selection Properties

	selected_symbol: EV_PIXMAP is
			-- Symbol representing button to which Current command is 
			-- associated, in selected (highlighted) state.
		do
			Result := Pixmaps.selected_cluster_pixmap
		end;

feature -- Execution

	execute (args: EV_ARGUMENT; data: EV_EVENT_DATA) is
		local
			button_event_data: EV_BUTTON_EVENT_DATA
			new_cluster_stone: NEW_CLUSTER_STONE
		do
			--if (cluster_window.current_creation_format /= Current) then
			--	cluster_window.select_cluster_creation
			--end	

			button_event_data ?= data

			if button_event_data /= Void then
				if button_event_data.third_button_pressed then
					if button /= Void then
						!! new_cluster_stone
						button.set_transported_data (new_cluster_stone)
						button.set_data_type (stone_types.cluster_type_pnd)
					end
				end
			end
		end

feature -- Settings

	set_button (b: like button) is
		do
			button := b
		end

end -- class SELECT_CLUSTER_CREATION
