indexing
	description: "Server for invariants byte code indexed by class id."
	date: "$Date$"
	revision: "$Revision$"

class
	INV_BYTE_SERVER 

inherit
	COMPILER_SERVER [INVARIANT_B]
		redefine
			has, item, disk_item
		end

creation
	make

feature -- Access

	cache: INV_BYTE_CACHE is
			-- Cache for routine tables
		once
			!! Result.make
		end
		
	id (t: INVARIANT_B): INTEGER is
			-- Id associated with `t'
		do
			Result := t.class_id
		end

	item (an_id: INTEGER): INVARIANT_B is
			-- Byte code of body id `and_id'. Look first in the temporary
			-- byte code server
		do
			if Tmp_inv_byte_server.has (an_id) then
				Result := Tmp_inv_byte_server.item (an_id);
			else
				Result := server_item (an_id);
			end;
		ensure then
			Result_exists: Result /= Void
		end;

	disk_item (an_id: INTEGER): INVARIANT_B is
			-- Byte code of body id `and_id'. Look first in the temporary
			-- byte code server
		do
			if Tmp_inv_byte_server.has (an_id) then
				Result := Tmp_inv_byte_server.disk_item (an_id);
			else
				Result := {COMPILER_SERVER} Precursor (an_id);
			end;
		end;

	has (an_id: INTEGER): BOOLEAN is
			-- Is the id `an_id' present in `Tmp_inv_byte_server' or
			-- Current ?
		do
			Result := server_has (an_id) or else Tmp_inv_byte_server.has (an_id);
		end;

feature -- Server size configuration

	Size_limit: INTEGER is 200
			-- Size of the INV_BYTE_SERVER file (200 Ko)

	Chunk: INTEGER is 500
			-- Size of a HASH_TABLE block

end
