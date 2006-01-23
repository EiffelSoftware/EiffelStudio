indexing 
	description: "Common ancestor to Eiffel routine for both ASP and VS implementations"
	legal: "See notice at end of class."
	status: "See notice at end of class."
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
		end

	CODE_SHARED_TYPE_REFERENCE_FACTORY
		export
			{NONE} all
		end

	CODE_STOCK_TYPE_REFERENCES
		export
			{NONE} all
		end

feature {NONE} -- Initialization

	make (a_name, a_eiffel_name: STRING) is
			-- Initialize instance.
		do
			Precursor {CODE_FEATURE}  (a_name, a_eiffel_name)
			create {ARRAYED_LIST [CODE_VARIABLE]} locals.make (4)
			create {ARRAYED_LIST [CODE_SNIPPET_VARIABLE]} snippet_locals.make (0)
			create cast_locals.make (1)
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

	locals: LIST [CODE_VARIABLE]
			-- Routine local variables

	snippet_locals: LIST [CODE_SNIPPET_VARIABLE]
			-- Routine snippet local variables

	cast_locals: HASH_TABLE [CODE_TYPE_REFERENCE, STRING]
			-- Local variables used for cast expressions
			-- Key is variable eiffel name
			-- Value is expression with type of variable

	statements: LIST [CODE_STATEMENT]
			-- Routine statements
	
	last_cast_variable: STRING
			-- Last cast variable name

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
		local
			l_creation_routine: CODE_CREATION_ROUTINE
		do	
			increase_tabulation
			create Result.make (1000)
			Result.append (signature)
			Result.append (" is%N")
			Result.append (comments_code)
			increase_tabulation
			Result.append (indexing_clause)
			Result.append (locals_code)
			Result.append (indent_string)
			if is_once_routine then
				Result.append ("once%N")
			elseif is_deferred then
				Result.append ("deferred%N")
			else
				Result.append ("do%N")
			end
			l_creation_routine ?= Current
			if l_creation_routine /= Void then
				increase_tabulation
				Result.append (indent_string)
				Result.append ("if not constructor_called then%N")
				increase_tabulation
				Result.append (indent_string)
				Result.append ("constructor_called := True%N")
				Result.append (body)
				decrease_tabulation
				Result.append (indent_string)
				Result.append ("end%N")
				decrease_tabulation
			else
				increase_tabulation
				Result.append (body)
				decrease_tabulation
			end
			Result.append (indent_string)
			Result.append ("end%N%N")
			decrease_tabulation
			decrease_tabulation
		end

