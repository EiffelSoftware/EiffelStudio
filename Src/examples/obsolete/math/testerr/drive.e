-- test routine for interface to chapter d01
indexing
	description: " Test routines for d01"
	legal: "See notice at end of class."
	status: "See notice at end of class."
class
	TEST_ERR
inherit
	EIFFELMATH_TESTING_FRAMEWORK
	NAG_EXCEPTIONS
		undefine
			print
		redefine
			print,
			nag_error --++--
		end;
	NAG_ERROR_NUMBERS
		undefine
			print
		end

create
	make

feature -- The main program

	make (args: ARRAY [STRING]) is
			-- test of various routines from d01
		do
			nag_error_history.remember_errors(6);
			nag_error.set("NW_ERROR 1", 1, 2);
			nag_try;
			nag_error.set("NW_ERROR 2", 2, 3);
			nag_try;
			nag_error.set("NE_ERROR 3", 3, 4);
			nag_try;
			nag_error.set("NW_ERROR 4", 4, 5);
			nag_try;
			nag_error.set("NE_ERROR 5", 48, 6);
			nag_ignore_errors;
			nag_try;
			if nag_error_history.error (1).code = NE_BAD_PARAM then
				print("Error code correctly read.%N");
			end;
			nag_do_not_ignore_errors;
			nag_error.set("NW_ERROR 6", 6, 7);
			nag_try;
			nag_error.set("NW_ERROR 7", 7, 8);
			nag_try;
			nag_error.set("NW_ERROR 8", 8, 9);
			nag_try;
			print(nag_error_history);
			nag_error_history.remember_all_errors
			nag_error.set("NW_ERROR 9", 9, 10);
			nag_try;
			print(nag_error_history);
			nag_error_history.remember_errors(2);
			print(nag_error_history);
			nag_error_history.remember_errors(0);
			nag_error.set("NW_ERROR 10", 10, 11);
			nag_try;
			print(nag_error_history)
		end;
	
	nag_try is
			-- Call nag_check, recover and continue.
		local
			idid: INTEGER
		do
			if idid = 0 then
				idid := idid + 1
				nag_check
			end;
		rescue
			retry
		end;


	nag_error: FAKE_NAG_ERROR is
		once
			create Result;
			Result.enable_error_recovery;
			Result.disable_error_printing
		end;

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"


end -- class DRIVE





