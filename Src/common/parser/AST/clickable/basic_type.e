-- Abstract class for Eiffel basic types

deferred class BASIC_TYPE

inherit

	STONABLE;
	TYPE
		redefine 
			format
		end;

feature -- Initialization

	set is
			-- Yacc initialization
		do
			-- Do nothing
		end;

feature -- stoning

	stone (reference_class: CLASS_C): CLASSC_STONE is
		do
			!!Result.make (actual_type.associated_class)
		end;

feature -- formatting

	format (ctxt: FORMAT_CONTEXT) is
			-- Reconstitute text
		do
			ctxt.put_class_name (actual_type.associated_class);
		end;
			

end
