indexing
	description: "A context type that appears in the context catalog."
	Id: "$Id$"
	Date: "$Date$"
	Revision: "$Revision$"

class CONTEXT_TYPE [T -> CONTEXT]

inherit
	TYPE_DATA

	WINDOWS

	SHARED_STORAGE_INFO

creation
	make
	
feature  {NONE} -- Initialization

	make (a_context: like dummy_context) is
			-- Create a context type associated with `a_context'.
		do
			dummy_context := a_context
			int_generator.next
			identifier := int_generator.value
			context_type_table.put (Current, identifier)
		end

feature -- Access

	identifier: INTEGER

	reset is
		do
			int_generator.reset
			if dummy_context /= Void then
				dummy_context.reset_name
			end
		end

	is_valid_parent (par: HOLDER_C): BOOLEAN is
			-- Is `parent_context' a valid parent?
		do
			Result := dummy_context.is_valid_parent (par)
		end

feature {NONE} -- Implementation

	dummy_context: T
			-- Reference to a context, descendant of current type

	int_generator: INT_GENERATOR is
		once
			create Result
		end

feature -- Callbacks

	initialize_callbacks (a_source: EV_TOOL_BAR_BUTTON) is
			-- Set the callbacks of `a_source' for
			-- the context_type.
		do
			a_source.activate_pick_and_drop (Void, Void)
			a_source.set_data_type (dummy_context.data_type)
			a_source.set_transported_data (Current)
		end
	
feature -- Context creation

	create_context (a_parent: HOLDER_C): like dummy_context is
		do
			Result := dummy_context.create_context (a_parent)
		end

	eiffel_type: STRING is
		do
			Result := dummy_context.eiffel_type
		end

	label: STRING is
		do
			Result := eiffel_type
		end

	symbol: EV_PIXMAP is
		do
			Result := dummy_context.symbol
		end

	type: like Current is
		do
			Result := Current
		end

end -- class CONTEXT_TYPE

