note
	description: "Command-line option extension service."

class
	EC_COMMAND_LINE_OPTION_EXTENSION

inherit
	COMMAND_LINE_OPTION_EXTENSION_S
	DISPOSABLE_SAFE
	CONF_KEY_VALUE_PARSER [E2B_OPTIONS]
	SHARED_LOCALE

feature {NONE} -- Clean up

	safe_dispose (a_explicit: BOOLEAN)
			-- <Precursor>
		do
		end

feature -- Access

	argument_count (o: READABLE_STRING_32): like unknown_option
			-- The number of arguments for the option `o` or
			-- `unknown_option` if the option is not recognized.
		do
			Result :=
				if help.has (o) then
					1
				else
					unknown_option
				end
		end

	help: STRING_TABLE [READABLE_STRING_32]
			-- Help messages indexed by option names.
		once
			create Result.make (1)
			Result [name_verify] := "verify specified components by AutoProof"
		end

	command (o: READABLE_STRING_32; a: LIST [READABLE_STRING_32]): detachable E_CMD
			-- The command to be executed for the command-line option `o` with arguments `a`,
			-- or `Void` on error or if the option has no associated command.
			-- In the latter case, `error` contains the error message.
		local
			argument: READABLE_STRING_32
		do
			is_verification_requested := False
			check
				from_precondition: a.count = 1
			end
			argument := a.first
				-- Register the verification request.
			if argument.is_empty then
					-- Error: empty argument.
				error := locale.translation_in_context ("Empty AutoProof argument.", "command.autoproof")
			elseif argument.index_of (delimiter, 1) > 0 then
					-- Explicit argument type.
				parse (argument, {E2B_SHARED_CONTEXT}.options)
			elseif argument.has ('.') then
				add_feature (argument, 0)
			else
				add_class (argument)
			end
			if attached error then
				error := locale.formatted_string (locale.translation_in_context ("Error in AutoProof argument %"$1%": $2", "command.autoproof"), argument, error)
			elseif is_verification_requested then
				Result := autoproof_command
			end
		ensure then
			is_request_consistent: is_verification_requested = (Result = autoproof_command)
			is_error_consistent: attached error implies not is_verification_requested
		end

feature {NONE} -- Status report

	is_verification_requested: BOOLEAN
			-- Has verification been requested in the most recent option?

feature {NONE} -- Modification

	add_feature (input: READABLE_STRING_32; delimiter_index: like {READABLE_STRING_32}.index_of)
			-- Add the feature of identified by `input` after position in the format "CLASS_NAME.feature_name" to the set of features to verify.
			-- Report an error if the input does not follow the format.
		require
			not attached error
			delimiter_index >= 0
			delimiter_index < input.count
		local
			dot_index: like {READABLE_STRING_32}.index_of
		do
			dot_index := input.index_of ('.', delimiter_index + 1)
			if dot_index = 0 then
				error := locale.translation_in_context ("Invalid feature name format (expected: CLASS_NAME.feature_name).", "command.autoproof")
			elseif dot_index = delimiter_index + 1 then
				error := locale.translation_in_context ("Empty class name.", "command.autoproof")
			elseif dot_index = input.count then
				error := locale.translation_in_context ("Empty feature name.", "command.autoproof")
			else
				autoproof_command.add_feature (input.tail (input.count - dot_index), input.substring (delimiter_index + 1, dot_index - 1))
				is_verification_requested := True
			end
		ensure
			attached error xor is_verification_requested
		end

	add_class (c: READABLE_STRING_32)
			-- Add the class of name `c` to the set of classes to verify.
		require
			not attached error
			not c.is_empty
		do
			autoproof_command.add_class (c)
			is_verification_requested := True
		ensure
			not attached error
			is_verification_requested
		end

	add_group (g: READABLE_STRING_32)
			-- Add the class of name `c` to the set of classes to verify.
		require
			not attached error
			not g.is_empty
		do
			autoproof_command.add_group (g)
			is_verification_requested := True
		ensure
			not attached error
			is_verification_requested
		end

feature {NONE} -- Input

	name_verify: STRING_32 = "verify"
			-- The AutoProof option name.

	false_string: STRING_32 = "false"
			-- The string for the boolean value "false".

	true_string: STRING_32 = "true"
			-- The string for the boolean value "true".

	boolean_values: SPECIAL [READABLE_STRING_32]
			-- The set of boolean values.
		once
			Result := (<<false_string, true_string>>).area
		end

	cluster_string: STRING_32 = "cluster"
			-- The string for the collection value "cluster".

	override_string: STRING_32 = "override"
			-- The string for the collection value "override".

	collection_values: SPECIAL [READABLE_STRING_32]
			-- The set of values of option `option_collection`.
		once
			Result := (<<cluster_string, override_string>>).area
		end

