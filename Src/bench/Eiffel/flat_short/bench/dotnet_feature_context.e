indexing
	description: "Formatting context for .NET feature."
	date: "$Date$"
	revision: "$1.0 $"
	
class
	DOTNET_FEATURE_CONTEXT

inherit
	DOTNET_FORMAT_CONTEXT
		rename
			make as format_make,
			execute as old_execute,
			arguments as old_arguments,
			prepare_for_feature as old_prepare_for_feature,
			put_normal_feature as old_put_normal_feature,
			put_comments as old_put_comments,
			put_origin_comment as old_put_origin_comment
		export
			{DOTNET_CLASS_AS} name_of_current_feature	
		redefine
			initialize
		end
		
	IL_ENVIRONMENT
		export
			{NONE} all
		end

creation
	make,
	make_from_entity

feature -- Initialization

	make (a_feature: E_FEATURE; c: CONSUMED_TYPE) is
			-- Initialize Current with feature 'a_feature'
		require
			a_feature_not_void: a_feature /= Void
			c_not_void: c /= Void
		local
			l_c_class: CLASS_C
		do
			class_i ?= a_feature.associated_class.lace_class
			if class_i /= Void then
				class_c ?= class_i.compiled_class				
			end
			format_make (c)
			current_feature := feature_from_type (c, a_feature)
			set_assembly_name
			initialize
		ensure
			has_eiffel_class: class_i /= Void
		end
		
	make_from_entity (a_entity: CONSUMED_ENTITY; c: CONSUMED_TYPE; a_ci: CLASS_I) is
			-- Initialize Current from .NET feature entity 'a_entity'.
		require
			a_entity_not_void: a_entity /= Void
			c_not_void: c /= Void
			a_ci_not_void: a_ci /= Void
		do
			class_i ?= a_ci
			if class_i /= Void then
				class_c ?= class_i.compiled_class				
			end
			format_make (c)
			current_feature := a_entity
			set_assembly_name
			initialize
		end

	initialize is
			-- Initialization
		require else
			has_current_feature: current_feature /= Void
		local
			retried: BOOLEAN
		do
			if not retried then
				Precursor
				declared_type := current_feature.declared_type
				name_of_current_feature := clone (current_feature.eiffel_name)
				create ast.make (current_feature)
				is_valid := True
			else
				is_valid := False
			end
		ensure then
			has_ast: ast /= Void
		rescue
			retried := True
			retry		
		end

feature -- Property

	current_feature: CONSUMED_ENTITY
			-- Current feature.

	declared_type: CONSUMED_REFERENCED_TYPE
			-- The type in which 'current_feature' was declared.

	arguments: ARRAY [CONSUMED_ARGUMENT]
			-- The arguments for the feature being formatted.
			
	return_type: CONSUMED_REFERENCED_TYPE
			-- Return value of feature.

	ast: DOTNET_FEATURE_AS
			-- .NET feature ast.

	is_valid: BOOLEAN
			-- Does Current contain valid feature to format?

feature -- Status Report

	is_inherited: BOOLEAN is
			-- Is 'current_feature' inherited?
		do
			Result := not declared_type.name.is_equal (consumed_t.dotnet_name)
		end

feature -- Execution

	execute is
			-- Format consumed type.
		local
			prev_class: CLASS_C
			prev_cluster: CLUSTER_I
		do
			if is_valid then
				prev_class := System.current_class
				prev_cluster := Inst_context.cluster
				execution_error := false
				ast.format (Current)				
			end
			System.set_current_class (prev_class)
			Inst_context.set_cluster (prev_cluster)
		end

