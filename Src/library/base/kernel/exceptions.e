indexing

	description:
		"Facilities for adapting the exception handling mechanism. %
		%This class may be used as ancestor by classes needing its facilities.";

	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class EXCEPTIONS

inherit

	EXCEP_CONST

feature -- Status report

	meaning (except: INTEGER): STRING is
			-- A message in English describing what `except' is
		external
			"C"
		alias
			"eename"
		end;

	assertion_violation: BOOLEAN is
			-- Is last exception originally due to a violated
			-- assertion or non-decreasing variant?
		do
			Result := 
				(original_exception = Check_instruction) or else
				(original_exception = Class_invariant) or else
				(original_exception = Loop_invariant) or else
				(original_exception = Loop_variant) or else
				(original_exception = Postcondition) or else
				(original_exception = Precondition)
		end;

	is_developer_exception: BOOLEAN is
			-- Is the last exception originally due to
			-- a developer exception?
		do
			Result := (original_exception = Developer_exception)
		end;

	is_developer_exception_of_name (name: STRING): BOOLEAN is
			-- Is the last exception originally due to a developer
			-- exception of name `name'?
		do
			Result := is_developer_exception and then
						equal (name, developer_exception_name)
		end;

	developer_exception_name: STRING is
			-- Name of last developer-raised exception
		do
			Result := original_tag_name
		end;

	is_signal: BOOLEAN is
			-- Is last exception originally due to an external
			-- event (operating system signal)?
		do
			Result := (original_exception = Signal_exception)
		end;

	is_system_exception: BOOLEAN is
			-- Is last exception originally due to an
			-- external event (operating system error)?
		do
			Result := 
				(original_exception = External_exception) or else
				(original_exception = Operating_system_exception)
		end;

	tag_name: STRING is
			-- Tag of last violated asssertion clause
		external
			"C"
		alias
			"eeltag"
		end;

	recipient_name: STRING is
			-- Name of the routine whose execution was
			-- interrupted by last exception
		external
			"C"
		alias
			"eelrout"
		end;

	class_name: STRING is
			-- Name of the class that includes the recipient
			-- of original form of last exception
		external
			"C"
		alias
			"eelclass"
		end;

	exception: INTEGER is
			-- Code of last exception that occurred
		external
			"C"
		alias
			"eelcode"
		end;

	original_tag_name: STRING is
			-- Assertion tag for original form of last
			-- assertion violation.
		external
			"C"
		alias
			"eeotag"
		end;

	original_exception: INTEGER is
			-- Original code of last exception that triggered
			-- current exception
		external
			"C"
		alias
			"eeocode"
		end;

	original_recipient_name: STRING is
			-- Name of the routine whose execution was
			-- interrupted by original form of last exception
		external
			"C"
		alias
			"eeorout"
		end;

	original_class_name: STRING is
			-- Name of the class that includes the recipient
			-- of original form of last exception
		external
			"C"
		alias
			"eeoclass"
		end;

feature -- Status setting 

	catch (code: INTEGER) is
			-- Make sure that any exception of code `code' will be
			-- caught. This is the default.
		external
			"C"
		alias
			"eecatch"
		end;

	ignore (code: INTEGER) is
			-- Make sure that any exception of code `code' will be
			-- ignored. This is not the default.
		external
			"C"
		alias
			"eeignore"
		end;

	raise (name: STRING) is
			-- Raise a developer exception of name `name'.
		local
			str: ANY;
		do
			if name /= Void then
				str := name.to_c
			end;
			eraise ($str, Developer_exception);
		end;

	message_on_failure is
			-- Print an exception history table
			-- in case of failure.
			-- This is the default.
		do
			c_trace_exception (True)
		end;

	no_message_on_failure is
			-- Do not print an exception history table
			-- in case of failure.
		do
			c_trace_exception (False)
		end;

feature {NONE} -- Implementation

	eraise (str: ANY; code: INTEGER) is
			-- Raise an exception
		external
			"C"
		end;

	c_trace_exception (b: BOOLEAN) is
		external
			"C"
		alias
			"eetrace"
		end;

end -- class EXCEPTIONS


--|----------------------------------------------------------------
--| EiffelBase: library of reusable components for ISE Eiffel 3.
--| Copyright (C) 1986, 1990, 1993, 1994, Interactive Software
--|   Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--|
--| 270 Storke Road, Suite 7, Goleta, CA 93117 USA
--| Telephone 805-685-1006
--| Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <eiffel@eiffel.com>
--|----------------------------------------------------------------

