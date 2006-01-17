indexing
	description: "Formatting context for .NET feature."
	legal: "See notice at end of class."
	status: "See notice at end of class."
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
			{DOTNET_CLASS_AS, DOTNET_CLASS_CONTEXT} name_of_current_feature
		redefine
			initialize
		end
	
	SHARED_NAMES_HEAP
		export
			{NONE} all
		end

create
	make,
	make_from_entity

feature {NONE} -- Initialization

	make (a_feature: E_FEATURE; c: CONSUMED_TYPE) is
			-- Initialize Current with feature 'a_feature'
		require
			a_feature_not_void: a_feature /= Void
			c_not_void: c /= Void
		local
			l_feat: E_FEATURE
			l_class: CLASS_C
			l_rout_id_set: ROUT_ID_SET
			i, nb: INTEGER
		do
			class_i ?= a_feature.associated_class.lace_class
			if class_i /= Void then
				class_c ?= class_i.compiled_class
			end
			l_class := a_feature.written_class
			if l_class /= Void and then l_class.has_feature_table then
				l_rout_id_set := a_feature.rout_id_set
				from
					i := l_rout_id_set.lower
					nb := i + l_rout_id_set.count - 1
				until
					i > nb or l_feat /= Void
				loop
					l_feat := l_class.feature_with_rout_id (l_rout_id_set.item (i))
					i := i + 1
				end
			end
			if l_feat = Void then
				l_feat := a_feature
			end
			format_make (c)
			current_feature := feature_from_type (c, l_feat)
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
			-- Initialization.
		local
			retried: BOOLEAN
		do
			if not retried and then current_feature /= Void then
				Precursor {DOTNET_FORMAT_CONTEXT}
				declared_type := current_feature.declared_type
				name_of_current_feature := current_feature.eiffel_name.twin
				dotnet_name_of_current_feature := current_feature.dotnet_eiffel_name.twin
				create ast.make (current_feature)
				is_valid := True
			else
				is_valid := False
			end
		rescue
			retried := True
			retry		
		end

feature -- Property

	current_feature: CONSUMED_ENTITY
			-- Current feature.

feature {NONE} -- Property

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

	use_dotnet_name_only: BOOLEAN
			-- Only display the .NET name of the feature
			-- Used for Eiffel ENViSioN!

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
				execution_error := False
				ast.format (Current)				
				System.set_current_class (prev_class)
				Inst_context.set_cluster (prev_cluster)
			end
		end

