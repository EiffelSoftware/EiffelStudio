indexing

	description: 
		"Abstract notion of command selected from class batch menu%
		%which is compiled.";
	date: "$Date$";
	revision: "$Revision $"

deferred class EWB_COMPILED_CLASS

inherit

	EWB_FILTER_CLASS
		redefine
			want_compiled_class
		end

feature {NONE} -- Properties

	want_compiled_class: BOOLEAN is
			-- Does current menu selection want a
			-- compiled class (e_class)?
			-- (True)
		do
			Result := True
		end;

end -- class EWB_COMPILED_CLASS
