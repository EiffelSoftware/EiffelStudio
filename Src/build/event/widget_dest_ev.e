
class WIDGET_DEST_EV 

inherit

	EVENT

creation

	make
	
feature 

	identifier: INTEGER is
		do
			Result := - Event_const.widget_dest_ev_id
		end;

	make is
		do
			set_symbol (Pixmaps.widget_destroy_pixmap);
			set_label (Event_const.widget_destroy_label);
			event_table.put (Current, - identifier);
		end;

	eiffel_text: STRING is "add_destroy_action (";	

end
