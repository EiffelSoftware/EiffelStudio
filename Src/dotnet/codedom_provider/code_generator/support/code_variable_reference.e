indexing
	description: "Variable reference in CodeDom"
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	CODE_VARIABLE_REFERENCE

inherit
	CODE_SHARED_GENERATION_HELPERS
		export
			{NONE} all
		end

	CODE_SHARED_NAME_FORMATTER
		export
			{NONE} all
		end

	CODE_SHARED_GENERATION_CONTEXT

create
	make

feature {NONE} -- Initialization

	make (a_name: STRING; a_type, a_declaring_type: CODE_TYPE_REFERENCE) is
			-- Initialize instance.
		require
			non_void_name: a_name /= Void
			valid_name: not a_name.is_empty
			non_void_type: a_type /= Void
			non_void_declaring_type: a_declaring_type /= Void
		do
			name := a_name
			type := a_type
			declaring_type := a_declaring_type
		ensure
			name_set: name = a_name
			type_set: type = a_type
			declaring_type_set: declaring_type = a_declaring_type
		end

feature -- Access

	name: STRING
			-- .NET simple name
		
	type: CODE_TYPE_REFERENCE
			-- Variable type
	
	declaring_type: CODE_TYPE_REFERENCE
			-- Type containing routine using this variable
	
	eiffel_name: STRING is
			-- Eiffel name
		require
			in_code_generation: current_state = Code_generation
		local
			l_gen_type: CODE_GENERATED_TYPE
			i: INTEGER
			l_features: HASH_TABLE [CODE_FEATURE, STRING]
			l_found: BOOLEAN
		do
			if internal_eiffel_name = Void then
				internal_eiffel_name := Name_formatter.formatted_variable_name (name)
				Resolver.search (declaring_type)
				if Resolver.found then
					l_gen_type := Resolver.found_type
					from
						l_features := l_gen_type.features
						l_features.search (internal_eiffel_name)
						l_found := l_features.found
						if not l_found then
							l_found := l_gen_type.parents.has_feature (internal_eiffel_name)
						end
						if l_found then
							internal_eiffel_name.append ("_2")
						end
						i := 2
					until
						not l_found
					loop
						l_features.search (internal_eiffel_name)
						l_found := l_features.found
						if not l_found then
							l_found := l_gen_type.parents.has_feature (internal_eiffel_name)
						end
						if l_found then
							internal_eiffel_name.keep_head (internal_eiffel_name.last_index_of ('_', internal_eiffel_name.count))
							internal_eiffel_name.append (i.out)
						end
						i := i + 1
					end
				end
			end
			Result := internal_eiffel_name
		ensure then
			non_void_eiffel_name: Result /= Void
		end

feature {NONE} -- Implementation

	internal_eiffel_name: STRING
			-- Cached Eiffel name

invariant
	non_void_name: name /= Void
	non_void_type: type /= Void
	non_void_declaring_type: declaring_type /= Void
	non_void_eiffel_name: eiffel_name /= Void

end -- class CODE_VARIABLE_REFERENCE

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