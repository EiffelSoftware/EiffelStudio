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

	make is
			-- Initialize `initializers'.
		do
			create initializers.make
		ensure
			non_void_initializers: initializers /= Void
		end
		
feature -- Access

	array_creation_feature: STRING
			-- Array initialization feature name

	array_type: STRING
			-- array type
	
	size: CODE_EXPRESSION
			-- Array size
	
	initializers: LINKED_LIST [CODE_EXPRESSION]
			-- Array initializers
		
	code: STRING is
			-- Eiffel code for array creation expression
			-- | 	Result := "create `object_created'.make (1, `size')" if size /= Void
			-- | OR
			-- |	Result := "`array_creation_feature'" if creation of a native_array [X] and X /= SYSTEM_OBJECT
			-- | OR 
			-- |	Result := "[`initializers', `initializers',...]"
		do
			check
				not_empty_array_type: not array_type.is_empty
			end

			create Result.make (160)
			if size /= Void then
				Result.append (Dictionary.Create_keyword)
				Result.append (Dictionary.Space)
				Result.append (array_creation_feature)
				Result.append (Dictionary.Dot_keyword)
				Result.append (Dictionary.Space)
				Result.append (Dictionary.Opening_round_bracket)
				Result.append ("1, ")
				Result.append (size.code)
				Result.append (Dictionary.Closing_round_bracket)
			elseif array_creation_feature /= Void then
				Result.append (array_creation_feature)
			else
				Result.append ("[")
				from
					initializers.start
					if not initializers.after then
						Result.append (initializers.item.code)
						initializers.forth
					end
				until
					initializers.after
				loop
					Result.append (Dictionary.Comma)
					Result.append (Dictionary.Space)
					Result.append (initializers.item.code)
				end
				Result.append ("]")
			end
		end
		
feature -- Status Report

	ready: BOOLEAN is
			-- Is epression ready to be generated?
		do
			Result := array_type /= Void and initializers /= Void
		end

	type: TYPE is
			-- Type
		local
			l_type_name: STRING
		do
			create l_type_name.make (array_type.count + 2)
			l_type_name.append (array_type)
			l_type_name.append ("[]")
			Result := known_type (l_type_name)
			if Result = Void then
--				from
--					Ace_file.Referenced_assemblies.start
--				until
--					Ace_file.Referenced_assemblies.after or l_type /= Void
--				loop
--					l_assembly := Ace_file.Referenced_assemblies.item.assembly
--					l_type := l_assembly.get_type (array_type)
--					Ace_file.Referenced_assemblies.forth
--				end
--				if l_type /= Void then
--					Result := l_assembly.get_type (l_type_name)
--				end
--				check
--					non_void_result: Result /= Void
--				end
--				add_known_type (Result, l_type_name)
			end
		end

feature -- Status Setting

	set_array_type (a_type: like array_type) is
			-- Set `array_type' with `a_type'.
		require
			non_void_type: a_type /= Void
		do
			array_type := a_type
		ensure
			array_type_set: array_type = a_type
		end		

	set_size (a_size: like size) is
			-- Set `size' with `a_size'.
		require
			non_void_size: a_size /= Void
		do
			size := a_size
		ensure
			size_set: size = a_size
		end	

	add_initializer (an_initializer: CODE_EXPRESSION) is
			-- add `an_initializer' to `initializers'.
		require
			non_void_list: an_initializer /= Void
		do
			initializers.extend (an_initializer)
		ensure
			initializers_set: initializers.has (an_initializer)
		end	

	set_array_creation_feature (a_array_creation_feature: like array_creation_feature) is
			-- Set `array_creation_feature' with `a_array_creation_feature'.
		require
			non_void_array_creation_feature: a_array_creation_feature /= Void
			not_empty_array_creation_feature: not array_creation_feature.is_empty
		do
			array_creation_feature := a_array_creation_feature
		ensure
			array_creation_featureset: array_creation_feature = a_array_creation_feature
		end		
		
invariant
	non_void_initializers: initializers /= Void
	
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