-- The source of the transport, i.e. the widget which, when clicked on with
-- the right mouse button, initializes the transport must be defined in
-- descendants. It also specifies stone transported.

deferred class DRAG_SOURCE

feature 

	source: WIDGET is
			-- Source of the stone: widget which triggers the 
			-- transport and yields the stone when
			-- clicked on with the right mouse button.
		deferred
		end;

	stone: STONE is
			-- Representative of 
			-- current stone.
		deferred
		end;

feature

	transportable: BOOLEAN is
		local
			st: STONE
		do
			st := stone;
			Result := st /= Void and then
				st.data /= Void
		end;

feature {TRANSPORT}

	update_before_transport is
		do
		end;

feature {NONE}

	initialize_transport is
			-- Initialize the mechanism through which
			-- the current stone may be dragged and
			-- dropped.
		do	
			source.set_action ("<Btn3Down>", transport_command, Current)
			source.set_action ("Shift<Btn3Down>", namer_command, Current)
			source.set_action ("Ctrl<Btn3Down>", create_editor_command, Current)
		end;

	namer_command: RENAME_COMMAND is
			-- Command which takes care of renaming.
		once
			!!Result
		end;

	create_editor_command: CREATE_EDITOR is
		once
			!! Result
		end;

	transport_command: TRANSPORT is
			-- Command which takes care of the 
			-- the transport.
		once
			!! Result
		end;

end
