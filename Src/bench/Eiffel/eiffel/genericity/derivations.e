-- Table recording all the derivations of all the generic classes indexed by class id

class
	DERIVATIONS

inherit
	HASH_TABLE [FILTER_LIST, CLASS_ID]

	COMPILER_EXPORTER
		undefine
			is_equal, copy
		end

creation
	make

feature

	has_derivation (an_id: CLASS_ID; a_type: GEN_TYPE_I): BOOLEAN is
		local
			derivations: FILTER_LIST;
		do
			derivations := item (an_id);
			if derivations /= Void then
				derivations.start;
				derivations.search (a_type);
				if not derivations.after then
					Result := True
				end;
			end;
		end;

	insert_derivation (an_id: CLASS_ID; a_type: GEN_TYPE_I) is
		local
			derivations: FILTER_LIST;
			tuple_type: TUPLE_TYPE_I
			is_new: BOOLEAN
		do
debug
	io.error.putstring ("Inserting a new derivation ");
	an_id.trace;
	io.error.new_line;
	a_type.trace
	io.error.new_line;
end;
			derivations := item (an_id);
			if derivations = Void then
				!!derivations.make;
				derivations.compare_objects
				put (derivations, an_id);
				is_new := True
			end;
			tuple_type ?= a_type

			-- Do not create multiple derivations for TUPLEs

			if is_new or else tuple_type = Void then
				derivations.put_front (a_type);
			end
		end;

end
