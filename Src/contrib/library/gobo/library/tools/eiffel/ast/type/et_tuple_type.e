note

	description:

		"Eiffel TUPLE types"

	library: "Gobo Eiffel Tools Library"
	copyright: "Copyright (c) 2003-2011, Eric Bezault and others"
	license: "MIT License"
	date: "$Date$"
	revision: "$Revision$"

class ET_TUPLE_TYPE

inherit

	ET_BASE_TYPE
		rename
			name as tuple_keyword
		redefine
			same_syntactical_tuple_type_with_type_marks,
			same_named_tuple_type_with_type_marks,
			same_base_tuple_type_with_type_marks,
			conforms_from_class_type_with_type_marks,
			conforms_from_tuple_type_with_type_marks,
			tuple_keyword, actual_parameters,
			resolved_formal_parameters_with_type_mark,
			append_unaliased_to_string,
			type_with_type_mark,
			type_mark,
			overridden_type_mark
		end

create

	make

feature {NONE} -- Initialization

	make (a_type_mark: like type_mark; a_parameters: like actual_parameters; a_named_base_class: like named_base_class)
			-- Create a new TUPLE type.
		require
			a_named_base_class_not_void: a_named_base_class /= Void
		do
			type_mark := a_type_mark
			tuple_keyword := tokens.tuple_keyword
			actual_parameters := a_parameters
			named_base_class := a_named_base_class
		ensure
			type_mark_set: type_mark = a_type_mark
			actual_parameters_set: actual_parameters = a_parameters
			named_base_class_set: named_base_class = a_named_base_class
		end

feature -- Access

	type_mark: ET_TYPE_MARK
			-- 'attached', 'detachable' or 'separate' keyword,
			-- or '!' or '?' symbol

	overridden_type_mark (a_override_type_mark: ET_TYPE_MARK): ET_TYPE_MARK
			-- Version of `type_mark' overridden by `a_override_type_mark'
		local
			l_result_expanded_mark: BOOLEAN
			l_result_reference_mark: BOOLEAN
			l_result_separate_mark: BOOLEAN
			l_result_attached_mark: BOOLEAN
			l_result_detachable_mark: BOOLEAN
			l_current_ok: BOOLEAN
			l_other_ok: BOOLEAN
		do
			if a_override_type_mark = Void then
				Result := type_mark
			elseif type_mark = Void then
				Result := a_override_type_mark
			else
				l_current_ok := True
				l_other_ok := True
				if a_override_type_mark.is_expandedness_mark then
					l_other_ok := False
				end
				if a_override_type_mark.is_separateness_mark then
					if not is_separate then
						l_current_ok := False
					end
					if not base_class.is_separate then
						l_result_separate_mark := True
					end
				elseif type_mark /= Void and then type_mark.is_separateness_mark then
					if not base_class.is_separate then
						l_other_ok := False
						l_result_separate_mark := True
					end
				end
				if a_override_type_mark.is_attachment_mark then
					if a_override_type_mark.is_attached_mark then
						if not is_attached then
							l_current_ok := False
						end
						l_result_attached_mark := True
					else
						if is_attached then
							l_current_ok := False
						end
						l_result_detachable_mark := True
					end
				elseif type_mark /= Void and then type_mark.is_attachment_mark then
					if type_mark.is_attached_mark then
						l_other_ok := False
						l_result_attached_mark := True
					else
						l_other_ok := False
						l_result_detachable_mark := True
					end
				end
				if l_current_ok then
					Result := type_mark
				elseif l_other_ok then
					Result := a_override_type_mark
				else
					Result := tokens.implicit_type_mark (l_result_expanded_mark, l_result_reference_mark, l_result_separate_mark, l_result_attached_mark, l_result_detachable_mark)
				end
			end
		end

	tuple_keyword: ET_IDENTIFIER
			-- 'TUPLE' keyword

	actual_parameters: ET_ACTUAL_PARAMETER_LIST
			-- Actual generic parameters

	base_type_with_type_mark (a_type_mark: ET_TYPE_MARK; a_context: ET_TYPE_CONTEXT): ET_BASE_TYPE
			-- Same as `base_type' except that its type mark status is
			-- overridden by `a_type_mark', if not Void
		local
			l_actual_parameters: like actual_parameters
			l_named_parameters: ET_ACTUAL_PARAMETER_LIST
			l_type_mark: ET_TYPE_MARK
			l_tuple_type: ET_TUPLE_TYPE
		do
			l_actual_parameters := actual_parameters
			if a_context = Current then
					-- The current type is its own context, therefore it has the same
					-- actual parameters as its base type.
				l_named_parameters := l_actual_parameters
			elseif l_actual_parameters /= Void then
				l_named_parameters := l_actual_parameters.named_types (a_context)
			end
			l_type_mark := overridden_type_mark (a_type_mark)
			if l_type_mark /= type_mark or l_named_parameters /= l_actual_parameters then
				create l_tuple_type.make (l_type_mark, l_named_parameters, named_base_class)
				l_tuple_type.set_tuple_keyword (tuple_keyword)
				Result := l_tuple_type
			else
				Result := Current
			end
		end

	type_with_type_mark (a_type_mark: ET_TYPE_MARK): ET_TUPLE_TYPE
			-- Current type whose type mark status is
			-- overridden by `a_type_mark', if not Void
		local
			l_type_mark: ET_TYPE_MARK
		do
			l_type_mark := overridden_type_mark (a_type_mark)
			if l_type_mark /= type_mark then
				create Result.make (l_type_mark, actual_parameters, named_base_class)
				Result.set_tuple_keyword (tuple_keyword)
			else
				Result := Current
			end
		end

	position: ET_POSITION
			-- Position of first character of
			-- current node in source code
		do
			if type_mark /= Void and then not type_mark.is_implicit_mark then
				Result := type_mark.position
			end
			if Result = Void or else Result.is_null then
				Result := tuple_keyword.position
			end
		end

	first_leaf: ET_AST_LEAF
			-- First leaf node in current node
		do
			if type_mark /= Void and then not type_mark.is_implicit_mark then
				Result := type_mark.first_leaf
			end
			if Result = Void then
				Result := tuple_keyword
			end
		end

	last_leaf: ET_AST_LEAF
			-- Last leaf node in current node
		do
			if actual_parameters /= Void then
				Result := actual_parameters.last_leaf
			else
				Result := tuple_keyword
			end
		end

	break: ET_BREAK
			-- Break which appears just after current node
		do
			if actual_parameters /= Void then
				Result := actual_parameters.break
			else
				Result := tuple_keyword.break
			end
		end

feature -- Setting

	set_tuple_keyword (a_tuple: like tuple_keyword)
			-- Set `tuple_keyword' to `a_tuple'.
		require
			a_tuple_not_void: a_tuple /= Void
		do
			tuple_keyword := a_tuple
		ensure
			tuple_keyword_set: tuple_keyword = a_tuple
		end

