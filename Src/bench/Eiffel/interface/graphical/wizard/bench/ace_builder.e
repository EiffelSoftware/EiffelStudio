indexing

	description:
		"Wizard action that preforms the creation of an Ace file";
	date: "$Date$";
	revision: "$Revision$"

class CREATE_ACE

inherit
	WIZARD_ACTION;
	EIFFEL_ENV;
	PROJECT_CONTEXT;
	WINDOWS;
	WINDOW_ATTRIBUTES

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
			twl: TWO_WAY_LIST [STRING];
			child: ARRAYED_LIST [WIDGET];
			toggle: TOGGLE_B;
			first: BOOLEAN;
			subdir: DIRECTORY_NAME;
			l_s_d, l_s_d_lower, std_precomp_name: STRING;
			proj: STRING
		do
			twl := precompiles;
			!! dir_edit.make ("dir_edit", dialog.action_form);
			!! system_edit.make ("system_edit", dialog.action_form);
			!! root_class_edit.make ("root_class_edit", dialog.action_form);
			!! creation_procedure_edit.make ("creation_procedure_edit", dialog.action_form);

			!! dir_label.make ("prject_directory", dialog.action_form);
			!! system_label.make ("system_label", dialog.action_form);
			!! root_class_label.make ("root_class_label", dialog.action_form);
			!! creation_procedure_label.make ("creation_procedure_label", dialog.action_form);
			!! precomp_label.make ("precomp_label", dialog.action_form);
			!! assertion_label.make ("assertion_label", dialog.action_form);

			!! precomp_radio.make ("precomp_radios", dialog.action_form);
			from
				twl := precompiles;
				twl.start;
				first := True;
				!! standard_precompiles_reverse.make (3)
			until
				twl.after
			loop
				!! toggle.make ("toggle", precomp_radio);
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

			!! assertion_radio.make ("assertion_radio", dialog.action_form);
			!! no_ass.make ("ass_no", assertion_radio);
			!! require_ass.make ("ass_require", assertion_radio);
			!! ensure_ass.make ("ass_ensure", assertion_radio);
			!! invariant_ass.make ("ass_invariant", assertion_radio);
			!! loop_ass.make ("ass_loop", assertion_radio);
			!! check_ass.make ("ass_check", assertion_radio);
			!! all_ass.make ("all_ass", assertion_radio);

			dir_label.set_text ("Project directory: ");
			system_label.set_text ("System name:");
			root_class_label.set_text ("Root class name:");
			creation_procedure_label.set_text ("Creation procedure name:");
			precomp_label.set_text ("Precompiled libraries:");
			assertion_label.set_text ("Default assertion checking:");

			dir_edit.set_text (Project_directory);
			dir_edit.set_read_only;
			system_edit.set_text ("sample");
			root_class_edit.set_text ("ROOT_CLASS");
			creation_procedure_edit.set_text ("make");

			no_ass.set_text ("No assertions");
			no_ass.set_toggle_off;
			require_ass.set_text ("Require");
			require_ass.set_toggle_on;
			ensure_ass.set_text ("Ensure");
			ensure_ass.set_toggle_off;
			invariant_ass.set_text ("Invariant");
			invariant_ass.set_toggle_off;
			loop_ass.set_text ("Loop");
			loop_ass.set_toggle_off;
			check_ass.set_text ("Check");
			check_ass.set_toggle_off;
			all_ass.set_text ("All");
			all_ass.set_toggle_off;

			precomp_radio.set_always_one (True);
			assertion_radio.set_always_one (True);

			dialog.action_form.attach_top (dir_label, 15);
			dialog.action_form.attach_left (dir_label, 10);

			dialog.action_form.attach_top (dir_edit, 10);
			dialog.action_form.attach_left_widget (dir_label, dir_edit, 20);
			dialog.action_form.attach_right (dir_edit, 10);

			dialog.action_form.attach_top_widget (dir_edit, system_label, 15);
			dialog.action_form.attach_left (system_label, 10);
			dialog.action_form.attach_top_widget (dir_edit, system_edit, 10);
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

			dialog.action_form.attach_left (precomp_label, 10);
			dialog.action_form.attach_top_widget (creation_procedure_edit, precomp_label, 15);

			dialog.action_form.attach_left (precomp_radio, 10);
			dialog.action_form.attach_top_widget (precomp_label, precomp_radio, 10);

			dialog.action_form.attach_left (assertion_label, 10);
			dialog.action_form.attach_top_widget (precomp_radio, assertion_label, 10);

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
			id: IDENTIFIER
		do
			!! id.make (0);
			id.append (system_edit.text);
			if not id.is_valid then
				warner (dialog).gotcha_call ("Invalid system name.%N");
				processed := False;
			else
				!! id.make (0);
				id.append (root_class_edit.text);
				if not id.is_valid then
					warner (dialog).gotcha_call ("Invalid root class name.%N");
					processed := False;
				else
					!! id.make (0);
					id.append (creation_procedure_edit.text);
					if not id.is_valid then
						warner (dialog).gotcha_call ("Invalid creation procedure name.%N");
						processed := False;
					else
						processed := True;
						create_ace_file;
						create_root_class;
						caller.perform_post_creation
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

feature -- Toggles

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

	dir_edit: TEXT;
			-- Text box to display the project directory.

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

	assertion_label: LABEL;
			-- Label to display the assertion checking text.

feature -- Radio Boxes

	precomp_radio: RADIO_BOX;
			-- Radio box to display all precompiles.

	assertion_radio: RADIO_BOX;
			-- Radio box to display assertion checking options.

