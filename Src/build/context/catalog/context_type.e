

class CONTEXT_TYPE 

inherit

	WINDOWS;
	COMMAND_ARGS;
	TYPE_STONE;
	SHARED_STORAGE_INFO;
	FOCUSABLE

creation

	make

	
feature 

	make (a_name: STRING; a_context: CONTEXT) is
			-- create a context type associated with `a_context'
		do
			dummy_context := a_context;
			focus_string := a_name;
			int_generator.next;
			identifier := int_generator.value;
			context_type_table.put (Current, identifier);
		end;

	identifier: INTEGER;

	reset is
		do
			int_generator.reset;
			if dummy_context /= Void then
				dummy_context.reset_name;
			end;
		end;

	
feature {NONE}

	int_generator: INT_GENERATOR is
		once
			!!Result
		end;

	focus_string: STRING;

	focus_label: LABEL is
		do
			Result := context_catalog.focus_label
		end;

	focus_source: WIDGET;

	
feature 

	initialize_callbacks (a_source: WIDGET) is
			-- Set the callbacks of `a_source' for
			-- the context_type
		do
			focus_source := a_source;
			initialize_focus;
			initialize_transport;
		end;

	
feature {NONE}

	dummy_context: CONTEXT;
			-- Reference to a context, descendant of current type

feature 

	create_context (a_parent: COMPOSITE_C): CONTEXT is
		do
			Result := dummy_context.create_context (a_parent);
		end;

	eiffel_type: STRING is
		do
			Result := dummy_context.eiffel_type
		end;

	source: WIDGET is
		do
			Result := focus_source
		end;

	label: STRING is
		do
			Result := eiffel_type;
		end;

	symbol: PIXMAP is
		do
			Result := dummy_context.symbol
		end;

	original_stone: TYPE_STONE is
		do
			Result := Current
		end;

end
