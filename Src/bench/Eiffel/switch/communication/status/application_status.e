indexing

	description: 
		"Status information about the running application - current routine,%
		%current object, ...";
	date: "$Date$";
	revision: "$Revision $"

class APPLICATION_STATUS

inherit

	SHARED_DEBUG
		export
			{NONE} all
		end;
	SHARED_EIFFEL_PROJECT
		export
			{NONE} all
		end;
	IPC_SHARED
		export
			{NONE} all;
			{ANY} Pg_break, Pg_interrupt,
				Pg_raise, Pg_viol 
		end;
	SHARED_APPLICATION_EXECUTION

creation {RUN_REQUEST}

	do_nothing

feature {STOPPED_HDLR} -- Initialization

	set (n: STRING; obj: STRING; ot, dt, offs, reas: INTEGER) is
			-- Set the various attributes identifying current 
			-- position in source code.
		local
			stack_num: INTEGER
		do

			object_address := obj;
			reason := reas;

				-- Compute class type.
			dynamic_class := Eiffel_system.class_of_dynamic_id (dt);

				-- Compute origin class type
			origin_class := Eiffel_system.class_of_dynamic_id (ot);
			
				-- Compute feature (E_FEATURE)
				--|Note: the applicaiton sends us the original name.
			e_feature := origin_class.feature_with_name (n);

				-- Compute break position.
			if e_feature /= Void then
				break_index := debug_info.breakable_index 
								(e_feature, Eiffel_system.type_of_dynamic_id (ot), offs);
			else
					--| This should eventually be removed, since the
					--| feature must necessarily be found.
				break_index := 0;
			end;
			!! where.make;
			stack_num := Application.current_execution_stack_number;
			if stack_num > where.count then
				stack_num := where.count
			end;
			Application.set_current_execution_stack (stack_num)
		end;

feature -- Values

	is_stopped: BOOLEAN;
			-- Is the debugged application stopped ?

	e_feature: E_FEATURE;
			-- Feature in which we are currently stopped

	dynamic_class: CLASS_C;
			-- Class type of object in which we are currently
			-- stopped

	origin_class: CLASS_C;
			-- Origin of feature in which we are currently
			-- stopped

	break_index: INTEGER;
			-- Breakpoint at which we are currently stopped
			-- (first, second...)

	reason: INTEGER;
			-- Reason for the applicaiton being stopped

	object_address: STRING;
			-- Address of object in which we are stopped
			-- (hector address with an indirection)

	where: EIFFEL_CALL_STACK;
			-- Eiffel call stack

	exception_code: INTEGER;
			-- Exception code if any

	exception_tag: STRING;
			-- Exception tag if any

	current_stack_element: CALL_STACK_ELEMENT is
			-- Current call stack element being displayed
		do
			Result := where.i_th (Application.current_execution_stack_number)
		end

feature -- Access

	class_name: STRING is
			-- Class name of object in which we are currently
			-- stopped
		do
			Result := dynamic_class.name
		end;

	valid_reason: BOOLEAN is
			-- Is the reason valid for stopping of execution?
		do
			Result := reason = Pg_break or else
				reason = Pg_interrupt or else
				reason = Pg_raise or else
				reason = Pg_viol
		ensure
			true_implies_correct_reason: 
				Result implies (reason = Pg_break) or else
						(reason = Pg_interrupt) or else
						(reason = Pg_raise) or else
						(reason = Pg_viol)
		end;

	is_at (f: E_FEATURE; index: INTEGER): BOOLEAN is
			-- Is the program stopped at breakpoint 
			-- defined by f and index
			-- (in fact, in a feature that has the same
			-- body as f)
		do
			Result := 
				is_stopped and then 
				equal (f.body_id, e_feature.body_id) and then
				break_index = index
		ensure
			yes_if: Result implies 
					is_stopped and then 
					equal (f.body_id, e_feature.body_id) and then
					break_index = index
		end;

feature -- Setting

	set_is_stopped (b: BOOLEAN) is
			-- set is_stopped to b
		do
			is_stopped := b;
		end;

	set_exception (i: INTEGER; s: STRING) is
		do
			exception_code := i;
			exception_tag := s
		end;

feature -- Output

	display_status (st: STRUCTURED_TEXT) is
			-- Display the status of the running application.
		local
			c, oc: CLASS_C;
			ll: LINKED_LIST [STRING];
			f, of: E_FEATURE;
			cs: CALL_STACK_ELEMENT;
			stack_num: INTEGER
		do
			if not is_stopped then
				st.add_string ("System is running");
				st.add_new_line
			else -- Application is stopped.
					-- Print object address.
				st.add_string ("Stopped in object [");
				c := dynamic_class;
				st.add_address (object_address, e_feature.name, c);
				st.add_string ("]");
				st.add_new_line;
					-- Print class name.
				st.add_indent;
				st.add_string ("Class: ");
				c.append_name (st);
				st.add_new_line;
					-- Print routine name.
				st.add_indent;
				st.add_string ("Feature: ");
				if e_feature /= Void then
					oc := origin_class;
					e_feature.append_name (st);
					if oc /= c then
						st.add_string (" (From ");
						oc.append_name (st)
						st.add_string (")")
					end
				else
					st.add_string ("Void")
				end;
				st.add_new_line;
					-- Print the reason for stopping.
				st.add_indent;
				st.add_string ("Reason: ");
				inspect reason
				when Pg_break then
					st.add_string ("Stop point reached");
					st.add_new_line
				when Pg_interrupt then
					st.add_string ("Execution interrupted");
					st.add_new_line
				when Pg_raise then
					st.add_string ("Explicit exception pending");
					st.add_new_line;
					display_exception (st)
				when Pg_viol then
					st.add_string ("Implicit exception pending");
					st.add_new_line;
					display_exception (st)
				else
					st.add_string ("Unknown");
					st.add_new_line
				end;
				if not where.empty then
					stack_num := Application.current_execution_stack_number;
					cs := where.i_th (stack_num);
					cs.display_arguments (st);
					if not oc.lace_class.hide_implementation then
						cs.display_locals (st);
					end;
					where.display_stack (st)
				end
			end;
		end;
	
	display_exception (st: STRUCTURED_TEXT) is
			-- Display exception in `st'.
		require
			non_void_st: st /= Void;
			valid_code: exception_code > 0
		local
			e: EXCEPTIONS;
			m: STRING
		do
			st.add_indent;
			st.add_indent;
			st.add_string ("Code: ");
			st.add_int (exception_code);
			st.add_string (" (");
			!!e;
			m := e.meaning (exception_code);
			if m = Void then
				m := "Undefined"
			end;
			st.add_string (m);
			st.add_string (")");
			st.add_new_line;
			st.add_indent;
			st.add_indent;
			st.add_string ("Tag: ");
			st.add_string (exception_tag);
			st.add_new_line
		end;

end -- class APPLICATION_STATUS
