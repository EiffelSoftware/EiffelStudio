note

	description:

		"AST Element of Phase 1, represents type specifiers"

	library: "Eiffel Wrapper Generator Library"
	copyright: "Copyright (c) 1999, Andreas Leitner and others"
	license: "Eiffel Forum License v2 (see forum.txt)"
	date: "$Date$"
	revision: "$Revision$"

class EWG_C_PHASE_1_TYPE_SPECIFIER

inherit

	ANY

	KL_IMPORTED_STRING_ROUTINES
		export {NONE} all end

create

	make,
	make_enum,
	make_struct,
	make_union

feature

	make (a_name: detachable STRING)
		do
			name := a_name
		end

	make_enum (a_name: detachable STRING; a_members: detachable DS_LINKED_LIST [EWG_C_PHASE_1_DECLARATION])
		do
			is_enum := True
			make (a_name)
			members := a_members
		end

	make_struct (a_name: detachable STRING; a_members: detachable DS_LINKED_LIST [EWG_C_PHASE_1_DECLARATION])
		do
			is_struct := True
			make (a_name)
			members := a_members
		end

	make_union (a_name: detachable STRING; a_members: detachable DS_LINKED_LIST [EWG_C_PHASE_1_DECLARATION])
		do
			is_union := True
			make (a_name)
			members := a_members
		end

feature

	append_name (a_type: EWG_C_PHASE_1_TYPE_SPECIFIER)
			-- Append `a_type.name' to `name'.
			-- Example: `old name' = "unsigned"
			--        : `a_type.name' = "int"
			--        : `name' = "unsigned int"
		require
			a_type_not_void: a_type /= Void
		local
			l_name: like name
		do
			l_name := name
			if l_name = Void then
				l_name := a_type.name
			elseif attached a_type.name as l_type_name then
				l_name := STRING_.concat (l_name, " ")
				l_name := STRING_.concat (l_name, l_type_name)
			end
			name := l_name
		end


feature

	has_members: BOOLEAN
		do
			Result := members /= Void
		end

	is_composite_type: BOOLEAN
		do
			Result := is_struct or is_union or is_enum
		end

	is_void: BOOLEAN
			-- Is this the simple 'void' specifier?
		do
				-- TODO: put manifiest string in a constants class
			if attached name as l_name then
				Result := STRING_.same_string (l_name, "void")
			end
		ensure
			true_implies_simple_type: Result implies not is_composite_type
		end

feature

	name: detachable STRING
			-- type may be anonymous (name = Void in this case)
			-- Note: Is this a good idea?

	is_struct: BOOLEAN

	is_union: BOOLEAN

	is_enum: BOOLEAN

	members: detachable DS_LINKED_LIST [EWG_C_PHASE_1_DECLARATION]


feature

	c_code: STRING
		do
			create Result.make (10)
			if is_enum then
				Result.append_string ("enum ")
			elseif is_struct then
				Result.append_string ("struct ")
			elseif is_union then
				Result.append_string ("union ")
			end

			if name /= Void then
				Result.append_string (name)
			end

			-- Members are ommited

		end

invariant

	enum_only: is_enum implies (not is_struct and not is_union)
	struct_only: is_struct implies (not is_union and not is_enum)
	union_only: is_union implies (not is_struct and not is_enum)

end
