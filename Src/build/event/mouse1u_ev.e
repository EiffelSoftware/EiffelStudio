
class MOUSE1U_EV 

inherit

	EVENT

creation

	make
	
feature 

	identifier: INTEGER is
		do
			Result := - Event_const.mouse1u_ev_id
		end;

	make is
		do
			set_symbol (Pixmaps.mouse1u_pixmap);
			set_label (Event_const.mouse1u_label);
			event_table.put (Current, - identifier);
		end;

	eiffel_text: STRING is "add_button_release_action (1, ";

end
