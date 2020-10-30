note

	description:

		"Represents a config file"

	copyright: "Copyright (c) 1999, Andreas Leitner and others"
	license: "Eiffel Forum License v2 (see forum.txt)"
	date: "$Date$"
	revision: "$Revision$"

class EWG_CONFIG_SYSTEM

inherit

	KL_IMPORTED_STRING_ROUTINES
		export {NONE} all end
	ANY

create

	make

feature {NONE} -- Initialization

	make (a_header_file_name: STRING)
		require
			a_header_file_name_not_void: a_header_file_name /= Void
			a_header_file_name_not_empty: a_header_file_name.count > 0
		do
			header_file_name := a_header_file_name

			create eiffel_wrapper_set.make
			output_directory_name := ""
			create include_path.make_empty
			name := "unknown"
			create {EWG_CONFIG_DEFAULT_WRAPPER_CLAUSE} default_wrapper_clause.make
			create rule_list.make_default
			create rule_macro_list.make_default
			create shallow_wrapped_type_table.make_map_default
			create deeply_wrapped_table.make_default
			create function_address.make (10)
			function_address.compare_objects
			create function_excludes.make (10)
			function_excludes.compare_objects
			create directory_structure.make (Current)
		end

feature {ANY} -- Access

	output_directory_name: STRING
			-- Directory name where output should be written to.

	directory_structure: EWG_DIRECTORY_STRUCTURE

	header_file_name: STRING
			-- Header file to parser (with full path name)

	eiffel_wrapper_set: EWG_EIFFEL_WRAPPER_SET

	name: STRING
			-- Wrapper name

	function_address: ARRAYED_LIST [STRING]
			-- List of functions which we want
			-- to return a function address.

	function_excludes: ARRAYED_LIST [STRING]
			-- List of functions which we want
			-- to eclude for the high level api.

	include_path: PATH
			-- Directory path to the header.

	compile_options: detachable STRING
			-- C compile options.

feature {ANY}

	has_wrapper_clause (a_wrapper_clause: EWG_CONFIG_WRAPPER_CLAUSE): BOOLEAN
			-- Does `Current' contain the wrapper clause `a_wrapper_clause' ?
		require
			a_wrapper_clause_not_void: a_wrapper_clause /= Void
		local
			cs: DS_LINEAR_CURSOR [EWG_CONFIG_RULE]
		do
			from
				cs := rule_list.new_cursor
				cs.start
			until
				cs.off
			loop
				if cs.item.wrapper_clause = a_wrapper_clause then
					Result := True
					cs.go_after
				else
					cs.forth
				end
			end
		end

	has_rule (a_rule: EWG_CONFIG_RULE): BOOLEAN
			-- Does `Current' contain the rule `a_rule' ?
		require
			a_rule_not_void: a_rule /= Void
		do
			Result := rule_list.has (a_rule)
		end

	has_macro_rule (a_rule: EWG_CONFIG_RULE): BOOLEAN
			-- Does `Current' contain the rule `a_rule' ?
		require
			a_rule_not_void: a_rule /= Void
		do
			Result := rule_macro_list.has (a_rule)
		end

	does_type_need_deep_wrapping (a_type: EWG_C_AST_TYPE): BOOLEAN
		do
			Result := shallow_wrapped_type_table.has (a_type) and then
								shallow_wrapped_type_table.item (a_type) = False
		end

	has_type_been_deeply_wrapped (a_type: EWG_C_AST_TYPE): BOOLEAN
		do
			Result := shallow_wrapped_type_table.has (a_type) and then
								shallow_wrapped_type_table.item (a_type) = True
		end

feature {ANY} -- Change Element

	set_output_directory_name (a_output_directory_name: STRING)
		require
			a_output_directory_name_not_void: a_output_directory_name /= Void
		do
			output_directory_name := a_output_directory_name
		ensure
			output_directory_name_set: output_directory_name = a_output_directory_name
		end

	set_name (a_name: STRING)
		require
			a_name_not_void: a_name /= Void
			a_name_not_empty: a_name.count > 0
		do
			name := a_name
		end

