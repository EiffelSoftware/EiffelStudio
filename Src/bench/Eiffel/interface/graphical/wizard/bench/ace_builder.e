indexing

	description:
		"Wizard action that preforms the creation of an Ace file";
	date: "$Date$";
	revision: "$Revision$"

class ACE_BUILDER

inherit
	WIZARD_ACTION;
	EIFFEL_ENV;
	PROJECT_CONTEXT;
	WINDOWS;
	WINDOW_ATTRIBUTES;
	EB_CONSTANTS

creation
	make

feature -- Initialization

	make (a_caller: CREATE_ACE_CALLER) is
		require
			non_void_caller: a_caller /= Void
		do
			caller := a_caller
		ensure
			caller_set: equal (caller, a_caller);
		end;

feature -- Graphical User Interface

	build_interface is
		local
			twl: TWO_WAY_LIST [STRING]
			child: ARRAYED_LIST [WIDGET]
			toggle: TOGGLE_B
			first: BOOLEAN
			subdir: DIRECTORY_NAME
			l_s_d, l_s_d_lower, std_precomp_name, project_name: STRING
			proj: STRING
			sep1, sep2, sep3: THREE_D_SEPARATOR
		once
			twl := precompiles;
			!! system_edit.make ("system_edit", dialog.action_form);
			!! root_class_edit.make ("root_class_edit", dialog.action_form);
			!! creation_procedure_edit.make ("creation_procedure_edit", dialog.action_form);

			!! dir_label.make ("project_directory", dialog.action_form);
			!! system_label.make ("system_label", dialog.action_form);
			!! root_class_label.make ("root_class_label", dialog.action_form);
			!! creation_procedure_label.make ("creation_procedure_label", dialog.action_form);

			!! sep1.make (Interface_names.t_Empty, dialog.action_form)

			!! precomp_label.make ("precomp_label", dialog.action_form);
			!! default_option_label.make ("default_option_label", dialog.action_form);
			!! assertion_label.make ("assertion_label", dialog.action_form);

			!! precomp_box.make ("precomp_box", dialog.action_form);
			from
				twl := precompiles;
				twl.start;
				first := True;
				!! standard_precompiles_reverse.make (3)
			until
				twl.after
			loop
				!! toggle.make ("toggle", precomp_box);
				!! subdir.make_from_string (twl.item);
				l_s_d := last_sub_dir (subdir);
				l_s_d_lower := clone (l_s_d);
				l_s_d_lower.to_lower;
				std_precomp_name := standard_precompiles.item (l_s_d_lower);
				if std_precomp_name /= Void then
					standard_precompiles_reverse.put (l_s_d, std_precomp_name);
					toggle.set_text (std_precomp_name)
				else
					standard_precompiles_reverse.put (l_s_d, l_s_d);
					toggle.set_text (l_s_d);
				end;
				if first then
					toggle.set_toggle_on
				else
					toggle.set_toggle_off
				end;
				first := False;
				twl.forth
			end;
			standard_precompiles_reverse.compare_objects;

			!! sep2.make (Interface_names.t_Empty, dialog.action_form)

			!! default_option_box.make ("default_option_box", dialog.action_form);
			!! multithreaded_toggle.make ("multithreaded", default_option_box)
			!! inlining_toggle.make ("inlining", default_option_box)
			!! profiler_toggle.make ("profiler", default_option_box)
			!! dead_code_removal_toggle.make ("dead_code_removal", default_option_box)
			!! debug_toggle.make ("debug", default_option_box)

			!! sep3.make (Interface_names.t_Empty, dialog.action_form)

			!! assertion_radio.make ("assertion_radio", dialog.action_form);
			!! no_ass.make ("ass_no", assertion_radio);
			!! require_ass.make ("ass_require", assertion_radio);
			!! ensure_ass.make ("ass_ensure", assertion_radio);
			!! invariant_ass.make ("ass_invariant", assertion_radio);
			!! loop_ass.make ("ass_loop", assertion_radio);
			!! check_ass.make ("ass_check", assertion_radio);
			!! all_ass.make ("all_ass", assertion_radio);

			project_name := "Project_directory:   "
			project_name.append (Project_directory_name)
			dir_label.set_text (project_name);
			system_label.set_text ("System name:");
			root_class_label.set_text ("Root class name:");
			creation_procedure_label.set_text ("Creation procedure name:");
			precomp_label.set_text ("Precompiled libraries:");
			default_option_label.set_text ("Default options:");
			assertion_label.set_text ("Default assertion checking:");

			system_edit.set_text ("sample");
			root_class_edit.set_text ("ROOT_CLASS");
			creation_procedure_edit.set_text ("make");

			multithreaded_toggle.set_text ("Multithreaded")
			inlining_toggle.set_text ("Inlining")
			profiler_toggle.set_text ("Profiler")
			dead_code_removal_toggle.set_text ("Dead code removal")
			debug_toggle.set_text ("Debug")
			dead_code_removal_toggle.set_toggle_on

			require_ass.set_toggle_on;
			assertion_radio.set_always_one (True);

			no_ass.set_text ("No assertions");
			require_ass.set_text ("Require");
			ensure_ass.set_text ("Ensure");
			invariant_ass.set_text ("Invariant");
			loop_ass.set_text ("Loop");
			check_ass.set_text ("Check");
			all_ass.set_text ("All");

			dialog.action_form.attach_top (dir_label, 15);
			dialog.action_form.attach_left (dir_label, 10);

			dialog.action_form.attach_top_widget (dir_label, system_label, 15);
			dialog.action_form.attach_left (system_label, 10);
			dialog.action_form.attach_top_widget (dir_label, system_edit, 10);
			dialog.action_form.attach_right (system_edit, 10);
			dialog.action_form.attach_left_widget (system_label, system_edit, 20);

			dialog.action_form.attach_left (root_class_label, 10);
			dialog.action_form.attach_top_widget (system_edit, root_class_label, 15);
			dialog.action_form.attach_left_widget (root_class_label, root_class_edit, 20);
			dialog.action_form.attach_right (root_class_edit, 10);
			dialog.action_form.attach_top_widget (system_edit, root_class_edit, 10);

			dialog.action_form.attach_left (creation_procedure_label, 10);
			dialog.action_form.attach_top_widget (root_class_edit, creation_procedure_label, 15);
			dialog.action_form.attach_left_widget (creation_procedure_label, creation_procedure_edit, 20);
			dialog.action_form.attach_right (creation_procedure_edit, 10);
			dialog.action_form.attach_top_widget (root_class_edit, creation_procedure_edit, 10);

			dialog.action_form.attach_left (sep1, 2);
			dialog.action_form.attach_right (sep1, 2);
			dialog.action_form.attach_top_widget (creation_procedure_edit, sep1, 5);

			dialog.action_form.attach_left (precomp_label, 10);
			dialog.action_form.attach_top_widget (sep1, precomp_label, 5);

			dialog.action_form.attach_left (precomp_box, 10);
			dialog.action_form.attach_top_widget (precomp_label, precomp_box, 10);

			dialog.action_form.attach_left (sep2, 2);
			dialog.action_form.attach_right (sep2, 2);
			dialog.action_form.attach_top_widget (precomp_box, sep2, 5);

			dialog.action_form.attach_left (default_option_label, 10);
			dialog.action_form.attach_top_widget (sep2, default_option_label, 5);

			dialog.action_form.attach_left (default_option_box, 10);
			dialog.action_form.attach_top_widget (default_option_label, default_option_box, 10);
			
			dialog.action_form.attach_left (sep3, 2);
			dialog.action_form.attach_right (sep3, 2);
			dialog.action_form.attach_top_widget (default_option_box, sep3, 5);

			dialog.action_form.attach_left (assertion_label, 10);
			dialog.action_form.attach_top_widget (sep3, assertion_label, 5);

			dialog.action_form.attach_left (assertion_radio, 10);
			dialog.action_form.attach_top_widget (assertion_label, assertion_radio, 10);

			dialog.set_next_label ("Create project");
			dialog.set_next_sensitive;
			set_composite_attributes (dialog)
		end;

