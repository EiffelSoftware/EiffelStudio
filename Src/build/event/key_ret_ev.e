
class KEY_RET_EV 

inherit

	EV_IDENTIFIERS
		export
			{NONE} all
		end;

	EVENT
		redefine
			is_valid_for_context
		
		end;

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
			Result := - key_return_ev_id
		end;

	make is
		do
			set_symbol (Key_return_pixmap);
			set_label (Key_return_label);
			event_table.put (Current, - identifier);
		end;

	eiffel_text: STRING is "set_action (%"<Key>Return%", ";

	is_valid_for_context (a_context: CONTEXT): BOOLEAN is
		local
			a_tf: TEXT_FIELD_C;
		do
			a_tf ?= a_context;
			Result := not (a_tf = Void);
		end;

end
