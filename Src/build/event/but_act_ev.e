
class BUT_ACT_EV 

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
			Result := - Event_const.but_act_ev_id
		end;

	symbol: PIXMAP is
		do
			Result := Pixmaps.button_activate_pixmap
		end;

	internal_name: STRING is
		do
			Result := Event_const.button_activate_label
		end;

	eiffel_text: STRING is "add_activate_action (";

	is_valid_for_context (a_context: CONTEXT): BOOLEAN is
		local
			a_button: BUTTON_C;
			toggle: TOGGLE_B_C;
		do
			a_button ?= a_context;
			toggle ?= a_context;
			Result := (not (a_button = Void)) and (toggle = Void);
		end;

end
