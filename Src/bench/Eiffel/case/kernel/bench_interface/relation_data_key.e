indexing

	description: "Key to identify a relation.";
	date: "$Date$";
	revision: "$Revision $"

deferred class RELATION_DATA_KEY

feature

	f_rom: LINKABLE_DATA;

	t_o: LINKABLE_DATA;

	data: RELATION_DATA is
		deferred
		end;

feature {NONE}

	internal_data: like data;

	make (from_key, to_key: LINKABLE_DATA) is
		require
			valid_keys: from_key /= Void and then to_key /= Void
		do
			f_rom := from_key;
			t_o := to_key	
		end;

	make_with_relation (rel: like data) is
		require
			valid_rel: rel /= Void
		do
			f_rom := rel.f_rom;
			t_o := rel.t_o;
			internal_data := rel;
		end;

end -- class RELATION_DATA_KEY
