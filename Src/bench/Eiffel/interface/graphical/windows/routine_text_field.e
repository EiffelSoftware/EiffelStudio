indexing

	description:	
		"Routine text field in routine window.";
	date: "$Date$";
	revision: "$Revision$"

class ROUTINE_TEXT_FIELD

inherit

	TOOL_COMMAND
		redefine
			execute, tool
		end;
	TEXT_FIELD
		rename
			make as text_field_make
		end;
	SHARED_EIFFEL_PROJECT

creation

	make

feature -- Initialization

	make (a_parent: COMPOSITE; a_tool: like tool) is
			-- Initialize the window.
		do
			text_field_make (name, a_parent);
			add_activate_action (Current, Void);
			init_from_tool (a_tool)
		end;

feature -- Properties

	choice: CHOICE_W;
			-- Window where the user can make choices.

	tool: ROUTINE_W;
			-- Routine tool window

	name: STRING is "Class name"

feature -- Update

	update_choice_position is
			-- Update the position of the choice window.
		do
			if choice /= Void then
				choice.update_position
			end
		end;

	update_text is
			-- Update the text after a resize.
		do
			set_text (text)
		end;

	popup_choice_window is
			-- Popup the choice window.
		do
			if choice /= Void then
				execute (Void)
			end
		end

	close_choice_window is
			-- Close the choice window.
		do
			if choice /= Void then
				choice.popdown
			end
		end

feature {NONE} -- Implementation

	execute (arg: ANY) is
			-- Execute the command.
		local
			e_class: E_CLASS;
			rname, cname, feat_name: STRING;
			temp: STRING;
			f_table: E_FEATURE_TABLE;
			class_tf: ROUTINE_CLASS_TEXT_FIELD;
			e_feature: E_FEATURE;
			stone: CLASSC_STONE;
			feature_stone: FEATURE_STONE;
			feat_names: SORTED_TWO_WAY_LIST [STRING];
			mp: MOUSE_PTR
		do
			if (choice /= Void) and then arg = choice then
				if choice.position /= 1 then
					set_text (choice.selected_item);
					execute (Void)
				end
			else
				!! mp.set_watch_cursor;
				rname := clone (text);
				rname.to_lower;
				rname.left_adjust;
				rname.right_adjust;
				class_tf := tool.class_text_field;
				stone := class_tf.classc_stone;
				if stone /= Void and then not rname.empty then
					e_class := stone.e_class;	
					if e_class /= Void then
						f_table := e_class.feature_table;
						if rname.item (rname.count) = '*' then
							rname.head (rname.count - 1);
							!! feat_names.make;
							from
								f_table.start
							until
								f_table.after
							loop
								feat_name := f_table.key_for_iteration;
								if
									rname.empty or else
									(feat_name.count >= rname.count and then
									feat_name.substring 
											(1, rname.count).is_equal (rname))
								then
									feat_names.extend (feat_name)
								end;
								f_table.forth
							end;
							if choice = Void then
								!! choice.make_with_widget (parent, Current)
							end;
							choice.popup (Current, feat_names)
						else
							e_feature := f_table.item (rname);		
							if e_feature = Void then
								warner (popup_parent).gotcha_call (w_Cannot_find_feature (rname, e_class.name))
							else
								!! feature_stone.make (e_feature, e_class);
								tool.process_feature (feature_stone);
							end
						end
					else
						cname := clone (class_tf.text);
						warner (popup_parent).gotcha_call (w_Cannot_find_class (cname))
					end
				elseif rname.empty then
					warner (popup_parent).gotcha_call (w_Specify_a_feature)
				else
					cname := clone (class_tf.text);
					cname.left_adjust;
					cname.right_adjust;
					if cname.empty  then
						warner (popup_parent).gotcha_call (w_Specify_a_class)
					elseif cname.item (cname.count) = '*' then
						class_tf.popup_choice_window 
					else
						warner (popup_parent).gotcha_call (w_Cannot_find_class (cname))
					end
				end;
				mp.restore
			end
		end;

	work (arg: ANY) is
		do
		end;

end -- class ROUTINE_TEXT_FIELD
