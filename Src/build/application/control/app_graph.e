
class APP_GRAPH 

inherit

	EXTEND_TABLE [HASH_TABLE [GRAPH_ELEMENT, STRING], GRAPH_ELEMENT]
		rename 
			make as extend_table_create
		end;
	SHARED_APPLICATION
		undefine
			is_equal, copy
		end

creation

	make

feature -- Creation

	make is
			-- Create application graph.
		do
			extend_table_create (30)
		end;
	
feature {NONE}

	initial_state: GRAPH_ELEMENT;
			-- Initial state of the application

feature 

	exit_element: EXIT_ELEMENT is
		once
			!! Result
		end;

	state (name: STRING): BUILD_STATE is
			-- Find state with label `name';
		local
			s: BUILD_STATE
		do
			from 
				start
			until
				off or else
				(Result /= Void)		
			loop
				s ?= key_for_iteration;
				if 
					(s /= Void) and then
					equal (s.label, name)
				then
					Result := s
				end;
				forth
			end
		end;

	has_state_name (name: STRING): BOOLEAN is
		local
			s: BUILD_STATE;
			other_name: STRING;
			new_name: STRING
		do
			new_name := clone (name);
			new_name.to_lower;
			from 
				start
			until
				off or else Result
			loop
				s ?= key_for_iteration;
				other_name := clone (s.label);
				other_name.to_lower;
				Result := equal (other_name, new_name);
				forth
			end
		end;

	state_names: LINKED_LIST [STRING] is
			-- All state names
		local
			s: BUILD_STATE
		do
			from
				!!Result.make;
				start
			until
				off	
			loop
				s ?= key_for_iteration;
				if not (s = Void) then
					Result.put_right (s.label);
					Result.forth;
				end;
				forth
			end
		end;

	states: LINKED_LIST [BUILD_STATE] is
			-- All states
		local
			s: BUILD_STATE
		do
			from
				!!Result.make;
				start
			until
				off	
			loop
				s ?= key_for_iteration;
				if not (s = Void) then
					Result.put_right (s);
					Result.forth;
				end;
				forth
			end
		end;

	eiffel_text: STRING is
			-- Code generation for the application class
		local
			transitions: HASH_TABLE [GRAPH_ELEMENT, STRING] ;
			org_element, dest_element: GRAPH_ELEMENT;
			label: STRING
		do
			!!Result.make (0);
			Result.append ("class APPLICATION%N%Ninherit%N%N%TSHARED_CONTROL;%N%N%TSTATES;%N%N%TWINDOWS%N%N");
			Result.append ("creation%N%N%Tmake%N%Nfeature%N%N%Tmake is%N%T%Tdo%N");
			from
				start
			until
				off
			loop
				transitions := item (key_for_iteration);
				org_element := key_for_iteration;
				from
					transitions.start
				until
					transitions.off
				loop
					label := transitions.key_for_iteration;
					dest_element := transitions.item (transitions.key_for_iteration);
					Result.append ("%T%T%Tcontrol.put (");
					Result.append (org_element.label);
					Result.append (", ");
					if (dest_element = Void) then
						Result.append ("Return_to_previous");
					elseif (dest_element = Exit_element) then
						Result.append ("Exit_from_application");
					else
						Result.append (dest_element.label);
					end;
					Result.append (", %"");
					Result.append (label);
					Result.append ("%");%N");
					transitions.forth
				end;
				forth
			end;
			Result.append ("%T%T%Tcontrol.set_initial_state (");
			if not (initial_state = Void) then
				Result.append (initial_state.label);
			else
				Result.append ("*** No initial state ***");
			end;
			Result.append (");%N%T%T%Tinit_windowing%N%T%Tend%N%Nend");
		end;

	set_initial_state (s: BUILD_STATE) is
			-- Set initial_state to `s'.
		do
			initial_state := s
		end;

feature -- Debugging purposes

	trace is
		do
			io.putstring ("******** Transition Graph ********\n\n");
			from
				start;
				io.putstring ("initial state: ");
				if
					initial_state = Void
				then
					io.putstring ("none%N%N")
				else
					io.putstring (initial_state.label);
					io.new_line;
					io.new_line;
				end
			until
				off
			loop
				trace_element (key_for_iteration, item (key_for_iteration));
				forth
			end
		end;

	trace_element (s: GRAPH_ELEMENT; t: HASH_TABLE [GRAPH_ELEMENT, STRING]) is
		require
			valid_s: s /= Void;
			valid_t: s /= Void
		local
			st: GRAPH_ELEMENT;
			s_tate: BUILD_STATE;
		do
			io.putstring ("Element Type: ");
			s_tate ?= s;
			if
				s_tate /= Void
			then
				io.putstring (" State\n");
				io.putstring (" State: ");
			end;
 
			io.putstring (s.label);
			io.putstring ("%N%N");
			from
				t.start
			until
				t.off
			loop
				io.putstring ("%T");
				io.putstring (t.key_for_iteration);
				io.putstring (" ---> ");
				st := t.item (t.key_for_iteration);
				if st = Void then
					io.putstring ("Return");
				else
					io.putstring (st.label);
				end;
				io.new_line;
				t.forth
			 end;
			io.new_line
		end
 
end 
