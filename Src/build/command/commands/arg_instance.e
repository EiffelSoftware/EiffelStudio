
class ARG_INSTANCE 

inherit

	ARG_INST_STONE
 


-- ***********************
-- Initialization features
-- ***********************

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

-- ****
-- Data
-- ****

	
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
			context := other;
			if associated_icon_stone /= Void then
				associated_icon_stone.set_symbol (context.symbol);
				associated_icon_stone.set_label (context.label);
			end
		end;

	type: CONTEXT_TYPE;

	context: CONTEXT_STONE;

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

	original_stone: ARG_INSTANCE is
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
				Result := context.original_stone.widget
			end;
		end;

-- ************************
-- Code generation features
-- ************************

	context_name: STRING is
		do
			if not (context = Void) then
				Result := context.original_stone.full_name
			else
				Result := ""
			end
		end;

end
