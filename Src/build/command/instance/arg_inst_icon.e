
class ARG_INST_ICON 

inherit

	ICON_STONE
		rename
			set_data as old_set_data
		undefine
			stone_cursor, stone, initialize_transport, init_toolkit -- last by samik
		redefine
			data, set_widget_default
		end;
	ICON_STONE
		undefine
			initialize_transport, init_toolkit -- last by sami
		redefine
			set_data, data, set_widget_default, stone
		select
			set_data
		end;
	HOLE
		rename
			target as source
		redefine
			process_context
		end;
	ERROR_POPUPER;
	CONTEXT_DRAG_SOURCE

feature 

	set_widget_default is
		do
			register;
			initialize_transport;
		end;

-- **************
-- Stone features
-- **************

	data: ARG_INSTANCE;
	
feature {NONE}

	stone: STONE is
		do
			if data.instantiated then
				Result := context
			else
				Result := type
			end
		end;

	context: CONTEXT is
		do
			Result := data.context
		end;
	
	identifier: INTEGER is
		do
			Result := data.identifier
		end;

	type: CONTEXT_TYPE is
		do
			Result := data.type
		end;

	stone_type: INTEGER is
		do
			Result:= Stone_types.context_type
		end;

feature 

	set_data (arg: ARG_INSTANCE) is
		do
			old_set_data (arg);
			data.set_icon_stone (Current);
		end;

	process_context (dropped: CONTEXT_STONE) is
		local 	
			instantiate_cmd: INSTANTIATE_CMD
		do
			if (data.type.eiffel_type.is_equal (dropped.data.eiffel_type)) then
				!!instantiate_cmd.make (data);
				instantiate_cmd.execute (dropped.data);
			else
				error_box.popup (Current, Messages.incomp_er, Void)
			end;
		end;

	popuper_parent: COMPOSITE is
		do
			Result := Current
		end;

end
