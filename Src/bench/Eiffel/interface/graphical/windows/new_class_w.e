
-- Model for workbench windows

class NEW_CLASS_W

inherit

	FORM_D
		rename
			make as form_d_make
		end;
	COMMAND_W;
	SHARED_WORKBENCH

creation

	make

feature

	cluster_entry: TEXT_FIELD;
	message, class_l: LABEL;
	cluster_name: LABEL;
	create_b, cancel_b: PUSH_B;
	form: FORM;
	create, cancel, clust: ANY;

	cluster: CLUSTER_I;
	class_name: STRING;

	class_text: CLASS_TEXT;

	aok: BOOLEAN;

	make (composite: COMPOSITE; text: CLASS_TEXT) is
		do
			class_text := text;
			!!create; !!cancel; !!clust;
			form_d_make ("New Class", composite);
			set_title ("New Class");
			!!class_l.make ("", Current);
			!!message.make ("", Current);
			!!cluster_name.make ("", Current);
			!!cluster_entry.make ("", Current);
			!!form.make ("", Current);
			!!create_b.make ("Create", form);
			!!cancel_b.make ("Cancel", form);
			attach_top (class_l, 5);
			attach_left (class_l, 10);
			attach_left (cluster_name, 10);
			attach_left (message, 10);
			attach_top_widget (class_l, cluster_name, 5);
			attach_top_widget (class_l, cluster_entry, 5);
			attach_left_widget (cluster_name, cluster_entry, 5);
			attach_top_widget (cluster_name, message, 5);
			attach_top_widget (cluster_entry, message, 5);
			attach_top_widget (message, form, 5);
			form.attach_left (create_b, 5);
			form.attach_top (create_b, 5);
			form.attach_bottom (create_b, 5);
			form.attach_right (cancel_b, 5);
			form.attach_top (cancel_b, 5);
			form.attach_bottom (cancel_b, 5);
			attach_right (cluster_entry, 5);
			attach_left (form, 10);
			attach_right (form, 10);
			attach_bottom (form, 10);
			cluster_name.set_text ("Cluster: ");
			message.set_text ("No such class in system");
			cluster_entry.add_activate_action (Current, clust);
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
			class_name := class_n.duplicate;
			str2 :=  class_n.duplicate;
			str2.to_upper;
			class_name.to_lower;
			!!str.make (0);
			str.append ("Class name: ");
			str.append (str2);
			class_l.set_text (str);	
			if cluster = Void then
				cluster_entry.set_text ("<cluster name>");
			else
				cluster_entry.set_text (cluster.cluster_name);
			end
			popup;
		end;

	work (argument: ANY) is
		local
			class_i: CLASS_I;
			fname: STRING;
			file: UNIX_FILE;
			stone: CLASSI_STONE;
			str: STRING;
			base_name: STRING
		do
			if argument = create then
				change_cluster;
				if aok then
					!!class_i.make;
					class_i.set_class_name (class_name);
					!!fname.make(0);
					fname.append (cluster.path);
					fname.append ("/");
					fname.append (class_name);
					fname.append (".e");
					base_name := class_name.duplicate;
					base_name.append (".e");
					!!file.make (fname);
					class_i.set_base_name (base_name);
					class_i.set_cluster (cluster);
					class_i.set_date;
					if cluster.classes.has (fname) then
						fname.wipe_out;
						str := class_name.duplicate;
						str.to_upper;
						fname.append ("Class ");
						fname.append (str);
						fname.append (" already exist in cluster");
						warner.gotcha_call (fname);
					elseif
						(not file.exists and then not file.is_creatable)
					then
						str := fname.duplicate;
						fname.wipe_out;
						fname.append ("Cannot create file:%N");
						fname.append (str);
						warner.gotcha_call (fname);
					else 
						stone := class_i.stone;
						if not file.exists then
							file.open_write;
							file.putstring ("class ");
							file.putstring (stone.signature);
							file.putstring (" feature%N%Nend -- class ");
							file.putstring (stone.signature);
							file.new_line;
							file.close;
							cluster.classes.put (class_i, class_name);
							stone := class_i.stone;
							class_text.receive (stone);
						elseif
							not (file.is_readable and then file.is_plain)
						then
							fname.prepend ("File ");
							fname.append ("%N cannot be read");
							warner.gotcha_call (fname);
						else
								--| Reading in existing file (created outside
								--| ebench).
							cluster.classes.put (class_i, class_name);
							class_text.receive (stone);
						end;
						popdown
					end;
				end;
			elseif argument = cancel then
				popdown
			elseif argument = clust then
				change_cluster
				work (create)
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
			clu := Universe.cluster_of_name (clun);
			if clu = Void then
				aok := False;
				warner.gotcha_call ("Invalid cluster name");
			else
				aok := True;
				cluster := clu
			end;
		end;


end
