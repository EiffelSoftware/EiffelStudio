indexing
	description: "To free allocated COM objects throug call to `Release'"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	COM_OBJECT

inherit
	MEMORY
		export
			{NONE} all
		redefine
			dispose
		end
		
	ANY
	
feature {NONE} -- Initialization

	make_by_pointer (an_item: POINTER) is
			-- Initialize Current with `an_item'.
		require
			an_item_not_null: an_item /= default_pointer
		do
			item := an_item
		ensure
			item_set: item = an_item
		end
		
feature {NONE} -- Access 

	item: POINTER
			-- Access to underlying COM object.
	
	last_call_success: INTEGER
			-- Result of last COM calls. When successful it should be `0'.

feature {NONE} -- Disposal

	dispose is
			-- Free `item'.
		do
			feature {CLI_COM}.release (item)
			item := default_pointer
		ensure then
			item_null: item = default_pointer
		end

invariant
	item_not_null: item /= default_pointer
	
end -- class COM_OBJECT
