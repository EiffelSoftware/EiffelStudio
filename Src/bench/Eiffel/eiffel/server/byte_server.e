-- Server for routine tables

class BYTE_SERVER 

inherit

	SERVER [BYTE_CODE]
		rename
			item as server_item,
			has as server_has,
			disk_item as disk_server_item,
			change_id as server_change_id
		export
			{ANY} server_item
		redefine
			ontable, updated_id
		end;
	SERVER [BYTE_CODE]
		redefine
			disk_item, has, item, ontable, updated_id, change_id
		select
			has, item, disk_item, change_id
		end

creation

	make

feature 

	ontable: O_N_TABLE is
			-- Mapping table between old id s and new ids.
			-- Used by `change_id'
		require else
			True
		once
			Result := System.onbidt
		end;

    updated_id (i: INTEGER): INTEGER is
        do
            Result := ontable.item (i)
        end;

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
			Result := server_has (an_id) or else Tmp_byte_server.has (an_id);
		end;

    change_id (new_value, old_value: INTEGER) is
        do
            if server_has (old_value) then
                server_change_id (new_value, old_value)
            end;
            if Tmp_byte_server.has (old_value) then
                Tmp_byte_server.change_id (new_value, old_value)
            end;
        end;

	Size_limit: INTEGER is 750000;

end