feature {NONE} -- Properties

	precompiles: TWO_WAY_LIST [STRING] is
			-- Looks up the disk to find the precompiled libraries in
			-- $EIFFEL3/precomp/spec/$PLATFORM/*.
			-- The list will only contain those precompiles that are actually
			-- precompiled (by the means the file ./EIFGEN/project.eif exists).
		local
			new_precomp: STRING;
			dir: DIRECTORY;
			full_name: STRING;
			file_name: FILE_NAME;
			file: RAW_FILE
		once
			!! Result.make;
			!! dir.make_open_read (Default_precompiled_location);
			from
				dir.start;
				dir.readentry
			until
				dir.lastentry = Void
			loop
				full_name := clone (dir.name);
				full_name.extend (Operating_environment.Directory_separator);
				full_name.append (dir.lastentry);
				!! file_name.make_from_string (full_name);
				file_name.extend_from_array (<<Eiffelgen, Dot_workbench>>);
				!! file.make (file_name);

				if file.exists then
					Result.extend (full_name)
				end;
				dir.readentry
			end;
			dir.close;
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
			Result.compare_objects
		end;

	standard_precompiles_reverse: HASH_TABLE [STRING, STRING];
			-- A hash table of the qualified name of standard precompiles (EiffelBase, EiffelLex, etc.)
			-- against their location in $EIFFEL3/precomp/spec/$PLATFORM (base, lex, etc.)
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
				Result.force (d.substring (first_sep + 1, second_sep - 1), Result.count + 1);
				first_sep := second_sep;
				second_sep := d.index_of (Operating_environment.Directory_separator, first_sep + 1);
			end;
			Result.force (d.substring (first_sep + 1, d.count), Result.count + 1)
		end;

	last_sub_dir (dir: DIRECTORY_NAME): STRING is
			-- Return the last sub directory in `dir'
		local
			s_d_r: ARRAY [STRING]
		do
			s_d_r := sub_dir_representation (dir);
			Result := s_d_r.item (s_d_r.count);
		end;

feature {NONE} -- Implementation

	create_ace_file is
			-- Creates the ace file.
		local
			new_ace: PLAIN_TEXT_FILE;
			child: ARRAYED_LIST [WIDGET];
			toggle: TOGGLE_B;
			t: STRING
		do
			!! new_ace.make_open_write ("Ace.ace");
			new_ace.putstring ("system%N%T");
			new_ace.putstring (system_edit.text);
			new_ace.putstring ("%N%T%T-- Name of the system.%N%Nroot%N%T%"");
			t := clone (root_class_edit.text);
			t.to_upper;
			new_ace.putstring (t);
			new_ace.putstring ("%" (root_cluster): %"");
			new_ace.putstring (creation_procedure_edit.text);
			new_ace.putstring ("%"%N%T%T-- Execute system by creating instance of class `");
			new_ace.putstring (t);
			new_ace.putstring ("'%N%T%T-- from cluster `root_cluster', using creation procedure `");
			new_ace.putstring (creation_procedure_edit.text);
			new_ace.putstring ("'.%N");
			new_ace.putstring ("%Ndefault%N%T");

			child := precomp_radio.children;
			if child.count > 0 then
				from
					child.start;
					toggle ?= child.item
				until
					child.after or else toggle.state
				loop
					child.forth;
					toggle ?= child.item
				end;
			end;
			if not child.after then
				new_ace.putstring ("precompiled (%"$EIFFEL3");
				new_ace.putchar (Operating_environment.Directory_separator);
				new_ace.putstring ("precomp");
				new_ace.putchar (Operating_environment.Directory_separator);
				new_ace.putstring ("spec");
				new_ace.putchar (Operating_environment.Directory_separator);
				new_ace.putstring ("$PLATFORM");
				new_ace.putchar (Operating_environment.Directory_separator);
				new_ace.putstring (standard_precompiles_reverse.item (toggle.text));
				new_ace.putstring ("%");%N");
			end;
			new_ace.putstring ("%Tassertion (");
			if no_ass.state then
				new_ace.putstring ("no");
			end;
			if require_ass.state then
				new_ace.putstring ("require");
			end;
			if ensure_ass.state then
				new_ace.putstring ("ensure");
			end;
			if invariant_ass.state then
				new_ace.putstring ("invariant");
			end;
			if loop_ass.state then
				new_ace.putstring ("loop");
			end;
			if check_ass.state then
				new_ace.putstring ("check");
			end;
			if all_ass.state then
				new_ace.putstring ("all");
			end;
			new_ace.putstring (");%N%Ncluster%N%Troot_cluster:%T%T%"");
			new_ace.putstring (Project_directory);
			new_ace.putstring ("%";%N%Nend -- system ");
			new_ace.putstring (system_edit.text);
			new_ace.putstring ("%N");
			new_ace.close
		end;

	create_root_class is
			-- Create the root class.
		local
			rc: STRING;
			new_class: PLAIN_TEXT_FILE;
			t: STRING
		do
			rc := clone (root_class_edit.text);
			rc.to_lower;
			rc.append (Dot_e);
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
				new_class.putstring ("%T%T%Tio.readline%N");
					-- FIXME **********************************************
					-- UNIX: `ebench &' will not work with this.
					-- FIXME **********************************************
				new_class.putstring ("%T%Tend;%N");
				new_class.putstring ("%Nend -- class ");
				new_class.putstring (t);
				new_class.putstring ("%N");
				new_class.close
			end
		end;

end -- class CREATE_ACE
