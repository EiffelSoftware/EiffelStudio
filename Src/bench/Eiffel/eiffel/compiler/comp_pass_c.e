deferred class COMP_PASS_C

inherit

	PART_COMPARABLE;
	PASS_C

feature

	infix "<" (other: like Current): BOOLEAN is
		do
			Result := associated_class < other.associated_class
		end;

end
