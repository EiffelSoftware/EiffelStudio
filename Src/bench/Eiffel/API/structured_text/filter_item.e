-- Mark appearing before or after major syntactic constructs.

class FILTER_ITEM

inherit

	TEXT_ITEM

creation

	make

feature

	make (new_construct: like construct) is
		require
			new_construct_not_void: new_construct /= Void
		do
			construct := new_construct
		end;

	construct: STRING;
			-- Name of the syntactic construct

	is_before: BOOLEAN;
			-- Does `Current' appear before the syntactic construct?

	set_before is
		do
			is_before := true
		end;

	set_after is
		do
			is_before := false
		end;

invariant

	construct_not_void: construct /= Void

end -- class FILTER_ITEM
