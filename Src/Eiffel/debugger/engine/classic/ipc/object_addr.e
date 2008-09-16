indexing
	description: "[
			Translation between physical address of objects and their
			hector address in the user application. At a given time
			a physical object has only one hector address.
		]"
	legal: "See notice at end of class."
	status: "See notice at end of class."

deferred class

	OBJECT_ADDR

inherit

	IPC_SHARED;

	DEBUG_EXT;

	HEXADECIMAL_STRING_CONVERTER

feature -- Access

	keep_object_as_hector_address (addr: DBG_ADDRESS): DBG_ADDRESS is
		require
			addr_not_void: addr /= Void and then not addr.is_void
		do
			Result := hector_addr (addr)
		ensure
			Result_attached: Result /= Void
		end

	update_kept_objects_addresses is
		do
			update_addresses
		end

	hector_addr (addr: DBG_ADDRESS): DBG_ADDRESS is
			-- Hector address (EIF_OBJ) of object at `addr';
			-- Ask user application to adopt that object if not already done
		require
			addr_not_void: addr /= Void and then not addr.is_void
		do
			if addr_table.has (addr) then
				Result := addr_table.item (addr)
			else
				send_rqst_3 (Rqst_adopt, In_address, 0, addr.as_pointer)
				create Result.make_from_string (c_tread)
				addr_table.put (Result, addr)
			end
			debug ("HECTOR")
				io.error.put_string ("Address: ")
				io.error.put_string (addr.output)
				io.error.put_string (" Hector: ")
				io.error.put_string (Result.output)
				io.error.put_new_line
			end
		ensure
			Result_attached: Result /= Void
			Result_in_addr_table: Result = addr_table.item (addr)
		end

	is_object_kept (h_addr: DBG_ADDRESS): BOOLEAN is
			-- Is `h_addr' a known hector address?
		require
			h_addr_not_void: h_addr /= Void
		do
			Result := addr_table.has_item (h_addr)
		end

feature -- Updating

	release_all_objects is
		do
			addr_table.wipe_out
		end

	keep_only_objects (kept_addrs: LIST [DBG_ADDRESS]) is
			-- Keep references to `kept_addrs' and ask user application
			-- to wean the other adopted objects not used anymore.
		require
			kept_addrs_compare_object: kept_addrs /= Void implies kept_addrs.object_comparison
		local
			addresses: SPECIAL [DBG_ADDRESS];
			i, addr_table_count: INTEGER;
			h_addr: DBG_ADDRESS
		do
			from
				addresses := addr_table.current_keys.area
				addr_table_count := addr_table.count
			until
				i >= addr_table_count
			loop
				h_addr := addr_table.item (addresses.item (i));
				if
					kept_addrs = Void
					or else not kept_addrs.has (h_addr)
				then
					forget_obj (h_addr);
					addr_table.remove (addresses.item (i))
				end
				i := i + 1
			end
		end

	update_addresses is
			-- Update physical addresses of adopted objects after
			-- an execution step.
		local
			h_addrs: ARRAYED_LIST [DBG_ADDRESS];
			h_addr: DBG_ADDRESS
		do
			from
				h_addrs := addr_table.linear_representation;
				addr_table.clear_all;
				h_addrs.start
			until
				h_addrs.after
			loop
				h_addr := h_addrs.item;
				addr_table.put (h_addr, physical_addr (h_addr));
				h_addrs.forth
			end
		end;

feature {NONE} -- Implementation

	physical_addr (h_addr: DBG_ADDRESS): DBG_ADDRESS is
			-- Address of object `h_addr' (hector addr) previously
			-- adopted by user application
		require
			h_addr_not_void: h_addr /= Void
		do
			send_rqst_3 (Rqst_access, In_address, 0, h_addr.as_pointer);
			create Result.make_from_string (c_tread)

			debug ("HECTOR")
				io.error.put_string ("Hector: ");
				io.error.put_string (h_addr.output);
				io.error.put_string (" Address: ");
				io.error.put_string (Result.output);
				io.error.put_new_line
			end
		ensure
			Result_attached: Result /= Void
		end

	forget_obj (h_addr: DBG_ADDRESS) is
			-- Ask user application to wean adopted object `h_addr'.
		require
			h_addr_not_void: h_addr /= Void
		do
			send_rqst_3 (Rqst_wean, In_address, 0, h_addr.as_pointer)

			debug ("HECTOR")
				io.error.put_string ("Wean Hector: ");
				io.error.put_string (h_addr.output);
				io.error.put_new_line
			end
		end;

	addr_table: HASH_TABLE [DBG_ADDRESS, DBG_ADDRESS] is
			-- Table of addresses of objects adopted by the user application;
			-- the key is the physical addr of the object, the item is
			-- its hector addr (with indirection)
		once
			create Result.make (40);
			Result.compare_objects
		end

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end -- class OBJECT_ADDR	
