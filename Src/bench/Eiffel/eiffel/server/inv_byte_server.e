-- Server for invariants byte code

class INV_BYTE_SERVER 

inherit

	SERVER [INVARIANT_B]
		rename
			item as server_item,
			has as old_has,
			disk_item as disk_server_item
		export
			{ANY} server_item
		end;

	SERVER [INVARIANT_B]
		redefine
			has, item, disk_item
		select
			has, item, disk_item
		end

creation

	make

feature 

	Cache: INV_BYTE_CACHE is
			-- Cache for routine tables
		once
			!!Result.make;
		end;

	item (an_id: INTEGER): INVARIANT_B is
			-- Byte code of body id `and_id'. Look first in the temporary
			-- byte code server
		do
			if Tmp_inv_byte_server.has (an_id) then
				Result := Tmp_inv_byte_server.item (an_id);
			else
				Result := server_item (an_id);
			end;
		ensure then
			Result_exists: Result /= Void
		end;

	disk_item (an_id: INTEGER): INVARIANT_B is
			-- Byte code of body id `and_id'. Look first in the temporary
			-- byte code server
		do
			if Tmp_byte_server.has (an_id) then
				Result := Tmp_inv_byte_server.disk_item (an_id);
			else
				Result := disk_server_item (an_id);
			end;
		end;

	has (an_id: INTEGER): BOOLEAN is
			-- Is the id `an_id' present in `Tmp_inv_byte_server' or
			-- Current ?
		do
			Result := old_has (an_id) or else Tmp_inv_byte_server.has (an_id);
		end;

	Size_limit: INTEGER is 50000;

end
