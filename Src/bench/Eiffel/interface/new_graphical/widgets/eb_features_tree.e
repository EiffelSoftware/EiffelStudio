indexing
	description: "Tree representing the features of the class currently opened"
	author: "$Author$"
	date: "$Date$"
	revision: "$Revision$"

class
	EB_FEATURES_TREE

inherit
	EV_TREE

	EB_CONSTANTS
		undefine
			default_create, is_equal, copy
		end

	SHARED_WORKBENCH
		undefine
			default_create, is_equal, copy
		end

	EB_SHARED_WINDOW_MANAGER
		export
			{NONE} all
		undefine
			default_create, is_equal, copy
		end

	EB_SHARED_PREFERENCES
		export
			{NONE} all
		undefine
			default_create, is_equal, copy
		end

create
	make

feature {NONE} -- Initialization

	make (a_features_tool: EB_FEATURES_TOOL; clickable: BOOLEAN) is
			-- Initialization: build the widget and the tree.
		do
			is_clickable := clickable
			features_tool := a_features_tool
			default_create

			set_minimum_height (20)
			key_press_actions.extend (agent on_key_pushed)
		end

feature -- Status report

	is_clickable: BOOLEAN
			-- Is the class corresponding to the item loaded in the tool when
			-- the user left-click on it.
			
feature -- Access

	disable_signature_status is
			-- Disable display of signature
		do
			signature_enabled := False
		end	

	toggle_signatures is
			-- Toggle signature on/off
		do
			signature_enabled := not signature_enabled		
			recursive_do_all (agent toggle_node_signature)
		end
		
	toggle_node_signature (n: EV_TREE_NODE) is
			-- Toggle signature mode on the tree node
		local
			ef: E_FEATURE
		do
			ef ?= n.data
			if ef /= Void then
				n.set_text (feature_name (ef))				
			end
		end
		
	signature_enabled: BOOLEAN
			-- Do we display signature of feature ?

