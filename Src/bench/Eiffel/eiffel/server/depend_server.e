indexing
	description: "Server of class dependances for incremental type check indexed by class id."
	date: "$Date$"
	revision: "$Revision$"
 
class DEPEND_SERVER 

inherit
	COMPILER_SERVER [CLASS_DEPENDANCE]
		redefine
			make, item, has
		end

creation
	make

feature -- Initialisation

	make is
		-- Creation
		do
			{COMPILER_SERVER}Precursor
			!! bindex_cid_table.make (200)
		end

	
feature -- Access

	id (t: CLASS_DEPENDANCE): INTEGER is
			-- Id associated with `t'
		do
			Result := t.class_id
		end

	cache: DEPEND_CACHE is
			-- Cache for routine tables
		once
			!! Result.make
		end

	bindex_cid_table: HASH_TABLE [INTEGER, INTEGER]
			-- you give it a body_index and it tells you in which 
			-- class the corresponding feature is written

	remove_correspondance (bindex: INTEGER) is
		do
			bindex_cid_table.remove (bindex)
		end

	add_correspondance (bindex: INTEGER; cid: INTEGER) is
		do
			bindex_cid_table.put (cid, bindex)
		end

	item (an_id: INTEGER): CLASS_DEPENDANCE is
			-- Class dependance of id 'an_id' . Look first in the temporary
			-- depend server. It not present, look in itself.
		do
			if Tmp_depend_server.has (an_id) then
				Result := Tmp_depend_server.item (an_id);
			else
				Result := server_item (an_id);
			end; 
		end;		
		
	has (an_id: INTEGER): BOOLEAN is
			-- Is an item of id `an_id' present in the current server?
		do
			Result := server_has (an_id) or else Tmp_depend_server.has (an_id);
		end

feature -- Server size configuration

	Size_limit: INTEGER is 100
			-- Size of the DEPEND_SERVER file (100 Ko)

	Chunk: INTEGER is 150
			-- Size of a HASH_TABLE block

end
