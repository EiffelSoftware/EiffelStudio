
class KEY_RET_EV 

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
			Result := - Event_const.key_return_ev_id
		end;

	make is
		do
			set_symbol (Pixmaps.key_return_pixmap);
			set_label (Event_const.key_return_label);
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
