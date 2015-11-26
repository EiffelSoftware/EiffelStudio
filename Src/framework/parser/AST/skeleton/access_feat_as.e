note
	description:
		"Abstract description of an access to an Eiffel feature (note %
		%that this access cannot be the first call of a nested %
		%expression)."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class ACCESS_FEAT_AS

inherit
	ACCESS_AS
		redefine
			is_equivalent
		end

	FEATURE_ID_AS
		rename
			make as make_feature_id,
			name as feature_name
		redefine
			is_equivalent,
			last_token,
			process
		end

create
	initialize

feature {NONE} -- Initialization

	initialize (f: like feature_name; p: like internal_parameters)
			-- Create a new FEATURE_ACCESS AST node.
		require
			f_not_void: f /= Void
		do
			set_parameters (p)
			make_feature_id (f)
		ensure
			feature_name_set: feature_name = f
			internal_parameters_set: internal_parameters = p
			no_routine_id: routine_ids.is_empty
		end

feature -- Visitor

	process (v: AST_VISITOR)
			-- process current element.
		do
			v.process_access_feat_as (Current)
		end

feature -- Attributes

	parameters: detachable EIFFEL_LIST [EXPR_AS]
			-- List of parameters
		do
			if attached internal_parameters as l_internal_paran then
				Result := l_internal_paran.parameters
				Result.start
			end
		end

	parameter_count: INTEGER
			-- Count of parameters
		do
			if attached parameters as l_params then
				Result := l_params.count
			end
		end

	is_qualified: BOOLEAN
			-- Is current entity a call on an other object?
		do
			Result := True
		end

	is_local: BOOLEAN
			-- Is current entity a local?
		do
			Result := (flags & is_local_flag) = is_local_flag
		end

	is_argument: BOOLEAN
			-- Is the current entity an argument?
		do
			Result := (flags & is_argument_flag) = is_argument_flag
		end

	is_object_test_local: BOOLEAN
			-- Is the current entity an object test local?
		do
			Result := (flags & is_object_test_local_flag) = is_object_test_local_flag
		end

	is_tuple_access: BOOLEAN
			-- Is the current entity an access to one of the TUPLE labels?
		do
			Result := (flags & is_tuple_access_flag) = is_tuple_access_flag
		end

	argument_position: INTEGER
			-- If the current entity is an argument this gives the position in the argument list.
		require
			is_argument: is_argument
		do
			Result := first
		end

	label_position: INTEGER
			-- If current entity is a tuple access, gives the position in the tuple actual generic argument list.
		require
			is_tuple_access: is_tuple_access
		do
			Result := first
		end

feature {INTERNAL_COMPILER_STRING_EXPORTER}

	access_name: STRING
		do
			Result := feature_name.name
		end

feature -- Roundtrip

	internal_parameters: detachable PARAMETER_LIST_AS
			-- Internal list of parameters, in which "(" and ")" are stored

feature -- Roundtrip/Token

	last_token (a_list: detachable LEAF_AS_LIST): detachable LEAF_AS
		do
			if a_list = Void then
				if attached parameters as l_params then
					Result := l_params.last_token (a_list)
				else
					Result := Precursor (a_list)
				end
			else
				if attached internal_parameters as l_params then
					Result := l_params.last_token (a_list)
				else
					Result := Precursor (a_list)
				end
			end
		end

feature -- Delayed calls

	is_delayed : BOOLEAN
			-- Is this access delayed?
		do
			-- Default: No
		end

feature -- Comparison

	is_equivalent (other: like Current): BOOLEAN
			-- Is `other' equivalent to the current object ?
		do
			Result := Precursor (other) and then
				equivalent (parameters, other.parameters) and then
				is_delayed = other.is_delayed
		end

feature -- Setting

	set_feature_name (name: like feature_name)
		require
			valid_arg: name /= Void
		do
			feature_name := name
		ensure
			feature_name_set: feature_name = name
		end

	set_parameters (p: like internal_parameters)
			-- Set `internal_parameters' with `p'.
		do
			internal_parameters := p
		ensure
			internal_parameters_set: internal_parameters = p
		end

	set_argument_position (an_argument_position: like argument_position)
			-- Set `argument_position' to `an_argument_position'.
		require
			is_argument: is_argument
		do
			first := an_argument_position
		ensure
			argument_position_set: argument_position = an_argument_position
		end

	set_label_position (a_pos: like label_position)
			-- Set `label_position' to `a_pos'.
		require
			is_tuple_access: is_tuple_access
		do
			first := a_pos
		ensure
			label_position_set: label_position = a_pos
		end

	enable_local
			-- Set `is_local' to true.
		do
			flags := flags | is_local_flag
		ensure
			is_local_set: is_local
		end

	enable_object_test_local
			-- Set `is_object_test_local' to true.
		do
			flags := flags | is_object_test_local_flag
		ensure
			is_object_test_local_set: is_object_test_local
		end

	enable_argument
			-- Set `is_argument' to true.
		do
			flags := flags | is_argument_flag
		ensure
			is_argument_set: is_argument
		end

	enable_tuple_access
			-- Set `is_tuple_access' to True.
		do
			flags := flags | is_tuple_access_flag
		ensure
			is_tuple_access_set: is_tuple_access
		end

feature {NONE} -- Implementation

	flags: NATURAL_8
			-- Store property of this node.

	is_local_flag: NATURAL_8 = 0x01
	is_argument_flag: NATURAL_8 = 0x02
	is_tuple_access_flag: NATURAL_8 = 0x04
	is_object_test_local_flag: NATURAL_8 = 0x08
			-- Various possible values for `flags'.

invariant
	not_local_and_argument_and_tuple_access: is_local and (not is_argument and not is_tuple_access) or
		is_argument and (not is_local and not is_tuple_access) or
		is_tuple_access and (not is_local and not is_argument) or
		not is_local and not is_argument and not is_tuple_access
	parameters_set: (attached internal_parameters as l_parameters implies parameters = l_parameters.parameters) and
					(internal_parameters = Void implies parameters = Void)
	parameter_count_correct: (parameters /= Void implies parameter_count > 0) and (parameters = Void implies parameter_count = 0)

note
	copyright:	"Copyright (c) 1984-2015, Eiffel Software"
	license:	"GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options:	"http://www.eiffel.com/licensing"
	copying: "[
			This file is part of Eiffel Software's Eiffel Development Environment.
			
			Eiffel Software's Eiffel Development Environment is free
			software; you can redistribute it and/or modify it under
			the terms of the GNU General Public License as published
			by the Free Software Foundation, version 2 of the License
			(available at the URL listed under "license" above).
			
			Eiffel Software's Eiffel Development Environment is
			distributed in the hope that it will be useful, but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301 USA
		]"
	source: "[
			Eiffel Software
			5949 Hollister Ave., Goleta, CA 93117 USA
			Telephone 805-685-1006, Fax 805-685-6869
			Website http://www.eiffel.com
			Customer support http://support.eiffel.com
		]"

end -- class ACCESS_FEAT_AS