feature -- Status report

	is_separate: BOOLEAN
			-- Is current type separate?
		do
			if type_mark /= Void then
				Result := type_mark.is_separate_mark
			else
				Result := base_class.is_separate
			end
		end

	is_expanded: BOOLEAN = False
			-- Is current type expanded?

	is_type_expanded_with_type_mark (a_type_mark: ET_TYPE_MARK; a_context: ET_TYPE_CONTEXT): BOOLEAN
			-- Same as `is_type_expanded' except that the type mark status is
			-- overridden by `a_type_mark', if not Void
		do
			Result := False
		end

	is_attached: BOOLEAN
			-- Is current type attached?
		do
			if type_mark = Void or else not type_mark.is_attachment_mark then
				Result := True
			else
				Result := type_mark.is_attached_mark
			end
		end

	is_type_attached_with_type_mark (a_type_mark: ET_TYPE_MARK; a_context: ET_TYPE_CONTEXT): BOOLEAN
			-- Same as `is_type_attached' except that the type mark status is
			-- overridden by `a_type_mark', if not Void
		do
			if a_type_mark = Void then
				Result := is_attached
			elseif a_type_mark.is_attached_mark then
				Result := True
			elseif a_type_mark.is_detachable_mark then
				Result := False
			else
				Result := is_attached
			end
		end

	base_type_has_class (a_class: ET_CLASS; a_context: ET_TYPE_CONTEXT): BOOLEAN
			-- Does the base type of current type contain `a_class'
			-- when it appears in `a_context'?
		local
			an_actual_parameters: like actual_parameters
		do
			if a_class = base_class then
				Result := True
			else
				an_actual_parameters := actual_parameters
				if an_actual_parameters /= Void then
					Result := an_actual_parameters.named_types_have_class (a_class, a_context)
				end
			end
		end

