
class INPUT_EV 

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
			Result := - Event_const.input_ev_id
		end;

	symbol: PIXMAP is
		do
			Result := Pixmaps.input_pixmap
		end;

	internal_name: STRING is
		do
			Result := Event_const.input_label
		end;

	eiffel_text: STRING is "add_input_action (";	

	is_valid_for_context (a_context: CONTEXT): BOOLEAN is
		local
			dr_area: DR_AREA_C
		do
			dr_area ?= a_context;
			Result := not (dr_area = Void)
		end;

	specific_add (a_widget: WIDGET; a_command: COMMAND) is
			-- Add	`a_command' to `a_widget' according to the 
			-- kind of event.
		local
			drawing_area_widget: DRAWING_AREA
		do
			drawing_area_widget ?= a_widget
			if drawing_area_widget /= Void then
				drawing_area_widget.add_input_action (a_command, Void)
			end
		end

	specific_remove (a_widget: WIDGET; a_command: COMMAND	) is
			-- Remove `a_command' from `a_widget' according to the
			-- kind of event.
		local
			drawing_area_widget: DRAWING_AREA
		do
			drawing_area_widget ?= a_widget
			if drawing_area_widget /= Void then
				drawing_area_widget.remove_input_action (a_command, Void)
			end
		end

end
