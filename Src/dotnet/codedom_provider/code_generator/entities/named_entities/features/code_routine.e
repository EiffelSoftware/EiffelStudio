indexing 
	description: "Common ancestor to Eiffel routine for both ASP and VS implementations"
	date: "$$"
	revision: "$$"

deferred class
	CODE_ROUTINE

inherit
	CODE_FEATURE
		redefine
			make
		end

	CODE_GENERATOR_CONSTANTS
		export
			{NONE} all
		undefine
			default_create,
			is_equal
		end

	CODE_SHARED_TYPE_REFERENCE_FACTORY
		export
			{NONE} all
		undefine
			default_create,
			is_equal
		end

feature {NONE} -- Initialization

	make (a_name, a_eiffel_name: STRING) is
			-- Initialize instance.
		do
			Precursor {CODE_FEATURE}  (a_name, a_eiffel_name)
			create {ARRAYED_LIST [CODE_VARIABLE_DECLARATION_STATEMENT]} locals.make (4)
			create {ARRAYED_LIST [CODE_STATEMENT]} statements.make (32)
			create {ARRAYED_LIST [CODE_PARAMETER_DECLARATION_EXPRESSION]} arguments.make (4)
		ensure then
			non_void_arguments: arguments /= Void
			non_void_locals: locals /= Void
			non_void_statements: statements /= Void
		end
		
feature -- Access

	arguments: LIST [CODE_PARAMETER_DECLARATION_EXPRESSION]
			-- Routine arguments

	locals: LIST [CODE_VARIABLE_DECLARATION_STATEMENT]
			-- Routine local variables

	snippet_locals: LIST [CODE_SNIPPET_VARIABLE]
			-- Routine snippet local variables

	statements: LIST [CODE_STATEMENT]
			-- Routine statements
		
	code: STRING is
			-- | result := "`export_clauses'	
			-- |				`signature' is
			-- |						`comment'
			-- |					`preconditions'
			-- |					`body'
			-- |					`postconditions'
			-- |					end"
			-- | Call `generate_signature', `comments_code', `generate_preconditions',
			-- | `generate_body', `generate_postconditions' successively.

			-- Eiffel code of routine
		do	
			increase_tabulation
			create Result.make (1000)
			Result.append (signature)
			Result.append (" is%N")
			Result.append (comments_code)
			increase_tabulation
			Result.append (indexing_clause)
			Result.append (body)
			decrease_tabulation
			Result.append (indent_string)
			Result.append ("end%N")
			decrease_tabulation
			decrease_tabulation
		end

feature {CODE_FACTORY} -- Status Setting

	set_deferred (a_value: like is_deferred) is
			-- Set `is_deferred' with `a_value'.
		do
			is_deferred := a_value
		ensure
			is_deferred_set: is_deferred = a_value
		end

	set_redefined (a_value: like is_redefined) is
			-- Set `is_redefined' with `a_value'.
		do
			is_redefined := a_value
		ensure
			is_redefined_set: is_redefined = a_value
		end

	set_arguments (a_arguments: LIST [CODE_PARAMETER_DECLARATION_EXPRESSION]) is
			-- Set `arguments' with `a_argument'.
		require
			non_void_arguments: a_arguments /= Void
		do
			arguments := a_arguments
		ensure
			arguments_set: arguments = a_arguments
		end

	add_local (a_local_variable: CODE_VARIABLE_DECLARATION_STATEMENT) is
			-- Add `a_local_variable' to `locals'.
		require
			non_void_local_variable: a_local_variable /= Void
		do
			locals.extend (a_local_variable)
		ensure
			local_variable_added: locals.has (a_local_variable)
		end

	add_snippet_local (a_local_variable: CODE_SNIPPET_VARIABLE) is
			-- Add `a_local_variable' to `snippet_locals'.
		require
			non_void_local_variable: a_local_variable /= Void
		do
			snippet_locals.extend (a_local_variable)
		ensure
			local_variable_added: snippet_locals.has (a_local_variable)
		end

	add_statement (a_statement: CODE_STATEMENT) is
			-- Add `a_statement' to `statements'.
		require
			non_void_statement: a_statement /= Void
		do
			statements.extend (a_statement)
		ensure
			statement_added: statements.has (a_statement)
		end

