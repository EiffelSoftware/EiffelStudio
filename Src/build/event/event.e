
deferred class EVENT 

inherit

	DATA;
	EVENT_STONE;
	SHARED_STORAGE_INFO;
	EB_HASHABLE;
	SHARED_APPLICATION
	
feature {NONE}

	same (other: like Current): BOOLEAN is
		do
			Result := not (other = Void) and then
				(label.is_equal (other.label))
		end;
 
	hash_code: INTEGER is
		do
			Result := label.hash_code
		end;

	make is
		do
			event_table.put (Current, - identifier)
		end;

	Event_const: EVENT_CONSTANTS is
		once
			!! Result
		end;

	help_file_name: STRING is
		do
			Result := Help_const.event_help_fn
		end;

feature {CAT_EV_IS}

	exists_in_application: BOOLEAN is
		local
			s: STATE;
			b: BEHAVIOR;
		do
			from
				Shared_app_graph.start
			until
				Shared_app_graph.off
			loop
				s ?= Shared_app_graph.key_for_iteration;
				if s /= Void then
					from
						s.start
					until
						s.after
					loop
						b := s.output.data;
						from
							b.start
						until
							b.after or else Result
						loop
							Result := b.input = Current;
							b.forth
						end;
						s.forth
					end;
				end;
				Shared_app_graph.forth
			end;
		end;
	
feature 

	data: EVENT is
		do
			Result := Current
		end;

	symbol: PIXMAP is
		deferred
		end;

	label: STRING is
		do
			Result := internal_name
		end;

	internal_name: STRING is
		deferred
		end;

	identifier: INTEGER is
			-- Identifier for current event
		deferred
		end;
	
	eiffel_text: STRING is
			-- Eiffel Text for current event
		deferred
		end;
	
feature 

	is_valid_for_context (a_context: CONTEXT): BOOLEAN is
			-- Is the current event defined for `a_context'
		do
			Result := True
		end;

end
