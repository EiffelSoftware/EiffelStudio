indexing
	description: "Argument which can be instantiated. It may not be instantiated %
				% if the corresponding context was deleted."
	id: "$Id$"
	date: "$Date$"
	revision: "$Revision$"

class ARG_INSTANCE 

inherit

	TYPE_DATA
 
creation

	session_init, storage_init
	
feature -- creation

	session_init (other: ARG) is
		do
			type := other.type
		end

	storage_init (t: CONTEXT_TYPE c: CONTEXT) is
			-- Create `Current' as an instantiated argument
			-- after retrieving information from the BUILDGEN.
		do
			type := t
--			!! argument_type.storage_init (t)
			context := c
		end

--  	formal_storage_init (other: CONTEXT_TYPE) is
--  			-- Create `Current' as a formal argument (not instantiated)
--  			-- after rtrieving the information from the BUILDGEN.
--  		do
--  			!! argument_type.storage_init (other)
--  		ensure
--  			Type_set: type /= Void 
--  		end
--  
--  	set (t: CONTEXT_TYPE p: CMD) is
--  			-- Set type to `t' and 
--  			-- parent `p'
--  		do
-- 			type := t
-- 			set_parent (p)
-- 			!! argument_type.set (t, p)
--  		end

feature -- Argument Instance part

	instantiated: BOOLEAN is
			-- Is current argument instantiated?
		do
			Result := not (context = Void or else
				context.deleted)
		end

feature {NONE} -- Attributes

	associated_icon_stone: ARG_INST_ICON

feature -- Attributes

	type: CONTEXT_TYPE 
			-- Type of current argument

	context: CONTEXT
			-- Context that Current represents when instantiated 

feature -- Access

	reset_context is 
			-- Reset `context'.
		do
			context := Void
			if associated_icon_stone /= Void then
				associated_icon_stone.set_symbol (type.symbol)
				associated_icon_stone.set_label (type.label)
			end
		end

	reset is 
			-- Reset Current.
		do
			associated_icon_stone := Void
		end

	set_icon_stone (i: ARG_INST_ICON) is
			-- Set `associated_icon_stone' to `i'.
		do
			associated_icon_stone := i
		end

	set_context (other: CONTEXT_STONE) is
			-- Set `context'.
		require
			not_void_other: not (other = Void)
		do
			context := other.data
			if associated_icon_stone /= Void then
				associated_icon_stone.set_symbol (context.symbol)
				associated_icon_stone.set_label (context.title_label)
			end
		end

feature -- Identification

	identifier: INTEGER is
			-- Unique identifier for storage
			-- and retrieval
		do
			if instantiated then
				Result := context.identifier
			else
				Result := - type.identifier
			end
		end

	data: ARG_INSTANCE is
		do
			Result := Current
		end

	label: STRING is
		do
			if instantiated then
				Result := context.title_label
			else
				Result := type.label
			end
		end

	symbol: PIXMAP is
		do
			if instantiated then
				Result := context.symbol
			else
				Result := type.symbol
			end
		end

	source: WIDGET is
		do
			if instantiated then
				Result := context.widget
			end
		end

feature -- Code generation

	context_name: STRING is
		do
			if context /= Void then
				Result := context.full_name
			else
				Result := ""
			end
		end

feature -- Argument part

--  	eiffel_type: STRING is
--  			-- Eiffel type of the argument
--  		do
--  			Result := type.eiffel_type
--  		end
--  
--  	parent_type: CMD is
--  		-- Command which defines
--  		-- Current argument if
--  		-- introduced by inheritance
-- 		do
-- 			Result := argument_type.parent_type
-- 		end
--  
--  	set_parent (c: CMD) is
-- 		require
-- 			argument_type_not_void: argument_type /= Void
--  		do
--  			argument_type.set_parent (c)
--  		end
--  
--  	inherited: BOOLEAN is
--  		do
--  			Result := not (parent_type = Void)
--  		end
-- 
--		argument_type: ARG 
			-- Type of Current argument

end
