indexing
	description: "Class text field in class tool."
	date: "$Date$"
	revision: "$Revision$"

class EB_CLASS_TEXT_FIELD

inherit

	NEW_EB_CONSTANTS
	EV_COMMAND
	EV_TEXT_FIELD
		export
			{NAVIGATE_CMD} implementation
		end
	SHARED_EIFFEL_PROJECT

creation

	make_with_tool

feature -- Initialization

	make_with_tool (a_parent: EV_CONTAINER; a_tool: EB_CLASS_TOOL) is
			-- Initialize the text field "Class_name".
			-- Set up the activate actions.
		local
			debug_tip_cmd: DEBUG_TOOLTIP_CMD
		do
			make (a_parent) 
--			create debug_tip_cmd.make (implementation)
			add_activate_command (Current, Void)
			tool := a_tool
		end

feature -- Properties

--	new_class_win: EB_NEW_CLASS_TOOL
			-- New window for a class tool.

	tool: EB_CLASS_TOOL
			-- Class tool

feature -- Updating

--	update_choice_position is
--			-- Update the text area after a resize
--		do
--			if choice /= Void then
--				choice.update_position
--			end
--		end

	update_text is
			-- Update the text area after a resize
		do
			set_text (text)
		end

feature -- Closure

	destroy_choice_window is
		do
			if choice /= Void then	
				choice.destroy
			end
		end

--	set_focus is
--		local
--			t: EV_TEXT_FIELD_IMP
--		do
--			if toolkit.name.is_equal ("MS_WINDOWS") then
--				t ?= implementation
--				t.wel_set_focus
--			end
--		end

feature {NONE} -- Implementation

	choice: EB_CHOICE_WINDOW
			-- Window for user choices.

	class_list: LINKED_LIST [CLASS_I]
			-- List of classes displayed in `choice'

feature {EB_CHOICE_WINDOW} -- Execution

	choose (choice_position: INTEGER) is
		local
			cname: STRING
			class_i: CLASS_I
		do
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

feature {NONE} -- Execution

	process (class_i: CLASS_I) is
		local
			classi_stone: CLASSI_STONE
			classc_stone: CLASSC_STONE
		do
			if class_i /= Void then
				if class_i.compiled then
					create classc_stone.make (class_i.compiled_class)
					tool.process_class (classc_stone)
				else
					create classi_stone.make (class_i)
					tool.process_classi (classi_stone)
				end
			end
		end

	execute (arg: EV_ARGUMENT; data: EV_EVENT_DATA) is
			-- Execute the command.
			--| The KMP commented lines are for the futur when the class
			--| KMP_WILD will be fully functional
		local
			cname: STRING
			clusters: LINKED_LIST [CLUSTER_I]
			sorted_classes: SORTED_TWO_WAY_LIST [CLASS_I]
--			mp: MOUSE_PTR
			at_pos: INTEGER
			cluster: CLUSTER_I
			cluster_name: STRING
			pattern: STRING_PATTERN
--KMP			matcher: KMP_WILD
			classes: EXTEND_TABLE [CLASS_I, STRING]
		do
			if Eiffel_project.initialized then
				cname := clone (text)
				cname.left_adjust
				cname.right_adjust
				if cname.empty then
--					warner (tool.popup_parent).gotcha_call (Warning_messages.w_Specify_a_class)
				else
					cname.to_lower
					create pattern.make (0)
					pattern.append (cname)
					if not pattern.has_wild_cards then
--						create mp.set_watch_cursor
						at_pos := cname.index_of ('@', 1)
						if at_pos = 0 then
							class_list := Eiffel_universe.classes_with_name (cname)
--							mp.restore
							if class_list.empty then
								class_list := Void
--								if new_class_win = Void then
--									create new_class_win.make (tool)
--								end
--								new_class_win.call (cname, tool.cluster)
							elseif class_list.count = 1 then
								cname.to_upper
								set_text (cname)
								process (class_list.first)
								class_list := Void
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
--							mp.restore
							if cluster = Void then
--								warner (tool.popup_parent).gotcha_call
--									(Warning_messages.w_Cannot_find_cluster (cluster_name))
							else
--								class_i := cluster.classes.item (cname)
--								if class_i = Void then
--									if new_class_win = Void then
--										create new_class_win.make (tool)
--									end
--									new_class_win.call (cname, cluster)
--								end
							end	
						end
					else
						from
--							create mp.set_watch_cursor
							create sorted_classes.make
--KMP							create matcher.make (cname, "")
							clusters := Eiffel_universe.clusters
							clusters.start
						until
							clusters.after
						loop
							from
								classes := clusters.item.classes
								classes.start
							until
								classes.after
							loop
--KMP								matcher.set_text (classes.key_for_iteration) 
--KMP								if matcher.search_for_pattern then
								if pattern.matches (classes.key_for_iteration) then
									sorted_classes.put_front (classes.item_for_iteration)
								end
								classes.forth
							end
							clusters.forth
						end
							sorted_classes.sort
						class_list := sorted_classes
--						mp.restore
						display_choice
					end
				end
			end
		end

	display_choice is
				-- Display class names from `class_list' to `choice'.
		require
			class_list_not_void: class_list /= Void
		local
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

feature -- focus action

end -- class EB_CLASS_TEXT_FIELD
