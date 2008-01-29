indexing
	description:
		"Abstract description of a the content of an Eiffel %
		%constant. Version for Bench."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class CONSTANT_AS

inherit
	CONTENT_AS
		redefine
			is_constant, is_unique
		end

create
	initialize

feature {NONE} -- Initialization

	initialize (v: like value) is
			-- Create a new CONSTANT AST node.
		require
			v_not_void: v /= Void
		do
			value := v
		ensure
			value_set: value = v
		end

feature -- Visitor

	process (v: AST_VISITOR) is
			-- process current element.
		do
			v.process_constant_as (Current)
		end

feature -- Attributes

	value: ATOMIC_AS
			-- Constant value

feature -- Roundtrip/Token

	first_token (a_list: LEAF_AS_LIST): LEAF_AS is
		do
			Result := value.first_token (a_list)
		end

	last_token (a_list: LEAF_AS_LIST): LEAF_AS is
		do
			Result := value.last_token (a_list)
		end

feature -- Properties

	is_built_in: BOOLEAN is False
			-- Is the current content a built in?

	is_constant: BOOLEAN is True
			-- Is the current content a constant one ?

	is_unique: BOOLEAN is
			-- Is the content a unique ?
		do
			Result := value.is_unique
		end

feature -- Comparison

	is_equivalent (other: like Current): BOOLEAN is
			-- Is `other' equivalent to the current object ?
		do
			Result := equivalent (value, other.value)
		end

feature -- Access

	is_body_equiv (other: like Current): BOOLEAN is
			-- Are the values of Current and other the
			-- same?
		do
			Result := equivalent (value, other.value)
		end

	has_instruction (i: INSTRUCTION_AS): BOOLEAN is
		do
			Result := False
		end

	index_of_instruction (i: INSTRUCTION_AS): INTEGER is
			-- Index of `i' in this constant.
			-- Result is `0'.
		do
			Result := 0
		end

feature {CONSTANT_AS} -- Replication

	set_value (v: like value) is
		do
			value := v
		end

invariant
	value_not_void: value /= Void

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
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
			distributed in the hope that it will be useful,	but
			WITHOUT ANY WARRANTY; without even the implied warranty
			of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
			See the	GNU General Public License for more details.
			
			You should have received a copy of the GNU General Public
			License along with Eiffel Software's Eiffel Development
			Environment; if not, write to the Free Software Foundation,
			Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301  USA
		]"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"

end -- class CONSTANT_AS
