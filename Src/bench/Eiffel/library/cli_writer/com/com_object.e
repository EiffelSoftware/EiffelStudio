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
			debug ("COM_OBJECT")
				io.put_string ("["+generating_type+"].make_by_pointer("+an_item.out+") called")
				io.put_new_line
			end
			item := an_item
		ensure
			item_set: item = an_item
		end

feature -- Ref management

	add_ref is
			-- Call to the AddRef feature
		do
			debug ("COM_OBJECT")
				io.put_string ("["+generating_type+"].add_ref called")
				io.put_new_line
			end			
			cpp_addref (item)
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
			debug ("COM_OBJECT")
				dispose_debug_output (1, item, $Current)
			end
			feature {CLI_COM}.release (item)
			item := default_pointer
			debug ("COM_OBJECT")
				dispose_debug_output (2, item, $Current)
			end
		ensure then
			item_null: item = default_pointer
		end

	dispose_debug_output (type: INTEGER; a_ptr: POINTER; an_obj: POINTER) is
			-- Safe display while disposing. If `type' is `1' then
			-- we are entering `dispose', else we are leaving it.
			-- `a_ptr' is the item being freed in current object `an_obj'.
		external
			"C inline use <stdio.h>"
		alias
			"[
				if ($type == 1) {
					extern char *eif_typename(int16);
					printf ("\nEntering dispose of %s with item value 0x%lX\n", eif_typename((int16)Dftype($an_obj)), $a_ptr);
				} else {
					printf ("Quitting dispose with item value 0x%lX\n", $a_ptr);
				}
			]"
		end

feature {NONE} -- COM Ref management

	cpp_addref (obj: POINTER) is
			-- 
		external
			"[
				C++ IUnknown signature 
					()
				use <unknwn.h>
			]"
		alias
			"AddRef"
		end

invariant
	item_not_null: item /= default_pointer
	
end -- class COM_OBJECT
