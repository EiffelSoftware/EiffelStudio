-- Table recording all the derivations of all the generic classes indexed by class id

class
	DERIVATIONS

inherit
	HASH_TABLE [FILTER_LIST, INTEGER]

	COMPILER_EXPORTER
		undefine
			is_equal, copy
		end

create
	make

feature

	has_derivation (an_id: INTEGER; a_type: CL_TYPE_I): BOOLEAN is
		local
			derivations: FILTER_LIST;
		do
			derivations := item (an_id)
			if derivations /= Void then
				Result := derivations.has_item (a_type)
			end;
		end;

	insert_derivation (an_id: INTEGER; a_type: CL_TYPE_I) is
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
				create derivations.make;
				put (derivations, an_id);
			end;

			tuple_i ?= a_type

			-- Do not add any TUPLE derivations

			if tuple_i = Void then
				derivations.extend (a_type);
			end
		end;

end
