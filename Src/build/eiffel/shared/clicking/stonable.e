
-- Parent of an AST which can build a stone for the interface

deferred class STONABLE

feature

--	stone (reference_class: CLASS_C): STONE is deferred end

	toto is
			-- To make this class deferred
		deferred
		end;

end
