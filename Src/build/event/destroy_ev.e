
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

	symbol: PIXMAP is
		do
			Result := Pixmaps.widget_destroy_pixmap
		end;

	internal_name: STRING is
		do
			Result := Event_const.widget_destroy_label
		end;

	eiffel_text: STRING is "add_destroy_action (";	

end
