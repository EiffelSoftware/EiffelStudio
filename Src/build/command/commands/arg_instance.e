-- Argument which is instantiated.
-- It may not be instantiated if the
-- corresponding context was deleted.

class ARG_INSTANCE 

inherit

	TYPE_DATA
 
creation

	session_init, storage_init
	
feature 

	session_init (other: ARG) is
		do
			type := other.type
		end;

	storage_init (t: CONTEXT_TYPE; c: CONTEXT) is
		do
			type := t;
			context := c
		end;

	instantiated: BOOLEAN is
		do
			Result := not (context = Void or else
				context.deleted)
		end
	
feature {NONE}

	associated_icon_stone: ARG_INST_ICON;

feature 

	reset_context is 
		do
			context := Void;
			if associated_icon_stone /= Void then
				associated_icon_stone.set_symbol (type.symbol);
				associated_icon_stone.set_label (type.label);
			end
		end;

	reset is 
		do
			associated_icon_stone := Void
		end;

	set_icon_stone (i: ARG_INST_ICON) is
		do
			associated_icon_stone := i
		end;

	set_context (other: CONTEXT_STONE) is
		require
			not_void_other: not (other = Void)
		do
			context := other.data;
			if associated_icon_stone /= Void then
				associated_icon_stone.set_symbol (context.symbol);
				associated_icon_stone.set_label (context.label);
			end
		end;

	type: CONTEXT_TYPE;

	context: CONTEXT;

-- **************
-- Stone features
-- **************

	identifier: INTEGER is
			-- Unique identifier for storage
			-- and retrieval
		do
			if instantiated then
				Result := context.identifier
			else
				Result := - type.identifier
			end
		end;

	data: ARG_INSTANCE is
		do
			Result := Current
		end;

	label: STRING is
		do
			if instantiated then
				Result := context.label
			else
				Result := type.label
			end;
		end;

	symbol: PIXMAP is
		do
			if instantiated then
				Result := context.symbol
			else
				Result := type.symbol
			end;
		end;

	source: WIDGET is
		do
			if instantiated then
				Result := context.widget
			end;
		end;

feature -- Code generation

	context_name: STRING is
		do
			if context /= Void then
				Result := context.full_name
			else
				Result := ""
			end
		end;

end
