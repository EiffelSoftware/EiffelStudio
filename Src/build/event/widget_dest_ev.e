
class WIDGET_DEST_EV 

inherit

	EV_IDENTIFIERS
		export
			{NONE} all
		end;

	EVENT
		;

	EV_PIXMAPS
		export
			{NONE} all
		end;

	EVENT_LABELS
		export
			{NONE} all
		end


creation

	make

	
feature 

	identifier: INTEGER is
		do
			Result := - widget_dest_ev_id
		end;

	make is
		do
			set_symbol (Widget_destroy_pixmap);
			set_label (Widget_destroy_label);
			event_table.put (Current, - identifier);
		end;

	eiffel_text: STRING is "add_destroy_action (";	

end
