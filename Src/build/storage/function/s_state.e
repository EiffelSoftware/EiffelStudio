
class S_STATE 

inherit

	STORAGE_INFO
		export
			{NONE} all
		end


creation

	make

	
feature 

	make (s: STATE) is
		local
			stored_input: S_CONTEXT_ELMT;
			stored_output: S_BEHAVIOR;
			c: CONTEXT;
			b: BEHAVIOR
		do
			!!input_list.make;
			!!output_list.make;
			internal_name := s.label;
			visual_name := s.visual_name;
			identifier := s.identifier;
			from
				s.start
			until
				s.after
			loop
				c := s.input;
				b := s.output;
				if not (c.deleted or b.empty)
				then
					!!stored_input.make (c);
					!!stored_output.make (b);
					input_list.add (stored_input);
					output_list.add (stored_output);
				end;
				s.forth
			end;
		end;

	identifier: INTEGER;

	
feature {NONE}

	input_list: LINKED_LIST [S_CONTEXT_ELMT];

	output_list: LINKED_LIST [S_BEHAVIOR];

	internal_name: STRING;

	visual_name: STRING;

	
feature 

	state: STATE is
		do
			!!Result.make;
			if for_import.value then
				Result.set_internal_name ("");
			else
				Result.set_internal_name (internal_name);
			end;
			if not (visual_name = Void) then
				Result.set_visual_name (visual_name);
			end;
			from
				input_list.start;
				output_list.start
			until
				input_list.after
			loop
				Result.add (input_list.item.context, 
								output_list.item.behavior);
				input_list.forth;
				output_list.forth
			end;
		end;
end
