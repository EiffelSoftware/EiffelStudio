-- Server for abstract syntax description of invariant

class REP_FEAT_SERVER 

inherit

	READ_SERVER [FEATURE_AS_B]
		rename
			item as server_item,
			has as server_has,
			change_id as server_change_id
		export
			{ANY} server_has, server_item, merge
		redefine
			ontable, updated_id
		end;

	READ_SERVER [FEATURE_AS_B]
		redefine
			has, item, ontable, updated_id, change_id
		select
			has, item, change_id
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

	item (an_id: INTEGER): FEATURE_AS_B is
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

	change_id (new_value, old_value: INTEGER) is
		do
			if server_has (old_value) then
				server_change_id (new_value, old_value)
			end;
			if Tmp_rep_feat_server.has (old_value) then
				Tmp_rep_feat_server.change_id (new_value, old_value)
			end;
		end;

end
