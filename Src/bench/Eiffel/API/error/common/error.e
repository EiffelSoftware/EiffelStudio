-- Error object sent by the compiler to the workbench

deferred class ERROR

inherit

	SHARED_WORKBENCH;
	EIFFEL_ENV;
	WINDOWS;
	STONABLE

feature -- Error code 

	code: STRING is
			-- Code error
		deferred
		end;

feature -- Debug pupose

	trace is
			-- Debug purpose
		local
			dummy_reference: CLASS_C
		do
			error_window.put_string ("Error ");
			error_window.put_clickable_string (stone (dummy_reference), code);
			error_window.put_string (":%N");
			build_explain (error_window)
		end;

	build_explain (a_clickable: CLICK_WINDOW) is
			-- Build specific explanation image for current error
			-- in `a_clickable'.
		do
			-- Do nothing
		end;

feature -- stoning

	stone (reference_class: CLASS_C): ERROR_STONE is
			-- Reference class is useless here
		do
			!!Result.make (Current)
		end

end
