indexing
	description:
		"Abstract description of an access to the precursor of%
		%an Eiffel feature. Version for Bench."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

class STATIC_ACCESS_AS

inherit
	ACCESS_FEAT_AS
		rename
			initialize as feat_initialize
		export
			{NONE} feat_initialize
		redefine
			process, is_equivalent, first_token
		end

	ATOMIC_AS

create
	initialize

feature {AST_FACTORY} -- Initialization

	initialize (c: like class_type; f: like feature_name; p: like internal_parameters; f_as: like feature_keyword; d_as: like dot_symbol) is
			-- Create a new STATIC_ACCESS_AS AST node.
		require
			c_not_void: c /= Void
			f_not_void: f /= Void
		do
			class_type := c
			feature_name := f
			set_parameters (p)
			feature_keyword := f_as
			dot_symbol := d_as
		ensure
			class_type_set: class_type = c
			feature_name_set: feature_name = f
			internal_parameters_set: internal_parameters = p
			feature_keyword_set: feature_keyword = f_as
			dot_symbol_set: dot_symbol = d_as
		end

feature -- Visitor

	process (v: AST_VISITOR) is
			-- process current element.
		do
			v.process_static_access_as (Current)
		end

feature -- Roundtrip/Token

	first_token (a_list: LEAF_AS_LIST): LEAF_AS is
		do
			if a_list = Void  then
				Result := Precursor (a_list)
			else
				if feature_keyword /= Void then
					Result := feature_keyword.first_token (a_list)
				else
					Result := class_type.first_token (a_list)
				end
			end
		end

feature -- Roundtrip

	feature_keyword: KEYWORD_AS
			-- Keyword "feature" associated with this structure

	dot_symbol: SYMBOL_AS
			-- Symbol "." associated with this structure

feature -- Attributes

	class_type: TYPE_AS
			-- Type in which `feature_name' is defined.

feature -- Comparison

	is_equivalent (other: like Current): BOOLEAN is
			-- Is `other' equivalent to the current object ?
		do
			Result := Precursor {ACCESS_FEAT_AS} (other) and then
				equivalent (class_type, other.class_type)
		end

feature {AST_EIFFEL} -- Output

	string_value: STRING is
			-- Printed value of Current
		do
			Result := "{" + class_type.dump + "}." + feature_name.string_value
		end

invariant
	class_type_not_void: class_type /= Void
	feature_name_not_void: feature_name /= Void

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software"
	license:	"GPL version 2 see http://www.eiffel.com/licensing/gpl.txt)"
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

end -- class STATIC_ACCESS_AS
