indexing 
	description: "Source code generator for creation expressions"
	date: "$$"
	revision: "$$"
	
class
	CODE_OBJECT_CREATE_EXPRESSION

inherit
	CODE_EXPRESSION

create
	make

feature {NONE} -- Initialization

	make is
			-- Initialize `type', `arguments'.
		do
			create object_created.make_empty
			create target_type.make_empty
			create arguments.make
			create constructor_name.make_empty
		ensure
			non_void_object_created: object_created /= Void
			non_void_type: type /= Void
			non_void_arguments: arguments /= Void
			non_void_constructor_name: constructor_name /= Void
		end
		
feature -- Access

	object_created: STRING
			-- Object created

	target_type: STRING
			-- type of object creation
			
	arguments: LINKED_LIST [CODE_EXPRESSION]
			-- Arguments to use when creating the object
			
	constructor_name: STRING
			-- Constructor name
			
	code: STRING is
			-- | Result := "create `object_created'.`constructor_name' [(`arguments', ...)]"
			-- | Result := "create {`type'}.`constructor_name' [(`arguments', ...)]" if `object_created'.is_empty
			-- Eiffel code of object create expression
		do
			check
				target_type_set: not target_type.is_empty
				constructor_name_set: not constructor_name.is_empty
			end
		
			create Result.make (160)
			if new_line then
				Result.append (indent_string)
			end
			Result.append (Dictionary.Create_keyword)
			Result.append (Dictionary.Space)
			if not object_created.is_empty then
				Result.append (Resolver.eiffel_entity_name (object_created))
			else
				Result.append (Dictionary.Opening_brace_bracket)
				Result.append (Resolver.eiffel_type_name (target_type))
				Result.append (Dictionary.Closing_brace_bracket)				
			end
			
			Result.append (".make")

			from
				arguments.start
				if not arguments.after then
					Result.append (Dictionary.Space)
					Result.append (Dictionary.Opening_round_bracket)
					Result.append (arguments.item.code)
					arguments.forth
				end
			until
				arguments.after
			loop
				Result.append (Dictionary.Comma)
				Result.append (Dictionary.Space)
				Result.append (arguments.item.code)
				arguments.forth
			end
			if arguments.count > 0 then
				Result.append (Dictionary.Closing_round_bracket)
			end
			
			if new_line then
				Result.append (Dictionary.New_line)
			end
		end
		
feature -- Status Report

	ready: BOOLEAN is
			-- Is object create expression ready to be generated?
		do
			Result := arguments /= Void 
		end

	type: TYPE is
			-- Type
		do
			Result := referenced_type_from_name (target_type)
		end

feature -- Status Setting

	set_object_created (a_object_created: like object_created) is
			-- Set `object_created' with `a_object_created'.
		require
			non_void_object_created: a_object_created /= Void
			not_empty_object_created: not a_object_created.is_empty
		do
			object_created := a_object_created
		ensure
			object_created_set: object_created = a_object_created
		end

	set_target_type (a_target_type: like target_type) is
			-- Set `target_type' with `a_target_type'.
		require
			non_void_target_type: a_target_type /= Void
			not_empty_target_type: not a_target_type.is_empty
		do
			target_type := a_target_type
		ensure
			target_type_set: target_type = a_target_type
		end
		
	set_constructor_name (a_name: like constructor_name) is
			-- Set `constructor_name' with `a_name'.
		require
			non_void_name: a_name /= Void
		do
			constructor_name := a_name
		ensure
			constructor_name_set: constructor_name = a_name
		end

	add_argument (an_argument: CODE_EXPRESSION) is
			-- Add `an_argement' to `arguments'.
		require
			non_void_arguments: an_argument /= Void
		do
			arguments.extend (an_argument)
		ensure
			arguments_set: arguments.has (an_argument)
		end

invariant
	non_void_object_created: object_created /= Void
	non_void_type: target_type /= Void 
	non_void_arguments: arguments /= Void
	non_void_constructor_name: constructor_name /= Void
	
end -- class CODE_OBJECT_CREATE_EXPRESSION

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