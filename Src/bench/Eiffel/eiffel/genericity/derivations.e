-- Table recording all the derivations of all the generic classes indexed by class id

class DERIVATIONS

inherit

	HASH_TABLE [FILTER_LIST, CLASS_ID];
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
		do
debug
	io.error.putstring ("Inserting a new derivation ");
	io.error.putint (an_id.id);
	io.error.new_line;
	a_type.dump (io.error);
	io.error.new_line;
end;
			derivations := item (an_id);
			if derivations = Void then
				!!derivations.make;
				derivations.compare_objects
				put (derivations, an_id);
			end;
			derivations.put_front (a_type);
		end;

end
