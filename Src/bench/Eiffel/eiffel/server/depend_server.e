-- Server of class dependances for incremental type check

class DEPEND_SERVER 

inherit
	COMPILER_SERVER [CLASS_DEPENDANCE, CLASS_ID]
		redefine
			make, item
		end

creation
	make

feature -- Initialisation

	make is
		-- Creation
		do
			{COMPILER_SERVER}Precursor
			!! cache.make
			!! bid_cid_table.make (200)
		end

	
feature -- Access

	id (t: CLASS_DEPENDANCE): CLASS_ID is
			-- Id associated with `t'
		do
			Result := t.id
		end

	cache: DEPEND_CACHE 
			-- Cache for routine tables

	bid_cid_table: EXTEND_TABLE [CLASS_ID, BODY_ID]
			-- you give it a body_id and it tells you in which 
			-- class the corresponding feature is written

	remove_correspondance (bid: BODY_ID) is
		do
			bid_cid_table.remove (bid)
		end

	add_correspondance (bid: BODY_ID; cid: CLASS_ID) is
		do
		
			bid_cid_table.put (cid, bid)
		end

	change_ids (new_id, old_id: BODY_ID) is
			-- update the keys in the class dependance of class_id
			-- when a body id is changed
		local
			class_concerned: CLASS_ID
		do
			class_concerned := bid_cid_table.item (old_id)
			if class_concerned /= Void then
				item (class_concerned).change_ids (new_id, old_id)
				bid_cid_table.remove (old_id)
				bid_cid_table.put (class_concerned, new_id)		
			end
		end
	
	item (an_id: CLASS_ID): CLASS_DEPENDANCE is
			-- Class dependance of id 'an_id' . Look first in the temporary
			-- depend server. It not present, look in itself.
		do
			if Tmp_depend_server.has (an_id) then
				Result := Tmp_depend_server.item (an_id);
			else
				Result := server_item (an_id);
			end; 
		end;		
		
feature -- Server size configuration

	Size_limit: INTEGER is 100
			-- Size of the DEPEND_SERVER file (100 Ko)

	Chunk: INTEGER is 150
			-- Size of a HASH_TABLE block

end
