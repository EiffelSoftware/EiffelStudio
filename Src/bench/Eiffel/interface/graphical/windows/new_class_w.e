
-- Model for workbench windows

class NEW_CLASS_W

inherit

	FORM_D
		rename
			make as form_d_make
		end;
	COMMAND_W;
	SHARED_EIFFEL_PROJECT

creation

	make

feature

	cluster_entry, file_entry: TEXT_FIELD;
	cluster_form, file_form: FORM;
	message, class_l: LABEL;
	cluster_name, file_label: LABEL;
	create_b, cancel_b: PUSH_B;
	form: FORM;
	create: ANY is once !!Result end;
	cancel: ANY is once !!Result end;

	cluster: CLUSTER_I;
	class_name: STRING;
	file_name: STRING;

	class_i: CLASS_I;
	stone: CLASSI_STONE;

	class_text: CLASS_TEXT;

	aok: BOOLEAN;

	make (composite: COMPOSITE; text: CLASS_TEXT) is
		do
			class_text := text;
			form_d_make ("New Class", composite);
			set_title ("New Class");
			!!class_l.make ("", Current);
			!!message.make ("", Current);
			!!cluster_form.make ("", Current);
			!!cluster_name.make ("", cluster_form);
			!!cluster_entry.make ("", cluster_form);
			!!file_form.make ("", Current);
			!!file_label.make ("", file_form);
			!!file_entry.make ("", file_form);
			!!form.make ("", Current);
			!!create_b.make ("Create", form);
			!!cancel_b.make ("Cancel", form);
			cluster_form.attach_left (cluster_name, 0);
			cluster_form.attach_right (cluster_entry, 0);
			cluster_form.attach_left_widget (cluster_name, cluster_entry, 5);
			file_form.attach_left (file_label, 0);
			file_form.attach_right (file_entry, 0);
			file_form.attach_left_widget (file_label, file_entry, 5);
			attach_top (class_l, 5);
			attach_left (class_l, 10);
			attach_left (file_form, 10);
			attach_left (cluster_form, 10);
			attach_left (message, 10);
			attach_top_widget (class_l, file_form, 5);
			attach_top_widget (file_form, cluster_form, 5);
			attach_top_widget (cluster_form, message, 5);
			attach_top_widget (message, form, 5);
			form.attach_left (create_b, 5);
			form.attach_top (create_b, 5);
			form.attach_bottom (create_b, 5);
			form.attach_right (cancel_b, 5);
			form.attach_top (cancel_b, 5);
			form.attach_bottom (cancel_b, 5);
			attach_right (cluster_form, 5);
			attach_right (file_form, 5);
			attach_left (form, 10);
			attach_right (form, 10);
			attach_bottom (form, 10);
			cluster_name.set_text ("Cluster: ");
			file_label.set_text ("File name: ");
			message.set_text ("No such class in system");
			cluster_entry.add_activate_action (Current, create);
			file_entry.add_activate_action (Current, create);
			cancel_b.add_activate_action (Current, cancel);
			create_b.add_activate_action (Current, create);
			set_exclusive_grab
		end;

	call (class_n: STRING; cl: CLUSTER_I) is
		require
			valid_args: class_n /= Void 
		local
			str, str2: STRING
		do
			cluster := cl;
			class_name := clone (class_n);
			str2 :=  clone (class_n);
			str2.to_upper;
			class_name.to_lower;
			!!str.make (0);
			str.append ("Class name: ");
			str.append (str2);
			class_l.set_text (str);	
			file_name := clone (class_name);
			file_name.append (".e");
			file_entry.set_text (file_name);
			if cluster = Void then
				cluster_entry.set_text ("<cluster name>");
			else
				cluster_entry.set_text (cluster.cluster_name);
			end
			popup;
		end;

	work (argument: ANY) is
		local
			f_name: FILE_NAME;
			file: PLAIN_TEXT_FILE;
			str: STRING;
			base_name: STRING;
		do
			if argument = create then
				change_cluster;
				file_name := file_entry.text;
				if aok then
					!!f_name.make_from_string (cluster.path);
					f_name.set_file_name (file_name);
					base_name := file_name;
					!! file.make (f_name);
					!! class_i.make;
					class_i.set_class_name (class_name);
					class_i.set_base_name (base_name);
					if cluster.has_base_name (base_name) then
						warner (class_text).gotcha_call 
							(w_Class_already_in_cluster (base_name));
					elseif
						(not file.exists and then not file.is_creatable)
					then
						warner (class_text).gotcha_call (w_Cannot_create_file (f_name))
					else 
						!! stone.make (class_i);
						if not file.exists then
							file.open_write;
							file.putstring ("class ");
							file.putstring (stone.signature);
							file.putstring (" feature%N%Nend -- class ");
							file.putstring (stone.signature);
							file.new_line;
							file.close;
							cluster.add_new_classs (class_i);
							!! stone.make (class_i);
							class_text.receive (stone);
							popdown;
						elseif
							not (file.is_readable and then file.is_plain)
						then
							popdown;
							warner (class_text).gotcha_call (w_Cannot_read_file (f_name))
						else
								--| Reading in existing file (created outside
								--| ebench). Ask for confirmation
							popdown;
							warner (class_text).custom_call
								(Current, w_File_exists_edit_it (f_name),
								" Edit ", "Select another file", Void)
						end;
					end;
				end;
			elseif argument = cancel then
				popdown
			elseif argument = Void then 
					-- The file name of the new class already exists.
					-- The user wants to choose another file name.
				popup
			elseif argument = last_warner then
					-- The file name of the new class already exists.
					-- The user wants to keep it.
				cluster.classes.put (class_i, class_name);
				class_text.receive (stone)
			end;
		end;

	change_cluster is
			-- Howdy Howdy
		local
			clun: STRING;
			clu: CLUSTER_I; 
		do
			clun := cluster_entry.text; 
			clun.to_lower;
			clu := Eiffel_universe.cluster_of_name (clun);
			if clu = Void then
				aok := False;
				warner (class_text).gotcha_call (w_Invalid_cluster_name)
			else
				aok := True;
				cluster := clu
			end;
		end;


end
