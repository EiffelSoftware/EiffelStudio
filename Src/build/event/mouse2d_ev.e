
class MOUSE2D_EV 

inherit

	EVENT

creation

	make
	
feature 

	identifier: INTEGER is
		do
			Result := - Event_const.mouse2d_ev_id
		end;

	make is
		do
			set_symbol (Pixmaps.mouse2d_pixmap);
			set_label (Event_const.mouse2d_label);
			event_table.put (Current, - identifier);
		end;

	eiffel_text: STRING is "add_button_press_action (2, ";

end
