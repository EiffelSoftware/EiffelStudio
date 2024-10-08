﻿note
	description: "List of comment strings."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision $"

class EIFFEL_COMMENTS

inherit
	COMPARABLE
		undefine
			copy
		redefine
			is_equal
		end

	ARRAYED_LIST [EIFFEL_COMMENT_LINE]
		rename
			make as list_make
		redefine
			is_equal
		end

create
	make,
	make_from_iterable

create {EIFFEL_COMMENTS}
	list_make, make_filled

feature {NONE}

	make
			-- Create Current.
		do
			list_make (2)
		end;

feature -- Comparison

	is_less alias "<" (other: like Current): BOOLEAN
			-- Is Current less than `other'?
		local
			different: BOOLEAN;
			i: INTEGER;
			txt, other_item: like item
		do
			from
				i := 1
			until
				different or else i > count or else i > other.count
			loop
				txt := i_th (i);
				other_item := other.i_th (i);
				different := not (txt.is_equal (other_item))
				if different then
						-- Let's compute the order
					Result := txt < other_item
				end
				i := i + 1
			end;

			if not different then
				Result := count < other.count
			end;
		end;

	is_equal (other: like Current): BOOLEAN
			-- Is `other' like Current?
		local
			i : INTEGER;
		do
			if other.count = count then
				Result := True;
				from
					i := 1
				until
					not Result or else i > count
				loop
					Result := (i_th (i)).is_equal (other.i_th (i));
					i := i + 1
				end;
			end;
		end;

	merge (other: like Current)
		require
			valid_other: other /= Void
		local
			other_count, i: INTEGER
		do
			other_count := other.count;
			from
				i := 1;
			until
				i > other_count
			loop
				put_left (other.i_th (i))
				i := i + 1;
			end;
		end;

	diff (old_templ: like Current): like Current
			-- Differences between Current and `old_templ';
		require
			valid_old_templ: old_templ /= Void
		local
			c, i: INTEGER
			s: like item;
		do
			create Result.make;
			c := count;
			old_templ.compare_objects;

			from
				i := 1
			until
				i > count
			loop
				s := i_th (i);
				if not old_templ.has (s) then
					Result.put_left (s)
				end;
				i := i + 1
			end;
			--is this needed
			old_templ.compare_references
		ensure
			valid_result: Result /= Void
		end

note
	copyright: "Copyright (c) 1984-2018, Eiffel Software"
	license:   "GPL version 2 (see http://www.eiffel.com/licensing/gpl.txt)"
	licensing_options: "http://www.eiffel.com/licensing"
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

end
