-- Server for abstract syntax description of invariant

class INV_AST_SERVER 

inherit

	READ_SERVER [INVARIANT_AS_B]
		rename
			item as server_item,
			has as server_has
		export
			{ANY} server_has, server_item, merge
		end;

	READ_SERVER [INVARIANT_AS_B]
		redefine
			has, item
		select
			has, item
		end

creation

	make

feature 

	Cache: INV_AST_CACHE is
			-- Cache for routine tables
		once
			!!Result.make;
		end;

	has (an_id: INTEGER): BOOLEAN is
			-- Is the id `an_id' present either in Current or in
			-- `Tmp_inv_ast_server' ?
		do
			Result := Tmp_inv_ast_server.has (an_id) or else server_has (an_id);
		end;

	item (an_id: INTEGER): INVARIANT_AS_B is
			-- Invariant of class of id `an_id'. Look for it first in
			-- the associated temporary server
	   do
			if Tmp_inv_ast_server.has (an_id) then
				Result := Tmp_inv_ast_server.item (an_id);
			else
				Result := server_item (an_id);
			end;
		ensure then
			Result_exists: Result /= Void
		end;

	offsets: EXTEND_TABLE [SERVER_INFO, INTEGER] is
			-- Class offsets in the AST server
		do
			Result := Ast_server;
		end;

end
