
class MOVE_EV 

inherit

	EVENT
		redefine
			is_valid_for_context
		end

creation

	make
	
feature 

	identifier: INTEGER is
		do
			Result := - Event_const.move_ev_id
		end;

	symbol: PIXMAP is
		do
			Result := Pixmaps.move_pixmap
		end;

	internal_name: STRING is
		do
			Result := Event_const.move_label
		end;

	eiffel_text: STRING is "add_move_action (";	

	is_valid_for_context (a_context: CONTEXT): BOOLEAN is
		local
			scale: SCALE_C
		do
			scale ?= a_context;
			Result := not (scale = Void)
		end;

end
