
class MOUSE2U_EV 

inherit

	EVENT

creation

	make

feature 

	identifier: INTEGER is
		do
			Result := - Event_const.mouse2u_ev_id
		end;

	make is
		do
			set_symbol (Pixmaps.mouse2u_pixmap);
			set_label (Event_const.mouse2u_label);
			event_table.put (Current, - identifier);
		end;

	eiffel_text: STRING is "add_button_release_action (2, ";

end
