indexing
	description: "A context type that appears in the context catalog."
	Id: "$Id$"
	Date: "$Date$"
	Revision: "$Revision$"

class CONTEXT_TYPE 

inherit

	DRAG_SOURCE

	WINDOWS

	COMMAND_ARGS

	TYPE_STONE

	SHARED_STORAGE_INFO

--	FOCUSABLE
--		redefine
--			initialize_focus
--		end

	TYPE_DATA

creation

	make
	
feature  {NONE}

	make (a_name: STRING; a_context: like dummy_context) is
			-- create a context type associated with `a_context'
		do
			dummy_context := a_context
			int_generator.next
			identifier := int_generator.value
			context_type_table.put (Current, identifier)
		end

feature

	identifier: INTEGER

	reset is
		do
			int_generator.reset
			if dummy_context /= Void then
				dummy_context.reset_name
			end
		end

	is_valid_parent (parent_context: COMPOSITE_C): BOOLEAN is
			-- Is `parent_context' a valid parent?
		do
			Result := dummy_context.is_valid_parent (parent_context)
		end

feature {NONE}

	int_generator: INT_GENERATOR is
		once
			!!Result
		end

	focus_source: WIDGET

feature 

	initialize_callbacks (a_source: WIDGET) is
			-- Set the callbacks of `a_source' for
			-- the context_type
		do
			focus_source := a_source
--			create_focus_label
--			initialize_focus
			initialize_transport
		end
	
feature {NONE}

	dummy_context: CONTEXT
			-- Reference to a context, descendant of current type

feature 

	create_context (a_parent: COMPOSITE_C): CONTEXT is
		do
			Result := dummy_context.create_context (a_parent)
		end

	eiffel_type: STRING is
		do
			Result := dummy_context.eiffel_type
		end

	source: WIDGET is
		do
			Result := focus_source
		end

	label: STRING is
		do
			Result := eiffel_type
		end

	symbol: PIXMAP is
		do
			Result := dummy_context.symbol
		end

	type, data: CONTEXT_TYPE is
		do
			Result := Current
		end

feature {NONE}

-- 	create_focus_label is
-- 		do
-- 			set_focus_string (label)
-- 		end
-- 
-- 	focus_label: FOCUS_LABEL_I is
-- 		local
-- 			ti: TOOLTIP_INITIALIZER
-- 		do
-- 			if focus_source /= Void then
-- 				ti ?= focus_source.top
-- 				check
-- 					valid_tooltip_initializer: ti /= void
-- 				end
-- 				Result := ti.label
-- 			end
-- 		end
-- 
-- 	destroyed: BOOLEAN is
-- 		do
-- 			Result := focus_source.destroyed
-- 		end
-- 
-- 	initialize_focus is
-- 		do
-- 			focus_label.initialize_widget (focus_source)
-- 		end

end
