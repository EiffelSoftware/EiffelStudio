-- Shared access to C extern declarations generator

class SHARED_DECLARATIONS

feature

	Extern_declarations: EXTERN_DECLARATIONS is
			-- C extern declarations generator
		once
			!!Result.make
		end;

end
