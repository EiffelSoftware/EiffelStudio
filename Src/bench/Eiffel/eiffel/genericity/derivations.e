-- Table recording all the derivations of all the generic classes indexed by class id

class
	DERIVATIONS

inherit
	HASH_TABLE [FILTER_LIST, INTEGER]

	COMPILER_EXPORTER
		undefine
			is_equal, copy
		end

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
				derivations.search (a_type);
				if not derivations.after then
					Result := True
				end;
			end;
		end;

	insert_derivation (an_id: INTEGER; a_type: GEN_TYPE_I) is
		local
			derivations: FILTER_LIST;
			tuple_i: TUPLE_TYPE_I
		do
debug
	io.error.putstring ("Inserting a new derivation ");
	io.error.putint (an_id)
	io.error.new_line;
	a_type.trace
	io.error.new_line;
end;
			derivations := item (an_id);
			if derivations = Void then
				!!derivations.make;
				put (derivations, an_id);
			end;

			tuple_i ?= a_type

			-- Do not add any TUPLE derivations

			if tuple_i = Void then
				derivations.put_front (a_type);
			end
		end;

end
