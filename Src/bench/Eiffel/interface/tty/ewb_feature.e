indexing

	description: 
		"Abstract notion of command selected from feature batch menu";
	date: "$Date$";
	revision: "$Revision $"

deferred class EWB_FEATURE 

inherit

	EWB_CLASS
		rename
			make as class_make,
			execute as class_execute
		redefine
			loop_action, process_compiled_class, 
			want_compiled_class
		end
	EWB_CLASS
		rename
			make as class_make
		redefine
			loop_action, process_compiled_class,
			want_compiled_class, execute
		select
			execute
		end

feature -- Initialization

	make (cn, fn: STRING) is
			-- Initialize Current with class_name `class_name'
			-- and feature_name `feature_name'.
		require
			non_void_cn: cn /= Void;
			non_void_fn: fn /= Void;
		do
			class_make (cn);
			feature_name := fn;
			feature_name.to_lower;
		ensure
			feature_set: feature_name = fn;
		end;

feature -- Properties

	feature_name: STRING;
			-- Feature_name for current menu selection

	want_compiled_class: BOOLEAN is
			-- Does current menu selection want a
			-- compiled class (class_c)?
			-- (Yes it does)
		do
			Result := True
		end;

feature {NONE} -- Implementation property

	associated_cmd: E_FEATURE_CMD is
			-- Associated feature command to be executed
			-- after successfully retrieving the feature_i
		deferred
		ensure
			non_void_result: Result /= Void
		end;

feature {NONE} -- Implementation

	loop_action is
		do
			if command_line_io.more_arguments then
				command_line_io.get_class_name;
				class_name := command_line_io.last_input;
				if command_line_io.more_arguments then
					command_line_io.get_feature_name;
					feature_name := command_line_io.last_input
				end;
			end;
			check_arguments_and_execute
		end;

	execute is
		do
			if class_name = Void then
				command_line_io.get_class_name;
				class_name := command_line_io.last_input;
			end;
			class_execute
		ensure then
			feature_name_cleared: feature_name = Void
		end

	process_compiled_class (e_class: E_CLASS) is
			-- Retrieve feature from `class_c' with
			-- `feature_name' and execute associated command.
		local
			e_feature: E_FEATURE;
			class_i: CLASS_I;
		do
			if feature_name = Void then
				command_line_io.get_feature_name;
				feature_name := command_line_io.last_input;
			end;
			if not command_line_io.abort then
				e_feature := e_class.feature_with_name (feature_name);
				if e_feature = Void then
					io.error.putstring (feature_name);
					io.error.putstring (" is not a feature of ");
					io.error.putstring (class_name);
					io.error.new_line
				else
					process_feature (e_feature, e_class)
				end;
			end;
			feature_name := Void;
		end;

	process_feature (e_feature: E_FEATURE; e_class: E_CLASS) is
			-- Process feature `feature_i' defined in `class_c'.
		require
			valid_e_feature: e_feature /= Void;
			valid_e_class: e_class /= Void
		local
			cmd: like associated_cmd;
			st: STRUCTURED_TEXT
		do
			!! st.make;
			cmd := clone (associated_cmd);
			cmd.set (e_feature, e_class, st);
			cmd.execute;
			output_window.put_string (st.image);
			output_window.new_line
		end

end -- class EWB_FEATURE
