indexing

	description:
		"Facilities for adapting the exception handling mechanism. %
		%This class may be used as ancestor by classes needing its facilities.";

	copyright: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class EXCEPTIONS

inherit

	EXCEP_CONST

feature -- Status report

	meaning (except: INTEGER): STRING is
		do
		end;

	assertion_violation: BOOLEAN is
		do
			Result := 
				(exception = Check_instruction) or else
				(exception = Class_invariant) or else
				(exception = Loop_invariant) or else
				(exception = Loop_variant) or else
				(exception = Postcondition) or else
				(exception = Precondition)
		end;

	is_developer_exception: BOOLEAN is
			-- Is the last exception a developer exception?
		do
			Result := (exception = Developer_exception)
		end;

	is_developer_exception_of_name (name: STRING): BOOLEAN is
			-- Is the last exception a developer exception
			-- of name `name' ?
		do
			Result := is_developer_exception and then
						equal (name, developer_exception_name)
		end;

	developer_exception_name: STRING is
			-- Name of last developer-raised exception
		external
			"C"
		alias
			"eeotag"
		end;

	is_signal: BOOLEAN is
			-- Is exception due to an external event (operating
			-- system signal)?
		do
		end;

	is_system_exception: BOOLEAN is
			-- Was last exception due to an exception due to
			-- external event (operating system error)?
		do
			Result := 
				(exception = External_exception) or else
				(exception = Operating_system_exception)
		end;

	tag_name: STRING is
			-- Tag of last violated asssertion clause
		do
		end;

	recipient_name: STRING is
			-- Name of the routine whose execution was
			-- interrupted by last exception
		do
		end;

	class_name: STRING is
			-- Name of the class that includes the recipient
			-- of original form of last exception
		do
		end;

	exception: INTEGER is
			-- Code of last exception that occurred
		do
		end;

	original_tag_name: STRING is
			-- Assertion tag for original form of last
			-- assertion violation.
		do
		end;

	original_exception: INTEGER is
			-- Code of last exception that triggered current
			-- exception
		external
			"C"
		alias
			"eeocode"
		end;

	original_recipient_name: STRING is
			-- Name of the routine whose execution was
			-- interrupted by original form of last exception
		do
		end;

	original_class_name: STRING is
			-- Name of the class that includes the recipient
			-- of original form of last exception
		do
		end;

feature -- Status setting 

	catch (code: INTEGER) is
			-- Make sure that any exception of code `code' will be
			-- caught. This is the default.
		do
		end;

	ignore (code: INTEGER) is
			-- Make sure that any exception of code `code' will be
			-- ignored. This is not the default.
		do
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
--| Copyright (C) 1986, 1990, 1993, Interactive Software
--|   Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--|
--| 270 Storke Road, Suite 7, Goleta, CA 93117 USA
--| Telephone 805-685-1006
--| Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <eiffel@eiffel.com>
--|----------------------------------------------------------------
