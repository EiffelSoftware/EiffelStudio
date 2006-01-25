indexing
	description: "Source code generator for array creation expression"
	date: "$$"
	revision: "$$"
	
class
	CODE_ARRAY_CREATE_EXPRESSION

inherit
	CODE_EXPRESSION

create
	make

feature {NONE} -- Initialization

	make (a_type: CODE_TYPE_REFERENCE; a_size: INTEGER; a_size_expression: CODE_EXPRESSION; a_initializers: LIST [CODE_EXPRESSION]) is
			-- Initialize `initializers'.
		require
			non_void_type: a_type /= Void
			valid_arguments: a_size_expression /= Void xor a_size > 0 xor a_initializers /= Void
		do
			array_type := a_type
			size := a_size
			size_expression := a_size_expression
			initializers := a_initializers
		ensure
			type_set: array_type = a_type
			size_set: size = a_size
			size_expression_set: size_expression = a_size_expression
			initializers_set: initializers = a_initializers
		end
		
feature -- Access

	array_type: CODE_TYPE_REFERENCE
			-- Array type
	
	size: INTEGER
			-- Array size

	size_expression: CODE_EXPRESSION
			-- Array size expression
	
	initializers: LIST [CODE_EXPRESSION]
			-- Array initializers
	
	target: STRING
			-- Creation target

feature -- Code Generation

	code: STRING is
			-- Eiffel code for array creation expression
			-- | 	Result := "create `target'.make (1, `size_expression')" if size_expression /= Void and target /= Void
			-- | OR
			-- | 	Result := "create `target'.make (1, `size')" if size > 0 and target /= Void
			-- | OR
			-- | 	Result := "create {`array_type'}.make (1, `size_expression')" if size_expression /= Void and target = Void
			-- | OR
			-- | 	Result := "create {`array_type'}.make (1, `size')" if size > 0 and target = Void
			-- | OR 
			-- |	Result := "(create {MANIFEST_ARRAY_CONVERTER [SYSTEM_OBJECT]}).convert_to (<<`initializers', `initializers',...>>)
		do
			create Result.make (160)
			if size_expression /= Void or size > 0 then
				Result.append ("create ")
				if target /= Void then
					Result.append (target)					
				else
					Result.append_character ('{')
					Result.append (array_type.eiffel_name)
					Result.append_character ('}')
				end
				Result.append (".make (0, ")
				if size_expression /= Void then
					Result.append (size_expression.code)
				else
					Result.append ((size - 1).out)
				end
				Result.append_character (')')
			elseif initializers /= Void then
				Result.append ("(create {MANIFEST_ARRAY_CONVERTER [")
				Result.append (array_type.eiffel_name)
				Result.append ("]}).cil_array (<<")
				from
					initializers.start
					if not initializers.after then
						Result.append (initializers.item.code)
						initializers.forth
					end
				until
					initializers.after
				loop
					Result.append (", ")
					Result.append (initializers.item.code)
					initializers.forth
				end
				Result.append (">>)")
			end
		end
		
feature -- Status Report

	type: CODE_TYPE_REFERENCE is
			-- Type
		do
			Result := array_type
		end
	
feature {CODE_ASSIGN_STATEMENT} -- Element Settings

	set_target (a_target: like target) is
			-- Set `target' with `a_target'.
		require
			non_void_target: a_target /= Void
		do
			target := a_target
		ensure
			target_set: target = a_target
		end
		
invariant
	non_void_element_type: array_type /= Void
	one_and_only_one_info: size_expression /= Void xor size > 0 xor initializers /= Void
	size_if_target: target /= Void implies (size > 0 or size_expression /= Void)
	
end -- class CODE_ARRAY_CREATE_EXPRESSION

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