feature {CODE_FACTORY} -- Status Setting

	set_deferred (a_value: like is_deferred) is
			-- Set `is_deferred' with `a_value'.
		require
			in_code_analysis: current_state = Code_analysis
		do
			is_deferred := a_value
		ensure
			is_deferred_set: is_deferred = a_value
		end

	set_redefined (a_value: like is_redefined) is
			-- Set `is_redefined' with `a_value'.
		require
			in_code_analysis: current_state = Code_analysis
		do
			is_redefined := a_value
		ensure
			is_redefined_set: is_redefined = a_value
		end

	set_arguments (a_arguments: LIST [CODE_PARAMETER_DECLARATION_EXPRESSION]) is
			-- Set `arguments' with `a_argument'.
		require
			non_void_arguments: a_arguments /= Void
			in_code_analysis: current_state = Code_analysis
		do
			arguments := a_arguments
		ensure
			arguments_set: arguments = a_arguments
		end

	add_local (a_local_variable: CODE_VARIABLE) is
			-- Add `a_local_variable' to `locals'.
		require
			non_void_local_variable: a_local_variable /= Void
			in_code_analysis: current_state = Code_analysis
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

	add_cast_local (a_expression: CODE_EXPRESSION; a_type: CODE_TYPE_REFERENCE) is
			-- Add local variable for cast expression with type `a_type'.
		require
			non_void_type: a_type /= Void
		do
			last_cast_variable := cast_variable_name
			add_statement (create {CODE_ASSIGNMENT_ATTEMPT_STATEMENT}.make (last_cast_variable, a_expression))
			cast_locals.put (a_type, last_cast_variable)
		ensure
			non_void_last_cast_variable: last_cast_variable /= Void
			local_added: cast_locals.item (last_cast_variable) = a_type
		end
	
	add_statement (a_statement: CODE_STATEMENT) is
			-- Add `a_statement' to `statements'.
		require
			non_void_statement: a_statement /= Void
			in_code_analysis: current_state = Code_analysis
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
			in_code_generation: current_state = Code_generation
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
			if result_type /= Void and then not result_type.name.is_equal ("System.Void") then
				Result.append (": ")
				Result.append (result_type.eiffel_name)
			end
		ensure
			signature_generated: Result /= Void and not Result.is_empty
		end

	locals_code: STRING is
			-- | Result := "	[local
			-- |					var: SYSTEM_TYPE....]
		require
			in_code_generation: current_state = Code_generation
		local
			l_need_dummy: BOOLEAN
		do
			create Result.make (1000)
			
				-- Dummy local for method with return value not in assignment statement
			from
				statements.start
			until
				statements.after or l_need_dummy
			loop
				l_need_dummy := statements.item.need_dummy
				statements.forth
			end

			if l_need_dummy then
				Result.append (indent_string)
				Result.append ("local%N")
				increase_tabulation
				Result.append (indent_string)
				Result.append ("res: SYSTEM_OBJECT%N")
				decrease_tabulation
			end

			from
				locals.start
				if not locals.after then
					if not l_need_dummy then
						Result.append (indent_string)
						Result.append ("local%N")				
					end
					increase_tabulation
					Result.append (locals.item.declaration_code)
					locals.forth
				end
			until
				locals.after
			loop
				Result.append (locals.item.declaration_code)
				locals.forth
			end
			if locals.count > 0 then
				decrease_tabulation
			end
			from
				snippet_locals.start
				if not snippet_locals.after and locals.count = 0 then
					Result.append (indent_string)
					Result.append ("local%N")
					increase_tabulation
					Result.append (snippet_locals.item.code)
					Result.append_character ('%N')
					snippet_locals.forth
				end
			until
				snippet_locals.after
			loop
				Result.append (snippet_locals.item.code)
				Result.append_character ('%N')
				snippet_locals.forth
			end
			if snippet_locals.count > 0 then
				decrease_tabulation
			end
			from
				cast_locals.start
				if not cast_locals.after then
					if locals.count = 0 and snippet_locals.count = 0 then
	 					Result.append (indent_string)
						Result.append ("local%N")
					end
					increase_tabulation
					Result.append (indent_string)
					Result.append (cast_locals.key_for_iteration)
					Result.append (": ")
					Result.append (cast_locals.item_for_iteration.eiffel_name)
					Result.append_character ('%N')
					cast_locals.forth
				end
			until
				cast_locals.after
			loop
				Result.append (indent_string)
				Result.append (cast_locals.key_for_iteration)
				Result.append (": ")
				Result.append (cast_locals.item_for_iteration.eiffel_name)
				Result.append_character ('%N')
				cast_locals.forth
			end
			if cast_locals.count > 0 then
				decrease_tabulation
			end
		ensure
			locals_generated: Result /= Void
		end

	body: STRING is
			-- | Result := "	[local
			-- |					var: SYSTEM_TYPE....]
			-- |				[do,once,deffered]
			-- |					[`other_statements'...]
			-- |				"
		require
			in_code_generation: current_state = Code_generation
		do
			create Result.make (9000)
			Result.append (constructor_call)
			from
				statements.start
			until
				statements.after
			loop
				Result.append (statements.item.code)
				statements.forth
			end
		ensure
			body_generated: Result /= Void and not Result.is_empty
		end

	cast_variable_name: STRING is
			-- Unique cast variable name
		do
			Result := "l_cast_result_"
			cast_variable_count.set_item (cast_variable_count.item + 1)
			Result.append (cast_variable_count.out)
		end
	
	cast_variable_count: INTEGER_REF is
			-- Cast variable counter
		once
			create Result
		end
		
feature {NONE} -- Specific implementation

	constructor_call: STRING is
			-- Call to constructor, only generate for non designer code generation
		require
			in_code_generation: current_state = Code_generation
		deferred
		ensure
			non_void_add_constructor: Result /= Void
		end
		
invariant
	non_void_arguments: arguments /= Void
	non_void_locals: locals /= Void
	non_void_snippet_locals: snippet_locals /= Void
	non_void_statements: statements /= Void

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