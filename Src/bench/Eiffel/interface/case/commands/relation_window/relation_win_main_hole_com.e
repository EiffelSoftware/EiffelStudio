indexing
	description: "Relation hole (target) located in the relation window.";
	date: "$Date$";
	revision: "$Revision $"

class 
	RELATION_WIN_MAIN_HOLE_COM

inherit
	EDITOR_WINDOW_HOLE_COM
		redefine
			--editor_window, 
			--stone, stone_type,
			--process_relation
		end

creation
	make

feature -- Properties

	--editor_window: RELATION_WINDOW;
			-- Associated relation window

	stone: STONE is
			-- Stone to be dragged and dropped
		do
			if editor_window.entity /= Void then
				--Result := editor_window.entity.stone
			end
		end;

	stone_type: INTEGER is
			-- Stone type that the hole associated to 
			-- Current command accepts
		do
			Result := Stone_types.relation_type
		end

	symbol: EV_PIXMAP is
			-- Symbol representing the button associated to Current command
		do
			if editor_window.entity = Void then
				Result := Pixmaps.relation_pixmap
			else
				Result := Pixmaps.relation_pixmap
			end
		end

feature -- Update

	process_relation (s: RELATION_STONE) is
			-- Process dropped relation `s'.
		local
			dat: RELATION_DATA;
		do
			dat := s.data;
			if editor_window.entity /= dat then
				editor_window.set_entity (dat)
			end
		end

feature -- Execution

	execute (args: EV_ARGUMENT; data: EV_EVENT_DATA) is
		local
			pnd_event_data: EV_PND_EVENT_DATA

			relation_window: EC_RELATION_WINDOW
			relation_data: RELATION_DATA
		do
			!! relation_window.make (editor_window)

			pnd_event_data ?= data
			if pnd_event_data /= Void then
				relation_data ?= pnd_event_data.data
				if relation_data /= Void then
					relation_window.set_entity (relation_data)
				end	
			end

		end


end -- class RELATION_WIN_MAIN_HOLE_COM
