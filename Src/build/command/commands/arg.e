indexing
	description: "Argument which is not instantiated."
	Id: "$Id$" 
	Date: "$Date$"
	Revision: "$Revision$"

class ARG 

inherit
	TYPE_DATA

creation
	session_init,
	storage_init,
	set
	
feature -- Initialization 

	set (t: CONTEXT_TYPE [CONTEXT]; p: CMD) is
			-- Set type to `t' and 
			-- parent `p'
		do
			set_type (t)
			set_parent (p)
		end

	session_init (other: CONTEXT_TYPE [CONTEXT]) is
		do
			set_type (other)
		ensure
			Type_set: type /= Void
		end

	storage_init (other: CONTEXT_TYPE [CONTEXT]) is
		do
			set_type (other)
		ensure
			Type_set: type /= Void 
		end

feature -- Pick and drop data

	type: CONTEXT_TYPE [CONTEXT]

	set_type (other: CONTEXT_TYPE [CONTEXT]) is
		do
			type := other
		end

	identifier: INTEGER is
		do
			Result := - type.identifier
		end

	label: STRING is
		do
			Result := type.label
		end

	symbol: EV_PIXMAP is
		do
			Result := type.symbol
		end

	eiffel_type: STRING is
		do
			Result := type.eiffel_type
		end

-- **************
-- Reuse features
-- **************

	parent_type: CMD
		-- Command which defines
		-- Current argument if
		-- introduced by inheritance

	set_parent (c: CMD) is
		do
			parent_type := c
		end

	inherited: BOOLEAN is
		do
			Result := not (parent_type = Void)
		end

end -- class ARG

