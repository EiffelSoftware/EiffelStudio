-- Server for abstract syntax description of invariant

class REP_FEAT_SERVER 

inherit

	READ_SERVER [FEATURE_AS]
		rename
			int_tbl_item as hash_table_item,
			item as server_item,
			has as server_has
		export
			{ANY} hash_table_item, server_has, server_item
		end;

	READ_SERVER [FEATURE_AS]
		rename
			int_tbl_item as hash_table_item
		export
			{ANY} hash_table_item
		redefine
			has, item
		select
			has, item
		end

creation

	make

feature 

	Cache: REP_FEAT_CACHE is
			-- Cache for routine tables
		once
			!!Result.make;
		end;

	has (an_id: INTEGER): BOOLEAN is
			-- Is the id `an_id' present either in Current or in
			-- `Tmp_rep_feat_server' ?
		do
			Result := Tmp_rep_feat_server.has (an_id) or else server_has (an_id);
		end;

	item (an_id: INTEGER): FEATURE_AS is
			-- Invariant of class of id `an_id'. Look for it first in
			-- the associated temporary server
	   do
			if Tmp_rep_feat_server.has (an_id) then
				Result := Tmp_rep_feat_server.item (an_id);
			else
				Result := server_item (an_id);
			end;
		ensure then
			Result_exists: Result /= Void
		end;

	offsets: EXTEND_TABLE [SERVER_INFO, INTEGER] is
			-- Class offsets in the AST server
		do
			Result := Rep_server;
		end;

end
