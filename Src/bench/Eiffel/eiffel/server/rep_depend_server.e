-- Server for replicated features 

class
	REP_DEPEND_SERVER 

inherit
	COMPILER_SERVER [REP_CLASS_DEPEND, CLASS_ID]
		redefine
			disk_item, has, item
		end

creation
	make

feature -- Access

	cache: REP_DEPEND_CACHE is
			-- Cache for routine tables
		once
			!! Result.make
		end
	
	id (t: REP_CLASS_DEPEND): CLASS_ID is
			-- Id associated with `t'
		do
			Result := t.id
		end

	item (an_id: CLASS_ID): REP_CLASS_DEPEND is
			-- Replicate features of class id `an_id'. 
			-- Look first in the temporary rep feat server.
		require else
			has_an_id: has (an_id);
		do
			if Tmp_rep_depend_server.has (an_id) then
				Result := Tmp_rep_depend_server.item (an_id);
			else
				Result := server_item (an_id);
			end;
		end;

	disk_item (an_id: CLASS_ID): REP_CLASS_DEPEND is
			-- Byte code of body id `and_id'. Look first in the temporary
			-- byte code server
		do
			if Tmp_rep_depend_server.has (an_id) then
				Result := Tmp_rep_depend_server.disk_item (an_id);
			else
				Result := {COMPILER_SERVER} Precursor (an_id);
			end;
		end;

	has (an_id: CLASS_ID): BOOLEAN is
			-- Is the id `an_id' present in `Tmp_rep_depend_server' or
			-- Current ?
		require else
			positive_id: an_id /= Void
		do
			Result := server_has (an_id) or else Tmp_rep_depend_server.has (an_id);
		end;

feature -- Server size configuration

	Size_limit: INTEGER is 100
			-- Size of the REP_DEPEND_SERVER file (100 Ko)

	Chunk: INTEGER is 150
			-- Size of a HASH_TABLE block

end