feature -- Useless stuff

	set_previous_action is
			--- Useless here.
		do
			-- Do Nothing
		end;

	work (argument: ANY) is
			--- Useless here.
		do
			-- Do Nothing
		end;

feature -- Information Handling

	process_information is
		local
			id: IDENTIFIER;
			contents, c_name: STRING;
			new_ace: PLAIN_TEXT_FILE
		do
			!! new_ace.make ("Ace.ace");
			!! id.make (0);
			id.append (system_edit.text);
			if 
				(new_ace.exists and then not new_ace.is_writable) or else
				not new_ace.is_creatable 
			 then
				warner (dialog).gotcha_call 
						(Warning_messages.w_Not_writable (new_ace.name))
				processed := False;
			elseif not id.is_valid then
				warner (dialog).gotcha_call 
						(Warning_messages.w_Invalid_system_name (id))
				processed := False;
			else
				!! id.make (0);
				id.append (root_class_edit.text);
				id.to_upper;
				!! c_name.make (0);
				c_name.append (id);
				if not id.is_valid then
					warner (dialog).gotcha_call 
						(Warning_messages.w_Invalid_root_class_name (id))
					processed := False;
				else
					!! id.make (0);
					id.append (creation_procedure_edit.text);
					id.to_lower;
					if not ((id.empty and then
						(c_name.is_equal ("ANY") or else
						c_name.is_equal ("NONE"))) or else
						id.is_valid)
					then
						warner (dialog).gotcha_call 
							(Warning_messages.w_Invalid_creation_name (id))
						processed := False;
					else
						contents := default_ace_file_contents;
						if contents = Void then
							warner (dialog).gotcha_call 
								(Warning_messages.w_Default_ace_file_not_exist (default_ace_name))
							processed := False;
						else
							processed := True;
							generate_ace_file (contents);
							save_ace_file (contents);
							if not c_name.is_equal ("ANY") or else c_name.is_equal ("NONE")
							then
								create_root_class;
							end
							caller.perform_post_creation
						end
					end
				end
			end
		end;

