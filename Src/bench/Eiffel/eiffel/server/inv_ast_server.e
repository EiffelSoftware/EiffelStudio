-- Server for abstract syntax description of invariant

class
	INV_AST_SERVER 

inherit
	READ_SERVER [INVARIANT_AS, CLASS_ID]
		rename
			ast_server as offsets
		export
			{ANY} merge
		redefine
			has, item, make
		end

creation
	make



feature -- Initialisation

	make is
		-- Creation
		do
			{READ_SERVER}Precursor
			!! cache.make
		end


feature 

	cache: INV_AST_CACHE 
			-- Cache for routine tables
		
	has (an_id: CLASS_ID): BOOLEAN is
			-- Is the id `an_id' present either in Current or in
			-- `Tmp_inv_ast_server' ?
		do
			Result := Tmp_inv_ast_server.has (an_id) or else server_has (an_id);
		end;

	item (an_id: CLASS_ID): INVARIANT_AS is
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

end