feature {NONE} -- Implementation

	signature: STRING is
			-- | Result := "[defered] [frozen] `routine_name'[(`argument',...)]"
			-- Routine signature (without `is' keyword)
		require
			ready: ready
		do
			create Result.make (160)
			Result.append (Indent_string)
			if is_deferred then
				Result.append ("deferred ")
			end
			if is_frozen then 
				Result.append ("frozen ")
			end
			Result.append (eiffel_name)			
			from
				arguments.start
				if not arguments.after then
					Result.append (" (")
					Result.append (arguments.item.code)
					arguments.forth
				end
			until
				arguments.after
			loop
				Result.append ("; ")
				Result.append (arguments.item.code)
				arguments.forth
			end
			if arguments.count > 0 then
				Result.append_character (')')
			end
			if result_type /= Void then
				Result.append (": ")
				Result.append (result_type.eiffel_name)
			end
		ensure
			signature_generated: Result /= Void and not Result.is_empty
		end

	body: STRING is
			-- | Result := "	[local
			-- |					var: TYPE....]
			-- |				[do,once,deffered]
			-- |					[`other_statements'...]
			-- |				"
		require
			ready: ready
		local
			str_local, str_body: STRING
			l_decl: CODE_VARIABLE_DECLARATION_STATEMENT
		do
			create str_local.make (1000)
			
			if dummy_variable then
				create l_decl.make (create {CODE_VARIABLE_REFERENCE}.make ("Result", result_type, Type_reference_factory.type_reference_from_code (current_type)), Void)
				add_local (l_decl)
				set_dummy_variable (False)
			end

				-- Local variables
			increase_tabulation
			from
				locals.start
				if not locals.after then
					str_local.append (indent_string)
					str_local.append ("local%N")
					str_local.append (locals.item.code)
					locals.forth
				end
			until
				locals.after
			loop
				str_local.append (locals.item.code)
				locals.forth
			end
			from
				snippet_locals.start
				if not snippet_locals.after and locals.count = 0 then
					str_local.append (indent_string)
					str_local.append ("local%N")
					str_local.append (snippet_locals.item.code)
					snippet_locals.forth
				end
			until
				snippet_locals.after
			loop
				str_local.append (snippet_locals.item.code)
				snippet_locals.forth
			end
			decrease_tabulation

			create str_body.make (9000)
			str_body.append (indent_string)
			if is_once_routine then
				str_body.append ("once%N")
			elseif is_deferred then
				str_body.append ("deferred%N")
			else
				str_body.append ("do%N")
			end
			increase_tabulation

			str_body.append (constructor_call)

				-- Routine's statements
			from
				statements.start
			until
				statements.after
			loop
				str_body.append (statements.item.code)
				statements.forth
			end

				-- Put it together
			create Result.make (8192)
			Result.append (str_local)
			Result.append (str_body)
		ensure
			body_generated: Result /= Void and not Result.is_empty
		end

	is_inherited_routine: BOOLEAN is
			-- Is routine inherited?
		do
			Result := False
		end

feature {NONE} -- Specific implementation

	constructor_call: STRING is
			-- Call to constructor, only generate for non designer code generation
		deferred
		ensure
			non_void_add_constructor: Result /= Void
		end
		
	Initialize_component_comment: STRING is "Required for Windows Forms Designer support, do not modify with Text Editor"
		-- Generated comment for 'initialize_component' routine.

invariant
	non_void_arguments: arguments /= Void
	non_void_locals: locals /= Void
	non_void_statements: statements /= Void

end -- class CODE_ROUTINE

--+--------------------------------------------------------------------
--| Eiffel CodeDOM Provider
--| Copyright (C) 2001-2004 Eiffel Software
--| Eiffel Software Confidential
--| All rights reserved. Duplication and distribution prohibited.
--|
--| Eiffel Software
--| 356 Storke Road, Goleta, CA 93117 USA
--| http://www.eiffel.com
--+--------------------------------------------------------------------