indexing
	description: "Objects that ..."
	date: "$Date$"
	revision: "$Revision$"

class
	EB_FEATURE_TEXT_FIELD

inherit
	EB_SHARED_INTERFACE_TOOLS
	NEW_EB_CONSTANTS
	EB_TOOL_COMMAND
		rename
			make as init_tool
		redefine
			tool
		end
	EV_TEXT_FIELD
		export
			{NAVIGATE_CMD} implementation
		end
	SHARED_EIFFEL_PROJECT

creation

	make_with_tool

feature -- Initialization

	make_with_tool (a_parent: EV_CONTAINER; a_tool: like tool) is
			-- Initialize the window.
		local
--			debug_tip_cmd: DEBUG_TOOLTIP_CMD
		do
			make (a_parent)
			init_tool (a_tool)
--			create debug_tip_cmd.make (implementation)
			add_return_command (Current, Void)
		end

feature -- Properties

	debug_tab (next_tab: EV_TEXT_FIELD) is
			-- manually fix the keyboard navigation with tab
		local
--			navigate_tab_cmd: NAVIGATE_CMD
		do
--			if not toolkit.name.is_equal ("MS_WINDOWS") then
--				!! navigate_tab_cmd.make (next_tab)
--				set_action ("<Key>Tab", navigate_tab_cmd, Void)
--				set_action ("Shift<Key>Tab", navigate_tab_cmd, Void)
--			end
		end

	tool: EB_FEATURE_TOOL
			-- Feature tool

feature -- Updating

	update_text is
			-- Update the text after a resize.
		do
			set_text (text)
		end

feature {EB_FEATURE_CLASS_TEXT_FIELD} -- Implementation

	process (stone: CLASSC_STONE) is
		local
			e_class: CLASS_C
			rname, cname, feat_name: STRING
			f_table: E_FEATURE_TABLE
			e_feature: E_FEATURE
			feature_stone: FEATURE_STONE
			feat_names: SORTED_TWO_WAY_LIST [STRING]
--			mp: MOUSE_PTR
			pattern: STRING_PATTERN
			choice: EB_CHOICE_WINDOW
			wd: EV_WARNING_DIALOG
		do
--			create mp.set_watch_cursor
			rname := clone (text)
			rname.to_lower
			rname.left_adjust
			rname.right_adjust
			if not rname.empty then
				e_class := stone.e_class	
				if e_class /= Void then
					f_table := e_class.api_feature_table
					if f_table /= Void then
						create pattern.make (0)
						pattern.append (rname)
						if pattern.has_wild_cards then
							create feat_names.make
							from
								f_table.start
							until
								f_table.after
							loop
								feat_name := f_table.key_for_iteration
								if pattern.matches (feat_name) then
									feat_names.extend (feat_name)
								end
								f_table.forth
							end
							create choice.make_default (Current)
							classc_stone := stone
--							mp.restore
							choice.set_list (feat_names)
							choice.set_title (Interface_names.t_Select_feature)
							choice.show
						else
							e_feature := f_table.item (rname)		
							if e_feature = Void then
--								mp.restore
								create wd.make_default (tool.parent, Interface_names.t_Warning,
									Warning_messages.w_Cannot_find_feature (rname, e_class.name))
							else
								create feature_stone.make (e_feature)
								tool.process_feature (feature_stone)
--								mp.restore
							end
						end
					else
--						mp.restore
						create wd.make_default (tool.parent, Interface_names.t_Warning,
							Warning_messages.w_features_not_compiled)
					end
				else
					cname := clone (tool.class_text_field.text)
--					mp.restore
					create wd.make_default (tool.parent, Interface_names.t_Warning,
						Warning_messages.w_Cannot_find_class (cname))
				end
			else
--				mp.restore
				create wd.make_default (tool.parent, Interface_names.t_Warning,
						Warning_messages.w_Specify_a_feature)
			end
		end


feature {NONE} -- Execution
	execute (arg: EV_ARGUMENT1 [EB_CHOICE_WINDOW]; data: EV_EVENT_DATA) is
			-- Execute the command.
		local
			stone: CLASSC_STONE
		do
			if arg = Void then
				tool.class_text_field.execute (Void, Void)
			else
				if arg.first.position /= 0 then
					set_text (arg.first.selected_name)
					arg.first.destroy
					stone := classc_stone
					classc_stone := Void
					process (stone)
				else
					arg.first.destroy
				end
			end
		end

feature {NONE} -- Implementation

	classc_stone: CLASSC_STONE
			-- Class stone saved while choosing a feature name

end -- class EB_FEATURE_TEXT_FIELD