feature -- Execution

	set_next_action is
		do
			has_next := False;
			finished := True;
			wizard.next_action
		end;

feature -- Toggles for the default option

	multithreaded_toggle: TOGGLE_B
			-- Toggle for the multithreaded mode.

	inlining_toggle: TOGGLE_B
			-- Toggle for the inlining option.

	profiler_toggle: TOGGLE_B
			-- Toggle for the profiler option.

	dead_code_removal_toggle: TOGGLE_B
			-- Toggle for the dead code removal option.

	debug_toggle: TOGGLE_B
			-- Toggle for the debug option.

feature -- Toggles for the assertions

	no_ass: TOGGLE_B;
			-- Toggle for no assertion checking.

	require_ass: TOGGLE_B;
			-- Toggle for check require clauses.

	ensure_ass: TOGGLE_B;
			-- Toggle for check enusre clauses.

	invariant_ass: TOGGLE_B;
			-- Toggle for check invariant clauses.

	loop_ass: TOGGLE_B;
			-- Toggle for check loop clauses.

	check_ass: TOGGLE_B;
			-- Toggle for check `check' statements.

	all_ass: TOGGLE_B;
			-- Toggle for check all assertions.

feature -- Edit control

	system_edit: TEXT_FIELD;
			-- Text field to type in the name of the system.

	root_class_edit: TEXT_FIELD;
			-- Text field to type in the name of the root class.

	creation_procedure_edit: TEXT_FIELD;
			-- Text field to type in the name of the creation procedure.

feature -- Text labels

	dir_label: LABEL;
			-- Label to display the project directory.

	system_label: LABEL;
			-- Label to indicate what to type in.

	root_class_label: LABEL;
			-- Label to indicate what to type in.

	creation_procedure_label: LABEL;
			-- Label to indicate what to type in.

	precomp_label: LABEL;
			-- Label to display the precompiled libraries text.

	default_option_label: LABEL
			-- Label to display the default option list.

	assertion_label: LABEL;
			-- Label to display the assertion checking text.

feature -- Radio Boxes

	precomp_box: CHECK_BOX;
			-- Check box to display all precompiles

	default_option_box: CHECK_BOX;
			-- Check box to display wether or not the user is using the multithreaded mode

	assertion_radio: RADIO_BOX;
			-- Radio box to display assertion checking options

feature {NONE} -- Properties

	precompiles: TWO_WAY_LIST [STRING] is
			-- Looks up the disk to find the precompiled libraries in
			-- $EIFFEL4/precomp/spec/$PLATFORM/*.
			-- The list will only contain those precompiles that are actually
			-- precompiled (by the means the file ./EIFGEN/project.eif exists).
		local
			new_precomp: STRING;
			dir: DIRECTORY;
			file_name: FILE_NAME;
			file: RAW_FILE
		once
			!! Result.make;
			!! dir.make (Default_precompiled_location);
			if dir.exists and then dir.is_readable then
				from
					dir.open_read;
					dir.start;
					dir.readentry
				until
					dir.lastentry = Void
				loop
					!! file_name.make_from_string (dir.name);
					file_name.extend_from_array 
						(<<dir.lastentry, Eiffelgen>>);
					file_name.set_file_name (Dot_workbench);
					!! file.make (file_name);

					if file.exists then
						Result.extend (file_name)
					end;
					dir.readentry
				end;
				dir.close;
			end
		end;

	caller: CREATE_ACE_CALLER;

feature -- Standard precompiles

	standard_precompiles: HASH_TABLE [STRING, STRING] is
			-- A hash table of standard precompiles (base, lex, vision, etc.)
			-- against their qualified names (EiffelBase, EiffelLex, EiffelVision, etc.)
		once
			!! Result.make (3);
			Result.put ("EiffelBase", "base");
			Result.put ("EiffelVision", "vision");
			Result.put ("EiffelParse", "parse");
			Result.put ("Windows Eiffel Library", "wel");
			Result.put ("MOTIF Eiffel Library", "mel");
			Result.put ("Eiffel Math Library", "math");
			Result.put ("EiffelNet", "net");
			Result.compare_objects
		end;

	standard_precompiles_reverse: HASH_TABLE [STRING, STRING];
			-- A hash table of the qualified name of standard precompiles (EiffelBase, EiffelLex, etc.)
			-- against their location in $EIFFEL4/precomp/spec/$PLATFORM (base, lex, etc.)
			--| Dynamically created.

feature -- Subdirs from a directory name

	sub_dir_representation (dir: DIRECTORY_NAME): ARRAY [STRING] is
			-- Generate an array representation of the directory name.
		local
			first_sep, second_sep: INTEGER
			d: STRING
		do
			from
				!! Result.make (1, 0);
				d ?= dir
				first_sep := d.index_of (Operating_environment.Directory_separator, 1);
				second_sep := d.index_of (Operating_environment.Directory_separator, first_sep + 1);
			until
				second_sep = 0 
			loop
				if first_sep /= second_sep - 1 then
					Result.force (d.substring (first_sep + 1, second_sep - 1), Result.count + 1);
					first_sep := second_sep;
					second_sep := d.index_of (Operating_environment.Directory_separator, first_sep + 1);
				else
					first_sep := second_sep;
					second_sep := d.index_of (Operating_environment.Directory_separator, second_sep + 1);
				end
			end;
			Result.force (d.substring (first_sep + 1, d.count), Result.count + 1)
		end;

	last_sub_dir (dir: DIRECTORY_NAME): STRING is
			-- Return the last sub directory in `dir'
		local
			s_d_r: ARRAY [STRING]
		do
			s_d_r := sub_dir_representation (dir);
			Result := s_d_r.item (s_d_r.count - 2);
		end;

