indexing 
	description: "Source code generator for delegate creation expression"
	date: "$$"
	revision: "$$"
	
class
	ECD_DELEGATE_CREATE_EXPRESSION

inherit
	ECD_EXPRESSION

create
	make

feature {NONE} -- Initialization

	make is
			-- Initialize `delegate_type' and `method_name'.
		do
			create method_name.make_empty
			create delegate_type.make_empty
		ensure
			non_void_method_name: method_name /= Void
			non_void_delegate_type: method_name /= Void
		end
		
feature -- Access

	delegate_type: STRING
			-- Type of delegate to create
	
	target_object: ECD_EXPRESSION
			-- Target object
			
	method_name: STRING
			-- method name
	
	code: STRING is
			-- | Result := "create {`delegate_type'}.constructor_name (`target_object.expression', $`method_name')"
			-- Eiffel code of delegate create expression
		do
			Check
				not_empty_type: not delegate_type.is_empty
				non_void_target_object: target_object /= Void
				not_empty_method_name: not method_name.is_empty
			end
		
			create Result.make (160)
			
			if new_line then
				Result.append (indent_string)
			end
			Result.append (Dictionary.Create_keyword)
			Result.append (Dictionary.Space)
			Result.append (Dictionary.Opening_brace_bracket)
			Result.append (Resolver.eiffel_type_name (delegate_type))
			Result.append (Dictionary.Closing_brace_bracket)
			Result.append (Dictionary.Dot_keyword)
			Result.append (generate_constructor_name)
			Result.append (Dictionary.Space)
			Result.append (Dictionary.Opening_round_bracket)
			Result.append (target_object.code)
			Result.append (Dictionary.Comma)
			Result.append (Dictionary.Space)
			Result.append ("$")
			Result.append (generate_eiffel_method_name)
			Result.append (Dictionary.Closing_round_bracket)
		end
		
feature -- Status Report

	ready: BOOLEAN is
			-- Is expression ready to be generated?
		do
			Result := True
		end

	type: TYPE is
			-- Type
		do
			Result := referenced_type_from_name (delegate_type)
		end

feature -- Status Setting

	set_delegate_type (a_type: like delegate_type) is
			-- Set `delegate_type' with `a_type'.
		require
			non_void_type: a_type /= Void
		do
			delegate_type := a_type
		ensure
			delegate_type_set: delegate_type = a_type
		end

	set_target_object (an_expression: like target_object) is
			-- Set `target_object' with `an_expression'.
		require
			non_void_expression: an_expression /= Void
		do
			target_object := an_expression
		ensure
			target_object_set: target_object = an_expression
		end
		
	set_method_name (a_name: like method_name) is
			-- Set `method_name' with `a_name'.
		require
			non_void_name: a_name /= Void
		do
			method_name := a_name
		ensure
			method_name_set: method_name = a_name
		end

feature {NONE} -- Implementation
	
	constructor_delegate_arguments: NATIVE_ARRAY [TYPE] is
			-- Arguments of the delegate constructor.
		once
			create Result.make (2)
			Result.put (0, referenced_type_from_name ("System.Object"))
			Result.put (1, referenced_type_from_name ("System.IntPtr"))
		ensure
			non_void_result: Result /= Void
		end

	generate_constructor_name: STRING is
			-- Generate eiffel constructor name.
		require
			method_name_set: not method_name.is_empty
			target_object_set: target_object /= Void
			delegate_type_set: not delegate_type.is_empty
		local
			l_type: TYPE
		do
			Result := Feature_finder.eiffel_feature_name_from_static_args (l_type, ".ctor", constructor_delegate_arguments)
		ensure
			Result_set: Result /= Void
		end

	generate_eiffel_method_name: STRING is
			-- generate eiffel method name.
		require
			method_name_set: not method_name.is_empty
			target_object_set: target_object /= Void
		do
				-- Already formatted
			Result := Resolver.eiffel_entity_name (method_name)
		ensure
			Result_set: Result /= Void
		end
		
invariant
	non_void_method_name: method_name /= Void
	non_void_delegate_type: method_name /= Void

end -- class ECD_DELEGATE_CREATE_EXPRESSION

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