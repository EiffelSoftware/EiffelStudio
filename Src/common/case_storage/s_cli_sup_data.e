class S_CLI_SUP_DATA

inherit

	S_RELATION_DATA
		rename
			f_rom as client, t_o as supplier,
			set_booleans as rel_set_boolens
		end	

feature

	is_implementation: BOOLEAN;
			-- Is this link a result of the implementation
			-- and assertion
			--| False implies that this relationship is derieved
			--| from the result type and argument type of the
			--| feature from the client class

	is_reflexive: BOOLEAN;
			-- Is this link an reflexive link ?

feature -- Setting values

	set_booleans (is_imp, is_ref: BOOLEAN) is
			-- Set all the booleans for Current.
		do
			is_implementation := is_imp;
			is_reflexive := is_ref;
		ensure
			booleans_are_set: is_implementation = is_imp and then
								is_reflexive = is_ref 
		end;

	set_implementation (b: BOOLEAN) is
			-- Set is_implementation to `b'.
		do
			is_implementation := b
		ensure
			is_implementation_set: is_implementation = b
		end;

	set_is_reflexive is
			-- Set is_reflexive to `True'.
		do
			is_reflexive := True
		ensure
			is_reflexive: is_reflexive
		end;

end