feature -- Comparison

	same_syntactical_type_with_type_marks (other: ET_TYPE; other_type_mark: ET_TYPE_MARK; other_context: ET_TYPE_CONTEXT; a_type_mark: ET_TYPE_MARK; a_context: ET_TYPE_CONTEXT): BOOLEAN
			-- Same as `same_syntactical_type' except that the type mark status of `Current'
			-- and `other' is overridden by `a_type_mark' and `other_type_mark', if not Void
		do
			if other = Current and then other_type_mark = a_type_mark and then (other_context = a_context or else not is_generic) then
				Result := True
			else
				Result := other.same_syntactical_tuple_type_with_type_marks (Current, a_type_mark, a_context, other_type_mark, other_context)
			end
		end

	same_named_type_with_type_marks (other: ET_TYPE; other_type_mark: ET_TYPE_MARK; other_context: ET_TYPE_CONTEXT; a_type_mark: ET_TYPE_MARK; a_context: ET_TYPE_CONTEXT): BOOLEAN
			-- Same as `same_named_type' except that the type mark status of `Current'
			-- and `other' is overridden by `a_type_mark' and `other_type_mark', if not Void
		do
			if other = Current and then other_type_mark = a_type_mark and then (other_context = a_context or else not is_generic) then
				Result := True
			else
				Result := other.same_named_tuple_type_with_type_marks (Current, a_type_mark, a_context, other_type_mark, other_context)
			end
		end

	same_base_type_with_type_marks (other: ET_TYPE; other_type_mark: ET_TYPE_MARK; other_context: ET_TYPE_CONTEXT; a_type_mark: ET_TYPE_MARK; a_context: ET_TYPE_CONTEXT): BOOLEAN
			-- Same as `same_base_type' except that the type mark status of `Current'
			-- and `other' is overridden by `a_type_mark' and `other_type_mark', if not Void
		do
			if other = Current and then other_type_mark = a_type_mark and then (other_context = a_context or else not is_generic) then
				Result := True
			else
				Result := other.same_base_tuple_type_with_type_marks (Current, a_type_mark, a_context, other_type_mark, other_context)
			end
		end

feature {ET_TYPE, ET_TYPE_CONTEXT} -- Comparison

	same_syntactical_tuple_type_with_type_marks (other: ET_TUPLE_TYPE; other_type_mark: ET_TYPE_MARK; other_context: ET_TYPE_CONTEXT; a_type_mark: ET_TYPE_MARK; a_context: ET_TYPE_CONTEXT): BOOLEAN
			-- Are current type appearing in `a_context' and `other'
			-- type appearing in `other_context' the same type?
			-- (Note: We are NOT comparing the base types here!
			-- Therefore anchored types are considered the same
			-- only if they have the same anchor. An anchor type
			-- is not considered the same as any other type even
			-- if they have the same base type.)
			-- Note that the type mark status of `Current' and `other' is
			-- overridden by `a_type_mark' and `other_type_mark', if not Void
		local
			other_parameters: ET_ACTUAL_PARAMETER_LIST
		do
			if other = Current and then other_type_mark = a_type_mark and then (other_context = a_context or else not is_generic) then
				Result := True
			elseif a_context.attachment_type_conformance_mode and then is_type_attached_with_type_mark (a_type_mark, a_context) /= other.is_type_attached_with_type_mark (other_type_mark, other_context) then
				Result := False
			elseif is_separate = other.is_separate then
				other_parameters := other.actual_parameters
				if other_parameters = Void then
					Result := actual_parameters = Void or else actual_parameters.is_empty
				elseif actual_parameters = Void then
					Result := other_parameters.is_empty
				else
					Result := actual_parameters.same_syntactical_types (other_parameters, other_context, a_context)
				end
			end
		end

	same_named_tuple_type_with_type_marks (other: ET_TUPLE_TYPE; other_type_mark: ET_TYPE_MARK; other_context: ET_TYPE_CONTEXT; a_type_mark: ET_TYPE_MARK; a_context: ET_TYPE_CONTEXT): BOOLEAN
			-- Do current type appearing in `a_context' and `other' type
			-- appearing in `other_context' have the same named type?
			-- Note that the type mark status of `Current' and `other' is
			-- overridden by `a_type_mark' and `other_type_mark', if not Void
		local
			other_parameters: ET_ACTUAL_PARAMETER_LIST
		do
			if other = Current and then other_type_mark = a_type_mark and then (other_context = a_context or else not is_generic) then
				Result := True
			elseif a_context.attachment_type_conformance_mode and then is_type_attached_with_type_mark (a_type_mark, a_context) /= other.is_type_attached_with_type_mark (other_type_mark, other_context) then
				Result := False
			elseif is_separate = other.is_separate then
				other_parameters := other.actual_parameters
				if other_parameters = Void then
					Result := actual_parameters = Void or else actual_parameters.is_empty
				elseif actual_parameters = Void then
					Result := other_parameters.is_empty
				else
					Result := actual_parameters.same_named_types (other_parameters, other_context, a_context)
				end
			end
		end

	same_base_tuple_type_with_type_marks (other: ET_TUPLE_TYPE; other_type_mark: ET_TYPE_MARK; other_context: ET_TYPE_CONTEXT; a_type_mark: ET_TYPE_MARK; a_context: ET_TYPE_CONTEXT): BOOLEAN
			-- Do current type appearing in `a_context' and `other' type
			-- appearing in `other_context' have the same base type?
			-- Note that the type mark status of `Current' and `other' is
			-- overridden by `a_type_mark' and `other_type_mark', if not Void
		local
			other_parameters: ET_ACTUAL_PARAMETER_LIST
		do
			if other = Current and then other_type_mark = a_type_mark and then (other_context = a_context or else not is_generic) then
				Result := True
			elseif a_context.attachment_type_conformance_mode and then is_type_attached_with_type_mark (a_type_mark, a_context) /= other.is_type_attached_with_type_mark (other_type_mark, other_context) then
				Result := False
			elseif is_separate = other.is_separate then
				other_parameters := other.actual_parameters
				if other_parameters = Void then
					Result := actual_parameters = Void or else actual_parameters.is_empty
				elseif actual_parameters = Void then
					Result := other_parameters.is_empty
				else
					Result := actual_parameters.same_named_types (other_parameters, other_context, a_context)
				end
			end
		end

