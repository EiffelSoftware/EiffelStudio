note
	description: "Controler of multi-branch instruction"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class INSPECT_CONTROL

inherit
	AST_NULL_VISITOR
		redefine
			process_static_access_as,
			process_id_as,
			process_char_as,
			process_integer_as
		end

	SHARED_STATELESS_VISITOR
		export
			{NONE} all
		end

	SHARED_ERROR_HANDLER
		export
			{NONE} all
		end

	SHARED_AST_CONTEXT
		export
			{NONE} all
		end

	COMPILER_EXPORTER
		export
			{NONE} all
		end

	SHARED_WORKBENCH
		export
			{NONE} all
		end

	CONF_CONSTANTS
		export
			{NONE} all
		end

	INTERNAL_COMPILER_STRING_EXPORTER
		export
			{NONE} all
		end

	SHARED_LOCALE
		export
			{NONE} all
		end

	FORMATTED_MESSAGE
		export
			{NONE} all
		end

create
	make

feature {NONE} -- Creation

	make (inspect_expression_type: TYPE_A)
			-- Create controller for inspect instruction with `inspect_expression_type'.
		require
			inspect_expression_type_not_void: inspect_expression_type /= Void
			valid_inspect_expression_type:
				inspect_expression_type.is_character or inspect_expression_type.is_integer or inspect_expression_type.is_natural or inspect_expression_type.is_enum or not inspect_expression_type.is_known
		do
			create unique_names.make
			create intervals.make
			type := inspect_expression_type
		ensure
			type_set: type = inspect_expression_type
			positive_value_set: positive_value = Void
			unique_names_set: unique_names /= Void and then unique_names.is_empty
			unique_constant_class_set: unique_constant_class = Void
			intervals_set: intervals /= Void and then intervals.is_empty
		end

feature -- Access

	type: TYPE_A
			-- Type of inspect expression

	last_interval_byte_node: INTERVAL_B
			-- Last byte node for interval (if any)

	is_inherited: BOOLEAN
			-- Is code being checked coming from an inherited routine?

feature {NONE} -- State

	positive_value: ATOMIC_AS
			-- One of the positive values found (error report)

	unique_names: LINKED_SET [STRING]
			-- Set of unique names already used

	unique_constant_class: CLASS_C
			-- Class for controling uniques

	last_unique_constant: UNIQUE_I
			-- Last unique constant (if any)

	last_inspect_value: INTERVAL_VAL_B
			-- Last byte node for inspect value (if any)

	intervals: SORTED_TWO_WAY_LIST [INTERVAL_B]
			-- Sorted list of intervals

feature -- Processing

	process_interval (interval: INTERVAL_AS; a_code_inherited: BOOLEAN)
			-- Check type validity of `interval' and make byte code available
			-- in `last_interval_byte_node' if possible.
		require
			type_not_void: type /= Void
			interval_not_void: interval /= Void
		local
			upper_as: ATOMIC_AS
			lower_bound: INTERVAL_VAL_B
			upper_bound: INTERVAL_VAL_B
			vomb3: VOMB3
			interval_byte_node: like last_interval_byte_node
		do
			is_inherited := a_code_inherited
			last_interval_byte_node := Void
			process_inspect_value (interval.lower)
			lower_bound := last_inspect_value
			upper_as := interval.upper
			if upper_as = Void then
				upper_bound := lower_bound
			else
				process_inspect_value (upper_as)
				upper_bound := last_inspect_value
			end
			if lower_bound /= Void and then upper_bound /= Void and then lower_bound <= upper_bound then
				interval_byte_node := lower_bound.inspect_interval (upper_bound)
				across
					intervals as i
				loop
					if not interval_byte_node.disjunction (i.item) then
							-- Intersecting intervals.
							-- Report error.
						create vomb3
						context.init_error (vomb3)
						vomb3.set_interval (interval_byte_node.intersection (i.item))
						vomb3.set_location (interval.end_location)
						Error_handler.insert_error (vomb3)
					end
				end
				intervals.extend (interval_byte_node)
			end
			last_interval_byte_node := interval_byte_node
		end

feature {STATIC_ACCESS_AS} -- Visitor

	process_static_access_as (l_as: STATIC_ACCESS_AS)
		local
			class_c: CLASS_C
			vuex: VUEX
			l_old_is_inherited: BOOLEAN
			is_once: BOOLEAN
		do
				-- Use `AST_FEATURE_CHECKER_GENERATOR' to properly type check the type of the static access
			l_old_is_inherited := feature_checker.is_inherited
			feature_checker.set_is_inherited (is_inherited)
			l_as.class_type.process (feature_checker)
			feature_checker.set_is_inherited (l_old_is_inherited)
			if attached feature_checker.last_type as l_last_type then
				if attached {FORMAL_A} l_last_type.actual_type as l_formal then
					if l_formal.is_multi_constrained (context.current_class) then
						error_handler.insert_error (create {NOT_SUPPORTED}.make
							(agent format_elements
								(?,
								locale.translation_in_context ("Multiple constraints are not supported in static access for {1} clause.", "compiler.error"),
								<<agent {TEXT_FORMATTER}.process_keyword_text ({TEXT_FORMATTER}.ti_when_keyword, Void)>>),
							context,
							l_as.start_location))
					else
						class_c := context.current_class.constrained_type (l_formal.position).base_class
					end
				else
					class_c := l_last_type.base_class
				end

				if class_c /= Void then
					if not attached class_c.feature_table.item_id (l_as.feature_name.name_id) as feature_i then
						report_veen (l_as.feature_name)
					else
						is_once := feature_i.is_once_creation (class_c)
						if
							not context.is_ignoring_export and then
							not (feature_i.is_exported_for (context.current_class) or else
							is_once and then class_c.creators [l_as.feature_name.name_id].is_exported_to (context.current_class))
						then
							create vuex
							context.init_error (vuex)
							vuex.set_static_class (class_c)
							vuex.set_exported_feature (feature_i)
							vuex.set_location (l_as.feature_name)
							error_handler.insert_error (vuex)
						elseif feature_i.is_valid_case (class_c, type) then
								-- Record dependencies.
							context.supplier_ids.extend_depend_unit_with_level (class_c.class_id, feature_i, 0)
								-- Check if this is a unique constant.
							last_unique_constant := {UNIQUE_I} / feature_i
								-- Calculate byte node.
							last_inspect_value := feature_i.case_value (class_c, type)
							if not is_inherited then
								feature_checker.set_is_inherited (False)
								feature_checker.check_obsolescence (feature_i, class_c, l_as.feature_name)
								feature_checker.set_is_inherited (l_old_is_inherited)
								feature_checker.set_routine_ids (feature_i.rout_id_set, l_as)
								l_as.set_class_id (class_c.class_id)
							end
						else
							report_vomb2 (l_as)
						end
					end
				end
			end
		end

