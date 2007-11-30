indexing
	description: "[
					Object that represents a set of class names used as client

					A client list appears in structures such as:
						export
							{A, B}foo, goo
						end
					or
						feature{A, B}
							foo is do end
				]"
	legal: "See notice at end of class."
	status: "See notice at end of class."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ERT_CLIENT_SET
inherit
	LINKED_SET [STRING]
		redefine
			make, put, extend
		end

create
	make

feature{NONE} -- Initialization

	make is
		do
			Precursor
			compare_objects
		end

feature -- Element change

	put (v: STRING) is
			-- Ensure that set includes `v'.
		require else
			v_not_void: v /= Void
			v_not_empty: not v.is_empty
		do
			Precursor (v.twin.as_upper)
		end

	extend (v: STRING) is
			-- Ensure that set includes `v'.
		require else
			v_not_void: v /= Void
			v_not_empty: not v.is_empty
		do
			put (v)
		end

	merge_other (other: like Current) is
			-- Merge `other' into current.
		require
			other_not_void: other /= Void
		local
			l_index: INTEGER
		do
			l_index := other.index
			from
				other.start
			until
				other.after
			loop
				put (other.item)
				other.forth
			end
			other.go_i_th (l_index)
		end

feature -- Status reporting

	is_included_by (other: like Current): BOOLEAN is
			-- Is current included by `other'?
		require
			other_not_void: other /= Void
		local
			l_index: INTEGER
		do
			l_index := index
			Result := True
			from
				start
			until
				after or not Result
			loop
				Result := other.has (item)
				forth
			end
			go_i_th (l_index)
		end

	is_true_included_by (other: like Current): BOOLEAN is
			-- Is current truly included by `other'?
		require
			other_not_void: other /= Void
		do
			Result := is_included_by (other) and other.count > count
		end

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
end
