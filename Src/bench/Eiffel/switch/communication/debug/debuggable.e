indexing
	legal: "See notice at end of class."
	status: "See notice at end of class."

class DEBUGGABLE

feature -- Data

	class_type: CLASS_TYPE;
			-- Class type of debuggable feature.
			-- (Varies for generic instantiations)

	byte_code: CHARACTER_ARRAY;
			-- Array of debuggable byte
			-- code

	real_body_index: INTEGER;
			-- Body index of feature associated
			-- with Current.

	real_body_id: INTEGER;
			-- Body id of feature associated
			-- with Current.

	was_frozen: BOOLEAN;
			-- Was the feature associated with
			-- Current initially frozen?

	breakable_points: SORTED_TWO_WAY_LIST [AST_POSITION];

feature -- Status

	is_breakpoint_set (i: INTEGER): BOOLEAN is
			-- Is the `i'-th breakable point set ?
		do
			if i >= 1 and i <= breakable_points.count then
				Result := breakable_points.i_th (i).is_set
			end
		end; -- is_breakpoint_set

	has_breakpoint_set: BOOLEAN is
			-- Is at least one breakable point set ?
		do
			from
				breakable_points.start
			until
				Result or breakable_points.after
			loop
				Result := breakable_points.item.is_set;
				breakable_points.forth
			end
		end; -- has_breakpoint_set

feature -- Setting

	set_breakable_points (bp: SORTED_TWO_WAY_LIST [AST_POSITION]) is
		do
			breakable_points := bp
		end;

	set_byte_code (ca: CHARACTER_ARRAY) is
		do
			byte_code := ca
		end;

	set_real_body_index (i: INTEGER) is
		do
			real_body_index := i
		end;

	set_real_body_id (i: INTEGER) is
		do
			real_body_id := i
		end;

	set_was_frozen is
		do
			was_frozen := True
		end;

	set_class_type (ct: CLASS_TYPE) is
		do
			class_type := ct
		end

feature -- Tracing

	trace is
		local
			i: INTEGER
		do
			from
				i := 1;
				io.put_string ("Byte code breakpoints:%N");
			until
				i > byte_code.size
			loop
				if byte_code.item (i) = '%/066/' then
					io.put_string ("Breakpoint, offset: ");
					io.put_integer (i);
					io.put_new_line;
				elseif byte_code.item (i) = '%/096/' then
					io.put_string ("Contpoint, offset: ");
					io.put_integer (i);
					io.put_new_line;
				end;
				i := i + 1;
			end;
			-- Breakable points
			from
				breakable_points.start;
				io.put_string ("Breakable point offsets: %N");
			until
				breakable_points.after
			loop
				io.put_integer (breakable_points.item.position);
				io.put_new_line;
				breakable_points.forth
			end
		end;

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

end
