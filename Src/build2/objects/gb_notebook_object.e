indexing
	description: "Objects that represent EiffelVision2 notebooks"
	date: "$Date$"
	revision: "$Revision$"

class
	GB_NOTEBOOK_OBJECT
	
inherit
	GB_WIDGET_LIST_OBJECT
		redefine
			add_child_object, remove_child
		end

create
	make_with_type,
	make_with_type_and_object

feature -- Element change

	add_child_object (an_object: GB_OBJECT; position: INTEGER) is
			-- Add `an_object' to `Current' at position `position'.
		local
			counter: INTEGER
			context: GB_CONSTANT_CONTEXT
			original_key: STRING
		do
			-- Must perform special handling of item text constants,
			-- as each one is referenced by an offset into the notebook.
			-- If we add a new child, this may affect the constants used.
			if position <= children.count then
				from				
					counter := children.count + 1
				until
					counter = position
				loop
					counter := counter - 1	
					original_key := type + item_text + counter.out
					context := constants.item (original_key)
						-- Context may be Void if item does not use a constant value.
					if context /= Void then
						context.modify (context.constant, context.object, context.property, item_text + (counter + 1).out)
						constants.remove (original_key)
						constants.put (context, type + item_text + (counter + 1).out)
					end
				end
			end
			Precursor {GB_WIDGET_LIST_OBJECT} (an_object, position)
		end
		
	remove_child (an_object: GB_OBJECT) is
			-- Removed `an_object' and all its representations from `Current'.
		local
			position: INTEGER
			counter: INTEGER
			original_key: STRING
			context: GB_CONSTANT_CONTEXT
		do
			position := children.index_of (an_object, 1)
			
			original_key := type + item_text + position.out
			constants.remove (original_key)
			if position < children.count then
				from
					counter := position + 1
				until
					counter > children.count
				loop
					original_key := type + item_text + counter.out
					context := constants.item (original_key)
						-- Context may be Void if item does not use a constant value.
					if context /= Void then
						context.modify (context.constant, context.object, context.property, item_text + (counter - 1).out)
						constants.remove (original_key)
						constants.put (context, type + item_text + (counter - 1).out)
					end
					counter := counter + 1
				end
			end
			Precursor {GB_WIDGET_LIST_OBJECT} (an_object)
		end
		
feature {NONE} -- Implementation

	item_text: STRING is "Item_text"
		-- Constant used for referncing item texts in XML.

end -- class GB_NOTEBOOK_OBJECT
