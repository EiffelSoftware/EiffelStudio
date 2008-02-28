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
			if f_as /= Void then
				feature_keyword_index := f_as.index
			end
			if d_as /= Void then
				dot_symbol_index := d_as.index
			end
		ensure
			class_type_set: class_type = c
			feature_name_set: feature_name = f
			internal_parameters_set: internal_parameters = p
			feature_keyword_set: f_as /= Void implies feature_keyword_index = f_as.index
			dot_symbol_set: d_as /= Void implies dot_symbol_index = d_as.index
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
			if a_list /= Void and feature_keyword_index /= 0 then
				Result := feature_keyword (a_list)
			else
				Result := class_type.first_token (a_list)
			end
		end

feature -- Roundtrip

	feature_keyword_index: INTEGER
			-- Index of keyword "feature" associated with this structure

	dot_symbol_index: INTEGER
			-- Index of symbol "." associated with this structure

	feature_keyword (a_list: LEAF_AS_LIST): KEYWORD_AS
			-- Keyword "feature" associated with this structure
		require
			a_list_not_void: a_list /= Void
		local
			i: INTEGER
		do
			i := feature_keyword_index
			if a_list.valid_index (i) then
				Result ?= a_list.i_th (i)
			end
		end

	dot_symbol (a_list: LEAF_AS_LIST): SYMBOL_AS
			-- Symbol "." associated with this structure
		require
			a_list_not_void: a_list /= Void
		local
			i: INTEGER
		do
			i := dot_symbol_index
			if a_list.valid_index (i) then
				Result ?= a_list.i_th (i)
			end
		end

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
			Result := "{" + class_type.dump + "}." + feature_name.name
		end

invariant
	class_type_not_void: class_type /= Void
	feature_name_not_void: feature_name /= Void

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

end -- class STATIC_ACCESS_AS