feature {ID_AS} -- Visitor

	process_id_as (l_as: ID_AS)
		local
			feature_i: FEATURE_I
		do
			if is_inherited then
					-- Locate feature in ancestor. It is guaranteed we can find it, as otherwise
					-- it was not found in ancestor and the descendant class would therefore not be compiled.
				feature_i := context.written_class.feature_table.item_id (l_as.name_id)
				check feature_i_not_void: feature_i /= Void end
				feature_i := context.current_class.feature_of_rout_id (feature_i.rout_id_set.first)
			else
				feature_i := context.current_class.feature_table.item_id (l_as.name_id)
			end
			if attached {CONSTANT_I} feature_i as constant_i and then constant_i.value.valid_type (type) then
					-- Record dependencies.
				context.supplier_ids.extend_depend_unit_with_level (context.current_class.class_id, constant_i, 0)
					-- Check if this is a unique constant.
				last_unique_constant := if attached {UNIQUE_I} constant_i as c then c else Void end
					-- Calculate byte node.
				last_inspect_value := constant_i.value.inspect_value (type)
			elseif
				feature_i /= Void or else
				context.current_feature.argument_position (l_as.name_id) /= 0 or else
				context.locals.has (l_as.name_id)
			then
				report_vomb2 (l_as)
			else
				report_veen (l_as)
			end
		end

