indexing 
	description: "Common ancestor to Eiffel routine for both ASP and VS implementations"
	date: "$$"
	revision: "$$"

deferred class
	ECDP_ROUTINE_INTERFACE

inherit
	ECDP_FEATURE
		redefine
			make,
			ready
		end
	
	ECDP_SHARED_CONSUMER_CONTEXT
		undefine
			default_create,
			is_equal
		end

	ECDP_SHARED_DATA
		export
			{NONE} all
		undefine
			default_create,
			is_equal
		end

feature {NONE} -- Initialization

	make is
			-- | Call Precursor {ECDP_FEATURE}.

			-- Initialize attributes.
		do
			Precursor {ECDP_FEATURE}
			create arguments.make
			create locals.make
			locals.compare_objects
				-- Code repeatedly adds the same local variable so this needs to be caught.
			create statements.make
		ensure then
			non_void_arguments: arguments /= Void
			non_void_locals: locals /= Void
			non_void_statements: statements /= Void
		end
		
feature -- Access

	arguments: LINKED_LIST [ECDP_PARAMETER_DECLARATION_EXPRESSION]
			-- Routine arguments

	locals: LINKED_LIST [ECDP_VARIABLE_DECLARATION_STATEMENT]
			-- Routine local variables

	statements: LINKED_LIST [ECDP_STATEMENT]
			-- Routine statements
		
	implemented_type_name: STRING
			-- Implemented type name

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
			add_tab_to_indent_string
			create Result.make (1000)
			Result.append (signature)
			Result.append (Dictionary.Space)
			Result.append (Dictionary.Is_keyword)
			Result.append (Dictionary.New_line)
			
			if comments /= Void and then not comments.is_empty then
				Result.append (comments_code)
			end

			add_tab_to_indent_string
			Result.append (indexing_clause)
			Result.append (body)
			sub_tab_to_indent_string
			Result.append (indent_string)
			Result.append (Dictionary.End_keyword)
			Result.append (Dictionary.New_line)
			sub_tab_to_indent_string
			sub_tab_to_indent_string
		end

feature -- Status Report

	is_inherited: BOOLEAN is
			-- Is inherited ?
		do
			Result := not Feature_finder.declaring_type (implemented_type_name, name, arguments).is_equal (implemented_type_name)
		end

	is_deferred: BOOLEAN
			-- Is routine deferred?

	ready: BOOLEAN is
			-- Is feature ready to be generated?
		do
			Result := Precursor {ECDP_FEATURE} and arguments /= Void and locals /= Void and statements /= Void
		end

feature -- Status Setting

	set_implemented_type_name (a_name: like implemented_type_name) is
			-- Set `implemented_type_name' with `a_name'.
		require
			non_void_name: a_name /= Void
			not_empty_name: not a_name.is_empty
		do
			implemented_type_name := a_name
		ensure
			implemented_type_name_set: implemented_type_name = a_name
		end

	set_deferred (a_value: like is_deferred) is
			-- Set `is_deferred' with `a_value'.
		do
			is_deferred := a_value
		ensure
			is_deferred_set: is_deferred = a_value
		end

feature -- Basic Operations

	add_argument (an_argument: ECDP_PARAMETER_DECLARATION_EXPRESSION) is
			-- Add `an_argument' to `arguments'.
		require
			non_void_argument: an_argument /= Void
		do
			if not arguments.has (an_argument) then
				arguments.extend (an_argument)
			end
		ensure
			argument_added: arguments.has (an_argument)
		end

	add_local (a_local_variable: ECDP_VARIABLE_DECLARATION_STATEMENT) is
			-- Add `a_local_variable' to `locals'.
		require
			non_void_local_variable: a_local_variable /= Void
		do
			if not locals.has (a_local_variable) then
				locals.extend (a_local_variable)
			end
		ensure
			local_variable_added: locals.has (a_local_variable)
		end

	add_statement (a_statement: ECDP_STATEMENT) is
			-- Add `a_statement' to `statements'.
		require
			non_void_statement: a_statement /= Void
		do
			if not statements.has (a_statement) then
				statements.extend (a_statement)
			end
		ensure
			statement_added: statements.has (a_statement)
		end

feature {NONE} -- Implementation

	signature: STRING is
			-- | Result := "[defered] [frozen] `routine_name'[(`argument',...)]"
			-- Routine signature (without `is' keyword)
		require
			ready: ready
		local
			l_parent_type_name: STRING
			l_arguments_str: STRING
		do
			create Result.make (160)
			Result.append (Indent_string)
			if is_deferred then
				Result.append ("deferred ")
			end
			if is_frozen then 
				Result.append ("frozen ")
			end
			
			if is_inherited and not name.is_equal (".ctor") then
				l_parent_type_name := Feature_finder.declaring_type (implemented_type_name, name, arguments)
				Result.append (Feature_finder.eiffel_feature_name_from_dynamic_args (Dotnet_types.dotnet_type (l_parent_type_name), name, arguments))
			else
					-- watch out!!!
					-- maybe the feature is inherited, but the `name' has already been replaced by the corresponding eiffel_name (case if redefinition).
				Result.append (Resolver.eiffel_entity_name (name))
			end
			
			create l_arguments_str.make (150)
			from
				arguments.start
				if not arguments.after then
					l_arguments_str.append (" (")
					l_arguments_str.append (arguments.item.code)
					arguments.forth
				end
			until
				arguments.after
			loop
				l_arguments_str.append ("; ")
				l_arguments_str.append (arguments.item.code)
				arguments.forth
			end
			if arguments.count > 0 then
				l_arguments_str.append_character (')')
			end

			Result.append (l_arguments_str)
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
			l_decl: ECDP_VARIABLE_DECLARATION_STATEMENT
		do
			create str_local.make (1000)
			
			if dummy_variable then
				create l_decl.make
				l_decl.set_name (Return_var_name)
				l_decl.set_eiffel_type ("SYSTEM_OBJECT")
				add_local (l_decl)
				set_dummy_variable (False)
			end

				-- Local variables
			from
				locals.start
				if not locals.after then
					str_local.append (indent_string)
					str_local.append (Dictionary.Local_keyword)
					str_local.append (Dictionary.New_line)
					add_tab_to_indent_string
					str_local.append (locals.item.code)
					locals.forth
				end
			until
				locals.after
			loop
				str_local.append (locals.item.code)
				locals.forth
			end
			if locals.count > 0 then
				sub_tab_to_indent_string
			end

			create str_body.make (9000)
			str_body.append (indent_string)
			if is_once_routine then
				str_body.append (dictionary.Once_keyword)
			elseif is_deferred then
				str_body.append (dictionary.Deferred_keyword)
			else
				str_body.append (dictionary.Do_keyword)
			end
			str_body.append (dictionary.New_line)
			add_tab_to_indent_string

			str_body.append (add_constructor)

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

	add_constructor: STRING is
			-- Add constructor
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

end -- class ECDP_ROUTINE_INTEFACE

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