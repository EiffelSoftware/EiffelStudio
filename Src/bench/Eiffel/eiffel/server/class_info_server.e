indexing
	description: "Server for class information indexed by class id."
	date: "$Date$"
	revision: "$Revision$"

class CLASS_INFO_SERVER 

inherit
	COMPILER_SERVER [CLASS_INFO]
		redefine
			has, item, disk_item
		end

creation
	make
	
feature 

	cache: CLASS_INFO_CACHE is
			-- Cache for routine tables
		once
			!! Result.make
		end
	
	has (an_id: INTEGER): BOOLEAN is
			-- Is an item of id `an_id' present in the current server ?
		do
			Result := server_has (an_id)
					or else Tmp_class_info_server.has (an_id);
		end;
					
	id (t: CLASS_INFO): INTEGER is
			-- Id associated with `t'
		do
			Result := t.class_id
		end

	item (an_id: INTEGER): CLASS_INFO is
			-- Feature table of id `an_id'. Look first in the temporary
			-- feature table server. It not present, look in itself.
		require else
			has_an_id: has (an_id);
		do
			if Tmp_class_info_server.has (an_id) then
				Result := Tmp_class_info_server.item (an_id);
			else
				Result := server_item (an_id);
			end; 
		end;

	disk_item (an_id: INTEGER): CLASS_INFO is
			-- Byte code of body id `and_id'. Look first in the temporary
			-- byte code server
		do
			if Tmp_class_info_server.has (an_id) then
				Result := Tmp_class_info_server.disk_item (an_id);
			else
				Result := {COMPILER_SERVER} Precursor (an_id);
			end;
		end;

feature -- Server size configuration

	Size_limit: INTEGER is 200
			-- Size of the CLASS_INFO_SERVER file (200 Ko)

	Chunk: INTEGER is 500
			-- Size of a HASH_TABLE block

end
