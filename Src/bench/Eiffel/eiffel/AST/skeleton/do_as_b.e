class DO_AS_B

inherit

	DO_AS
		redefine
			compound
		end;

	INTERNAL_AS_B
		redefine
			compound
		end

feature -- Properties

	compound: EIFFEL_LIST_B [INSTRUCTION_AS_B]

end -- class DO_AS_B