feature {EB_FEATURES_TOOL} -- Implementation

	feature_name (a_ef: E_FEATURE): STRING is
			-- Feature name of `a_ef' depending of the signature displayed or not.
		require
			a_ef_not_void: a_ef /= Void
		do
			if signature_enabled then
				Result := a_ef.feature_signature
				if a_ef.type /= Void then
					Result.append (": " + a_ef.type.dump)						
				end
			else
				Result := a_ef.name
			end
		end

	build_tree (fcl: EIFFEL_LIST [FEATURE_CLAUSE_AS]) is
			-- Build the feature tree corresponding to current class.
		require
			feature_clause_list_not_void: fcl /= Void
		local
			features: EIFFEL_LIST [FEATURE_AS]
			tree_item: EV_TREE_ITEM
			name: STRING
			expand_tree: BOOLEAN
			class_text: STRING
			retried: BOOLEAN
			l_class: CLASS_C
		do
			if not retried then
				expand_tree := preferences.feature_tool_data.expand_feature_tree
				l_class := features_tool.current_compiled_class
				class_text := l_class.text
				if class_text /= Void or else l_class.is_precompiled then
						--| Features
					from
						fcl.start
					until
						fcl.after
					loop
						if fcl.item = Void then
							extend (create {EV_TREE_ITEM}.make_with_text (
								Warning_messages.w_short_internal_error ("Void feature clause")))
						else
							features := fcl.item.features
							if class_text = Void then
								name := " "
							else
								name := fcl.item.comment (class_text)
								name.right_adjust
							end
							tree_item := build_tree_folder (name, features, l_class)
							if fcl.item.export_status.is_none then
								tree_item.set_pixmap (Pixmaps.Icon_feature_clause_none)
							elseif fcl.item.export_status.is_set then
								tree_item.set_pixmap (Pixmaps.Icon_feature_clause_some)
							else
								tree_item.set_pixmap (Pixmaps.Icon_feature_clause_any)
							end
							if is_clickable then
								tree_item.set_data (fcl.item)
								tree_item.pointer_button_press_actions.extend (
									agent button_go_to_clause (fcl.item, ?, ?, ?, ?, ?, ?, ?, ?))
							end
							extend (tree_item)
							if
								expand_tree and then
								tree_item.is_expandable
							then
								tree_item.expand
							end
						end
						fcl.forth
					end
					if fcl.is_empty then
							-- Display a message not to confuse the user.
						extend (create {EV_TREE_ITEM}.make_with_text (
							Warning_messages.w_no_feature_to_display))
					end
				else
					extend (create {EV_TREE_ITEM}.make_with_text (
						Warning_messages.w_cannot_read_file (l_class.file_name)))
				end
			else
				extend (create {EV_TREE_ITEM}.make_with_text (
					Warning_messages.w_short_internal_error ("Crash in build_tree")))
			end
		rescue
			retried := True
			retry
		end

	build_tree_for_external (a_class: CLASS_C) is
			-- Build the feature tree corresponding to current .NET class 'a_class'.
		require
			a_class_not_void: a_class /= Void
		local
			tree_item: EV_TREE_ITEM
			name: STRING
			expand_tree: BOOLEAN
			class_text: STRING
			retried: BOOLEAN
			l_dev_win: EB_DEVELOPMENT_WINDOW
			l_clauses: ARRAYED_LIST [DOTNET_FEATURE_CLAUSE_AS [CONSUMED_ENTITY]]
		do
			if not retried then
				expand_tree := preferences.feature_tool_data.expand_feature_tree
				class_text := features_tool.current_compiled_class.text
				l_dev_win := Window_manager.last_focused_development_window
				if l_dev_win /= Void then
					l_clauses := l_dev_win.get_feature_clauses (a_class.name)
				end
				if l_clauses.is_empty then
					extend (create {EV_TREE_ITEM}.make_with_text (Interface_names.l_compile_first))
				elseif class_text /= Void then
					from
						l_clauses.start
					until
						l_clauses.after
					loop
						name := l_clauses.item.name
						name.right_adjust
						tree_item := build_tree_folder_for_external (name, l_clauses.item)
						if not l_clauses.item.is_exported then
							tree_item.set_pixmap (Pixmaps.Icon_feature_clause_none)
--						elseif l_clauses.item.export_status.is_set then
--							tree_item.set_pixmap (Pixmaps.Icon_feature_clause_some)
						else
							tree_item.set_pixmap (Pixmaps.Icon_feature_clause_any)
						end
						if is_clickable then
							--FIXME: NC
							-- tree_item.set_data (l_clauses.item)
							-- tree_item.pointer_button_press_actions.extend (
							--	agent button_go_to_clause (l_clauses.item, ?, ?, ?, ?, ?, ?, ?, ?))
						end
						extend (tree_item)
						if
							expand_tree and then
							tree_item.is_expandable
						then
							tree_item.expand
						end
						l_clauses.forth
					end
					if l_clauses.is_empty then
							-- Display a message not to confuse the user.
						extend (create {EV_TREE_ITEM}.make_with_text (
							Warning_messages.w_no_feature_to_display))
					end
				else
					wipe_out
					extend (create {EV_TREE_ITEM}.make_with_text (
						Warning_messages.w_cannot_read_file (
							features_tool.current_compiled_class.file_name)))
				end
			else
				wipe_out
				extend (create {EV_TREE_ITEM}.make_with_text (Interface_names.l_compile_first))
			end
		rescue
			retried := True
			retry
		end

feature {NONE} -- Implementation

	on_key_pushed (a_key: EV_KEY) is
			-- If `a_key' is enter, set a stone in the development window.
		require
			a_key_not_void: a_key /= Void
		local
			l_data: ANY
			l_feature: E_FEATURE
			l_clause: FEATURE_CLAUSE_AS
		do
				-- When features tree is created, there is no element and therefore
				-- no selected items.
			if selected_item /= Void then
				l_data := selected_item.data
			end
			if a_key.code = {EV_KEY_CONSTANTS}.Key_enter and then l_data /= Void then
				l_feature ?= l_data
				if l_feature /= Void then
					features_tool.go_to (l_feature)
				else
					l_clause ?= l_data
					if l_clause /= Void then
						features_tool.go_to_clause (l_clause)
					end
				end
			end
		end
	
	button_go_to (ef: E_FEATURE; a_x: INTEGER; a_y: INTEGER; a_button: INTEGER
						 a_x_tilt: DOUBLE; a_y_tilt: DOUBLE; a_pressure: DOUBLE
						 a_screen_x: INTEGER; a_screen_y: INTEGER) is
			-- Target `features_tool' to `ef'.
		require
			ef_not_void: ef /= Void
		do
			if a_button = 1 then
				features_tool.go_to (ef)
			end
		end

	button_go_to_clause (fclause: FEATURE_CLAUSE_AS; a_x: INTEGER; a_y: INTEGER; a_button: INTEGER
						 a_x_tilt: DOUBLE; a_y_tilt: DOUBLE; a_pressure: DOUBLE
						 a_screen_x: INTEGER; a_screen_y: INTEGER) is
			-- Target `features_tool' to `fclause'.
		require
			fclause_not_void: fclause /= Void
		do
			if a_button = 1 then
				features_tool.go_to_clause (fclause)
			end
		end

	features_tool: EB_FEATURES_TOOL
			-- Associated features tool.

	build_tree_folder (n: STRING; fl: EIFFEL_LIST [FEATURE_AS]; a_class: CLASS_C): EV_TREE_ITEM is
			-- Build the tree node corresponding to feature clause named `n'.
		require
			fl_not_void: fl /= Void
			a_class_not_void: a_class /= Void
		local
			tree_item: EV_TREE_ITEM
			ef: E_FEATURE
			st: FEATURE_STONE
			fa: FEATURE_AS
			f_names: EIFFEL_LIST [FEATURE_NAME]
			f_item_name: STRING
		do
			create Result
			if
				n /= Void and then
				not n.is_equal ("")
			then
				Result.set_text (n)
			else
				Result.set_text (Interface_names.l_no_feature_group_clause)
			end
			from
				fl.start
			until
				fl.after
			loop
				fa := fl.item
				if fa = Void then
					Result.extend (create {EV_TREE_ITEM}.make_with_text (
						warning_messages.w_short_internal_error ("Void feature")))
				else
					from
						f_names := fa.feature_names
						f_names.start
					until
						f_names.after
					loop
						f_item_name := f_names.item.internal_name
						if a_class.has_feature_table then
							ef := a_class.feature_with_name (f_item_name)
						end
						create tree_item
						if ef = Void then
							tree_item.set_text (f_item_name)
							tree_item.pointer_button_press_actions.force_extend (
								agent features_tool.go_to_line (fa.start_location.line))
							tree_item.set_pixmap (pixmaps.Icon_feature.item (1))
						else
							if is_clickable then
								tree_item.set_data (ef)
								tree_item.pointer_button_press_actions.extend (
									agent button_go_to (ef, ?, ?, ?, ?, ?, ?, ?, ?))	
							end

							tree_item.set_text (feature_name (ef))
							set_tree_item_pixmap (tree_item, ef)
							
							create st.make (ef)
							tree_item.set_pebble (st)
							tree_item.set_accept_cursor (st.stone_cursor)
							tree_item.set_deny_cursor (st.X_stone_cursor)
						end
						Result.extend (tree_item)
						f_names.forth
					end
				end
				fl.forth
			end			
		end
		
	build_tree_folder_for_external (n: STRING; fl: DOTNET_FEATURE_CLAUSE_AS [CONSUMED_ENTITY]): EV_TREE_ITEM is
			-- Build the tree node corresponding to feature clause named `n'.
		local
			tree_item: EV_TREE_ITEM
			ef: E_FEATURE
			st: FEATURE_STONE
		do
			create Result
			if n /= Void and then not n.is_empty then
				Result.set_text (n)
			else
				Result.set_text (Interface_names.l_no_feature_group_clause)
			end
			from
				fl.start
			until
				fl.after
			loop
				if fl.item = Void then
					Result.extend (create {EV_TREE_ITEM}.make_with_text (
						warning_messages.w_short_internal_error ("Void feature")))
				else
					if is_clickable then
						if
							features_tool.current_compiled_class /= Void and then
							features_tool.current_compiled_class.has_feature_table
						then
							ef := features_tool.current_compiled_class.feature_with_name (
								fl.item.eiffel_name)
							if ef = Void then
									-- Check for infix feature
								ef := features_tool.current_compiled_class.feature_with_name (
									"infix %"" + fl.item.eiffel_name + "%"")
								if ef = Void then
										-- Check for prefix feature
									ef := features_tool.current_compiled_class.feature_with_name (
										"prefix %"" + fl.item.eiffel_name + "%"")
								end
							end
						end
					end
					if ef = Void then
						Result.extend (create {EV_TREE_ITEM}.make_with_text (
							warning_messages.w_short_internal_error ("Void feature")))
					else
						create tree_item
						tree_item.set_data (ef)
						tree_item.pointer_button_press_actions.extend (
						agent button_go_to (ef, ?, ?, ?, ?, ?, ?, ?, ?))	
						tree_item.set_text (feature_name (ef))
					
						set_tree_item_pixmap (tree_item, ef)
						
						create st.make (ef)
						tree_item.set_pebble (st)
						tree_item.set_accept_cursor (st.stone_cursor)
						tree_item.set_deny_cursor (st.X_stone_cursor)
						Result.extend (tree_item)
					end
				end
				fl.forth
			end			
		end
		
	set_tree_item_pixmap (a_item: EV_TREE_ITEM; a_feature: E_FEATURE) is
			-- Sets `a_item' pixmap base on `a_feature'
		require
			a_item_not_void: a_item /= Void
			a_feature_not_void: a_feature /= Void
		local
			l_pixmap: EV_PIXMAP
		do
			if a_feature.is_deferred then
				if a_feature.is_obsolete then
					l_pixmap := Pixmaps.Icon_deferred_obsolete_feature
				else
					l_pixmap := Pixmaps.Icon_deferred_feature
				end
			elseif a_feature.is_once or a_feature.is_constant then
				if a_feature.is_obsolete then
					l_pixmap := Pixmaps.Icon_once_obsolete_objects
				elseif a_feature.is_frozen then
					l_pixmap := Pixmaps.Icon_once_frozen_objects
				else
					l_pixmap := Pixmaps.Icon_once_objects
				end
			elseif a_feature.is_attribute then
				if a_feature.is_obsolete then
					l_pixmap := Pixmaps.Icon_obsolete_attribute
				elseif a_feature.is_frozen then
					l_pixmap := Pixmaps.Icon_frozen_attribute
				else
					l_pixmap := Pixmaps.Icon_attributes
				end
			elseif a_feature.is_external then
				if a_feature.is_obsolete then
					l_pixmap := Pixmaps.Icon_external_obsolete_feature
				elseif a_feature.is_frozen then
					l_pixmap := Pixmaps.Icon_external_frozen_feature
				else
					l_pixmap := Pixmaps.Icon_external_feature
				end
			else
				if a_feature.is_obsolete then
					l_pixmap := Pixmaps.Icon_obsolete_feature
				elseif a_feature.is_frozen then
					l_pixmap := Pixmaps.Icon_frozen_feature
				else
					l_pixmap := Pixmaps.Icon_feature @ 1
				end
			end
			check
				l_pixmap_not_void: l_pixmap /= Void
			end
			a_item.set_pixmap (l_pixmap)
		end

end -- class EB_FEATURES_TREE

