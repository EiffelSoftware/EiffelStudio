-- Server for routine tables

class BYTE_SERVER 

inherit

	SERVER [BYTE_CODE]
		rename
			item as server_item,
			has as old_has,
			disk_item as disk_server_item
		export
			{ANY} server_item
		end;
	SERVER [BYTE_CODE]
		redefine
			disk_item, has, item
		select
			has, item, disk_item
		end

creation

	make

feature 

	Cache: BYTE_CACHE is
			-- Cache for routine tables
		once
			!!Result.make;
		end;

	item (an_id: INTEGER): BYTE_CODE is
			-- Byte code of body id `and_id'. Look first in the temporary
			-- byte code server
		require else
			has_an_id: has (an_id);
		do
			if Tmp_byte_server.has (an_id) then
				Result := Tmp_byte_server.item (an_id);
			else
				Result := server_item (an_id);
			end;
		end;

	disk_item (an_id: INTEGER): BYTE_CODE is
			-- Byte code of body id `and_id'. Look first in the temporary
			-- byte code server
		do
			if Tmp_byte_server.has (an_id) then
				Result := Tmp_byte_server.disk_item (an_id);
			else
				Result := disk_server_item (an_id);
			end;
		end;

	has (an_id: INTEGER): BOOLEAN is
			-- Is the id `an_id' present in `Tmp_byte_server' or
			-- Current ?
		require else
			positive_id: an_id > 0;
		do
			Result := old_has (an_id) or else Tmp_byte_server.has (an_id);
		end;

	Size_limit: INTEGER is 750000;

end
