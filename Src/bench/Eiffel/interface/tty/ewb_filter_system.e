indexing

	description:
		"Notion of a filter applied to the Ace file.";
	date: "$Date$";
	revision: "$Revision$"

deferred class EWB_FILTER_SYSTEM

inherit
	EWB_FILTER;
	EWB_SYSTEM
		redefine
			execute, loop_action
		end

feature {NONE} -- Execution

	loop_action is
			-- Action to be done before `execute'.
		do
			command_line_io.get_filter_name;
			filter_name := command_line_io.last_input;
			check_arguments_and_execute
		end;

	execute is
		local
			cmd: like associated_cmd;
			st: STRUCTURED_TEXT;
			filter: TEXT_FILTER
		do
			!! st.make;
			cmd := clone (associated_cmd);
			cmd.set_structured_text (st);
			cmd.execute;
			!! filter.make (filter_name);
			filter.process_text (cmd.structured_text);
			output_window.put_string (filter.image);
			output_window.new_line;
		end;

end -- class EWB_FILTER_SYSTEM
