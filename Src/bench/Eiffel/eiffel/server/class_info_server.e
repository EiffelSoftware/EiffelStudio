-- Server for class information

class CLASS_INFO_SERVER 

inherit

	COMPILER_SERVER [CLASS_INFO, CLASS_ID]
		rename
			item as server_item,
			has as server_has,
			disk_item as disk_server_item
		export
			{ANY} server_item
		end;
	COMPILER_SERVER [CLASS_INFO, CLASS_ID]
		redefine
			has, item, disk_item
		select
			has, item, disk_item
		end

creation

	make

	
feature 

	Cache: CLASS_INFO_CACHE is
			-- Cache for routine tables
		once
			!!Result.make;
		end;

	has (an_id: CLASS_ID): BOOLEAN is
			-- Is an item of id `an_id' present in the current server ?
		do
			Result := 	server_has (an_id)
						or else
						Tmp_class_info_server.has (an_id);
		end;
					
	id (t: CLASS_INFO): CLASS_ID is
			-- Id associated with `t'
		do
			Result := t.id
		end

	item (an_id: CLASS_ID): CLASS_INFO is
			-- Feature table of id `an_id'. Look first in the temporary
			-- feature table server. It not present, look in itself.
		require else
			has_an_id: has (an_id);
		do
			if Tmp_class_info_server.has (an_id) then
				Result := Tmp_class_info_server.item (an_id);
			else
				Result := server_item (an_id);
			end; 
		end;

	disk_item (an_id: CLASS_ID): CLASS_INFO is
			-- Byte code of body id `and_id'. Look first in the temporary
			-- byte code server
		do
			if Tmp_class_info_server.has (an_id) then
				Result := Tmp_class_info_server.disk_item (an_id);
			else
				Result := disk_server_item (an_id);
			end;
		end;

	Size_limit: INTEGER is 50
			-- Size of the CLASS_INFO_SERVER file (50 Ko)

	Chunk: INTEGER is 150
			-- Size of a HASH_TABLE block


end
