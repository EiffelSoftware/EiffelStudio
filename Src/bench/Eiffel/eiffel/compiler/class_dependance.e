indexing
	description: "Description of the supplier of a class: each feature%
				%name written in the associated class is associated to%
				%a supplier list (list of ids), indexed by body index."
	date: "$Date$"
	revision: "$Revision$"

class CLASS_DEPENDANCE 

inherit
	EXTEND_TABLE [FEATURE_DEPENDANCE, INTEGER]
		redefine
			remove, put
		end

	IDABLE
		rename
			id as class_id,
			set_id as set_class_id
		undefine
			is_equal, copy
		end

	SHARED_WORKBENCH
		undefine
			is_equal, copy
		end

creation
	make

feature 

	associated_class: CLASS_C is
			-- Associated class
		do
			Result := System.class_of_id (class_id)
		end

	put (f: FEATURE_DEPENDANCE; bindex: INTEGER) is
			-- We must update the correspondance table in the server
		do
			System.depend_server.add_correspondance (bindex, class_id)
			Precursor {EXTEND_TABLE} (f, bindex)
		end

	remove (bindex: INTEGER) is
			-- we must update the correspondance table in the server
		do
			System.depend_server.remove_correspondance (bindex)
			Precursor {EXTEND_TABLE} (bindex)
		end

end
