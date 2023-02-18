note
	description:  "[
			RULE #48: Attribute can be made constant

			An attribute that is assigned the same value
			by every creation procedure but not assigned
			by any other routine can be made constant.
		]"
	date: "$Date$"
	revision: "$Revision$"

class
	CA_ATTRIBUTE_CAN_BE_CONSTANT_RULE

inherit
	CA_STANDARD_RULE

create
	make

feature {NONE} -- Initialization

	make
			-- Initialization.
		do
			make_with_defaults
			create attributes.make (10)
			create unassigned_attributes.make
			unassigned_attributes.compare_objects
		end

feature {NONE} -- Activation

	register_actions (a_checker: attached CA_ALL_RULES_CHECKER)
		do
			a_checker.add_class_pre_action (agent check_class)
			a_checker.add_assign_pre_action (agent check_assign)
			a_checker.add_class_post_action (agent check_attributes)
		end

feature -- Properties

	name: STRING = "fixed_attribute_value"
			-- <Precursor>

	title: STRING_32
		do
			Result := ca_names.attribute_can_be_constant_title
		end

	id: STRING_32 = "CA048"
			-- <Precursor>

	description: STRING_32
		do
			Result :=  ca_names.attribute_can_be_constant_description
		end

	format_violation_description (a_violation: attached CA_RULE_VIOLATION; a_formatter: attached TEXT_FORMATTER)
		do
			a_formatter.add (ca_messages.attribute_can_be_constant_violation_1)

			if attached {READABLE_STRING_GENERAL} a_violation.long_description_info.first as l_attribute then
				a_formatter.add (l_attribute)
			end

			a_formatter.add (ca_messages.attribute_can_be_constant_violation_2)

			if attached {READABLE_STRING_GENERAL} a_violation.long_description_info.at(2) as l_value then
				a_formatter.add (l_value)
			end

			a_formatter.add (ca_messages.attribute_can_be_constant_violation_3)
		end

feature {NONE} -- Feature Visitor for Violation Check

	check_class (a_class: CLASS_AS)
			-- Checks `a_class' for attributes which aren't constant.
		do
			across
				current_context.checking_class.written_in_features as l_feat
			loop
				if l_feat.is_attribute and not l_feat.is_constant then
					attributes.put (Void, l_feat.name_32)
					unassigned_attributes.extend (l_feat.name_32)
				end
			end
		end

	check_assign (a_assign: ASSIGN_AS)
			-- Checks `a_assign' for attributes that are assigned a value.
		local
			l_key: STRING_32
		do
			l_key := a_assign.target.access_name_32

			if attributes.has (l_key) then
				-- Remove the attribute from unassigned_attributes since we found it as
				-- a target in the current ASSIGN_AS node
				if unassigned_attributes.has (l_key) then
					unassigned_attributes.go_i_th (unassigned_attributes.index_of (l_key, 1))
					unassigned_attributes.remove
				end

				if attached attributes.at (l_key) as l_attribute then
					-- This attribute has already been assigned, compare values. If a value
					-- differs from other assignments, the attribute is removed from the table.

					if attached {INTEGER_AS} a_assign.source as l_int_const and attached {INTEGER_AS} l_attribute as l_stored then
						if l_int_const.natural_32_value /= l_stored.natural_32_value then
							attributes.remove (l_key)
						end
					elseif attached {BOOL_AS} a_assign.source as l_bool_const and attached {BOOL_AS} l_attribute as l_stored then
						if l_bool_const.value /= l_stored.value then
							attributes.remove (l_key)
						end
					elseif attached {CHAR_AS} a_assign.source as l_char_const and attached {CHAR_AS} l_attribute as l_stored then
						if not l_char_const.value.is_equal (l_stored.value) then
							attributes.remove (l_key)
						end
					elseif attached {REAL_AS} a_assign.source as l_real_const and attached {REAL_AS} l_attribute as l_stored then
						if not l_real_const.value.is_equal (l_stored.value) then
							attributes.remove (l_key)
						end
					elseif attached {STRING_AS} a_assign.source as l_string_const and attached {STRING_AS} l_attribute as l_stored then
						if not l_string_const.value_32.is_equal (l_stored.value_32) then
							attributes.remove (l_key)
						end
					elseif attached {CONVERTED_EXPR_AS} a_assign.source as l_converted and then attached {REAL_AS} l_converted.expr as l_real_const and attached {REAL_AS} l_attribute as l_stored then
						if not l_real_const.value.is_equal (l_stored.value) then
							attributes.remove (l_key)
						end
					end
				else
						-- This is the first explicit assignment to this attribute.
					if attached {ATOMIC_AS} a_assign.source as l_atomic then
						register_first_assignment (l_atomic, l_key)
					elseif attached {CONVERTED_EXPR_AS} a_assign.source as l_converted and then attached {ATOMIC_AS} l_converted.expr as l_atomic then
						register_first_assignment (l_atomic, l_key)
					else
							-- The assignment source is not a constant value, hence we cannot make the attriute constant.
						attributes.remove (l_key)
					end
				end
			end
		end

	register_first_assignment (value: ATOMIC_AS; attribute_name: STRING_32)
			-- Register first explicit assignment of value `value' to attribute `attribute_name'.
		local
			is_default: BOOLEAN
		do
				-- Unfortunately the attribute might have been used with a default value earlier.
				-- A deeper analysis may figure out if that was the case.
				-- For the time being ignore all assignments with non-default values.
			if attached {BOOL_AS} value as boolean_constant then
				is_default := not boolean_constant.value
			elseif attached {CHAR_AS} value as character_constant then
				is_default := character_constant.value = '%U'
			elseif attached {INTEGER_AS} value as integer_constant then
				is_default := integer_constant.is_zero
			elseif attached {REAL_AS} value as real_constant then
					-- There are different representations, the value may need to be normalized before comparison.
				is_default := real_constant.value ~ "0" or else real_constant.value ~ "0.0"
			end
			if is_default then
					-- The default value is assigned, keep the attribute.
				attributes.replace (value, attribute_name)
			else
					-- A non-default value is assigned, remove the attribute.
				attributes.remove (attribute_name)
			end
		end

	check_attributes (a_class: CLASS_AS)
			-- Checks the attributes table. Any attributes that were not removed by check_assign
			-- will always have been assigned the same values in every assignment and can be made constant.
		do
			across attributes as l_key loop
				if not unassigned_attributes.has (@ l_key.key) then
					create_violation (current_context.checking_class.feature_with_name_32 (@ l_key.key), l_key.string_value_32)
				end
			end

				-- Reset the tables for the next class.
			attributes.wipe_out
			unassigned_attributes.wipe_out
		end

	create_violation (a_feature: attached E_FEATURE; a_value: attached STRING_32)
			-- Creates violation regarding `a_feature' never being called.
		local
			l_violation: CA_RULE_VIOLATION
			l_fix: CA_ATTRIBUTE_CAN_BE_CONSTANT_FIX
		do
			create l_violation.make_with_rule (Current)
			l_violation.set_location (a_feature.ast.start_location)
			l_violation.long_description_info.extend (a_feature.name_32)
			l_violation.long_description_info.extend (a_value)

			create l_fix.make_with_attribute_and_value (current_context.checking_class, a_feature.ast, a_value)
			l_violation.fixes.extend (l_fix)

			violations.extend (l_violation)
		end

feature {NONE} -- Rule checking

	attributes: HASH_TABLE [ATOMIC_AS, STRING_32]
			-- Table of all attributes which are not constant but always assigned the same value.

	unassigned_attributes: LINKED_LIST [STRING_32]
			-- List of attributes that have never been assigned any values.

end
