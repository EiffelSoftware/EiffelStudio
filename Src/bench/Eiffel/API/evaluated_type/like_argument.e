indexing

	description: 
		"Representation of an type anchored on a routine argument."
	date: "$Date$"
	revision: "$Revision $"

class LIKE_ARGUMENT

inherit
	LIKE_TYPE_A
		redefine
			is_basic, conformance_type, is_like_argument
		end

	SHARED_ARG_TYPES

feature -- Properties

	is_like_argument: BOOLEAN is True
			-- Is Current a like argument? (True)

	is_basic: BOOLEAN is
			-- Is the current actual type a basic one ?
		do
			Result := actual_type.is_basic
		end

feature -- Comparison

	is_equivalent (other: like Current): BOOLEAN is
			-- Is `other' equivalent to the current object ?
		do
			Result := position = other.position and then
				equivalent (actual_type, other.actual_type)
		end

feature -- Access

	same_as (other: TYPE_A): BOOLEAN is
			-- Is the current type the same as `other' ?
		local
			other_like_arg: LIKE_ARGUMENT
		do
			other_like_arg ?= other
			Result := other_like_arg /= Void
					and then other_like_arg.position = position
		end

	position: INTEGER
			-- Position in the argument list

feature -- Setting

	set_position (p: like position) is
			-- Assign `p' to `position'.
		do
			position := p
		end

feature -- Output

	dump: STRING is
			-- Dumped trace
		local
			actual_dump: STRING
		do
			actual_dump := actual_type.dump
			!!Result.make (16 + actual_dump.count)
			Result.append ("[like arg #")
			Result.append_integer (position)
			Result.append ("] ")
			Result.append (actual_dump)
		end

	ext_append_to (st: STRUCTURED_TEXT; f: E_FEATURE) is
		do
			st.add (ti_L_bracket)
			st.add (ti_Like_keyword)
			st.add_space
			if f /= Void then
				st.add (create {LOCAL_TEXT}.make (f.arguments.argument_names.i_th (position)))
			else
				st.add (ti_Argument_index)
				st.add_int (position)
			end
			st.add (ti_R_bracket)
			st.add_space
			actual_type.ext_append_to (st, f)
		end

feature {COMPILER_EXPORTER} -- Primitives

	solved_type (feat_table: FEATURE_TABLE; f: FEATURE_I): LIKE_ARGUMENT is
			-- Check if the anchor type is still a non like type and
			-- update `actual_type'.
		local
			argument_type: TYPE
		do
			if Like_control.is_on then
				Like_control.raise_error
			else
				argument_type := f.arguments.i_th (position)
				Result := clone (Current)
					-- Recalculation of the anchor
				Result.set_actual_type 
					(argument_type.solved_type (feat_table, f).actual_type)
				check
					Result_actual_type_exists: Result.actual_type /= Void
				end
			end
		end

	instantiation_in (type: TYPE_A; written_id: INTEGER): LIKE_ARGUMENT is
			-- Instantiation of Current in the context of `class_type',
			-- assuming that Current is written in class of id `written_id'.
		do
			Result := clone (Current)
			Result.set_actual_type (actual_type.instantiation_in (type, written_id))
		end

	conformance_type: TYPE_A is
			-- Type for conformance.
			-- `actual_type' is the declared type and is the wrong one for
			-- conformance validation.
		do
			Result := Argument_types.i_th (position).actual_type
		end

	create_info: CREATE_ARG is
			-- Byte code information for entity type creation
		do
			!! Result
			Result.set_position (position)
		end

end -- class LIKE_ARGUMENT