feature {ANY} -- Operations

	try_shallow_wrap_type (a_type: EWG_C_AST_TYPE;
								  a_include_header_file_name: STRING;
								  a_eiffel_wrapper_set: EWG_EIFFEL_WRAPPER_SET)
			-- Create an Eiffel wrapper for `a_type' acording to the
			-- users configuration and add it to `eiffel_wrapper_set'
			-- (but only if the user didn't specify to ignore
			-- `a_type'). Wrappers for members (if any) are not created
			-- (hence the "shallow" in the name). Because wrappers can
			-- have cyclic dependencies a two step wrapping process is
			-- needed.
		require
			a_type_not_void: a_type /= Void
			eiffel_wrapper_set_not_has_a_type: not eiffel_wrapper_set.has_wrapper_for_type (a_type)
			a_include_header_file_name_not_void: a_include_header_file_name /= Void
			a_eiffel_wrapper_set_not_void: a_eiffel_wrapper_set /= Void
		local
			cs: DS_LINEAR_CURSOR [EWG_CONFIG_RULE]
			type_wrapped: BOOLEAN
			skipped_type: EWG_C_AST_TYPE
		do

			skipped_type := a_type.skip_wrapper_irrelevant_types
			if
				skipped_type.can_be_wrapped and
					not a_eiffel_wrapper_set.has_wrapper_for_type (skipped_type)
			then
				from
					cs := rule_list.new_cursor
					cs.start
				until
					cs.off
				loop
					if
						cs.item.matching_clause.is_matching_type (a_type)
					then
						if cs.item.wrapper_clause.accepts_type (a_type) then
							cs.item.wrapper_clause.shallow_wrap_type (a_type,
																					a_include_header_file_name,
																					a_eiffel_wrapper_set)
							type_wrapped := True
							cs.go_after
						else
							-- TODO: proper error reporting
							print ("%N%NError: Wrapper clause does not accept type%N%N")
						end
					end
					if not cs.off then
						cs.forth
					end
				end
			end
			if a_eiffel_wrapper_set.has_wrapper_for_type (skipped_type) then
				make_sure_type_will_be_deeply_wrapped (a_type)
			end
		end

	try_shallow_wrap_declaration (a_declaration: EWG_C_AST_DECLARATION;
											a_include_header_file_name: STRING;
											a_eiffel_wrapper_set: EWG_EIFFEL_WRAPPER_SET)
			-- Create an Eiffel wrapper for `a_declaration' and add it to
			-- `eiffel_wrapper_set' (but only if the user didn't
			-- specify to ignore `a_declaration'). Wrappers for members
			-- (if any) are not created (hence the "shallow" in the
			-- name). Because wrappers can have cyclic dependencies a two
			-- step wrapping process is needed.
		require
			a_declaration_not_void: a_declaration /= Void
			eiffel_wrapper_set_not_has_a_declaration: not eiffel_wrapper_set.has_wrapper_for_declaration (a_declaration)
			a_include_header_file_name_not_void: a_include_header_file_name /= Void
			a_eiffel_wrapper_set_not_void: a_eiffel_wrapper_set /= Void
		local
			cs: DS_LINEAR_CURSOR [EWG_CONFIG_RULE]
			declaration_wrapped: BOOLEAN
		do
			from
				cs := rule_list.new_cursor
				cs.start
			until
				cs.off
			loop
				if cs.item.matching_clause.is_matching_declaration (a_declaration) then
					if cs.item.wrapper_clause.accepts_declaration (a_declaration) then
						cs.item.wrapper_clause.shallow_wrap_declaration (a_declaration,
																						 a_include_header_file_name,
																						 a_eiffel_wrapper_set)
						declaration_wrapped := True
						cs.go_after
					else
						-- TODO: proper error reporting
						print ("%N%NWrapper clause does not accept decl%N%N")
					end
				end
				if not cs.off then
					cs.forth
				end
			end
		end

	force_shallow_wrap_type (a_type: EWG_C_AST_TYPE;
									 a_include_header_file_name: STRING;
									 a_eiffel_wrapper_set: EWG_EIFFEL_WRAPPER_SET)
			-- Create an Eiffel wrapper for `a_type' acording to the
			-- users configuration and add it to `eiffel_wrapper_set'.
			-- Wrappers for members (if any) are not created (hence the
			-- "shallow" in the name). Because wrappers can have cyclic
			-- dependencies a two step wrapping process is needed.
		require
			a_type_not_void: a_type /= Void
			a_include_header_file_name_not_void: a_include_header_file_name /= Void
			a_eiffel_wrapper_set_not_void: a_eiffel_wrapper_set /= Void
		local
			skipped_type: EWG_C_AST_TYPE
		do
			skipped_type := a_type.skip_wrapper_irrelevant_types
			if not eiffel_wrapper_set.has_wrapper_for_type (skipped_type) then
				try_shallow_wrap_type (a_type,
											  a_include_header_file_name,
											  a_eiffel_wrapper_set)

				if not eiffel_wrapper_set.has_wrapper_for_type (skipped_type) then
					if not skipped_type.has_built_in_wrapper then
							check
								default_wrapper_clause_accepts_everything: default_wrapper_clause.accepts_type (a_type)
							end
						default_wrapper_clause.shallow_wrap_type (a_type,
																				a_include_header_file_name,
																				a_eiffel_wrapper_set)
					end
				end
				if a_eiffel_wrapper_set.has_wrapper_for_type (skipped_type) then
					make_sure_type_will_be_deeply_wrapped (a_type)
				end
			end
		end

	force_shallow_wrap_declaration (a_declaration: EWG_C_AST_DECLARATION;
											  a_include_header_file_name: STRING;
											  a_eiffel_wrapper_set: EWG_EIFFEL_WRAPPER_SET)
			-- Create an Eiffel wrapper for `a_declaration' and add it to
			-- `eiffel_wrapper_set'. Wrappers for members (if any) are
			-- not created (hence the "shallow" in the name). Because
			-- wrappers can have cyclic dependencies a two step wrapping
			-- process is needed.
		require
			a_declaration_not_void: a_declaration /= Void
			a_include_header_file_name_not_void: a_include_header_file_name /= Void
			a_eiffel_wrapper_set_not_void: a_eiffel_wrapper_set /= Void
		do
			if not eiffel_wrapper_set.has_wrapper_for_declaration (a_declaration) then
				try_shallow_wrap_declaration (a_declaration,
														a_include_header_file_name,
														a_eiffel_wrapper_set)

				if not eiffel_wrapper_set.has_wrapper_for_declaration (a_declaration) then
						check
							default_wrapper_clause_accepts_everything: default_wrapper_clause.accepts_declaration (a_declaration)
						end
					default_wrapper_clause.shallow_wrap_declaration (a_declaration,
																					 a_include_header_file_name,
																					 a_eiffel_wrapper_set)
				end
			end
		end

	deep_wrap_type (a_type: EWG_C_AST_TYPE;
						 a_include_header_file_name: STRING;
						 a_eiffel_wrapper_set: EWG_EIFFEL_WRAPPER_SET)
			-- Once `shallow_wrap_type' has been called on `a_type',
			-- `deep_wrap_type' can be called to wrap `a_type's members
			-- if any exist.
		require
			a_type_not_void: a_type /= Void
			type_needs_deep_wrapping: does_type_need_deep_wrapping (a_type)
			a_include_header_file_name_not_void: a_include_header_file_name /= Void
			a_eiffel_wrapper_set_not_void: a_eiffel_wrapper_set /= Void
		local
			cs: DS_LINEAR_CURSOR [EWG_CONFIG_RULE]
			type_wrapped: BOOLEAN
			skipped_type: EWG_C_AST_TYPE
		do
			skipped_type := a_type.skip_wrapper_irrelevant_types

			if not deeply_wrapped_table.has (skipped_type) then
				from
					cs := rule_list.new_cursor
					cs.start
				until
					cs.off
				loop
					if cs.item.matching_clause.is_matching_type (a_type) then
						if cs.item.wrapper_clause.accepts_type (a_type) then
							cs.item.wrapper_clause.deep_wrap_type (a_type,
																				a_include_header_file_name,
																				a_eiffel_wrapper_set,
																				Current)
							type_wrapped := True
							cs.go_after
						else
							-- TODO: proper error reporting
							print ("%N%NError: Wrapper clause does not accept type%N%N")
						end
					end
					if not cs.off then
						cs.forth
					end
				end
				if not deeply_wrapped_table.has (skipped_type) then
					if default_wrapper_clause.accepts_type (a_type) then
						default_wrapper_clause.deep_wrap_type (a_type,
																			a_include_header_file_name,
																			a_eiffel_wrapper_set,
																			Current)
					else
						-- TODO: proper error reporting
						print ("%N%NError: Wrapper clause does not accept type%N%N")
					end
				end
			end
		end

	deep_wrap_declaration (a_declaration: EWG_C_AST_DECLARATION;
								  a_include_header_file_name: STRING;
								  a_eiffel_wrapper_set: EWG_EIFFEL_WRAPPER_SET)
			-- Once `shallow_wrap_declaration' has been called on `a_declaration',
			-- `deep_wrap_declaration' can be called to wrap `a_declaration's members
			-- if any exist.
			-- TODO: declarations can be treated with a simpler one stap wrapping process
		require
			a_declaration_not_void: a_declaration /= Void
			eiffel_wrapper_set_has_a_declaration: eiffel_wrapper_set.has_wrapper_for_declaration (a_declaration)
			a_include_header_file_name_not_void: a_include_header_file_name /= Void
			a_eiffel_wrapper_set_not_void: a_eiffel_wrapper_set /= Void
		local
			cs: DS_LINEAR_CURSOR [EWG_CONFIG_RULE]
			declaration_wrapped: BOOLEAN
		do
			from
				cs := rule_list.new_cursor
				cs.start
			until
				cs.off
			loop
				if cs.item.matching_clause.is_matching_declaration (a_declaration) then
					if cs.item.wrapper_clause.accepts_declaration (a_declaration) then
						cs.item.wrapper_clause.deep_wrap_declaration (a_declaration,
																					 a_include_header_file_name,
																					 a_eiffel_wrapper_set,
																					 Current)
						declaration_wrapped := True
						cs.go_after
					else
						-- TODO: proper error reporting
						print ("%N%NWrapper clause does not accept decl%N%N")
					end
				end
				if not cs.off then
					cs.forth
				end
			end
		end


	default_deep_wrap_declaration (a_declaration: EWG_C_AST_DECLARATION;
											 a_include_header_file_name: STRING;
											 a_eiffel_wrapper_set: EWG_EIFFEL_WRAPPER_SET)
			-- Once `force_shallow_wrap_declaration' has been called on
			-- `a_declaration', `default_deep_wrap_declaration' can be
			-- called to wrap `a_declaration's members if any exist.
			-- TODO: declarations can be treated with a simpler one stap
			-- wrapping process
		require
			a_declaration_not_void: a_declaration /= Void
			eiffel_wrapper_set_has_a_declaration: eiffel_wrapper_set.has_wrapper_for_declaration (a_declaration)
			a_include_header_file_name_not_void: a_include_header_file_name /= Void
			a_eiffel_wrapper_set_not_void: a_eiffel_wrapper_set /= Void
		local
			wrapper_clause: EWG_CONFIG_FUNCTION_WRAPPER_CLAUSE
		do
			create wrapper_clause.make
				check
					-- Should be precondition
					accepts_declaration: wrapper_clause.accepts_declaration (a_declaration)
				end
			wrapper_clause.deep_wrap_declaration (a_declaration,
															  a_include_header_file_name,
															  a_eiffel_wrapper_set,
															  Current)
		end

	append_rule (a_rule: EWG_CONFIG_RULE)
			-- Add `a_rule' at the end of the rule list.
		require
			a_rule_not_void: a_rule /= Void
		do
			rule_list.force_last (a_rule)
		ensure
			has_rule: has_rule (a_rule)
		end

	append_macro_rule (a_rule: EWG_CONFIG_RULE)
			-- Add `a_rule' at the end of the rule list.
		require
			a_rule_not_void: a_rule /= Void
		do
			rule_macro_list.force_last (a_rule)
		ensure
			has_rule: has_macro_rule (a_rule)
		end

	set_include_path (a_path: PATH)
			-- Set `include_path` with `a_path`.
		do
			include_path := a_path
		ensure
			include_path_set: include_path = a_path
		end

	set_comile_options (a_options: like compile_options)
		do
			compile_options := a_options
		ensure
			compile_options_set: compile_options = a_options
		end

feature {NONE} -- Implementation

	rule_list: DS_ARRAYED_LIST [EWG_CONFIG_RULE]


	default_wrapper_clause: EWG_CONFIG_WRAPPER_CLAUSE

feature {EWG_CONFIG_SYSTEM, EWG_EIFFEL_WRAPPER_BUILDER} -- Macro implementation

	rule_macro_list: DS_ARRAYED_LIST [EWG_CONFIG_RULE]

feature {NONE} -- Implementation

	shallow_wrapped_type_table: DS_HASH_TABLE [BOOLEAN, EWG_C_AST_TYPE]
			-- Table containing all types that have a wrapper in this set.
			-- If their value is `True' then their members have not yet been wrapped.

	deeply_wrapped_table: DS_HASH_SET [EWG_C_AST_TYPE]

	all_members_of_all_types_wrapped: BOOLEAN
			-- Have all members of all types been wrapped yet?
		local
			cs: DS_HASH_TABLE_CURSOR [BOOLEAN, EWG_C_AST_TYPE]
		do
			Result := True
			from
				cs := shallow_wrapped_type_table.new_cursor
				cs.start
			until
				cs.off
			loop
				if cs.item = False then
					Result := False
					cs.go_after
				else
					cs.forth
				end
			end
		end

	make_sure_type_will_be_deeply_wrapped (a_type: EWG_C_AST_TYPE)
		require
			a_type_not_void: a_type /= Void
		do
			if
				not shallow_wrapped_type_table.has (a_type)
			then
				shallow_wrapped_type_table.force_new (False, a_type)
			end
		end

feature {EWG_CONFIG_WRAPPER_CLAUSE}

	mark_type_completely_wrapped (a_type: EWG_C_AST_TYPE)
		require
			a_type_not_void: a_type /= Void
			type_needs_deep_wrapping: does_type_need_deep_wrapping (a_type)
		do
			shallow_wrapped_type_table.replace (True, a_type)
			deeply_wrapped_table.force (a_type.skip_wrapper_irrelevant_types)
		end

feature {EWG_EIFFEL_WRAPPER_BUILDER}

	new_shallow_wrapped_type_table_cursor: DS_HASH_TABLE_CURSOR [BOOLEAN, EWG_C_AST_TYPE]
		do
			Result := shallow_wrapped_type_table.new_cursor
		ensure
			result_not_void: Result /= Void
		end

	number_of_types_whose_members_have_not_been_wrapped_yet: INTEGER
			-- Number of types, whose members have yet to be wrapped
		local
			cs: DS_HASH_TABLE_CURSOR [BOOLEAN, EWG_C_AST_TYPE]
		do
			from
				cs := shallow_wrapped_type_table.new_cursor
				cs.start
			until
				cs.off
			loop
				if
					cs.item = False
				then
					Result := Result + 1
				end
				cs.forth
			end
		end

invariant

	header_file_name_not_void: header_file_name /= Void
	header_file_name_not_empty: header_file_name.count > 0
	output_directory_name_not_void: output_directory_name /= Void
	rule_list_not_void: rule_list /= Void
	rule_macro_list_not_void: rule_macro_list /= Void
--	rule_list_not_has_empty: not rule_list.has (Void)
	default_wrapper_clause_not_void: default_wrapper_clause /= Void
	eiffel_wrapper_set_not_void: eiffel_wrapper_set /= Void
	directory_structure_not_void: directory_structure /= Void
	shallow_wrapped_type_table_not_void: shallow_wrapped_type_table /= Void
	name_not_void: name /= Void
	name_not_empty: name.count > 0

end