feature -- Conformance

	conforms_to_type_with_type_marks (other: ET_TYPE; other_type_mark: ET_TYPE_MARK; other_context: ET_TYPE_CONTEXT; a_type_mark: ET_TYPE_MARK; a_context: ET_TYPE_CONTEXT): BOOLEAN
			-- Same as `conforms_to_type' except that the type mark status of `Current'
			-- and `other' is overridden by `a_type_mark' and `other_type_mark', if not Void
		do
			if other = Current and then other_type_mark = a_type_mark and then (other_context = a_context or else not is_generic) then
				Result := True
			else
				Result := other.conforms_from_tuple_type_with_type_marks (Current, a_type_mark, a_context, other_type_mark, other_context)
			end
		end

feature {ET_TYPE, ET_TYPE_CONTEXT} -- Conformance

	conforms_from_class_type_with_type_marks (other: ET_CLASS_TYPE; other_type_mark: ET_TYPE_MARK; other_context: ET_TYPE_CONTEXT; a_type_mark: ET_TYPE_MARK; a_context: ET_TYPE_CONTEXT): BOOLEAN
			-- Does `other' type appearing in `other_context' conform
			-- to current type appearing in `a_context'?
			-- Note that the type mark status of `Current' and `other' is
			-- overridden by `a_type_mark' and `other_type_mark', if not Void
			-- (Note: 'current_system.ancestor_builder' is used on the classes
			-- whose ancestors need to be built in order to check for conformance.)
		local
			other_base_class: ET_CLASS
		do
			other_base_class := other.base_class
			if other_base_class.is_none then
					-- Class type "NONE" is always detachable regardless of type marks.
					-- Therefore it conforms to any detachable tuple type since tuple types are reference types.
				if other_context.attachment_type_conformance_mode then
					Result := is_type_detachable_with_type_mark (a_type_mark, a_context)
				else
					Result := True
				end
			elseif other_base_class = base_class and then not is_generic then
					-- Class type "TUPLE" conforms to Tuple_type "TUPLE".
				if other_context.attachment_type_conformance_mode then
					Result := is_type_attached_with_type_mark (a_type_mark, a_context) implies other.is_type_attached_with_type_mark (other_type_mark, other_context)
				else
					Result := True
				end
			end
		end

	conforms_from_tuple_type_with_type_marks (other: ET_TUPLE_TYPE; other_type_mark: ET_TYPE_MARK; other_context: ET_TYPE_CONTEXT; a_type_mark: ET_TYPE_MARK; a_context: ET_TYPE_CONTEXT): BOOLEAN
			-- Does `other' type appearing in `other_context' conform
			-- to current type appearing in `a_context'?
			-- Note that the type mark status of `Current' and `other' is
			-- overridden by `a_type_mark' and `other_type_mark', if not Void
			-- (Note: 'current_system.ancestor_builder' is used on the classes
			-- whose ancestors need to be built in order to check for conformance.)
		local
			a_parameters: like actual_parameters
			other_parameters: ET_ACTUAL_PARAMETER_LIST
		do
			if other = Current and then other_type_mark = a_type_mark and then (other_context = a_context or else not is_generic) then
				Result := True
			elseif other_context.attachment_type_conformance_mode and then not (is_type_attached_with_type_mark (a_type_mark, a_context) implies other.is_type_attached_with_type_mark (other_type_mark, other_context)) then
				Result := False
			else
				a_parameters := actual_parameters
				other_parameters := other.actual_parameters
				if a_parameters = Void then
					Result := True
				elseif other_parameters = Void then
					Result := a_parameters.is_empty
				else
					Result := other_parameters.tuple_conforms_to_types (a_parameters, a_context, other_context)
				end
			end
		end

