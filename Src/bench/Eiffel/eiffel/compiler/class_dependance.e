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
		end;
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
			Result := System.class_of_id (class_id);
		end;

	put (f: FEATURE_DEPENDANCE; bindex: INTEGER) is
			-- We must update the correspondance table in the server
		do
			System.depend_server.add_correspondance (bindex, class_id)
			{EXTEND_TABLE} Precursor (f, bindex)
		end

	remove (bindex: INTEGER) is
			-- we must update the correspondance table in the server
		do
			System.depend_server.remove_correspondance (bindex)
			{EXTEND_TABLE} Precursor (bindex)
		end

feature {CASE_RECORD_SUPPLIERS} -- Case specific

	item_of_name (n: STRING): FEATURE_DEPENDANCE is
			-- to find the dependances of a feature from its name
		local
			feature_found: BOOLEAN	
		do
			from
				start
			until
				after or else feature_found
			loop
				feature_found := item_for_iteration.feature_name.is_equal (n)
				if not feature_found then
					forth
				end
			end	
			if feature_found then
				Result := item_for_iteration
			end
		end
			
end
