-- Server for abstract syntax description of invariant

class REP_FEAT_SERVER 

inherit
	READ_SERVER [FEATURE_AS, BODY_ID]
		rename
			rep_server as offsets
		export
			{ANY} merge
		redefine
			has, item, ontable, updated_id, change_id
		end

creation
	make

feature -- Access

	ontable: O_N_TABLE [BODY_ID] is
			-- Mapping table between old id s and new ids.
			-- Used by `change_id'
		require else
			True
		once
			Result := System.onbidt
		end;

	updated_id (i: BODY_ID): BODY_ID is
		do
			Result := ontable.item (i)
		end;

	cache: REP_FEAT_CACHE is
			-- Cache for routine tables
		once
			!! Result.make
		end
		
	has (an_id: BODY_ID): BOOLEAN is
			-- Is the id `an_id' present either in Current or in
			-- `Tmp_rep_feat_server' ?
		do
			Result := Tmp_rep_feat_server.has (an_id) or else server_has (an_id);
		end;

	item (an_id: BODY_ID): FEATURE_AS is
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

	change_id (new_value, old_value: BODY_ID) is
		do
			if server_has (old_value) then
				{READ_SERVER} Precursor (new_value, old_value)
			end;
			if Tmp_rep_feat_server.has (old_value) then
				Tmp_rep_feat_server.change_id (new_value, old_value)
			end;
		end;

end