feature {NONE} -- Implementation

	generate_ace_file (contents: STRING) is
			-- Creates the ace file.
		require
			valid_contents: contents /= Void
		local
			child: ARRAYED_LIST [WIDGET];
			toggle: TOGGLE_B;
			t: STRING;
			assert, precomp_lines, root_class_line: STRING;
			d_name: DIRECTORY_NAME;
			root_cluster_line: STRING;
			default_options: STRING
			is_first: BOOLEAN
		do
			contents.replace_substring_all ("$system_name", system_edit.text);	
			root_class_line := clone (root_class_edit.text);
			root_class_line.to_upper;
			if not creation_procedure_edit.text.empty then
				root_class_line.append (" (root_cluster): %"");
				root_class_line.append (creation_procedure_edit.text);
				root_class_line.extend ('"');
			end;
			contents.replace_substring_all ("$root_class_line", root_class_line);	

			!! default_options.make (0);
			if multithreaded_toggle.state then
				default_options.append ("%Tmultithreaded (yes);%N")
			end

			if inlining_toggle.state then
				default_options.append ("%Tinlining (yes);%N")
			end

			if profiler_toggle.state then
				default_options.append ("%Tprofile (yes);%N")
			end

			if debug_toggle.state then
				default_options.append ("%Tdebug (yes);%N")
			end

			if not dead_code_removal_toggle.state then
				default_options.append ("%Tdead_code_removal (no);%N")
			end
			
			contents.replace_substring_all ("$default_options", default_options);	

			child := precomp_box.children;
			!! precomp_lines.make (0);
			if child.count > 0 then
				from
					is_first := True;
					child.start
				until
					child.after 
				loop
					toggle ?= child.item
					if toggle.state then
						precomp_lines.append ("%Tprecompiled (%"");
						!! d_name.make;
						d_name.extend_from_array (
							<<"$EIFFEL4", "precomp", "spec", "$PLATFORM">>);
						d_name.extend (standard_precompiles_reverse.item (toggle.text));
						precomp_lines.append (d_name);
						precomp_lines.append ("%");%N")
					end;
					child.forth;
				end;
			end;
			contents.replace_substring_all ("$precompile", precomp_lines);
			if no_ass.state then
				assert := "no"
			elseif require_ass.state then
				assert := "require"
			elseif ensure_ass.state then
				assert := "ensure"
			elseif invariant_ass.state then
				assert := "invariant"
			elseif loop_ass.state then
				assert := "loop"
			elseif check_ass.state then
				assert := "check"
			elseif all_ass.state then
				assert := "all"
			end;
			contents.replace_substring_all ("$assertion_value", assert);	
			!! root_cluster_line.make (0);
			if not creation_procedure_edit.text.empty then
				root_cluster_line.append ("%N%Troot_cluster: %"");
				root_cluster_line.append (Project_directory_name);
				root_cluster_line.append ("%";");
			end;
			contents.replace_substring_all ("$root_cluster_line", root_cluster_line);	
		end;

	create_root_class is
			-- Create the root class.
		local
			rc: STRING;
			new_class: PLAIN_TEXT_FILE;
			t: STRING
		do
			rc := clone (root_class_edit.text);
			rc.append (Dot_e);
			rc.to_lower;
			!! new_class.make (rc);
			if not new_class.exists then
				new_class.open_write;
				new_class.putstring ("indexing%N%
					%%Tdescription: %"System's root class%";%N%
					%%Tnote: %"Initial version automatically generated%"%N%N");
				new_class.putstring ("class%N%T");
				t := clone (root_class_edit.text);
				t.to_upper;
				new_class.putstring (t);
				new_class.putstring ("%N%N");
				new_class.putstring ("creation%N%N%T");
				new_class.putstring (creation_procedure_edit.text);
				new_class.putstring ("%N%N");
				new_class.putstring ("feature -- Initialization%N%N%T");
				new_class.putstring (creation_procedure_edit.text);
				new_class.putstring (" is%N");
				new_class.putstring ("%T%T%T-- Output a welcome message.%N%
					%%T%T%T--| (Automatically generated.)%N");
				new_class.putstring ("%T%Tdo%N");
				new_class.putstring ("%T%T%Tio.putstring (%"Welcome to ISE Eiffel!%%N%");%N");
				if Platform_constants.is_windows then
					new_class.putstring ("%T%T%Tio.readline%N");
				end;
				new_class.putstring ("%T%Tend;%N");
				new_class.putstring ("%Nend -- class ");
				new_class.putstring (t);
				new_class.putstring ("%N");
				new_class.close
			end
		end;

	save_ace_file (contents: STRING) is
			-- Save the ace file `content'.
		require
			valid_contents: contents /= Void
		local
			new_file: RAW_FILE;
			fname: FILE_NAME;
			char: CHARACTER
		do
			!! fname.make_from_string (Project_directory_name);
			fname.set_file_name ("Ace.ace");

			!! new_file.make (fname);
			new_file.open_write;
			if not contents.empty then
				new_file.putstring (contents);
				char := contents.item (contents.count);
				if Platform_constants.is_unix and 
					then char /= '%N' and
					then char /= '%R'
						-- Add a carriage return like vi if there's none at
						-- the end
				then
					new_file.new_line
				end
			end;
			new_file.close;
		end;

	default_ace_file_contents: STRING is
			-- Contents of the default ace file
		local
			a_file: RAW_FILE
		do
			!! a_file.make (Default_ace_name);
			if a_file.exists and then a_file.is_readable then
				a_file.open_read;
				a_file.readstream (a_file.count);
				a_file.close;
				Result := a_file.laststring
			end
		end;

end -- class ACE_BUILDER
