-- Table recording all the derivations of all the generic classes indexed by class id

class DERIVATIONS

inherit

	HASH_TABLE [FILTER_LIST, INTEGER]

creation

	make

feature

	has_derivation (an_id: INTEGER; a_type: GEN_TYPE_I): BOOLEAN is
		local
			derivations: FILTER_LIST;
		do
			derivations := item (an_id);
			if derivations /= Void then
				derivations.start;
				derivations.search_equal (a_type);
				if not derivations.offright then
					Result := True
				end;
			end;
		end;

	insert_derivation (an_id: INTEGER; a_type: GEN_TYPE_I) is
		local
			derivations: FILTER_LIST;
		do
debug
	io.error.putstring ("Inserting a new derivation ");
	io.error.putint (an_id);
	io.error.new_line;
	a_type.dump (io.error);
	io.error.new_line;
end;
			derivations := item (an_id);
			if derivations = Void then
				!!derivations.make;
				put (derivations, an_id);
			end;
			derivations.add_front (a_type);
		end;

end
