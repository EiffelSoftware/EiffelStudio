indexing
	description: "Class text field in feature tool."
	date: "$Date$"
	revision: "$Revision$"

class
	EB_FEATURE_CLASS_TEXT_FIELD

inherit
	EB_SHARED_INTERFACE_TOOLS
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
	NEW_EB_CONSTANTS

creation
	make_with_tool

feature -- Initialization

	make_with_tool (a_parent: EV_CONTAINER; a_tool: like tool) is
			-- Initialize the text field "Class_name".
			-- Set up the activate actions.
		local
--			debug_tip_cmd: DEBUG_TOOLTIP_CMD
		do
			make (a_parent)
			init_tool (a_tool)
--			create debug_tip_cmd.make (implementation)
			add_return_command (Current, Void)
		end

feature -- Properties
	
	debug_tab (previous_tab: EV_TEXT_FIELD) is
			-- manually fix the keyboard navigation with tab
		local
--			navigate_tab_cmd: NAVIGATE_CMD
		do
--			if not toolkit.name.is_equal ("MS_WINDOWS") then
--				create navigate_tab_cmd.make (previous_tab)
--				set_action ("<Key>Tab", navigate_tab_cmd, Void)
--				set_action ("Shift<Key>Tab", navigate_tab_cmd, Void)
--			end
		end

	tool: EB_FEATURE_TOOL
			-- Tool of the feature.

feature -- Updating

	update_text is
			-- Update the text area after a resize
		do
			set_text (text)
		end

	update_class_name (n: STRING) is
			-- Redisplay the class name.
		require
			valid_n: n /= Void
		local
			temp: STRING
		do
			temp := clone (n)
			temp.to_upper
			set_text (temp)
		end

feature {EB_CHOICE_DIALOG} -- Execution

	process (class_i: CLASS_I) is
		local
			classc_stone: CLASSC_STONE
		do
			if class_i /= Void then
				check
					class_i.compiled
				end
				create classc_stone.make (class_i.compiled_class)
				tool.feature_text_field.process (classc_stone)
			end
		end

feature {EB_FEATURE_TEXT_FIELD} -- Implementation

	execute (arg: EV_ARGUMENT1 [EB_CHOICE_DIALOG]; data: EV_EVENT_DATA) is
			-- Execution of the command.
		local
			choice_position: INTEGER
			cname: STRING
			clusters: LINKED_LIST [CLUSTER_I]
			sorted_classes: SORTED_TWO_WAY_LIST [CLASS_I]
--			mp: MOUSE_PTR
			class_i: CLASS_I
			at_pos: INTEGER
			cluster_name: STRING
			cluster: CLUSTER_I
			pattern: STRING_PATTERN
--KMP			matcher: KMP_WILD
			classes_c: CLASS_C_SERVER
			classes: ARRAY [CLASS_C]
			class_c: CLASS_C
			i, nb: INTEGER
			wd: EV_WARNING_DIALOG
		do
			if arg = Void then
				if Eiffel_project.initialized and then Eiffel_project.system /= Void then
					cname := clone (text)
					cname.left_adjust
					cname.right_adjust
					if cname.empty then
						create wd.make_default (tool.parent, Interface_names.t_warning,
							Warning_messages.w_Specify_a_class)
					else
						cname.to_lower
						create pattern.make (0)
						pattern.append (cname)
						if not pattern.has_wild_cards then
--							create mp.set_watch_cursor
							at_pos := cname.index_of ('@', 1)
							if at_pos = 0 then
								class_list := Eiffel_universe.compiled_classes_with_name (cname)
--								mp.restore
								if class_list.empty then
									class_list := Void
									create wd.make_default (tool.parent, Interface_names.t_warning,
										Warning_messages.w_Cannot_find_class (cname))
								elseif class_list.count = 1 then
									class_i := class_list.first
									class_list := Void
									process(class_i)
								else
									display_choice
								end
							elseif at_pos = cname.count then
								cname.head (cname.count - 1)
								set_text (cname)
								execute (Void, data)
							else
								cluster_name := cname.substring (at_pos + 1, cname.count)
								if at_pos > 1 then
									cname := cname.substring (1, at_pos - 1)
								else
									cname := ""
								end
								cluster := Eiffel_universe.cluster_of_name (cluster_name)
--								mp.restore
								if cluster = Void then
									create wd.make_default (tool.parent, Interface_names.t_warning,
										Warning_messages.w_Cannot_find_cluster (cluster_name))
								else
									class_i := cluster.classes.item (cname)
									if class_i = Void then
										create wd.make_default (tool.parent, Interface_names.t_warning,
											Warning_messages.w_Cannot_find_class (cname))
									end
								end
							end
						else
							from
--								create mp.set_watch_cursor
								create sorted_classes.make
--KMP								create matcher.make (cname, "")
								classes_c := Eiffel_system.system.classes
								classes_c.start
							until
								classes_c.after
							loop
								from
									classes := classes_c.item_for_iteration
									i := classes.lower
									nb := classes.upper
								until
									i > nb
								loop
									class_c := classes.item (i)
									if class_c /= Void then
--KMP										matcher.set_text (class_c.lace_class.name)
--KMP										if matcher.search_for_pattern then
										if pattern.matches (class_c.lace_class.name) then
											sorted_classes.put_front (class_c.lace_class)
										end
									end
									i := i + 1
								end
								classes_c.forth
							end
							class_i := Void
							sorted_classes.sort
							class_list := sorted_classes
--							mp.restore
							display_choice
						end
					end
				end
			else
				choice_position := arg.first.position
				arg.first.destroy
				check
					class_list /= Void
				end
				if choice_position /= 0 then
					class_i := class_list.i_th (choice_position)
					cname := clone (class_i.name)
					cname.to_upper
					set_text (cname)
					process (class_i)
				else
					class_list := Void
				end
			end
		end

feature {NONE} -- Implementation

	class_list: LINKED_LIST [CLASS_I]
			-- List of classes displayed in `choice'

	display_choice is
				-- Display class names from `class_list' to `choice'.
		require
			class_list_not_void: class_list /= Void
		local
			choice: EB_CHOICE_DIALOG
			class_names: ARRAYED_LIST [STRING]
			class_i, last_class: CLASS_I
			cname, last_name: STRING
			first_ambiguous: BOOLEAN
		do
			create class_names.make (class_list.count)
			from class_list.start until class_list.after loop
				class_i := class_list.item
				cname := clone (class_i.name)
				if
					last_class /= Void and then
					last_class.name.is_equal (cname)
				then
					if not first_ambiguous then
						first_ambiguous := True
						last_name := class_names.last
						last_name.extend ('@')
						last_name.append (last_class.cluster.cluster_name)
					end
					cname.to_upper
					cname.extend ('@')
					cname.append (class_i.cluster.cluster_name)
				else
					cname.to_upper
					first_ambiguous := False
				end
				class_names.extend (cname)
				last_class := class_i
				class_list.forth
			end
			create choice.make_default (Current)
			choice.set_title (Interface_names.t_Select_class)
			choice.set_list (class_names)
			choice.show
		end

end -- class EB_FEATURE_CLASS_TEXT_FIELD
