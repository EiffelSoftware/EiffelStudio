
class S_STATE 

inherit

	SHARED_STORAGE_INFO

creation

	make
	
feature 

	make (s: BUILD_STATE) is
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
					input_list.extend (stored_input);
					output_list.extend (stored_output);
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

	state: BUILD_STATE is
		local
			b: BEHAVIOR;
			c: CONTEXT;
		do
			!!Result.make;
			if for_import.item then
				Result.set_internal_name ("");
			else
				Result.set_internal_name (internal_name);
			end;
			if visual_name /= Void then
				Result.retrieve_set_visual_name (visual_name);
			end;
			from
				input_list.start;
				output_list.start
			until
				input_list.after
			loop
				c := input_list.item.context;
					-- to be fixed when importing of groups is fixed
				if c /= void then
					b := output_list.item.behavior;
					b.set_context (c);
					Result.add (c, b);
				else
					io.error.putstring ("Behaviour lost for ");
					io.error.putstring (input_list.item.full_name);
					io.error.new_line;
				end;
				input_list.forth;
				output_list.forth
			end;
		end;
end