feature -- Element change

	set_use_dotnet_name_only is
			-- Set `use_dotnet_name_only' to True
		do
			use_dotnet_name_only := True
		end
		
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
			l_is_str: BOOLEAN
		do
			begin
			new_expression
			set_separator (ti_comma)
			text.add_new_line
			text.add_indent

				-- Put either `frozen, deferred, infix or prefix'.
			put_feature_qualification

			l_is_str := current_feature.is_infix or current_feature.is_prefix
			if
				class_c /= Void and then class_c.has_feature_table and then
				class_c.feature_table.has (name_of_current_feature)
			then
				-- Feature should be clickable
				l_feature ?= class_c.feature_table.item (name_of_current_feature).
					api_feature (class_c.class_id)
			end		
			if l_is_str then
				text.add_string ("%"")
			end
			if l_feature /= Void then
				text.add_feature (l_feature, dotnet_name_of_current_feature)
				if l_is_str then
					text.add_string ("%"")
				end
				if
					not use_dotnet_name_only and
					not dotnet_name_of_current_feature.is_equal (name_of_current_feature)
				then				
					text.add_char (',')
					text.add_new_line
					text.add_indent
					put_feature_qualification
					text.add_feature (l_feature, name_of_current_feature)
				end
			else
				create {LOCAL_TEXT} l_txt.make (dotnet_name_of_current_feature)
				text.add (l_txt)
				if l_is_str then
					text.add_string ("%"")
				end
				if
					not use_dotnet_name_only and
					not dotnet_name_of_current_feature.is_equal (name_of_current_feature)
				then				
					text.add_char (',')
					text.add_new_line
					text.add_indent
					put_feature_qualification
					text.add (create {LOCAL_TEXT}.make (name_of_current_feature))
				end
			end
			put_signature
			put_comments
		end

feature {NONE} -- Element Change

	put_feature_qualification is
			-- Put current feature qualification: frozen, deferred, infix or prefix.
		require
			text_not_void: text /= Void
		do
			if current_feature.is_frozen then
					-- Check if feature is frozen.
				text.add (Ti_frozen_keyword)
				text.add_space
			end
			if current_feature.is_deferred then
					-- Check if feature is deferred.
				text.add (Ti_deferred_keyword)
				text.add_space
			end
			if current_feature.is_infix then
					-- Check if feature is infix.
				text.add (Ti_infix_keyword)
				text.add_space
			elseif current_feature.is_prefix then
					-- Check if feature is prefix.
				text.add (Ti_prefix_keyword)
				text.add_space
			end
		end

	put_signature is
			-- Feature signature
		local
			l_c_arg: CONSUMED_ARGUMENT
			l_c_class: CLASS_I
			l_cnt,
			l_char_count: INTEGER
			l_ext: EXTERNAL_CLASS_C
			l_type_a: CL_TYPE_A
		do
			if not (arguments = Void or arguments.is_empty) then
				begin
				set_separator (ti_comma)
				set_space_between_tokens
				text.add_space
				text.add (ti_l_parenthesis)
				abort_on_failure
				l_char_count := name_of_current_feature.count + 8
				from
					l_cnt := 1
				until
					l_cnt > arguments.count
				loop
					l_c_arg := arguments.item (l_cnt)
					l_c_class := class_i.type_from_consumed_type (l_c_arg.type)
					
					if not use_dotnet_name_only and l_char_count > 60 then
						text.add_new_line
						text.add_indents (4)
						l_char_count := 0
					end
					text.add (create {LOCAL_TEXT}.make (l_c_arg.eiffel_name))
					text.add_char (':')
					text.add_space
					
					if class_i.is_compiled then
						l_ext ?= class_i.compiled_class
						l_type_a := l_ext.type_from_consumed_type (l_c_arg.type)
						l_type_a.format (Current)
					else
						text.add_class (l_c_class)
					end				
					
					if l_cnt < arguments.count then
						text.add_char (';')
						text.add_space
					end
					
					l_char_count := l_char_count + l_c_arg.eiffel_name.count + 2 +
						l_c_class.name.count
					l_ext := Void
					l_cnt := l_cnt + 1
				end
				text.add (ti_r_parenthesis)
			end
				-- Feature return type, if any
			if return_type /= Void then
				text.add_char (':')
				text.add_space
				l_c_class := class_i.type_from_consumed_type (return_type)
				if 	class_i.is_compiled then
					l_ext ?= class_i.compiled_class
					l_type_a := l_ext.type_from_consumed_type (return_type)
					l_type_a.format (Current)
				else
					text.add_class (l_c_class)
				end
			end
		end
		
	put_comments is
			-- Feature comments from XML.
		local
			l_member_info: MEMBER_INFORMATION
			l_parameter_information: ARRAYED_LIST [PARAMETER_INFORMATION]
			l_parsed_arguments, l_namespace_name, l_dotnet_name: STRING
			l_constructor: CONSUMED_CONSTRUCTOR
			l_summary, l_return_info: ARRAYED_LIST [STRING]
			l_c_arg: CONSUMED_ARGUMENT
			l_cnt: INTEGER
			l_id: INTEGER
			l_overloaded_names: HASH_TABLE [ARRAYED_LIST [INTEGER], INTEGER]
		do
			create l_parsed_arguments.make_empty
			l_constructor ?= current_feature
			
			if l_constructor /= Void then
					-- Feature is a constructor so add constructor suffix.
				l_parsed_arguments.append ("#ctor")
			end
			
			if arguments /= Void then
					-- Feature has arguments so append to 'l_parsed_arguments'.
				from
					l_cnt := 1
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
			elseif l_parsed_arguments.is_empty then
				create l_parsed_arguments.make_empty
			end
			
			if is_inherited then
					-- Retrieve .NET member name depending upon if inherited.	
				l_namespace_name := class_i.type_from_consumed_type (declared_type).external_name
			else
				l_namespace_name := consumed_t.dotnet_name
			end
			
			if l_constructor /= Void then
					-- Return constructor member type information.
				l_member_info := assembly_info.find_feature (assembly_name, l_namespace_name, l_parsed_arguments)
			else
				if current_feature.is_property_or_event then
						-- Return property or event member type information.
					l_dotnet_name := parsed_entity_string (current_feature.dotnet_name)
					l_member_info := assembly_info.find_feature (assembly_name, l_namespace_name, l_dotnet_name)
				else
						-- Return any other member type information.
					l_dotnet_name := current_feature.dotnet_name
					l_member_info := assembly_info.find_feature (assembly_name, l_namespace_name, l_dotnet_name + l_parsed_arguments)
				end	
			end
			
			-- Tell if feature is overloaded and or static
			if class_c /= Void and then class_c.has_feature_table then
				l_overloaded_names := class_c.feature_table.overloaded_names
				if l_overloaded_names /= Void then
					l_id := names_heap.id_of (current_feature.dotnet_eiffel_name)
					if l_id > 0 then
						l_overloaded_names.search (l_id)
						if l_overloaded_names.found then
							text.add_new_line
							text.add_indents (3)
							text.add_comment ("-- (+")
							l_cnt := l_overloaded_names.found_item.count - 1
							text.add_comment (l_cnt.out)
							if l_cnt > 1 then
								text.add_comment (" overloads")
							else
								text.add_comment (" overload")
							end
							if current_feature.is_static then
								text.add_comment (", static)")
							else
								text.add_comment (")")
							end
						end
					end
				end
			end
			if (class_c = Void or l_overloaded_names = Void or else not l_overloaded_names.found) and current_feature.is_static then
				text.add_new_line
				text.add_indents (3)
				text.add_comment ("-- (static)")
			end

			put_origin_comment

			if l_member_info /= Void then
					-- Write returned member type information to class/feature text.
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
					put_argument_comments (l_parameter_information)
				end	
	
				l_return_info := parse_summary (l_member_info.returns)
				if not l_return_info.is_empty then
						-- Return Type comments.	
					text.add_new_line
					text.add_indents (3)
					text.add_comment ("-- ")
					text.add_new_line
					text.add_indents (3)
					text.add_comment ("-- Return:")
					from
						l_return_info.start
					until
						l_return_info.after
					loop
						text.add_new_line
						text.add_indents (3)
						text.add_comment ("-- ")
						text.add_indents (1)
						text.add_comment (l_return_info.item)
						l_return_info.forth
					end
				end
				put_new_line
			else
				text.add_new_line
				text.add_indents (3)
				text.add_comment ("-- ")
				text.add_comment ("Description unavailable.")
				put_new_line
			end
		end
	
	put_origin_comment is
			-- Put the 'from (CLASS)' if feature is declared in ancestor where 'CLASS' is
			-- ancestor class.
		do
			if is_inherited then
				text.add_new_line
				text.add_indents (3)
				text.add_comment ("-- (from ")
				text.add_class (class_i.type_from_consumed_type (declared_type))
				text.add_char (')')
			end
		end		
	
	put_argument_comments (a_param_info: ARRAYED_LIST [PARAMETER_INFORMATION]) is
			-- Put the parameter information comments in the feature documentation.
		require
			param_info_not_void: a_param_info /= Void
		local
			l_summary: ARRAYED_LIST [STRING]
			l_next_line: BOOLEAN
			l_max_count: INTEGER
			l_string: STRING
		do
			text.add_new_line
			text.add_indents (3)
			text.add_comment ("--")
			text.add_new_line
			text.add_indents (3)
			if a_param_info.count > 1 then
				text.add_comment ("-- Arguments:")
			else
				text.add_comment ("-- Argument:")			
			end
			l_max_count := max_length (a_param_info)
			from
				a_param_info.start
			until
				a_param_info.after
			loop
				text.add_new_line
				text.add_indents (3)
				text.add_comment ("-- ")
				text.add_indents (1)
				create l_string.make_from_string (a_param_info.item.name)
				l_string.prune_all_leading (' ')
				text.add_comment (l_string + ": ")

				l_summary := parse_summary (a_param_info.item.description)
				from
					l_summary.start
				until
					l_summary.after
				loop
					if l_next_line then
						create l_string.make (l_max_count + 1)
						l_string.fill_character (' ')
						text.add_new_line
						text.add_indents (3)
						text.add_comment ("-- ")
						text.add_indents (1)
						text.add_string (l_string)
					else
						if (l_max_count - a_param_info.item.name.count > 0) then
							create l_string.make_filled (' ', l_max_count - a_param_info.item.name.count)
							text.add_string (l_string)
						end
						l_next_line := not l_next_line
					end
					text.add_comment (l_summary.item)
					l_summary.forth
				end

				l_next_line := False
				a_param_info.forth
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
			ensure
				parse_summary_not_void: Result /= Void
				has_an_element: not a_summary.is_empty implies not Result.is_empty
			end

	parsed_entity_string (a_string: STRING): STRING is
			-- Parse 'a_string' for property or event to return correct .NET string.
		require
			string_not_void: a_string /= Void
		do
			Result := a_string.substring (a_string.index_of ('_', 1) + 1, a_string.count)	
		end

	feature_from_type (a_consumed_type: CONSUMED_TYPE; a_feature: E_FEATURE): CONSUMED_ENTITY is
			-- Given consumed 'a_type' and Eiffel 'a_feature' return consumed feature.
		require
			a_consumed_type_not_void: a_consumed_type /= Void
			a_feature_not_void: a_feature /= Void
		local
			l_entities: ARRAYED_LIST [CONSUMED_ENTITY]
		do
			l_entities := a_consumed_type.flat_entities
			from 
				l_entities.start
			until
				l_entities.after or Result /= Void
			loop
				if l_entities.item.eiffel_name.is_equal (a_feature.name) then
					Result := l_entities.item
				end
				l_entities.forth
			end
			if Result = Void then
				Result := event_or_property_feature_from_type (a_consumed_type, a_feature)
			end
			if Result = Void then
				Result := creation_routine_from_type (a_consumed_type, a_feature)
			end
		end
		
	creation_routine_from_type (a_consumed_type: CONSUMED_TYPE; a_feature: E_FEATURE): CONSUMED_ENTITY is
			-- Given consumed 'a_type' and Eiffel 'a_feature' return consumed constructor.
		require
			a_consumed_type_not_void: a_consumed_type /= Void
			a_feature_not_void: a_feature /= Void
		local
			l_constructors: ARRAY [CONSUMED_CONSTRUCTOR]
			i, l_count: INTEGER
			l_found: BOOLEAN
		do
			l_constructors := a_consumed_type.constructors
			if l_constructors /= Void then
				from
					i := 1
					l_count := l_constructors.count
				until
					i > l_count or l_found
				loop
					Result := l_constructors.item (i)
					l_found := Result.eiffel_name.is_equal (a_feature.name)
					i := i + 1
				end
				if not l_found then
					Result := Void
				end
			end
		end

	event_or_property_feature_from_type (a_consumed_type: CONSUMED_TYPE; a_feature: E_FEATURE): CONSUMED_ENTITY is
			-- Given consumed 'a_type' and Eiffel 'a_feature' return consumed feature.
		require
			a_consumed_type_not_void: a_consumed_type /= Void
			a_feature_not_void: a_feature /= Void
		local
			l_properties: ARRAY [CONSUMED_PROPERTY]
			l_events: ARRAY [CONSUMED_EVENT]
			l_counter: INTEGER
		do
			l_properties := a_consumed_type.properties
			if l_properties /= Void then
				from 
					l_counter := 1
				until
					l_counter > l_properties.count or Result /= Void
				loop
					if 	
						l_properties.item (l_counter).getter /= Void and 
						l_properties.item (l_counter).getter.eiffel_name.is_equal (a_feature.name) 
					then
						Result := l_properties.item (l_counter).getter
					elseif
						l_properties.item (l_counter).setter /= Void and 
						l_properties.item (l_counter).setter.eiffel_name.is_equal (a_feature.name) 
					then
						Result := l_properties.item (l_counter).setter
					end
					l_counter := l_counter + 1
				end
			end
			if Result = Void then
				l_events := a_consumed_type.events
				if l_events /= Void then
					from
						l_counter := 1
					until
						l_counter > l_events.count or Result /= Void
					loop
						if
							l_events.item (l_counter).adder /= Void and
							l_events.item (l_counter).adder.eiffel_name.is_equal (a_feature.name)
						then
							Result := l_events.item (l_counter).adder
						elseif
							l_events.item (l_counter).remover /= Void and
							l_events.item (l_counter).remover.eiffel_name.is_equal (a_feature.name)
						then
							Result := l_events.item (l_counter).remover
						elseif
							l_events.item (l_counter).raiser /= Void and
							l_events.item (l_counter).raiser.eiffel_name.is_equal (a_feature.name)
						then
							Result := l_events.item (l_counter).raiser
						end
						l_counter := l_counter + 1
					end
				end
			end
		end

feature {NONE} -- Implementation

	max_length (a_list: ARRAYED_LIST [PARAMETER_INFORMATION]): INTEGER is
			-- Get the count of the longest argument string in 'a_list'
		require
			a_list_not_void: a_list /= Void
		local
			l_max: INTEGER
		do
			from 
			 	a_list.start
			until
				a_list.after
			loop
				if a_list.item.name.count > l_max then
					l_max := a_list.item.name.count
				end
				a_list.forth
			end
			Result := l_max
		end

	Maximum_line_count: INTEGER is 70
			-- Number of characters after which we should stop displaying
			-- remaining characters of a string on same line.

invariant
	has_eiffel_class: class_i /= Void
	has_consumed_type: consumed_t /= Void
	do_flat: not is_short

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end -- class DOTNET_FEATURE_CONTEXT
