-- Abstract description for formal generic type

class FORMAL_AS

inherit

	TYPE
		rename
			position as text_position
		redefine
			simple_format
		end;
--	STONABLE;
	BASIC_ROUTINES
		export
			{NONE}
				all
		end;

feature
	
	toto is do end;

feature

	position: INTEGER;
			-- Position of the formal parameter in the declaration
			-- array

	set_position (i: INTEGER) is
			-- Assign `i' to `position'.
		do
			position := i;
		end;

feature -- Initialization

	set is
			-- Yacc initialization
		do
			position := yacc_int_arg (0);
		end;

feature

	dump: STRING is
		do
			!!Result.make (12);
			Result.append ("Generic #");
			Result.append_integer (position);
		end;

feature -- Formatting

	simple_format (ctxt: FORMAT_CONTEXT) is
			-- Reconstitute text.
		local
			id_as: ID_AS
		do
			--ctxt.put_string (ctxt.formal_name (position));

			-- FOLLOWING NEEDS ADAPTATION:
			id_as := ctxt.ast.generics.i_th (position).formal_name
			id_as.to_upper
			ctxt.put_string (id_as)

		--	new_type := ctxt.format.global_types.adapted_type (Current);
		--	if new_type = void then
		--		ctxt.put_string (ctxt.formal_name (position));
		--	else
		--		new_type.simple_format (ctxt);
		--	end
		end;
end
