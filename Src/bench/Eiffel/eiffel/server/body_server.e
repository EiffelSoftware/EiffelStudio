-- Server for routine tables

class BODY_SERVER 

inherit

	READ_SERVER [FEATURE_AS]
		rename
			item as server_item,
			int_tbl_item as hash_table_item
		export
			{ANY} hash_table_item, server_item
		end;
	READ_SERVER [FEATURE_AS]
		rename
			int_tbl_item as hash_table_item
		export
			{ANY} hash_table_item
		redefine
			item
		select
			item
		end

creation

	make
	
feature 

	Cache: BODY_CACHE is
			-- Cache for routine tables
		once
			!!Result.make;
		end;

	offsets: EXTEND_TABLE [SERVER_INFO, INTEGER] is
			-- Class offsets
		do
			Result := Ast_server;
		end;

	item (an_id: INTEGER): FEATURE_AS is
			-- Body of id `an_id'. Look first in the temporary
			-- body server. It not present, look in itself.
		require else
			has_an_id: Tmp_body_server.has (an_id) or else has (an_id);
	   do
			if Tmp_body_server.has (an_id) then
				Result := Tmp_body_server.item (an_id);
			else
				Result := server_item (an_id);
			end;
		end;

	info (an_id: INTEGER): READ_INFO is
			-- Info for item of id `an_id'.
		require
			has_an_id: Tmp_body_server.has (an_id) or else has (an_id);
		do
			if Tmp_body_server.has (an_id) then
				Result := Tmp_body_server.hash_table_item (an_id);
			else
				Result := hash_table_item (an_id);
			end;
		end;

end
