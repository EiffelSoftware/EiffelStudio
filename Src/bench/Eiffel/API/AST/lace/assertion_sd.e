indexing
	description: "Assertion clause description in Ace"
	legal: "See notice at end of class."
	status: "See notice at end of class.";
	date: "$Date$";
	revision: "$Revision$"

class ASSERTION_SD

inherit
	OPTION_SD
		redefine
			is_assertion
		end

feature -- Properties

	option_name: STRING is "assertion"

	is_assertion: BOOLEAN is True
			-- Is the option an assertion one ?

feature {COMPILER_EXPORTER}

	adapt ( value: OPT_VAL_SD;
			classes: HASH_TABLE [CLASS_I, STRING];
			list: LACE_LIST [ID_SD]) is
		local
			v: ASSERTION_I;
		do
			if value /= Void then
				if value.is_no then
					create v.make_no
				else
					if value.is_require then
						create v.make_require
					elseif value.is_ensure then
						create v.make_ensure
					elseif value.is_invariant then
						create v.make_invariant
					elseif value.is_loop then
						create v.make_loop
					elseif value.is_check then
						create v.make_check
					elseif value.is_all then
						create v.make_all
					else
						error (value);
					end;
						-- If an error occurred, the assertion level
						-- will be reset later on.
					Lace.ace_options.set_has_assertion (True)
				end
			else
				create v.make_no
			end;
			if v /= Void then
				if list = Void then
					from
						classes.start;
					until
						classes.after
					loop
						classes.item_for_iteration.set_assertion_level (v);
						classes.forth;
					end;
				else
					from
						list.start;
					until
						list.after
					loop
							-- Class names are stored in upper, thus the conversion to upper cases
							-- for the lookup.
						classes.item (list.item.as_upper).set_assertion_level (v);
						list.forth;
					end;
				end;
			end;
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

end -- class ASSERTION_SD
