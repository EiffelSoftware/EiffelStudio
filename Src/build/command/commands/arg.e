
class ARG 

inherit

	ARG_STONE

-- ***********************
-- Initialization features
-- ***********************

creation

	session_init, storage_init, set
	
feature 

	set (t: CONTEXT_TYPE; p: CMD) is
			-- Set type to `t' and 
			-- parent `p'
		do
			set_type (t);
			set_parent (p)
		end;

	session_init (other: TYPE_STONE) is
		local
			context: CONTEXT_STONE;
			arg: ARG_STONE
		do
			context ?= other;
			arg ?= other;
			if not (context = Void) then
				type := context.original_stone.context_type
			elseif not (arg = Void) then
				type := arg.type
			else
				type ?= other
			end;
		ensure
			Type_set: not (type = Void) 
		end;

	storage_init (other: CONTEXT_TYPE) is
		do
			set_type (other)
		ensure
			Type_set: not (type = Void) 
		end;

-- ****
-- Data
-- ****

	type: CONTEXT_TYPE;

	set_type (other: CONTEXT_TYPE) is
		do
			type := other
		end;

-- **************
-- Stone features
-- **************

	source: WIDGET is do end;

	identifier: INTEGER is
		do
			Result := - type.identifier
		end;

	original_stone: ARG is
		do
			Result := Current
		end;

	label: STRING is
		do
			Result := type.label
		end;

	symbol: PIXMAP is
		do
			Result := type.symbol
		end;

-- **************
-- Reuse features
-- **************

	parent_type: CMD;
		-- Command which defines
		-- Current argument if
		-- introduced by inheritance

	set_parent (c: CMD) is
		do
			parent_type := c
		end;

	inherited: BOOLEAN is
		do
			Result := not (parent_type = Void)
		end

end