feature -- Type processing

	resolved_formal_parameters_with_type_mark (a_type_mark: ET_TYPE_MARK; a_parameters: ET_ACTUAL_PARAMETER_LIST): ET_TUPLE_TYPE
			-- Same as `resolved_formal_parameters' except that the type mark status is
			-- overridden by `a_type_mark', if not Void
		local
			l_actual_parameters: like actual_parameters
			l_resolved_parameters: ET_ACTUAL_PARAMETER_LIST
			l_type_mark: ET_TYPE_MARK
		do
			l_actual_parameters := actual_parameters
			if l_actual_parameters /= Void then
				l_resolved_parameters := l_actual_parameters.resolved_formal_parameters (a_parameters)
			end
			l_type_mark := overridden_type_mark (a_type_mark)
			if l_type_mark /= type_mark or l_resolved_parameters /= l_actual_parameters then
				create Result.make (l_type_mark, l_resolved_parameters, named_base_class)
				Result.set_tuple_keyword (tuple_keyword)
			else
				Result := Current
			end
		end

feature -- Output

	append_to_string (a_string: STRING)
			-- Append textual representation of
			-- current type to `a_string'.
		local
			a_parameters: like actual_parameters
		do
			if type_mark /= Void then
				if type_mark.is_implicit_mark then
					a_string.append_character ('[')
				end
				a_string.append_string (type_mark.text)
				if type_mark.is_implicit_mark then
					a_string.append_character (']')
				end
				a_string.append_character (' ')
			end
			a_string.append_string (tuple_string)
			a_parameters := actual_parameters
			if a_parameters /= Void and then not a_parameters.is_empty then
				a_string.append_character (' ')
				a_parameters.append_to_string (a_string)
			end
		end

	append_unaliased_to_string (a_string: STRING)
			-- Append textual representation of unaliased
			-- version of current type to `a_string'.
			-- An unaliased version if when aliased types such as INTEGER
			-- are replaced by the associated types such as INTEGER_32.
		local
			a_parameters: like actual_parameters
		do
			if type_mark /= Void then
				if type_mark.is_implicit_mark then
					a_string.append_character ('[')
				end
				a_string.append_string (type_mark.text)
				if type_mark.is_implicit_mark then
					a_string.append_character (']')
				end
				a_string.append_character (' ')
			end
			a_string.append_string (tuple_string)
			a_parameters := actual_parameters
			if a_parameters /= Void and then not a_parameters.is_empty then
				a_string.append_character (' ')
				a_parameters.append_unaliased_to_string (a_string)
			end
		end

feature -- Processing

	process (a_processor: ET_AST_PROCESSOR)
			-- Process current node.
		do
			a_processor.process_tuple_type (Current)
		end

feature {NONE} -- Constants

	tuple_string: STRING = "TUPLE"
			-- Eiffel keywords

invariant

	tuple_keyword_not_void: tuple_keyword /= Void

end
