indexing

	description: 
		"Build a filtered version (troff, ..) of the class text%
		%and display the result in output_window."
	date: "$Date$"
	revision: "$Revision$"

deferred class EWB_FILTER_CLASS

inherit

	EWB_FILTER
	EWB_CLASS
		rename
			make as class_make
		redefine
			process_compiled_class, loop_action
		end

feature -- Initialization

	make (cn, filter: STRING) is
			-- Initialize Current with class_name `cn',
			-- and `filter_name' `filter'.
		require
			cn_not_void: cn /= Void
		do
			class_make (cn)
			init (filter)
		end

feature {NONE} -- Execution

	associated_cmd: E_CLASS_CMD is
			-- Command to be executed after successful
			-- retrieving of the class text.
		deferred
		end

	process_compiled_class (e_class: CLASS_C) is
			-- Execute associated command
		local
			cmd: like associated_cmd
			filter: TEXT_FILTER
		do
			cmd := associated_cmd
			cmd.make (e_class)
			cmd.execute
			if filter_name /= Void and then not filter_name.is_empty then
				!! filter.make (filter_name)
				filter.process_text (cmd.structured_text)
				output_window.put_string (filter.image)
			else
				output_window.put_string (cmd.structured_text.image)
			end
			output_window.new_line
		end

	loop_action is
			-- Execute Current command from loop.
		do
			command_line_io.get_class_name
			class_name := command_line_io.last_input
			command_line_io.get_filter_name
			filter_name := command_line_io.last_input
			check_arguments_and_execute
		end

invariant

	filter_name_not_void: filter_name /= Void

end -- class EWB_FILTER_CLASS
