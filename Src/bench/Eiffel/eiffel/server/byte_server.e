-- Server for routine tables

class
	BYTE_SERVER 

inherit
	COMPILER_SERVER [BYTE_CODE, BODY_ID]
		redefine
			disk_item, has, item, ontable, updated_id, change_id
		end

creation
	make

feature -- Update

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

	id (t: BYTE_CODE): BODY_ID is
			-- Id associated with `t'
		do
			Result := t.byte_id
		end

	cache: BYTE_CACHE is
			-- Cache for routine tables
		once
			!! Result.make
		end
	
feature -- Access

	item (an_id: BODY_ID): BYTE_CODE is
			-- Byte code of body id `and_id'. Look first in the temporary
			-- byte code server
		do
			if Tmp_byte_server.has (an_id) then
				Result := Tmp_byte_server.item (an_id);
			else
				Result := server_item (an_id);
			end;
		end;

	disk_item (an_id: BODY_ID): BYTE_CODE is
			-- Byte code of body id `and_id'. Look first in the temporary
			-- byte code server
		do
			if Tmp_byte_server.has (an_id) then
				Result := Tmp_byte_server.disk_item (an_id);
			else
				Result := {COMPILER_SERVER} Precursor (an_id);
			end;
		end;

	has (an_id: BODY_ID): BOOLEAN is
			-- Is the id `an_id' present in `Tmp_byte_server' or
			-- Current ?
		require else
			positive_id: an_id /= Void;
		do
			Result := server_has (an_id) or else Tmp_byte_server.has (an_id);
		end;

feature -- Update

	change_id (new_value, old_value: BODY_ID) is
		require else
			True
		do
			if server_has (old_value) then
				{COMPILER_SERVER} Precursor (new_value, old_value)
			end;
			if Tmp_byte_server.has (old_value) then
				Tmp_byte_server.change_id (new_value, old_value)
			end;
		end;

feature -- Server size configuration

	Size_limit: INTEGER is 150
			-- Size of the BYTE_SERVER file (150 Ko)

	Chunk: INTEGER is 500
			-- Size of a HASH_TABLE block

end
