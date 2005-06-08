indexing
	description: "To free allocated COM objects throug call to `Release'"
	date: "$Date$"
	revision: "$Revision$"

deferred class
	COM_OBJECT

inherit
	DISPOSABLE
	
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

feature -- Status report

	is_successful: BOOLEAN is
			-- Was last call to a COM routine of `Current' successful?
		do
			Result := last_call_success = 0
		end
		
feature {NONE} -- Access 

	item: POINTER
			-- Access to underlying COM object.
	
	last_call_success: INTEGER
			-- Result of last COM calls. When successful it should be `0'.

feature {NONE} -- Disposal

	dispose is
			-- Free `item'.
		local
			l_nb_ref: INTEGER
		do
			debug ("COM_OBJECT")
				dispose_debug_output (1, item, $Current, 0)
			end
			if item /= Default_pointer then
				l_nb_ref := {CLI_COM}.release (item)
				item := default_pointer
			end
			debug ("COM_OBJECT")
				dispose_debug_output (2, item, $Current, l_nb_ref)
			end
		ensure then
			item_null: item = default_pointer
		end

	dispose_debug_output (type: INTEGER; a_ptr: POINTER; an_obj: POINTER; a_nb_ref: INTEGER) is
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
					printf ("Quitting dispose with item value 0x%lX nb_ref[%d]\n", $a_ptr, $a_nb_ref);
				}
			]"
		end

feature {NONE} -- COM Ref management

	cpp_addref (a_pointer: POINTER): INTEGER is
			-- AddRef COM objects
		external
			"C++ IUnknown use %"unknwn.h%""
		alias
			"AddRef"
		end

end -- class COM_OBJECT
