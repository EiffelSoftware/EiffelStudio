indexing

	description: 
		"Command associated to the class hole (ie %
		%target) located in the class window.";
	date: "$Date$";
	revision: "$Revision $"


class 
	CLASS_WIN_CLASS_HOLE_COM

inherit

	EDITOR_WINDOW_HOLE_COM
		redefine
			editor_window--, process_class, stone, stone_type
		end

creation
	make

feature -- Properties

	stone: STONE is
			-- Stone used for drag and drop
		do
			if editor_window.entity /= Void then
				--Result := editor_window.entity.stone
			end
		end

	stone_type: INTEGER is
			-- Stone type that the hole associated to 
			-- Current command accepts
		do
			--Result := Stone_types.class_type
		end

	symbol: EV_PIXMAP is
			-- Symbol representing the button associated to Current command
		do
			--if editor_window.entity = Void then
				--Result := Pixmaps.class_pixmap
			--else
			--	Result := Pixmaps.class_edit_pixmap
			--end
		end

	editor_window: EC_CLASS_WINDOW

feature -- Update

	process_class (cs: CLASS_STONE) is
			-- Set entity of associated class window
			-- to `cs' data.
		do
			set_entity (cs)
		end

feature -- Execution

	execute (args: EV_ARGUMENT; data: EV_EVENT_DATA) is
		local
			class_stone: CLASS_STONE
			class_data: CLASS_DATA

			pnd_event_data: EV_PND_EVENT_DATA
			button_event_data: EV_BUTTON_EVENT_DATA
		do
 			pnd_event_data ?= data
 			if pnd_event_data /= Void then
				class_stone ?= pnd_event_data.data
				if class_stone /= Void then
					editor_window.set_entity (class_stone.data)
				end
			else
	 			button_event_data ?= data
 				if button_event_data /= Void then
					if button_event_data.third_button_pressed  then
 						if editor_window /= Void then
 							if editor_window.entity /= Void then
								if button /= Void then
	 								!! class_stone.make (editor_window.entity)
 									button.set_transported_data (class_stone)
	 								button.set_data_type (stone_types.class_type_pnd)
								end
 							end
 						end
 					end
				end
 			end
		end
end -- class  CLASS_WIN_MAIN_HOLE_COM
