indexing
	description	: "Tree representing the features of the class currently opened"
	date		: "$Date$"
	revision	: "$Revision$"

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

	EB_FEATURE_TOOL_DATA
		undefine
			default_create, is_equal, copy
		end

	EXCEPTIONS
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
		end

feature -- Status report

	is_clickable: BOOLEAN
			-- Is the class corresponding to the item loaded in the tool when
			-- the user left-click on it.

feature {EB_FEATURES_TOOL} -- Implementation

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
		do
			if not retried then
				expand_tree := expand_feature_tree
				class_text := features_tool.current_compiled_class.text
				if not features_tool.current_compiled_class.has_feature_table then
						--| We cannot rely on feature calls on Void targets: they corrupt memory.
					raise ("No feature table")
				end
				if class_text /= Void then
					from 
						fcl.start
					until
						fcl.after
					loop
						if fcl.item = Void then
							raise ("Void feature clause")
						end
						features := fcl.item.features
						name := fcl.item.comment (class_text)
						name.right_adjust
						tree_item := build_tree_folder (name, features)
						if fcl.item.export_status.is_none then
							tree_item.set_pixmap (Pixmaps.Icon_feature_clause_none)
						elseif fcl.item.export_status.is_set then
							tree_item.set_pixmap (Pixmaps.Icon_feature_clause_some)
						else
							tree_item.set_pixmap (Pixmaps.Icon_feature_clause_any)
						end
						if is_clickable then
							tree_item.select_actions.extend (agent features_tool.go_to_clause (fcl.item))
						end
						extend (tree_item)
						if
							expand_tree and then
							tree_item.is_expandable
						then
							tree_item.expand
						end
						fcl.forth
					end
					if fcl.is_empty then
							-- Display a message not to confuse the user.
						extend (create {EV_TREE_ITEM}.make_with_text (Warning_messages.w_No_feature_to_display))
					end
				elseif features_tool.current_compiled_class.cluster.is_precompiled then
					from 
						fcl.start
					until
						fcl.after
					loop
						if fcl.item = Void then
							raise ("Void feature clause")
						end
						features := fcl.item.features
						tree_item := build_tree_folder (" ", features)
						if fcl.item.export_status.is_none then
							tree_item.set_pixmap (Pixmaps.Icon_feature_clause_none)
						elseif fcl.item.export_status.is_set then
							tree_item.set_pixmap (Pixmaps.Icon_feature_clause_some)
						else
							tree_item.set_pixmap (Pixmaps.Icon_feature_clause_any)
						end
						if is_clickable then
							tree_item.select_actions.extend (agent features_tool.go_to_clause (fcl.item))
						end
						extend (tree_item)
						if
							expand_tree and then
							tree_item.is_expandable
						then
							tree_item.expand
						end
						fcl.forth
					end
					if fcl.is_empty then
							-- Display a message not to confuse the user.
						extend (create {EV_TREE_ITEM}.make_with_text (Warning_messages.w_No_feature_to_display))
					end
				else
					wipe_out
					extend (create {EV_TREE_ITEM}.make_with_text (Warning_messages.w_Cannot_read_file (features_tool.current_compiled_class.file_name)))
				end
			else
				wipe_out
				extend (create {EV_TREE_ITEM}.make_with_text (Interface_names.l_Compile_first))
			end
		rescue
			retried := True
			retry
		end

feature {NONE} -- Implementation

	features_tool: EB_FEATURES_TOOL
			-- Associated features tool.

	build_tree_folder (n: STRING; fl: EIFFEL_LIST [FEATURE_AS]): EV_TREE_ITEM is
			-- Build the tree node corresponding to feature clause named `n'.
		local
			tree_item: EV_TREE_ITEM
			ef: E_FEATURE
			st: FEATURE_STONE
		do
			create Result
			if
				n /= Void and then
				not n.is_equal ("")
			then
				Result.set_text (n)
			else
				Result.set_text (Interface_names.l_No_feature_group_clause)
			end
			from
				fl.start
			until
				fl.after
			loop
				if fl.item = Void then
					raise ("Void feature")
				end
				create tree_item
				tree_item.set_text (fl.item.feature_name)
				if is_clickable then
					tree_item.select_actions.extend (features_tool~go_to (fl.item))
				end
				ef := features_tool.current_compiled_class.feature_with_name (fl.item.feature_name)
				if ef = Void then
					raise ("Void feature")
				end
				
				if ef.is_deferred then
					tree_item.set_pixmap (Pixmaps.Icon_deferred_feature)
				elseif ef.is_once or ef.is_constant then
					tree_item.set_pixmap (Pixmaps.Icon_once_objects)
				elseif ef.is_attribute then
					tree_item.set_pixmap (Pixmaps.Icon_attributes)
				elseif ef.is_external then
					tree_item.set_pixmap (Pixmaps.Icon_external_feature)
				else
					tree_item.set_pixmap (Pixmaps.Icon_feature @ 1)
				end
				create st.make (ef)
				tree_item.set_pebble (st)
				tree_item.set_accept_cursor (st.stone_cursor)
				tree_item.set_deny_cursor (st.X_stone_cursor)
				Result.extend (tree_item)
				fl.forth
			end			
		end			

end -- class EB_FEATURES_TREE


