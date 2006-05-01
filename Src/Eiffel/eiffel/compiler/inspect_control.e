indexing
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

create
	make

feature {NONE} -- Creation

	make (inspect_expression_type: TYPE_A) is
			-- Create controller for inspect instruction with `inspect_expression_type'.
		require
			inspect_expression_type_not_void: inspect_expression_type /= Void
			valid_inspect_expression_type:
				inspect_expression_type.is_character or inspect_expression_type.is_integer or inspect_expression_type.is_natural
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

	process_interval (interval: INTERVAL_AS) is
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
			i: like intervals
			interval_byte_node: like last_interval_byte_node
		do
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
				from
					i := intervals
					i.start
				until
					i.after
				loop
					if not interval_byte_node.disjunction (i.item) then
							-- Intersecting intervals
							-- Report error
						create vomb3
						context.init_error (vomb3)
						vomb3.set_interval (interval_byte_node.intersection (i.item))
						vomb3.set_location (interval.end_location)
						Error_handler.insert_error (vomb3)
					end
					i.forth
				end
				i.extend (interval_byte_node)
			end
			last_interval_byte_node := interval_byte_node
		end

feature {STATIC_ACCESS_AS} -- Visitor

	process_static_access_as (l_as: STATIC_ACCESS_AS) is
		local
			feature_i: FEATURE_I
			constant_i: CONSTANT_I
			class_c: CLASS_C
			vuex: VUEX
			obs_warn: OBS_FEAT_WARN
		do
				-- At this stage `l_as' has already been type checked thus `solved_type' will be non-void.
			class_c := type_a_generator.evaluate_type (l_as.class_type, context.current_class).associated_class
			feature_i := class_c.feature_table.item (l_as.feature_name)
			constant_i ?= feature_i
			if feature_i = Void then
				report_veen (l_as.feature_name)
			elseif
				not context.is_ignoring_export and then
				not feature_i.is_exported_for (context.current_class)
			then
				create vuex
				context.init_error (vuex)
				vuex.set_static_class (class_c)
				vuex.set_exported_feature (feature_i)
				vuex.set_location (l_as.feature_name)
				error_handler.insert_error (vuex)
			elseif constant_i /= Void and then constant_i.value.valid_type (type) then
					-- Record dependencies
				context.supplier_ids.extend (create {DEPEND_UNIT}.make (class_c.class_id, constant_i))
					-- Check if this is a unique constant
				last_unique_constant ?= constant_i
					-- Calculate byte node
				last_inspect_value := constant_i.value.inspect_value (type)
				if
					feature_i.is_obsolete
						-- If the obsolete call is in an obsolete class,
						-- no message is displayed
					and then not context.current_class.is_obsolete
						-- The current feature is whether the invariant or
						-- a non obsolete feature
					and then not context.current_feature.is_obsolete
						-- Inherited code is checked in parent class.
					-- and then not is_inherited
					and then context.current_class.lace_class.options.is_warning_enabled (w_obsolete_feature)
				then
					create obs_warn
					obs_warn.set_class (context.current_class)
					obs_warn.set_obsolete_class (class_c)
					obs_warn.set_obsolete_feature (feature_i)
					obs_warn.set_feature (context.current_feature)
					error_handler.insert_warning (obs_warn)
				end
			else
				report_vomb2 (l_as)
			end
		end

feature {ID_AS} -- Visitor

	process_id_as (l_as: ID_AS) is
		local
			feature_i: FEATURE_I
			constant_i: CONSTANT_I
		do
			feature_i := context.current_class.feature_table.item (l_as)
			constant_i ?= feature_i
			if constant_i /= Void and then constant_i.value.valid_type (type) then
					-- Record dependencies
				context.supplier_ids.extend (create {DEPEND_UNIT}.make (context.current_class.class_id, constant_i))
					-- Check if this is a unique constant
				last_unique_constant ?= constant_i
					-- Calculate byte node
				last_inspect_value := constant_i.value.inspect_value (type)
			elseif
				feature_i /= Void or else
				context.current_feature.argument_position (l_as) /= 0 or else
				context.locals.has (l_as)
			then
				report_vomb2 (l_as)
			else
				report_veen (l_as)
			end
		end

feature {CHAR_AS} -- Visitor

	process_char_as (l_as: CHAR_AS) is
		do
			if type.is_character then
				create {CHAR_VAL_B} last_inspect_value.make (l_as.value)
			else
				report_vomb2 (l_as)
			end
		end

feature {INTEGER_CONSTANT} -- Visitor

	process_integer_as (l_as: INTEGER_CONSTANT) is
		do
			if l_as.valid_type (type) then
				last_inspect_value := l_as.inspect_value (type)
			else
				report_vomb2 (l_as)
			end
		end

feature {NONE} -- Implementation

	report_veen (identifier: ID_AS) is
			-- Report unknown `identifier'.
		require
			identifier_not_void: identifier /= Void
		local
			veen: VEEN
		do
			create veen
			context.init_error (veen)
			veen.set_identifier (identifier)
			veen.set_location (identifier)
			error_handler.insert_error (veen)
		end

	report_vomb2 (value: ATOMIC_AS) is
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

	process_inspect_value (bound: ATOMIC_AS) is
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

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
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

end
