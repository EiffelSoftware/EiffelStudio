note
	description: "Translator to map Eiffel names to Boogie names."

class
	E2B_NAME_TRANSLATOR

inherit

	INTERNAL_COMPILER_STRING_EXPORTER
		export {NONE} all end

	SHARED_WORKBENCH
		export
			{NONE}
				all
			{ANY}
				deep_twin,
				is_deep_equal,
				standard_is_equal
		end

feature -- Access

	boogie_procedure_for_feature (a_feature: FEATURE_I; a_context_type: CL_TYPE_A): READABLE_STRING_8
			-- Name of the boogie procedure that encodes `a_feature'.
		require
			a_feature_attached: attached a_feature
			a_context_type_attached: attached a_context_type
		local
			l_type_name: READABLE_STRING_8
			l_feature_name: READABLE_STRING_8
		do
			l_type_name := boogie_name_for_type (a_context_type)
			l_feature_name := feature_name (a_feature)
			Result := l_type_name + "." + l_feature_name
		ensure
			result_attached: attached Result
			result_valid: is_valid_feature_name (Result)
		end

	boogie_procedure_for_creator (a_feature: FEATURE_I; a_context_type: CL_TYPE_A): READABLE_STRING_8
			-- Name of the boogie procedure that encodes `a_feature' used as a creation procedure.
		require
			a_feature_attached: attached a_feature
			a_context_type_attached: attached a_context_type
		local
			l_type_name: READABLE_STRING_8
			l_feature_name: READABLE_STRING_8
		do
			l_type_name := boogie_name_for_type (a_context_type)
			l_feature_name := feature_name (a_feature)
			Result := "create." + l_type_name + "." + l_feature_name
		ensure
			result_attached: attached Result
			result_valid: is_valid_feature_name (Result)
		end

	boogie_function_for_feature (a_feature: FEATURE_I; a_context_type: CL_TYPE_A; a_uninterpreted: BOOLEAN): READABLE_STRING_8
			-- Name of the boogie function that encodes the result of `a_feature'.
		require
			a_feature_attached: attached a_feature
			a_context_type_attached: attached a_context_type
		local
			l_type_name: READABLE_STRING_8
			l_feature_name: READABLE_STRING_8
		do
			l_type_name := boogie_name_for_type (a_context_type)
			l_feature_name := feature_name (a_feature)
			Result :=
				if a_uninterpreted then
					"fun0."
				else
					"fun."
				end + l_type_name + "." + l_feature_name
		ensure
			result_attached: attached Result
		end

	boogie_function_for_write_frame (a_feature: FEATURE_I; a_context_type: CL_TYPE_A): READABLE_STRING_8
			-- Name of the boogie function that encodes the write frame of `a_feature'.
		require
			a_feature_attached: attached a_feature
			a_context_type_attached: attached a_context_type
		local
			l_type_name: READABLE_STRING_8
			l_feature_name: READABLE_STRING_8
		do
			l_type_name := boogie_name_for_type (a_context_type)
			l_feature_name := feature_name (a_feature)
			Result := "modify." + l_type_name + "." + l_feature_name
		ensure
			result_attached: attached Result
		end

	boogie_function_for_read_frame (a_feature: FEATURE_I; a_context_type: CL_TYPE_A): READABLE_STRING_8
			-- Name of the boogie function that encodes the read frame of the functional representation of `a_feature'.
		require
			a_feature_attached: attached a_feature
			a_context_type_attached: attached a_context_type
		local
			l_type_name: READABLE_STRING_8
			l_feature_name: READABLE_STRING_8
		do
			l_type_name := boogie_name_for_type (a_context_type)
			l_feature_name := feature_name (a_feature)
			Result := "read.fun." + l_type_name + "." + l_feature_name
		ensure
			result_attached: attached Result
		end

	boogie_procedure_for_contract_check (a_feature: FEATURE_I; a_context_type: CL_TYPE_A): READABLE_STRING_8
			-- Name of the boogie procedure that encodes the consistence check of `a_feature's contracts.
		require
			a_feature_attached: attached a_feature
			a_context_type_attached: attached a_context_type
		local
			l_type_name: READABLE_STRING_8
			l_feature_name: READABLE_STRING_8
		do
			l_type_name := boogie_name_for_type (a_context_type)
			l_feature_name := feature_name (a_feature)
			Result := l_type_name + "." + l_feature_name + ".check"
		ensure
			result_attached: attached Result
		end

	boogie_function_precondition (a_function_name: READABLE_STRING_8): STRING
			-- Precondition predicate name for function named `a_function_name'.
		require
			a_function_name_attached: attached a_function_name
		do
			Result := "pre." + a_function_name
		ensure
			result_attached: attached Result
		end

--	boogie_free_function_precondition (a_function_name: STRING): STRING
--			-- Free precondition predicate name for function named `a_function_name'.
--		require
--			a_function_name_attached: attached a_function_name
--		do
--			Result := "free_pre." + a_function_name
--		ensure
--			result_attached: attached Result
--		end

	boogie_function_trigger (a_function_name: READABLE_STRING_8): STRING
			-- Trigger predicate name for opaque function named `a_function_name'.
		require
			a_function_name_attached: attached a_function_name
		do
			Result := "trigger." + a_function_name
		ensure
			result_attached: attached Result
		end

	boogie_function_for_variant (a_index: INTEGER; a_feature: FEATURE_I; a_context_type: CL_TYPE_A): READABLE_STRING_8
			-- Name of the boogie function that encodes `a_index'-th variant of `a_feature'.
		require
			a_feature_attached: attached a_feature
			a_context_type_attached: attached a_context_type
		local
			l_type_name: READABLE_STRING_8
			l_feature_name: READABLE_STRING_8
		do
			l_type_name := boogie_name_for_type (a_context_type)
			l_feature_name := feature_name (a_feature)
			Result := "variant." + l_type_name + "." + l_feature_name + "." + a_index.out
		ensure
			result_attached: attached Result
		end

	boogie_function_for_invariant (a_type: CL_TYPE_A): STRING
			-- Name of the boogie function that encodes the class invariant of type `a_type'.
		require
			a_type: attached a_type
		local
			l_type_name: STRING
		do
			l_type_name := boogie_name_for_type (a_type)
			Result := l_type_name + ".user_inv"
		ensure
			result_attached: attached Result
		end

	boogie_function_for_filtered_invariant (a_type: CL_TYPE_A; a_included, a_excluded: LIST [STRING]; a_ancestor: CLASS_C): STRING
			-- Name of the boogie function that encodes the partial class invariant of type `a_type'
			-- with `a_included' clauses included and `a_excluded' clauses excluded.
		require
			a_type_exists: attached a_type
			a_ancestor_exists: attached a_ancestor
		local
			l_type_name: STRING
			l_filter_string: STRING
		do
			l_type_name := boogie_name_for_type (a_type)
			l_filter_string := ""
			if a_included /= Void then
				l_filter_string.append ("#I")
				across a_included as i loop l_filter_string.append ("#" + i) end
			end
			if a_excluded /= Void then
				l_filter_string.append ("#E")
				across a_excluded as i loop l_filter_string.append ("#" + i) end
			end
			if a_ancestor.class_id /= a_type.base_class.class_id then
				l_filter_string.append ("#A#" + a_ancestor.name_in_upper)
			end
			Result := l_type_name + l_filter_string + ".filtered_inv"
		ensure
			result_attached: attached Result
		end

	boogie_function_for_ghost_definition (a_type: CL_TYPE_A; a_name: READABLE_STRING_8): STRING
			-- Name of the boogie function that encodes the static definition of a ghost field `a_name' of type `a_type'.
		require
			a_type: attached a_type
			a_name: attached a_name
		local
			l_type_name: STRING
		do
			l_type_name := boogie_name_for_type (a_type)
			Result := l_type_name + "." + a_name + ".static"
		ensure
			result_attached: attached Result
		end

	boogie_field_for_tuple_field (a_context_type: CL_TYPE_A; a_position: INTEGER): STRING
			-- Name of the boogie constant that encodes tuple field at `a_position' in the tuple type `a_context_type'.
		require
			a_context_type_attached: attached a_context_type
			is_tuple: a_context_type.is_tuple
		local
			l_type_name: STRING
			l_feature_name: STRING
		do
			l_type_name := boogie_name_for_type (a_context_type)
			l_feature_name := "field_" + a_position.out
			Result := l_type_name + "." + l_feature_name
		ensure
			result_attached: attached Result
			result_valid: is_valid_feature_name (Result)
		end

	boogie_procedure_for_tuple_creation (a_context_type: CL_TYPE_A): STRING
			-- Name of the boogie constant that encodes tuple field at `a_position' in the tuple type `a_context_type'.
		require
			a_context_type_attached: attached a_context_type
			is_tuple: a_context_type.is_tuple
		local
			l_type_name: STRING
		do
			l_type_name := boogie_name_for_type (a_context_type)
			Result := "create." + l_type_name + ".make"
		ensure
			result_attached: attached Result
			result_valid: is_valid_feature_name (Result)
		end

	feature_for_boogie_name (a_name: READABLE_STRING_8): TUPLE [type: TYPE_A; feature_: FEATURE_I; is_creator: BOOLEAN]
			-- For a feature named `a_name' in Boogie code,
			-- return its enclosing type (different from where it is defined if inherited), the eiffel feature and whether it is a creator.
		require
			valid_feature_name: is_valid_feature_name (a_name)
		local
			l_name: READABLE_STRING_8
			l_list: LIST [READABLE_STRING_8]
			l_type_name: READABLE_STRING_8
			l_feature_name: READABLE_STRING_8
			l_type: TYPE_A
			l_is_creator: BOOLEAN
		do
			if a_name.starts_with ("create.") then
				l_is_creator := True
				l_name := a_name.tail (a_name.count - 7)
			else
				l_name := a_name
			end
			if l_name.has ('.') then
				l_list := l_name.split ('.')
				l_type_name := l_list.i_th (1)
				l_feature_name := l_list.i_th (2)
				if l_type_name.starts_with ("$") then
					l_type_name := l_type_name.tail (l_type_name.count - 1)
				end
			else
					-- Built in features
				l_type_name := "ANY"
				l_feature_name := l_name
			end
			l_type := type_for_boogie_name (l_type_name)
			Result := [l_type, l_type.base_class.feature_named (l_feature_name), l_is_creator]
		ensure
			result_attached: attached Result
		end

	boogie_name_for_type (a_type: CL_TYPE_A): STRING
			-- Name for type `a_type'.
		require
			a_type_attached: attached a_type
		local
			i: INTEGER
			l_type_name: STRING
			l_helper: E2B_HELPER
			t: TYPE_A
		do
			create l_helper
			if l_helper.is_agent_type (a_type) then
				Result := a_type.base_class.name_in_upper
			elseif attached {GEN_TYPE_A} a_type as l_gen_type then
				Result := l_gen_type.base_class.name_in_upper.twin
				Result.append ("^")
				from
					i := l_gen_type.generics.lower
				until
					i > l_gen_type.generics.upper
				loop
					t := l_gen_type.generics [i]
					if attached {CL_TYPE_A} t as c then
						l_type_name := boogie_name_for_type (c)
					elseif attached {CL_TYPE_A} l_gen_type.base_class.single_constraint (i) as c then
						l_type_name := boogie_name_for_type (c)
					else
						check class_type_constraint: False then end
					end
					Result.append (l_type_name)
					if i < l_gen_type.generics.upper then
						Result.append ("#")
					end
					i := i + 1
				end
				Result.append ("^")
			else
				Result := a_type.base_class.name_in_upper.twin
			end
		ensure
			result_attached: attached Result
			result_valid: is_valid_type_name (Result)
		end

	type_for_boogie_name (a_name: READABLE_STRING_8): TYPE_A
			-- Type named `a_name' in Boogie code.
		require
			valid_type_name: is_valid_type_name (a_name)
		local
			l_class_name: READABLE_STRING_8
			l_classes: LIST [CLASS_I]
		do
			if a_name.has ('^') then
				l_class_name := a_name.substring (1, a_name.index_of ('^', 1)-1)
					-- TODO: handle generic parameters
			elseif a_name.has ('#') then
				l_class_name := a_name.substring (1, a_name.index_of ('#', 1)-1)
					-- TODO: handle generic parameters
			else
				l_class_name := a_name
			end
			l_classes := universe.classes_with_name (l_class_name)
			if not l_classes.is_empty then
				Result := l_classes.first.compiled_class.actual_type
			end
		ensure
			result_attached: attached Result
		end

	postcondition_predicate_name (a_feature: FEATURE_I; a_context_type: CL_TYPE_A): STRING
			-- Postcondition predicate name for feature `a_feature'.
		require
			a_feature_attached: attached a_feature
			a_context_type_attached: attached a_context_type
		do
			Result := "post." + boogie_procedure_for_feature (a_feature, a_context_type)
		ensure
			result_attached: attached Result
		end

	boogie_name_for_local (i: INTEGER): STRING
			-- Name for local with index `i'.
		require
			i_valid: i > 0
		do
			Result := "local" + i.out
		ensure
			result_attached: attached Result
		end

feature -- Status report

	is_valid_feature_name (a_name: READABLE_STRING_8): BOOLEAN
			-- Can `a_name' be mapped to an Eiffel feature?
		do
				-- TODO: implement
			Result := True
		end

	is_valid_type_name (a_name: READABLE_STRING_8): BOOLEAN
			-- Can `a_name' be mapped to an Eiffel type?
		do
				-- TODO: implement
			Result := True
		end

	is_creator_name (a_name: READABLE_STRING_8): BOOLEAN
			-- Is Boogie procedure `a_name' a translation of a creator?
		do
			Result := a_name.starts_with ("create.")
		end

feature -- Name adaptation

	feature_name (f: FEATURE_I): READABLE_STRING_8
			-- Name of `f` adpated to Boogie naming convention.
		do
			Result := f.feature_name
		end

note
	date: "$Date$"
	revision: "$Revision$"
	copyright:
		"Copyright (c) 2012-2014 ETH Zurich",
		"Copyright (c) 2018-2019 Politecnico di Milano",
		"Copyright (c) 2022 Schaffhausen Institute of Technology"
	author: "Julian Tschannen", "Nadia Polikarpova", "Alexander Kogtenkov"
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