feature -- Element change

	prepare_for_feature (a_dn_entity: CONSUMED_ENTITY) is
			-- Prepare for formatting of feature found in 'dn_entity'.
		require
			entity_not_void: a_dn_entity /= Void
		do
			current_feature := a_dn_entity
			if a_dn_entity.has_arguments then
				arguments := a_dn_entity.arguments
			elseif arguments /= Void then
				arguments := Void
			end
			if a_dn_entity.has_return_value then
				return_type := a_dn_entity.return_type
			elseif return_type /= Void then
				return_type := Void
			end
			declared_type := a_dn_entity.declared_type
		ensure
			current_feature_not_void: current_feature /= Void
			declared_type_not_void: declared_type /= Void
		end
		
	put_normal_feature is
			-- Format feature
		local
			l_txt: BASIC_TEXT
			l_feature: E_FEATURE
		do
			begin
			new_expression
			set_separator (ti_comma)					
			-- Feature name
			if class_c /= Void then
				-- Feature should be clickable	
				l_feature := class_c.feature_table.item (name_of_current_feature).api_feature (class_c.class_id)
				text.add_new_line
				text.add_indent
				text.add_feature (l_feature, name_of_current_feature)
			else
				l_txt := create {LOCAL_TEXT}.make (name_of_current_feature)
				text.add_new_line
				text.add_indent
				text.add (l_txt)
			end			
			put_signature
			put_comments
		end		

	put_signature is
			-- Feature signature
		local
			l_c_arg: CONSUMED_ARGUMENT
			l_cnt: INTEGER
		do
			if not (arguments = Void or arguments.is_empty) then
				begin
				set_separator (ti_comma)
				set_space_between_tokens
				text.add_space
				text.add (ti_l_parenthesis)
				abort_on_failure
				from
					l_cnt := 1
				until
					l_cnt > arguments.count
				loop
					l_c_arg := arguments.item (l_cnt)
					text.add (create {LOCAL_TEXT}.make (l_c_arg.eiffel_name) )
					text.add_char (':')
					text.add_space
					text.add_class (class_i.type_from_consumed_type (l_c_arg.type))
					if l_cnt < arguments.count then
						text.add_char (';')
						text.add_space
					end
					l_cnt := l_cnt + 1
				end
				text.add (ti_r_parenthesis)
			end
			-- Feature return type, if any
			if return_type /= Void then
				text.add_char (':')
				text.add_space
				text.add_class (class_i.type_from_consumed_type (return_type))
			end
		end
		
	put_comments is
			-- Feature comments from XML
		local
			l_member_info: MEMBER_INFORMATION
			l_parameter_information: LINKED_LIST [PARAMETER_INFORMATION]
			l_parsed_arguments, l_namespace_name: STRING
			l_constructor: CONSUMED_CONSTRUCTOR
			l_summary, l_return_info: ARRAYED_LIST [STRING]
			l_c_arg: CONSUMED_ARGUMENT
			l_cnt: INTEGER
		do
			-- Retrieve feature comments for feature
			if arguments /= Void then
				from
					l_cnt := 1
					create l_parsed_arguments.make_empty
					l_constructor ?= current_feature
					if l_constructor /= Void then
						l_parsed_arguments.append ("#ctor")
					end
					if arguments.count > 0 then
						l_parsed_arguments.extend ('(')
					end
				until
					l_cnt > arguments.count
				loop
					l_c_arg := arguments.item (l_cnt)
					l_parsed_arguments.append (l_c_arg.type.name)
					if l_cnt < arguments.count then
						l_parsed_arguments.extend (',')
					end
					if l_cnt = arguments.count then
						l_parsed_arguments.extend (')')
					end
					l_cnt := l_cnt + 1
				end
			else
				create l_parsed_arguments.make_empty
			end
			
			if not is_inherited then
				l_namespace_name := class_i.type_from_consumed_type (declared_type).external_name
			else
				l_namespace_name := consumed_t.dotnet_name
			end
			
			if l_constructor /= void then
				l_member_info := assembly_info.find_feature (l_namespace_name, l_parsed_arguments)
			else
				l_member_info := assembly_info.find_feature (l_namespace_name, current_feature.dotnet_name + l_parsed_arguments)
			end
			
			if l_member_info /= Void then
				l_summary := parse_summary (l_member_info.summary)
				from
					l_summary.start
				until
					l_summary.after
				loop
					text.add_new_line
					text.add_indents (3)
					text.add_comment ("-- ")
					text.add_comment (l_summary.item)		
					l_summary.forth
				end
				
				-- Arguments comments.
				
				l_parameter_information := l_member_info.parameters
				if not l_parameter_information.is_empty then
					text.add_new_line
					text.add_new_line
					text.add_indents (3)
					text.add_comment ("-- Argument Information ")
					text.add_new_line
					text.add_indents (3)
					text.add_comment ("-- -------------------- ")
					from
						l_parameter_information.start
					until
						l_parameter_information.after
					loop
						text.add_new_line
						text.add_indents (3)
						text.add_comment ("-- ")
						text.add_comment (l_parameter_information.item.name + ": ")		
						text.add_comment (l_parameter_information.item.description)	
						l_parameter_information.forth
					end
					new_line
				else
					new_line
				end
	
				l_return_info := parse_summary (l_member_info.returns)
				if not l_return_info.is_empty then
								-- Return Type comments.	
--					text.add_new_line
					text.add_new_line
					text.add_indents (3)
					text.add_comment ("-- Return Type Information")
					text.add_new_line
					text.add_indents (3)
					text.add_comment ("-- -----------------------")
					from
						l_return_info.start
					until
						l_return_info.after
					loop
						text.add_new_line
						text.add_indents (3)
						text.add_comment ("-- ")
						text.add_comment (l_return_info.item)
						l_return_info.forth
					end
					new_line
				end
			else 
				new_line
			end
			put_origin_comment
		end
	
	put_origin_comment is
			-- Put the 'from CLASS' if feature is declared in ancestor.
		do
			-- Check if feature is inherited, if display inherited class name
			if is_inherited then
--				text.add_new_line
				text.add_indents (3)
				text.add_comment ("-- from (")
				text.add_class (class_i.type_from_consumed_type (declared_type))
				text.add_char (')')
				new_line
			end
		end		
		
	parse_summary (a_summary: STRING): ARRAYED_LIST [STRING] is
				-- Strip 'a_summary' of all unwanted whites space
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
					l_space_index := l_temp_string.index_of (' ', 50)
					if l_space_index /= 0 then
						Result.extend (l_temp_string.substring (1, l_space_index))
						l_temp_string := l_temp_string.substring (l_space_index, l_temp_string.count)
						l_temp_string.prune_all_leading (' ')
					end
					l_counter := l_counter + 1
				end
				if not l_temp_string.is_empty then
					Result.extend (l_temp_string)
				end			
			end

	feature_from_type (a_consumed_type: CONSUMED_TYPE; a_feature: E_FEATURE): CONSUMED_ENTITY is
			-- Given consumed 'a_type' and Eiffel 'a_feature' return consumed feature.
		require
			a_consumed_type_not_void: a_consumed_type /= Void
			a_feature_not_void: a_feature /= Void
		local
			l_entities: ARRAYED_LIST [CONSUMED_ENTITY]
		do
			l_entities := a_consumed_type.entities
			from 
				l_entities.start
			until
				l_entities.after
			loop
				if l_entities.item.eiffel_name.is_equal (a_feature.name) then
					Result := l_entities.item
				end
				l_entities.forth
			end
		end

invariant
	has_eiffel_class: class_i /= Void
	has_consumed_type: consumed_t /= Void
	do_flat: not is_short

end -- class DOTNET_FEATURE_CONTEXT
