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

creation {RUN_REQUEST}

	do_nothing

feature {STOPPED_HDLR} -- Initialization

	set (n: STRING; obj: STRING; ot, dt, offs, reas: INTEGER) is
			-- Set the various attributes identifying current 
			-- position in source code.
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
								(e_feature.body_id, offs);
			else
					--| This should eventually be removed, since the
					--| feature must necessarily be found.
				break_index := 0;
			end;
			!! where.make;
		end;

feature -- Values

	is_stopped: BOOLEAN;
			-- Is the debugged application stopped ?

	e_feature: E_FEATURE;
			-- Feature in which we are currently stopped

	dynamic_class: E_CLASS;
			-- Class type of object in which we are currently
			-- stopped

	origin_class: E_CLASS;
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
				f.body_id = e_feature.body_id and then
				break_index = index
		ensure
			yes_if: Result implies 
					is_stopped and then 
					f.body_id = e_feature.body_id and then
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

	display_status (ow: OUTPUT_WINDOW) is
			-- Display the status of the running application.
		local
			c, oc: E_CLASS;
			ll: LINKED_LIST [STRING];
			f, of: E_FEATURE;
		do
			ow.clear_window;
			if not is_stopped then
				ow.put_string ("System is running%N")
			else -- Application is stopped.
					-- Print object address.
				ow.put_string ("Stopped in object [");
				c := dynamic_class;
				ow.put_address (object_address, c);
				ow.put_string ("]%N");
					-- Print class name.
				ow.put_string ("%TClass: ");
				c.append_name (ow);
				ow.put_string ("%N");
					-- Print routine name.
				ow.put_string ("%TFeature: ");
				if e_feature /= Void then
					oc := origin_class;
					e_feature.append_name (ow, oc)
					if oc /= c then
						ow.put_string (" (From ");
						oc.append_name (ow)
						ow.put_string (")")
					end
				else
					ow.put_string ("Void")
				end;
				ow.put_string ("%N");
					-- Print the reason for stopping.
				ow.put_string ("%TReason: ");
				inspect reason
				when Pg_break then
					ow.put_string ("Stop point reached%N")
				when Pg_interrupt then
					ow.put_string ("Execution interrupted%N")
				when Pg_raise then
					ow.put_string ("Explicit exception pending%N");
					display_exception (ow)
				when Pg_viol then
					ow.put_string ("Implicit exception pending%N");
					display_exception (ow)
				else
					ow.put_string ("Unknown%N")
				end;
				if not where.empty then
					where.first.display_arguments (ow);
					where.first.display_locals (ow);
					where.display_stack (ow)
				end
			end;
			ow.display
		end;
	
	display_exception (ow: OUTPUT_WINDOW) is
			-- Display exception in `ow'.
		require
			non_void_ow: ow /= Void;
			valid_code: exception_code > 0
		local
			e: EXCEPTIONS;
			m: STRING
		do
			ow.put_string ("%T%TCode: ");
			ow.put_int (exception_code);
			ow.put_string (" (");
			!!e;
			m := e.meaning (exception_code);
			if m = Void then
				m := "Undefined"
			end;
			ow.put_string (m);
			ow.put_string (")%N%T%TTag: ");
			ow.put_string (exception_tag);
			ow.new_line
		end;

end -- class APPLICATION_STATUS
