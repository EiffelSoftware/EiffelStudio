class DO_AS_B

inherit

	DO_AS
		rename
			compound as old_compound
		end;

	INTERNAL_AS_B
		select
			compound
		end

feature

end -- class DO_AS_B
