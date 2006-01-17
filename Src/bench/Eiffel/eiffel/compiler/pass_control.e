indexing
	legal: "See notice at end of class."
	status: "See notice at end of class."
-- Controller of a compiler pass for a class

class PASS_CONTROL 


create

	make

	
feature 

	removed_features: SEARCH_TABLE [FEATURE_I];
			-- Table of the features written in a class and removed
			-- from a compilation to another one.
			-- [Useful for updating dependances for incremental type
			-- check.]

	propagators: TWO_WAY_SORTED_SET [DEPEND_UNIT];
			-- List of all the dependance units responsible for
			-- the propagation of the third pass on the class

	melted_propagators: TWO_WAY_SORTED_SET [DEPEND_UNIT];
			-- List of all the features which are changed from
			-- an attribute (a function resp.) into a function (an attribute
			-- resp.) beetween two recompilations. All the features
			-- using such a feature should be melted.

	make is
			-- Initialization
		do
			create removed_features.make (5);
			create propagators.make;
			propagators.compare_objects
			create melted_propagators.make;
			melted_propagators.compare_objects
		end;

	wipe_out is
			-- Empty the structure
		do
			removed_features.clear_all;
			propagators.wipe_out;
			melted_propagators.wipe_out;
		end;

	make_pass3: BOOLEAN is
			-- Has a third pass to be done ?
		do
			Result := propagate_pass3 or else removed_features.count > 0
		end;

	propagate_pass3: BOOLEAN is
			-- Has a third pass to be propagated to clients ?
		do
			Result := not (propagators.is_empty and then melted_propagators.is_empty)
		end;

feature -- Debug

	trace is
		do
			io.error.put_string ("Propagators:%N");
			from
				propagators.start
			until
				propagators.after
			loop
				propagators.item.trace;
				propagators.forth
			end;
			io.error.put_string ("Melted propagators:%N");
			from
				melted_propagators.start
			until
				melted_propagators.after
			loop
				melted_propagators.item.trace;
				melted_propagators.forth
			end;
		end;

invariant

	removed_features_exists: removed_features /= Void;
	propagators_exists: propagators /= Void;
	melted_propagators_exists: melted_propagators /= Void;

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
