
class S_BEHAVIOR 

inherit

	SHARED_STORAGE_INFO

creation

	make

	
feature 

	make (b: BEHAVIOR) is
		local
			stored_input: S_EVENT_ELMT;
			stored_output: S_COMMAND_ELMT
		do
			identifier := b.identifier;
			internal_name := b.label;
			!!input_list.make;
			!!output_list.make;
			from
				b.start
			until
				b.off
			loop
				!!stored_input.make (b.input);
				!!stored_output.make (b.output);
				input_list.put_right (stored_input);
				output_list.put_right (stored_output);
				input_list.forth;
				output_list.forth;
				b.forth
			end;
		end;

	identifier: INTEGER;

	
feature {NONE}

	input_list: LINKED_LIST [S_EVENT_ELMT];

	output_list: LINKED_LIST [S_COMMAND_ELMT];

	internal_name: STRING;

	
feature 

	behavior: BEHAVIOR is
		do
			!!Result.make;
			if for_import.item then
				Result.set_internal_name ("")
			else
				Result.set_internal_name (internal_name);
			end;
			from
				input_list.start;
				output_list.start
			until
				input_list.after
			loop
				Result.add (input_list.item.event, output_list.item.command);
				input_list.forth;
				output_list.forth
			end;
		end;
end
