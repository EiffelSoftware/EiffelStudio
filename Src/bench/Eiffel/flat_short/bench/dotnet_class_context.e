indexing
	description: "Formatting context for dotnet class ast (flat short format)."
	date: "$Date$"
	revision: "$1.0 $"

class DOTNET_CLASS_CONTEXT

inherit
	DOTNET_FORMAT_CONTEXT
		rename
			make as format_make,
			execute as old_execute,
			arguments as old_arguments
		export
			{DOTNET_CLASS_AS} name_of_current_feature	
		end
		
	EB_WINDOW_MANAGER
		rename
			make as win_manager_make
		export 
			{NONE} all 
		end

create
	make

feature {NONE} -- Initialization

	make (a_consumed_type: CONSUMED_TYPE; a_classi: CLASS_I; a_flag: BOOLEAN) is
			-- Initialize Current.  'a_flag' determines short or flat short.
		require
			consume_type_not_void: a_consumed_type /= Void
			classi_not_void: a_classi /= Void
		do
			class_i ?= a_classi
			class_c ?= a_classi.compiled_class
			format_make (a_consumed_type)
			create ast.make (a_consumed_type, a_flag, class_i)
			initialize
		ensure
			analyze_ancestors: not current_class_only
			class_i_set: class_i = a_classi
			class_c_set: class_c = Void or else class_c = a_classi.compiled_class
			ast_not_void: ast /= Void
		end

feature -- Execution

	execute is
			-- Format consumed type.
		local
			prev_class: CLASS_C
			prev_cluster: CLUSTER_I
		do
			if not rescued then
				prev_class := System.current_class
				prev_cluster := Inst_context.cluster
				execution_error := False
				class_name := consumed_t.eiffel_name.as_upper
				
				if current_class_only then
					ast.set_current_class_only (True)
				end
				
				ast.format (Current)
			else
				Rescue_status.set_is_error_exception (False)
				Error_handler.trace
				execution_error := True
				rescued := False
			end
			System.set_current_class (prev_class)
			Inst_context.set_cluster (prev_cluster)
		end

feature -- Element change

	format_feature (a_ctxt: DOTNET_CLASS_CONTEXT; a_dn_entity: CONSUMED_ENTITY) is
			-- Format feature found in 'dn_entity'
		require
			a_entity_not_void: a_dn_entity /= Void
		local
			ftxt: DOTNET_FEATURE_CONTEXT
			l_feature: E_FEATURE
			l_dev_win: EB_DEVELOPMENT_WINDOW
			l_featurei: FEATURE_I
		do
			create ftxt.make_from_entity (a_dn_entity, consumed_t, class_i)
			ftxt.prepare_for_feature (a_dn_entity)
			if not (current_class_only and ftxt.is_inherited) then
				ftxt.put_normal_feature
				if ftxt.class_c /= Void then
						-- Is compiled class so we can make feature clickable and scrollable.
					l_dev_win := Window_manager.last_focused_development_window
					if l_dev_win /= Void then
						l_featurei ?= ftxt.class_c.feature_table.item (ftxt.name_of_current_feature)
						if l_featurei = Void then
								-- Do a check for an infix feature.
							l_featurei ?= ftxt.class_c.feature_table.item ("infix %"" + ftxt.name_of_current_feature + "%"")
						end
						if l_featurei = Void then
								-- Do a check for an prefix feature.
							l_featurei ?= ftxt.class_c.feature_table.item ("prefix %"" + ftxt.name_of_current_feature + "%"")
						end
						if l_featurei /= Void then
							l_feature ?= l_featurei.api_feature (ftxt.class_c.class_id)
						end
						if l_feature /= Void then
							if l_dev_win.feature_positions.has (l_feature) then
								l_dev_win.feature_positions.replace (a_ctxt.text.position, l_feature)
							else
								l_dev_win.feature_positions.put (a_ctxt.text.position, l_feature)
							end
						end
					end
				end
				from
					ftxt.text.start
				until
					ftxt.text.after
				loop
					put_text_item (ftxt.text.item)
					ftxt.text.forth
				end
			end			
		end
		
	parse_summary (a_summary: STRING): ARRAYED_LIST [STRING] is
				-- Strip 'a_summary' of all unwanted whites space
			require
				a_summary_not_void: a_summary /= Void
			local
				l_num_new_lines,
				l_space_index,
				l_counter: INTEGER
				l_temp_string: STRING
			do
				l_num_new_lines := a_summary.count // 40
				strip_down (a_summary)
				create Result.make (1)
				from
					l_counter := 1
					l_temp_string := a_summary
				until
					l_counter > l_num_new_lines
				loop
					if not l_temp_string.is_empty then
						l_space_index := l_temp_string.index_of (' ', l_temp_string.count.min (Maximum_line_count))
						if l_space_index /= 0 then
							Result.extend (l_temp_string.substring (1, l_space_index))
							l_temp_string := l_temp_string.substring (l_space_index, l_temp_string.count)
							l_temp_string.prune_all_leading (' ')
						end
					end
					l_counter := l_counter + 1
				end
				if not l_temp_string.is_empty then
					Result.extend (l_temp_string)
				end			
			end
			
feature {NONE} -- Implmentation
		
	ast: DOTNET_CLASS_AS
		-- .NET ast.
		
	Maximum_line_count: INTEGER is 70
		-- Numbers of characters after which we will go to a new line once the 
		-- next white space is found.
			
invariant
	analyze_ancestors: not current_class_only
	class_i_not_void: class_i /= Void
	class_c_set: class_c = Void or else class_c = class_i.compiled_class
	ast_not_void: ast /= Void

end	-- class DOTNET_CLASS_CONTEXT
