-- Server for replicated features 

class
	REP_SERVER 

inherit
	COMPILER_SERVER [REP_FEATURES, CLASS_ID]
		redefine
			disk_item, has, item, make
		end

creation
	make

feature -- Initialisation

	make is
		-- Creation
		do
			{COMPILER_SERVER}Precursor
			!! cache.make
		end

feature -- Access

	cache: REP_CACHE 
			-- Cache for routine tables
		
	id (t: REP_FEATURES): CLASS_ID is
			-- Id associated with `t'
		do
			Result := t.class_id
		end

	item (an_id: CLASS_ID): REP_FEATURES is
			-- Replicate features of class id `an_id'. 
			-- Look first in the temporary rep feat server.
		require else
			has_an_id: has (an_id);
		do
			if Tmp_rep_server.has (an_id) then
				Result := Tmp_rep_server.item (an_id);
			else
				Result := server_item (an_id);
			end;
		end;

	disk_item (an_id: CLASS_ID): REP_FEATURES is
			-- Byte code of body id `and_id'. Look first in the temporary
			-- byte code server
		do
			if Tmp_rep_server.has (an_id) then
				Result := Tmp_rep_server.disk_item (an_id);
			else
				Result := {COMPILER_SERVER} Precursor (an_id);
			end;
		end;

	has (an_id: CLASS_ID): BOOLEAN is
			-- Is the id `an_id' present in `Tmp_rep_feat_server' or
			-- Current ?
		require else
			positive_id: an_id /= Void
		do
			Result := server_has (an_id) or else Tmp_rep_server.has (an_id);
		end;

feature -- Server size configuration

	Size_limit: INTEGER is 100
			-- Size of the REP_SERVER file (75 Ko)

	Chunk: INTEGER is 150
			-- Size of a HASH_TABLE block

end
