indexing
	description: "Routine text field in routine window.";
	date: "$Date$";
	revision: "$Revision$"

class ROUTINE_TEXT_FIELD

inherit

	WINDOWS;
	EB_CONSTANTS;
	COMMAND;
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
			text_field_make ("", a_parent);
			add_activate_action (Current, Void);
			tool := a_tool
		end;

feature -- Properties

	choice: CHOICE_W;
			-- Window where the user can make choices.

	tool: ROUTINE_W;
			-- Routine tool window

feature -- Updating

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

feature -- Closure

	close_choice_window is
			-- Close the choice window.
		do
			if choice /= Void then
				choice.popdown
			end
		end

	set_focus is
		local
			t: TEXT_FIELD_IMP
		do
			if toolkit.name.is_equal ("MS_WINDOWS") then
				t ?= implementation
				t.wel_set_focus
			end
		end

feature {ROUTINE_CLASS_TEXT_FIELD} -- Implementation

	execute (arg: ANY) is
			-- Execute the command.
		local
			e_class: CLASS_C;
			rname, cname, feat_name: STRING;
			temp: STRING;
			f_table: E_FEATURE_TABLE;
			e_feature: E_FEATURE;
			stone: CLASSC_STONE;
			feature_stone: FEATURE_STONE;
			feat_names: SORTED_TWO_WAY_LIST [STRING];
			mp: MOUSE_PTR;
			pattern: STRING_PATTERN
		do
			if (choice /= Void) and then arg = choice then
				if choice.position /= 0 then
					set_text (choice.selected_item);
					stone := classc_stone;
					classc_stone := Void;
					execute (stone)
				end
			else
				stone ?= arg;
				if stone = Void then
						-- Ask for a class name first.
					tool.class_text_field.execute (Void)
				else
					!! mp.set_watch_cursor;
					rname := clone (text);
					rname.to_lower;
					rname.left_adjust;
					rname.right_adjust;
					if not rname.empty then
						e_class := stone.e_class;	
						if e_class /= Void then
							f_table := e_class.api_feature_table;
							if f_table /= Void then
								!! pattern.make (0);
								pattern.append (rname);
								if pattern.has_wild_cards then
									!! feat_names.make;
									from
										f_table.start
									until
										f_table.after
									loop
										feat_name := f_table.key_for_iteration;
										if pattern.matches (feat_name) then
											feat_names.extend (feat_name)
										end;
										f_table.forth
									end;
									if choice = Void then
										!! choice.make_with_widget (parent, Current)
									end;
									classc_stone := stone;
									mp.restore;
									choice.popup (Current, feat_names, Interface_names.t_Select_feature)
								else
									e_feature := f_table.item (rname);		
									if e_feature = Void then
										mp.restore;
										warner (tool.popup_parent).gotcha_call 
											(Warning_messages.w_Cannot_find_feature (rname, e_class.name))
									else
										!! feature_stone.make (e_feature);
										tool.process_feature (feature_stone);
										mp.restore;
									end
								end
							else
								mp.restore
								warner (tool.popup_parent).gotcha_call
									(Warning_messages.w_features_not_compiled)
							end
						else
							cname := clone (tool.class_text_field.text);
							mp.restore;
							warner (tool.popup_parent).gotcha_call 
								(Warning_messages.w_Cannot_find_class (cname))
						end
					else
						mp.restore;
						warner (tool.popup_parent).gotcha_call 
								(Warning_messages.w_Specify_a_feature)
					end
				end
			end
		end;

feature {NONE} -- Implementation

	classc_stone: CLASSC_STONE;
			-- Class stone saved while choosing a feature name

end -- class ROUTINE_TEXT_FIELD