feature {CHAR_AS} -- Visitor

	process_char_as (l_as: CHAR_AS)
		do
			if type.is_character then
				create {CHAR_VAL_B} last_inspect_value.make (l_as.value)
			elseif type.is_known then
				report_vomb2 (l_as)
			end
		end

feature {INTEGER_CONSTANT} -- Visitor

	process_integer_as (l_as: INTEGER_CONSTANT)
		do
			if l_as.valid_type (type) then
				last_inspect_value := l_as.inspect_value (type)
			elseif type.is_known then
				report_vomb2 (l_as)
			end
		end

feature {NONE} -- Implementation

	report_veen (identifier: ID_AS)
			-- Report unknown `identifier'.
		require
			identifier_not_void: identifier /= Void
		local
			veen: VEEN
		do
			create veen
			context.init_error (veen)
			veen.set_identifier (identifier.name)
			veen.set_location (identifier)
			error_handler.insert_error (veen)
		end

	report_vomb2 (value: ATOMIC_AS)
			-- Report that `value' does not match inspect expression `type'.
		require
			value_not_void: value /= Void
			type_not_void: type /= Void
		local
			vomb2: VOMB2
		do
			create vomb2
			context.init_error (vomb2)
			vomb2.set_type (type)
			vomb2.set_location (value.start_location)
			error_handler.insert_error (vomb2)
		end

	process_inspect_value (bound: ATOMIC_AS)
			-- Chack inspect value `bound' for validity and make its byte code
			-- available in `last_inspect_value' if possible.
		require
			type_not_void: type /= Void
			bound_not_void: bound /= Void
		local
			constant_name: STRING
			written_class: CLASS_C
			make_vomb5: BOOLEAN
			vomb5: VOMB5
			vomb4: VOMB4
			vomb6: VOMB6
		do
			last_inspect_value := Void
			last_unique_constant := Void
			bound.process (Current)
			if last_unique_constant /= Void then
				constant_name := last_unique_constant.feature_name
				if unique_names.has (constant_name) then
						-- Error
					create vomb4
					context.init_error (vomb4)
					vomb4.set_unique_feature (last_unique_constant)
					vomb4.set_location (bound.start_location)
					Error_handler.insert_error (vomb4)
				else
					unique_names.extend (constant_name)
					written_class := last_unique_constant.written_class
					if unique_constant_class = Void then
						unique_constant_class := written_class
					elseif unique_constant_class /= written_class then
							-- Error
						create vomb6
						context.init_error (vomb6)
						vomb6.set_unique_feature (last_unique_constant)
						vomb6.set_original_class (unique_constant_class)
						vomb6.set_location (bound.start_location)
						Error_handler.insert_error (vomb6)
					end
				end
				make_vomb5 := positive_value /= Void
			elseif last_inspect_value /= Void and then last_inspect_value.is_allowed_unique_value then
				positive_value := bound
				make_vomb5 := not unique_names.is_empty
			end
			if make_vomb5 then
				create vomb5
				context.init_error (vomb5)
				vomb5.set_positive_value (positive_value)
				vomb5.set_location (bound.start_location)
				Error_handler.insert_error (vomb5)
			end
		end

invariant
	type_not_void: type /= Void
	valid_type: type.is_integer or type.is_character or type.is_natural
	unique_names_not_void: unique_names /= Void
	intervals_not_void: intervals /= Void

note
	copyright:	"Copyright (c) 1984-2020, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful, but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
		]"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end
