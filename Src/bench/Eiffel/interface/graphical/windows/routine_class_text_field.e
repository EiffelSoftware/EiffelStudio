indexing

	description:	
		"Class text field in routine tool."
	date: "$Date$";
	revision: "$Revision$"

class ROUTINE_CLASS_TEXT_FIELD

inherit

	TOOL_COMMAND
		redefine
			tool, execute
		end
	TEXT_FIELD
		rename
			make as text_field_make
		end;
	SHARED_EIFFEL_PROJECT;
	NAMER

creation

	make

feature -- Initialization

	make (a_parent: COMPOSITE; a_tool: ROUTINE_W) is
			-- Initialize the text field "Class_name".
			-- Set up the activate actions.
		do
			text_field_make (name, a_parent);
			add_activate_action (Current, Void);
			init_from_tool (a_tool)
		end;

feature -- Updating

	update_class_name (n: STRING) is
			-- Redisplay the class name.
		require
			valid_n: n /= Void
		local
			temp: STRING
		do
			temp := clone (n);
			temp.to_upper;
			set_text (temp);
		end

	update_text is
			-- Update the text area after a resize
		do
			set_text (text)
		end;

	update_choice_position is
			-- Update the position of the choice window.
		do
			if choice /= Void then
				choice.update_position
			end
		end;

feature -- Properties

	tool: ROUTINE_W;
			-- Tool of the routine.

	name: STRING is "change routine";

	classc_stone: CLASSC_STONE is
			-- Stone for a compiled class.
		local
			stone: STONE;
			cname: STRING;
			class_name_in_tool: STRING;
			fs: FEATURE_STONE;
			class_i: CLASS_I
		do
			cname := clone (text);
			cname.left_adjust;
			cname.right_adjust;
			cname.to_lower;
			fs := tool.stone;
			if fs /= Void then
				class_name_in_tool := clone (fs.e_class.name);
				if class_name_in_tool.is_equal (cname) then
					--| Name in class field same as class
					--| for routine. Just retrieve stone.
					!! Result.make (fs.e_class)
				elseif not cname.empty then
					--| Get class stone for cname
					class_i := Eiffel_universe.class_with_name (cname);	
					if class_i /= Void and then class_i.compiled then
						!! Result.make (class_i.compiled_eclass)
					end;
				end
			elseif not cname.empty then
					--| Get class stone for cname
				class_i := Eiffel_universe.class_with_name (cname);	
				if class_i /= Void and then class_i.compiled then
					!! Result.make (class_i.compiled_eclass)
				end;
			end
		end;

feature -- Closure

	close_choice_window is
		do
			if choice /= Void then
				choice.popdown
			end
		end

	popup_choice_window is
			-- Popup the choice window for text field.
		do
			execute (Void)
		end

feature {NONE} -- Implementation

	execute (arg: ANY) is
			-- Execution of the command.
		local
			stone: CLASSC_STONE;
			cname, class_name: STRING;
			rname, temp: STRING;
			routine_tf: ROUTINE_TEXT_FIELD;
			fs: FEATURE_STONE;
			feat: E_FEATURE;
			class_names: SORTED_TWO_WAY_LIST [STRING];
			clusters: LINKED_LIST [CLUSTER_I];
			classes: EXTEND_TABLE [CLASS_I, STRING];
			mp: MOUSE_PTR
		do
			if (choice /= Void) and then arg = choice then
				if choice.position /= 1 then
					set_text (choice.selected_item);
					execute (Void)
				end
			else
				cname := clone (text);
				cname.left_adjust;
				cname.right_adjust;
				if not cname.empty then
					!! mp.set_watch_cursor;
					cname.to_lower;
					if cname.item (cname.count) = '*' then
						!! class_names.make;
						cname.head (cname.count - 1);
						from
							clusters := Eiffel_universe.clusters;
							clusters.start
						until
							clusters.after
						loop
							from
								classes := clusters.item.classes;
								classes.start
							until
								classes.after
							loop
								class_name := classes.key_for_iteration;
								if
									classes.item_for_iteration.compiled and 
									(cname.empty or else
									(class_name.count >= cname.count and then
									class_name.substring
											(1, cname.count).is_equal (cname)))
								then
									class_name := clone (class_name);
									class_name.to_upper;
									class_names.extend (class_name)
								end;
								classes.forth
							end;
							clusters.forth
						end;

						if choice = Void then
							!! choice.make_with_widget (parent, Current)
						end;
						mp.restore;
						choice.popup (Current, class_names)
					else
						stone := classc_stone;
						if stone /= Void then
							routine_tf := tool.routine_text_field;
							rname := clone (routine_tf.text);
							rname.to_lower;
							rname.left_adjust;
							rname.right_adjust;
							fs := tool.stone;
							--if fs /= void and then rname.is_equal (fs.feature_i.feature_name) then
									-- Use same feature in tool for update
								--routine_text.receive (stone);
							if rname.empty then
									-- Retrieve feature
								mp.restore;
								warner (popup_parent).gotcha_call (w_Specify_a_feature)
							elseif rname.item (rname.count) = '*' then
								routine_tf.popup_choice_window
							else
								feat := classc_stone.e_class.feature_with_name (rname);
								if feat = Void then
									mp.restore;
									warner (popup_parent).gotcha_call 
										(w_Cannot_find_feature (rname, cname));
								else
									!! fs.make (feat, classc_stone.e_class);
									tool.process_feature (fs);
								end
							end	
						else
							mp.restore;
							warner (popup_parent).gotcha_call (w_Cannot_find_class (cname))
						end;
					end;
					mp.restore;
				else
					warner (popup_parent).gotcha_call (w_Specify_a_class)
				end
			end
		end;

	work (arg: ANY) is
			-- Work that is to be done for the command.
		do
		end;

	choice: CHOICE_W;
			-- Window where the user can make his/her choices.

end -- class ROUTINE_CLASS_TEXT_FIELD
