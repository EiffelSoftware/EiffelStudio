indexing
	description: "Generate the documentation for a project";
	date: "$Date$";
	revision: "$Revision $"

class EWB_DOCUMENTATION 

inherit
	TTY_CONSTANTS

	EWB_FILTER_SYSTEM
		redefine
			execute, loop_action
		end

creation
	make_flat,
	make_flat_short,
	make_short,
	make_text

feature -- Initialization

	make_flat (f_name: like filter_name; b: BOOLEAN) is
			-- Initialize document generation to flat.
			-- Set `do_parents' to `b'.
		do
			format_type := flat_type
			filter_name := f_name
			do_parents := b
		end;

	make_flat_short (f_name: like filter_name; b: BOOLEAN) is
			-- Initialize document generation to flat_short.
			-- Set `do_parents' to `b'.
		do
			format_type := flat_short_type
			filter_name := f_name
			do_parents := b
		end;

	make_text (f_name: like filter_name) is
			-- Initialize document generation to text.
			-- Set `do_parents' to `b'.
		do
			format_type := text_type
			filter_name := f_name
			do_parents := False
		end;

	make_short (f_name: like filter_name; b: BOOLEAN) is
			-- Initialize document generation to text.
			-- Set `do_parents' to `b'.
		do
			format_type := short_type
			filter_name := f_name
			do_parents := b
		end;

feature -- Access

	name: STRING is
		do
			inspect 
				format_type
			when flat_type then
				Result := flat_doc_cmd_name
			when flat_short_type then
				Result := flat_short_doc_cmd_name
			when text_type then
				Result := text_doc_cmd_name
			when short_type then
				Result := short_doc_cmd_name
			end
		end;

	help_message: STRING is
		do
			inspect 
				format_type
			when flat_type then
				Result := flat_doc_help
			when flat_short_type then
				Result := flat_short_doc_help
			when text_type then
				Result := text_doc_help
			when short_type then
				Result := short_doc_help
			end
		end;

	abbreviation: CHARACTER is
		do
			inspect 
				format_type
			when flat_type then
				Result := flat_doc_abb
			when flat_short_type then
				Result := flat_short_doc_abb
			when text_type then
				Result := text_doc_abb
			when short_type then
				Result := short_doc_abb
			end
		end;

feature -- Execution

	loop_action is
			-- Action to be done before `execute'.
		do
			command_line_io.get_filter_name;
			filter_name := command_line_io.last_input;
			if format_type /= text_type then
				command_line_io.get_option_value ("Include parents", False);
			end;
			do_parents := command_line_io.last_input.to_boolean;
			check_arguments_and_execute
		end;

	execute is
		local
			cmd: E_GENERATE_DOCUMENTATION
		do
			inspect 
				format_type
			when flat_type then
				!! cmd.make_flat (filter_name, degree_output)
			when flat_short_type then
				!! cmd.make_flat_short (filter_name, degree_output)
			when text_type then
				!! cmd.make_text (filter_name, degree_output)
			when short_type then
				!! cmd.make_short (filter_name, degree_output)
			end
			if do_parents then
				cmd.set_do_parents
			end;
			cmd.set_error_window (Output_window);
			cmd.execute;
		end;

feature {NONE} -- Implementation

	associated_cmd: E_OUTPUT_CMD is
			-- Associated system command to be executed
		do
		end;

	do_parents: BOOLEAN;
			-- Print the parents as well

	format_type: INTEGER;
			-- Format type

	flat_short_type, short_type, flat_type, text_type: INTEGER is unique

end -- class EWB_DOCUMENTATION
