indexing
	description: "MATISSE-Eiffel Binding";
	date: "$Date$";
	revision: "$Revision$"

class
	MT_HASH_TABLE_RELATIONSHIP

inherit
	MT_MULTI_RELATIONSHIP
		redefine
			get_container_type_id,
			empty_container_for
		end

creation
	make_from_id

feature

	get_container_type_id: INTEGER is
		local
			c_string: ANY
		do
			c_string := ("MT_HASH_TABLE").to_c
			Result := c_generic_type_id ($c_string)
		end

feature {MT_STORABLE} -- Container

	empty_container_for(a_predecessor: MT_STORABLE): MT_RS_CONTAINABLE is
			-- Return an empty container object (HASH_TABLE).
			-- The container is initialized so that it can load successors later.
			-- ('predecessor' and 'relationship' is set to `a_predecessor' and `Current'.)
		do
			Result := c_create_empty_rs_container (container_type_id, a_predecessor.oid, oid)
			if Result /= Void then
				Result.set_predecessor (a_predecessor)
				Result.set_relationship (Current)
			end
		end
		
feature {NONE}  -- dummy declaration for dynamic object creation

	aaii: MT_AA_HASH_TABLE[INTEGER, INTEGER] is once end
	aaic: MT_AA_HASH_TABLE[INTEGER, CHARACTER] is once end
	aair: MT_AA_HASH_TABLE[INTEGER, REAL] is once end
	aaid: MT_AA_HASH_TABLE[INTEGER, DOUBLE] is once end
	aaib: MT_AA_HASH_TABLE[INTEGER, BOOLEAN] is once end
	aais: MT_AA_HASH_TABLE[INTEGER, STRING] is once end
	
	aaci: MT_AA_HASH_TABLE[CHARACTER, INTEGER] is once end
	aacc: MT_AA_HASH_TABLE[CHARACTER, CHARACTER] is once end
	aacr: MT_AA_HASH_TABLE[CHARACTER, REAL] is once end
	aacd: MT_AA_HASH_TABLE[CHARACTER, DOUBLE] is once end
	aacb: MT_AA_HASH_TABLE[CHARACTER, BOOLEAN] is once end
	aacs: MT_AA_HASH_TABLE[CHARACTER, STRING] is once end
	
	aari: MT_AA_HASH_TABLE[REAL, INTEGER] is once end
	aarc: MT_AA_HASH_TABLE[REAL, CHARACTER] is once end
	aarr: MT_AA_HASH_TABLE[REAL, REAL] is once end
	aard: MT_AA_HASH_TABLE[REAL, DOUBLE] is once end
	aarb: MT_AA_HASH_TABLE[REAL, BOOLEAN] is once end
	aars: MT_AA_HASH_TABLE[REAL, STRING] is once end
	
	aadi: MT_AA_HASH_TABLE[DOUBLE, INTEGER] is once end
	aadc: MT_AA_HASH_TABLE[DOUBLE, CHARACTER] is once end
	aadr: MT_AA_HASH_TABLE[DOUBLE, REAL] is once end
	aadd: MT_AA_HASH_TABLE[DOUBLE, DOUBLE] is once end
	aadb: MT_AA_HASH_TABLE[DOUBLE, BOOLEAN] is once end
	aads: MT_AA_HASH_TABLE[DOUBLE, STRING] is once end
	
	aabi: MT_AA_HASH_TABLE[BOOLEAN, INTEGER] is once end
	aabc: MT_AA_HASH_TABLE[BOOLEAN, CHARACTER] is once end
	aabr: MT_AA_HASH_TABLE[BOOLEAN, REAL] is once end
	aabd: MT_AA_HASH_TABLE[BOOLEAN, DOUBLE] is once end
	aabb: MT_AA_HASH_TABLE[BOOLEAN, BOOLEAN] is once end
	aabs: MT_AA_HASH_TABLE[BOOLEAN, STRING] is once end

	aasi: MT_AA_HASH_TABLE[STRING, INTEGER] is once end
	aasc: MT_AA_HASH_TABLE[STRING, CHARACTER] is once end
	aasr: MT_AA_HASH_TABLE[STRING, REAL] is once end
	aasd: MT_AA_HASH_TABLE[STRING, DOUBLE] is once end
	aasb: MT_AA_HASH_TABLE[STRING, BOOLEAN] is once end
	aass: MT_AA_HASH_TABLE[STRING, STRING] is once end


	rari: MT_RA_HASH_TABLE[MT_OBJECT, INTEGER] is once end
	rarc: MT_RA_HASH_TABLE[MT_OBJECT, CHARACTER] is once end
	rarr: MT_RA_HASH_TABLE[MT_OBJECT, REAL] is once end
	rard: MT_RA_HASH_TABLE[MT_OBJECT, DOUBLE] is once end
	rarb: MT_RA_HASH_TABLE[MT_OBJECT, BOOLEAN] is once end
	rars: MT_RA_HASH_TABLE[MT_OBJECT, STRING] is once end
	
	
	arir: MT_AR_HASH_TABLE[INTEGER, STRING] is once end
	arcr: MT_AR_HASH_TABLE[CHARACTER, STRING] is once end
	arrr: MT_AR_HASH_TABLE[REAL, STRING] is once end
	ardr: MT_AR_HASH_TABLE[DOUBLE, STRING] is once end
	arbr: MT_AR_HASH_TABLE[BOOLEAN, STRING] is once end
	arsr: MT_AR_HASH_TABLE[STRING, STRING] is once end
	
	rrrr: MT_RR_HASH_TABLE[MT_OBJECT, STRING] is once end

end -- class MT_HASH_TABLE_RELATIONSHIP
