-- Translation between physical address of objects and their
-- hector address in the user application. At a given time
-- a physical object has only one hector address.

class

	OBJECT_ADDR

inherit

	IPC_SHARED;

	DEBUG_EXT;

	BEURK_HEXER

feature -- Access

	hector_addr (addr: STRING): STRING is
			-- Hector address (EIF_OBJ) of object at `addr';
			-- Ask user application to adopt that object if not already done
		require
			addr_not_void: addr /= Void
		do
			if not addr_table.has (addr) then
				send_rqst_3 (Rqst_adopt, In_address, 0, hex_to_integer (addr));
				addr_table.put (c_tread, addr)
			end;
			Result := addr_table.item (addr)
		end;
	
	physical_addr (eif_obj: STRING): STRING is
			-- Address of object `eif_obj' (hector addr) previously
			-- adopted by user application
		require
			eif_obj_not_void: eif_obj /= Void
		do
			send_rqst_3 (Rqst_access, In_address, 0, hex_to_integer (eif_obj));
			Result := c_tread
		end;

feature -- Updating

	keep_objects (hector_addrs: SET [STRING]) is
			-- Keep references to `hector_addrs' and ask user application
			-- to wean the other adopted objects not used any more.
		require
			hector_addrs_exists: hector_addrs /= Void
		local
			addresses: SPECIAL [STRING];
			i, addr_table_count: INTEGER;
			eif_obj: STRING
		do
			from
				addresses := addr_table.current_keys.area
				addr_table_count := addr_table.count
			until
				i >= addr_table_count
			loop
				eif_obj := addr_table.item (addresses.item (i));
				if not hector_addrs.has (eif_obj) then
					forget_obj (eif_obj);
					addr_table.remove (eif_obj)
				end;
				i := i + 1
			end
		end;

	update_addresses is
			-- Update physical addresses of adopted objects after
			-- an execution step.
		local
			addresses: SPECIAL [STRING];
			i, addr_table_count: INTEGER;
			objects: LINKED_LIST [STRING];
			eif_obj: STRING
		do
			from
				objects.make;
				addresses := addr_table.current_keys.area
				addr_table_count := addr_table.count
			until
				i >= addr_table_count
			loop
				objects.add (addr_table.item (addresses.item (i)));
				i := i + 1
			end;
			addr_table.clear_all;
			from
				objects.start
			until
				objects.after
			loop
				eif_obj := objects.item;
				addr_table.put (eif_obj, physical_addr (eif_obj));
				objects.forth
			end
		end;

feature {NONE} 

	forget_obj (eif_obj: STRING) is
			-- Ask user application to wean adopted object `eif_obj'.
		require
			eif_obj_not_void: eif_obj /= Void
		do
			send_rqst_3 (Rqst_wean, In_address, 0, hex_to_integer (eif_obj))
		end;

	addr_table: HASH_TABLE [STRING, STRING] is
			-- Table of addresses of objects adopted by the user application;
			-- the key is the physical addr of the object, the item is
			-- its hector addr (with indirection)
		once
			Result.make (40)
		end;

end -- class OBJECT_ADDR	