feature {NONE} -- AutoProof settings

	keys: SPECIAL [READABLE_STRING_32]
			-- <Precursor>
		once
			Result := (<<
				option_arithmetic_fresh,
				option_arithmetic_trigger,
				option_auto_inlining,
				option_auto_unrolling,
				option_bulk,
				option_class,
				option_collection,
				option_feature,
				option_forks,
				option_group,
				option_html,
				option_independent_invariant_check,
				option_inlining_depth,
				option_measure,
				option_nonvariant,
				option_overflow,
				option_ownership,
				option_postcondition_predicate,
				option_print_time,
				option_semantic_collaboration_defaults,
				option_timeout,
				option_trigger,
				option_two_step,
				option_unrolling_depth
			>>).area
		end

	option_arithmetic_fresh: STRING_32 = "arithfresh"
	option_arithmetic_trigger: STRING_32 = "arithtrigger"
	option_auto_inlining: STRING_32 = "autoinline"
	option_auto_unrolling: STRING_32 = "autounroll"
	option_bulk: STRING_32 = "bulk"
	option_class: STRING_32 = "class"
	option_collection: STRING_32 = "collection"
	option_feature: STRING_32 = "feature"
	option_forks: STRING_32 = "forks"
	option_group: STRING_32 = "group"
	option_html: STRING_32 = "html"
	option_independent_invariant_check: STRING_32 = "independent"
	option_inlining_depth: STRING_32 = "inlinedepth"
	option_measure: STRING_32 = "measure"
	option_nonvariant: STRING_32 = "nonvariant"
	option_overflow: STRING_32 = "overflow"
	option_ownership: STRING_32 = "ownership"
	option_postcondition_predicate: STRING_32 = "postpredicate"
	option_print_time: STRING_32 = "printtime"
	option_semantic_collaboration_defaults: STRING_32 = "scdefaults"
	option_timeout: STRING_32 = "timeout"
	option_trigger: STRING_32 = "trigger"
	option_two_step: STRING_32 = "twostep"
	option_unrolling_depth: STRING_32 = "unrolldepth"

feature {NONE} -- Basic operations

	parse_value (input: READABLE_STRING_32; delimiter_index: INTEGER; option: READABLE_STRING_32; options: E2B_OPTIONS)
			-- <Precursor>
		local
			b: BOOLEAN
			s: READABLE_STRING_32
		do
			if option = option_feature then
				add_feature (input, delimiter_index)
			elseif option = option_class then
				add_class (input.substring (delimiter_index + 1, input.count))
			elseif option = option_group then
				add_group (input.substring (delimiter_index + 1, input.count))
			elseif option = option_collection then
				if attached value_from_list (collection_values, input, delimiter_index, False) as v then
					if v = cluster_string then
						autoproof_command.add_cluster_collection
						is_verification_requested := True
					elseif v = override_string then
						autoproof_command.add_override_collection
						is_verification_requested := True
					else
						check is_collection_known: False end
					end
				else
					error := conf_interface_names.e_parse_string_invalid_value
						(option, input.substring (delimiter_index + 1, input.count), collection_values)
				end
			elseif
				option = option_forks or else
				option = option_inlining_depth or else
				option = option_timeout or else
				option = option_unrolling_depth
			then
					-- Integer setting.
				s := input.substring (delimiter_index + 1, input.count)
				if
					not s.is_integer_32 or else
					not attached s.to_integer_32 as n or else
					n <= 0
				then
					error := conf_interface_names.e_parse_string_invalid_value (option, s, <<"1 .. " + {INTEGER_32}.max_value.out>>)
				elseif option = option_forks then
					options.set_max_parallel_boogies (n)
				elseif option = option_inlining_depth then
					options.set_max_recursive_inlining_depth (n)
				elseif option = option_timeout then
					options.set_is_enforcing_timeout (True)
					options.set_timeout (n)
				elseif option = option_unrolling_depth then
					options.set_loop_unrolling_depth (n)
				else
					check is_setting_known: False end
				end
			elseif attached value_from_list (boolean_values, input, delimiter_index, True) as v then
					-- Boolean setting.
				b := v = true_string
				if option = option_arithmetic_fresh then
					options.set_arithmetic_extracted (b)
				elseif option = option_arithmetic_trigger then
					options.set_triggering_on_arithmetic (b)
				elseif option = option_auto_inlining then
					options.set_automatic_inlining_enabled (b)
				elseif option = option_auto_unrolling then
					options.set_automatic_loop_unrolling_enabled (b)
				elseif option = option_bulk then
					options.set_bulk_verification_enabled (b)
				elseif option = option_html then
					autoproof_command.set_html (b)
				elseif option = option_independent_invariant_check then
					options.set_inv_check_independent (b)
				elseif option = option_measure then
					autoproof_command.set_measured (b)
				elseif option = option_nonvariant then
					options.set_ignoring_nonvariant (not b)
				elseif option = option_overflow then
					options.set_checking_overflow (b)
				elseif option = option_ownership then
					options.set_ownership_enabled (b)
				elseif option = option_postcondition_predicate then
					options.set_postcondition_predicate_enabled (b)
				elseif option = option_print_time then
					options.set_print_time (b)
				elseif option = option_semantic_collaboration_defaults then
					options.set_ownership_defaults_enabled (b)
				elseif option = option_trigger then
					options.set_generating_triggers (b)
				elseif option = option_two_step then
					options.set_two_step_verification_enabled (b)
				else
					check is_setting_known: False end
				end
			else
				error := conf_interface_names.e_parse_string_invalid_value
					(option, input.substring (delimiter_index + 1, input.count), boolean_values)
			end
		end

feature {NONE} -- Access

	autoproof_command: E_AUTOPROOF
			-- Command to launch AutoProof.
		once
			create Result.make
		end

note
	date: "$Date$"
	revision: "$Revision$"
	copyright: "Copyright (c) 2021-2022 Schaffhausen Institute of Technology"
	author: "Alexander Kogtenkov"
	license: "GNU General Public License"
	license_name: "GPL"
	EIS: "name=GPL", "src=https://www.gnu.org/licenses/gpl.html", "tag=license"
	copying: "[
		This program is free software; you can redistribute it and/or modify it under the terms of
		the GNU General Public License as published by the Free Software Foundation; either version 1,
		or (at your option) any later version.

		This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY;
		without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
		See the GNU General Public License for more details.

		You should have received a copy of the GNU General Public License along with this program.
		If not, see <https://www.gnu.org/licenses/>.
	]"

end
