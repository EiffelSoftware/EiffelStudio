indexing
	description: "Eiffel class feature"
	status: "See notice at end of class";
	date: "$Date$"
	revision: "$Revision$"

class
	WIZARD_WRITER_FEATURE

inherit
	WIZARD_WRITER

	WIZARD_VARIABLE_NAME_MAPPER

creation
	make,
	make_constant

feature {NONE} -- Initialization

	make is
			-- Initialize data.
		do
			create {LINKED_LIST [STRING]} arguments.make
			create {LINKED_LIST [WIZARD_WRITER_ASSERTION]} preconditions.make
			create {LINKED_LIST [WIZARD_WRITER_ASSERTION]} postconditions.make
			create {LINKED_LIST [STRING]} local_variables.make
		end

	make_constant (a_value: INTEGER; a_name, a_description: STRING) is
			-- Make integer constant `a_name' with value `a_value' and
			-- comment `a_description'.
		do
			constant := True
			body := a_value.out
			name := clone (a_name)
			comment := clone (a_description)
			result_type := clone (Integer_type)
		ensure
			name_set: name.is_equal (a_name)
			description_set: comment.is_equal (a_description)
		end

feature -- Access

	generated_code: STRING is
			-- Generated code
		do
			Result := clone (Tab)
			Result.append (name_for_feature (name))
			if not constant and then not arguments.is_empty then
				Result.append (Space)
				from
					arguments.start
					if not arguments.off then
						Result.append (Open_parenthesis)
						Result.append (arguments.item)
						arguments.forth
					end
				until
					arguments.after
				loop
					Result.append (Semicolon)
					Result.append (Space)
					Result.append (arguments.item)
					arguments.forth
				end
				if not arguments.is_empty then
					Result.append (Close_parenthesis)
				end
			end
			if result_type /= Void and then not result_type.is_empty then
				Result.append (Colon)
				Result.append (Space)
				Result.append (result_type)
			end
			if not is_attribute then
				Result.append (Space)
				Result.append (Is_keyword)
				if constant then
					Result.append (Space)
					Result.append (body)
				end
			end
			Result.append (New_line_tab_tab_tab)
			Result.append (Double_dash)
			Result.append (Space)
			Result.append (comment)

			if not is_attribute and not constant then
				Result.append (New_line_tab_tab)
				from
					preconditions.start
					if not preconditions.after then
						Result.append (Require_keyword)
					end
				until
					preconditions.after
				loop
					Result.append (New_line_tab_tab_tab)
					Result.append (preconditions.item.generated_code)
					preconditions.forth
				end
				if not preconditions.is_empty then
					Result.append (New_line_tab_tab)
				end
				if not is_deferred then
					from
						local_variables.start
						if not local_variables.after then
							Result.append (Local_keyword)
						end
					until
						local_variables.after
					loop
						Result.append (New_line_tab_tab_tab)
						Result.append (local_variables.item)
						local_variables.forth
					end
					if not local_variables.is_empty then
						Result.append (New_line_tab_tab)
					end
				end
				if is_deferred then
					Result.append (Deferred_keyword)
				elseif is_once then
					Result.append (Once_keyword)
				elseif is_external then
					Result.append (External_keyword)
				else
					Result.append (Do_keyword)
				end
				Result.append (New_line)
				if not is_deferred then
					Result.append (body)
				end
				Result.append (New_line_tab_tab)
				from
					postconditions.start
					if not postconditions.after then
						Result.append (Ensure_keyword)
					end
				until
					postconditions.after
				loop
					Result.append (New_line_tab_tab_tab)
					Result.append (postconditions.item.generated_code)
					postconditions.forth
				end
				if postconditions /= Void and then not postconditions.is_empty then
					Result.append (New_line_tab_tab)
				end
				Result.append (End_keyword)
			end
		end

	can_generate: BOOLEAN is
			-- Can code be generated?
		do
			Result := name /= Void and ((is_deferred or is_attribute) implies (body = Void)) and
				comment /= Void
		end

	name: STRING
			-- Feature name

	is_deferred: BOOLEAN
			-- Is feature is_deferred?
	
	is_once: BOOLEAN
			-- Is feature a once?

	is_external: BOOLEAN
			-- Is feature an external?

	is_attribute: BOOLEAN
			-- Is feature an attribute?

	arguments: LIST [STRING]
			-- Feature arguments
			-- Each element contains both name and type
			-- E.g.: ("arg1: TYPE1", "arg2, arg3: TYPE2")
	
	local_variables: LIST [STRING]
			-- Feature local variables
			-- Each element contains both name and type
			-- E.g.: ("arg1: TYPE1", "arg2, arg3: TYPE2")
			
	result_type: STRING
			-- Feature result type
	
	preconditions: LIST [WIZARD_WRITER_ASSERTION]
			-- Preconditions

	postconditions: LIST [WIZARD_WRITER_ASSERTION]
			-- Postconditions

	body: STRING
			-- Feature body

	comment: STRING
			-- Feature comment

	constant: BOOLEAN
			-- Is feature a constant?

feature -- Element Change

	set_name (a_name: like name) is
			-- Set `name' with `a_name'.
		do
			name := clone (a_name)
		ensure
			name_set: name.is_equal (a_name)
		end

	add_argument (a_argument: STRING) is
			-- Add `a_argument' to `arguments'.
		require
			non_void_argument: a_argument /= Void
			valid_argument: not a_argument.is_empty
			not_constant: not constant
			not_attribute: not is_attribute
		do
			arguments.extend (a_argument)
		ensure
			added: arguments.last = a_argument
		end
	
	add_local_variable (a_variable: STRING) is
			-- Add `a_variable' to `local_variables'.
		require
			non_void_variable: a_variable /= Void
			valid_variable: not a_variable.is_empty
			not_constant: not constant
			not_attribute: not is_attribute
		do
			local_variables.extend (a_variable)
		ensure
			added: local_variables.last = a_variable
		end

	set_result_type (a_result_type: like result_type) is
			-- Set `result_type' with `a_result_type'.
		require
			non_void_result_type: a_result_type /= Void
			valid_result_type: not a_result_type.is_empty
			not_constant: not constant
		do
			result_type := clone (a_result_type)
		ensure
			result_type_set: result_type.is_equal (a_result_type)
		end
	
	add_precondition (a_precondition: WIZARD_WRITER_ASSERTION) is
			-- Add `a_precondition' to `preconditions'.
		require
			non_void_precondition: a_precondition /= Void
			not_constant: not constant
			not_attribute: not is_attribute
		do
			preconditions.extend (a_precondition)
		ensure
			precondition_set: preconditions.last = a_precondition
		end
	
	add_postcondition (a_postcondition: WIZARD_WRITER_ASSERTION) is
			-- Add `a_postcondition' to `postconditions'.
		require
			non_void_postcondition: a_postcondition /= Void
			not_constant: not constant
			not_attribute: not is_attribute
		do
			postconditions.extend (a_postcondition)
		ensure
			postcondition_set: postconditions.last = a_postcondition
		end
	
	set_body (a_body: like body) is
			-- Set `body' with `a_body'.
		require
			non_void_body: a_body /= Void
			valid_syntax: (not a_body.is_empty) implies (not (a_body.item (a_body.count) = '%N') and not (a_body.item (1) = '%N'))
			not_constant: not constant
			not_deferred: not is_deferred
		do
			body := clone (a_body)
		ensure
			body_set: body.is_equal (a_body)
		end
	
	set_comment (a_comment: like comment) is
			-- Set `comment' with `a_comment'.
		require
			non_void_comment: a_comment /= Void
			valid_comment: not a_comment.is_empty
			valid_syntax: not (a_comment.item (a_comment.count) = '%N') and not (a_comment.item (1) = '%N')
		do
			comment := clone (a_comment)
		ensure
			comment_set: comment.is_equal (a_comment)
		end

	set_deferred is
			-- Set `is_deferred' to `True'.
		require
			not_constant: not constant
			not_attribute: not is_attribute
			not_external: not is_external
		do
			is_deferred := True
		ensure
			is_deferred: is_deferred
		end
	
	set_effective is
			-- Set `is_deferred', `is_once' and `is_external' to False.
		do
			is_deferred := False
			is_once := False
			is_external := False
		ensure
			effective: not is_deferred
		end

	set_once is
			-- Set `is_once' to `True'.
		require
			not_constant: not constant
			not_deferred: not is_deferred
			not_external: not is_external
			not_attribute: not is_attribute
		do
			is_once := True
		end

	set_external is
			-- Set `is_external' to `True'.
		require
			not_constant: not constant
			not_deferred: not is_deferred
			not_once: not is_once
			not_attribute: not is_attribute
		do
			is_external := True
		ensure
			external_set: is_external
		end

	set_attribute is
			-- Set `is_attribute' to `True'.
		require
			not_constant: not constant
			not_deferred: not is_deferred
			not_once: not is_once
		do
			is_attribute := True
		ensure
			attribute_set: is_attribute
		end

invariant

	non_void_arguments: not constant implies arguments /= Void
	non_void_preconditions: not constant implies preconditions /= Void
	non_void_postconditions: not constant implies postconditions /= Void
	non_void_local_variables: not constant implies local_variables /= Void
	correct_deferred_feature: is_deferred implies body = Void
	constant_or_deferred_or_once_or_external: (constant implies (not is_deferred and not is_external and not is_once)) and
										(is_deferred implies (not constant and not is_external and not is_once)) and
										(is_external implies (not constant and not is_deferred and not is_once)) and
										(is_once implies (not constant and not is_deferred and not is_external))

end -- class WIZARD_WRITER_FEATURE

--|----------------------------------------------------------------
--| EiffelCOM: library of reusable components for ISE Eiffel.
--| Copyright (C) 1988-1999 Interactive Software Engineering Inc.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 2nd floor
--| 270 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support http://support.eiffel.com
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------
  