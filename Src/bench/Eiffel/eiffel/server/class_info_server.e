-- Server for class information

class CLASS_INFO_SERVER 

inherit

	SERVER [CLASS_INFO]
		rename
			item as server_item,
			has as server_has
		export
			{ANY} server_item
		end;
	SERVER [CLASS_INFO]
		redefine
			has, item
		select
			has, item
		end

creation

	make

	
feature 

	Cache: CLASS_INFO_CACHE is
			-- Cache for routine tables
		once
			!!Result.make;
		end;

	has (an_id: INTEGER): BOOLEAN is
			-- Is an item of id `an_id' present in the current server ?
		do
			Result := 	server_has (an_id)
						or else
						Tmp_class_info_server.has (an_id);
		end;
					
	item (an_id: INTEGER): CLASS_INFO is
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

	Size_limit: INTEGER is 500000;

end
