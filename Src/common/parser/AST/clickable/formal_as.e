-- Abstract description for formal generic type

class FORMAL_AS

inherit

	TYPE
		rename
			position as text_position
		redefine
			format
		end;
	STONABLE;
	BASIC_ROUTINES
		export
			{NONE}
				all
		end;

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

	solved_type (feat_table: FEATURE_TABLE; f: FEATURE_I): FORMAL_A is
			-- Calculated type in function of the feature `f' which has
			-- the type Current and the feautre table `feat_table'
		do
			Result := actual_type;
		end;

	actual_type: FORMAL_A is
			-- Actual type for formal generic
		do
			!!Result;
			Result.set_base_type (position);
		end;

feature -- stoning
 
	stone (reference_class: CLASS_C): CLASSC_STONE is
		local
			aclass: CLASS_C;
		do  
			aclass := actual_type.associated_class;
			!!Result.make (aclass)
		end;


feature -- Formatting

	format (ctxt: FORMAT_CONTEXT) is
			-- Reconstitute text.

			--| G, H, I, J... according to position
			--| do not work with instantiation for flat
			--| to be changed
		local
			s: STRING; 
		do
			!!s.make(1);
			s.append_character (charconv (charcode('F') + position));
			ctxt.put_string (s);
			ctxt.always_succeed;
		end;
end
