indexing
	description: "Server for byte code routine indexed by body_index"
	date: "$Date$"
	revision: "$Revision$"

class
	BYTE_SERVER 

inherit
	COMPILER_SERVER [BYTE_CODE]
		redefine
			disk_item, has, item
		end

creation
	make

feature -- Update

	id (t: BYTE_CODE): INTEGER is
			-- Id associated with `t'
		do
			Result := t.body_index
		end

	cache: BYTE_CACHE is
			-- Cache for routine tables
		once
			!! Result.make
		end
	
feature -- Access

	item (an_id: INTEGER): BYTE_CODE is
			-- Byte code of body index `an_id'. Look first in the temporary
			-- byte code server
		do
			if Tmp_byte_server.has (an_id) then
				Result := Tmp_byte_server.item (an_id);
			else
				Result := server_item (an_id);
			end;
		end;

	disk_item (an_id: INTEGER): BYTE_CODE is
			-- Byte code of body index `an_id'. Look first in the temporary
			-- byte code server
		do
			if Tmp_byte_server.has (an_id) then
				Result := Tmp_byte_server.disk_item (an_id);
			else
				Result := {COMPILER_SERVER} Precursor (an_id);
			end;
		end;

	has (an_id: INTEGER): BOOLEAN is
			-- Is the id `an_id' present in `Tmp_byte_server' or
			-- Current ?
		require else
			positive_id: an_id /= 0;
		do
			Result := server_has (an_id) or else Tmp_byte_server.has (an_id);
		end;

feature -- Server size configuration

	Size_limit: INTEGER is 150
			-- Size of the BYTE_SERVER file (150 Ko)

	Chunk: INTEGER is 500
			-- Size of a HASH_TABLE block

end
