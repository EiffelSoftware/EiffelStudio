indexing
	description: "Comment server for a class indexed by class id.";
	date: "$Date$";
	revision: "$Revision$"

class
	CLASS_COMMENTS_SERVER 

inherit
	COMPILER_SERVER [CLASS_COMMENTS]

create
	make

feature -- Access

	id (t: CLASS_COMMENTS): INTEGER is
			-- Id associated with `t'
		do
			Result := t.class_id
		end

feature {NONE} -- Implementation

	Cache: CACHE [CLASS_COMMENTS] is
			-- No caching machanism 
			-- (Returns void)
		do
		end;

	Size_limit: INTEGER is 200
			-- Size of the CLASS_COMMENTS_SERVER file (200 Ko)

	Chunk: INTEGER is 500
			-- Size of a HASH_TABLE block

end
