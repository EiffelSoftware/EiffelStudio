indexing

	description: 
		"Status information about the running application - current routine,%
		%current object, ...";
	date: "$Date$";
	revision: "$Revision $"

class APPLICATION_STATUS

feature {STOPPED_HDLR} -- Initialization

	set (n: STRING; obj: STRING; ot, dt, offs, reas: INTEGER) is
		do
		end;

feature -- Values

	is_stopped: BOOLEAN;

	e_feature: E_FEATURE;

	dynamic_class: CLASS_C;

	origin_class: CLASS_C;

	break_index: INTEGER;

	reason: INTEGER;

	object_address: STRING;

	exception_code: INTEGER;

	exception_tag: STRING;

	current_stack_element: CALL_STACK_ELEMENT is
		do
		end

feature -- Access

	class_name: STRING is
		do
		end;

	valid_reason: BOOLEAN is
		do
		end;

	is_at (f: E_FEATURE; index: INTEGER): BOOLEAN is
		do
		end;

feature -- Setting

	set_is_stopped (b: BOOLEAN) is
		do
		end;

	set_exception (i: INTEGER; s: STRING) is
		do
		end;

feature -- Output

	display_status (st: STRUCTURED_TEXT) is
		do
		end;
	
	display_exception (st: STRUCTURED_TEXT) is
		do
		end;

end -- class APPLICATION_STATUS
