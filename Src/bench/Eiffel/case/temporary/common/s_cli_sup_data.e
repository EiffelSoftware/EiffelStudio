indexing

	description: 
		"Data describing client-supplier relationships."
	date: "$Date$";
	revision: "$Revision $"

class S_CLI_SUP_DATA

inherit

	S_RELATION_DATA
		rename
			f_rom as client, t_o as supplier
		end	

feature -- Properties

	label: STRING;
			-- Label of relation

	is_implementation: BOOLEAN;
			-- Is this link a result of the implementation
			-- and assertion
			--| False implies that this relationship is derieved
			--| from the result type and argument type of the
			--| feature from the client class

	is_reflexive: BOOLEAN;
			-- Is this link an reflexive link ?

feature -- Setting 

	set_implementation (b: BOOLEAN) is
			-- Set is_implementation to `b'.
		do
			is_implementation := b
		ensure
			is_implementation_set: is_implementation = b
		end;

	set_reflexive (b: BOOLEAN) is
			-- Set is_reflexive to `True'.
		do
			is_reflexive := b
		ensure
			reflexive_set: is_reflexive = b
		end;

	set_label (l: STRING) is
			-- Set label to `l'.
		require
			valid_arg: l /= Void
		do
			label := l
		ensure
			label_set: label = l
		end;

end -- class S_CLI_SUP_DATA
