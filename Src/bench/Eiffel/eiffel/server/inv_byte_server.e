-- Server for invariants byte code

class INV_BYTE_SERVER 

inherit

	COMPILER_SERVER [INVARIANT_B, CLASS_ID]
		rename
			item as server_item,
			has as server_has,
			disk_item as disk_server_item
		export
			{ANY} server_item
		end;

	COMPILER_SERVER [INVARIANT_B, CLASS_ID]
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

	id (t: INVARIANT_B): CLASS_ID is
			-- Id associated with `t'
		do
			Result := t.id
		end

	item (an_id: CLASS_ID): INVARIANT_B is
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

	disk_item (an_id: CLASS_ID): INVARIANT_B is
			-- Byte code of body id `and_id'. Look first in the temporary
			-- byte code server
		do
			if Tmp_inv_byte_server.has (an_id) then
				Result := Tmp_inv_byte_server.disk_item (an_id);
			else
				Result := disk_server_item (an_id);
			end;
		end;

	has (an_id: CLASS_ID): BOOLEAN is
			-- Is the id `an_id' present in `Tmp_inv_byte_server' or
			-- Current ?
		do
			Result := server_has (an_id) or else Tmp_inv_byte_server.has (an_id);
		end;

	Size_limit: INTEGER is 40
			-- Size of the INV_BYTE_SERVER file (40 Ko)

	Chunk: INTEGER is 100
			-- Size of a HASH_TABLE block

end
