indexing

	description: 
		"Command associated to the class hole located %
		%in the feature window.";
	date: "$Date$";
	revision: "$Revision $"

class 
	FEATURE_WIN_CLASS_HOLE_COM

inherit

	EDITOR_WINDOW_HOLE_COM
		redefine
			editor_window
			--, process_class, stone, stone_type
		end

creation

	make

feature -- Properties

	editor_window: EC_CLASS_WINDOW;
			-- Associated feature window

	stone: STONE is
			-- Stone to be dragged
		do
			if editor_window.entity /= Void then
				--Result := editor_window.class_entity.stone
			end
		end

	stone_type: INTEGER is
			-- Stone type that Current hole accepts
		do
			Result := Stone_types.class_type
		end

	symbol: EV_PIXMAP is
			-- Symbol representing Current button
		once
			--Result := Pixmaps.class_pixmap
		end

feature -- Dropped stone processing

	process_class (s: CLASS_STONE) is
			-- Process class stone `s' dropped in Currrent associated hole.
			--| Do nothing for the time being.
		do
		end

feature -- Execution

	execute (args: EV_ARGUMENT; data: EV_EVENT_DATA) is
		local
			feature_stone: FEATURE_STONE
			feature_data: FEATURE_DATA
			feature_window: EC_FEATURE_WINDOW

			pnd_event_data: EV_PND_EVENT_DATA
			button_event_data: EV_BUTTON_EVENT_DATA
		do
			!! feature_window.make (editor_window)
 			pnd_event_data ?= data
 			if pnd_event_data /= Void then
				feature_data ?= pnd_event_data.data
				if feature_data /= Void then
					if feature_window /= Void then
						feature_window.set_entity (feature_data)
					end
				end
 			end
		end

end -- class FEATURE_WIN_CLASS_HOLE_COM
