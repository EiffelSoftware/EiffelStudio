
class MOUSE1D_EV 

inherit

	EVENT

creation

	make
	
feature 

	identifier: INTEGER is
		do
			Result := - Event_const.mouse1d_ev_id
		end;

	make is
		do
			set_symbol (Pixmaps.mouse1d_pixmap);
			set_label (Event_const.mouse1d_label);
			event_table.put (Current, - identifier);
		end;

	eiffel_text: STRING is "add_button_press_action (1, ";	

end
