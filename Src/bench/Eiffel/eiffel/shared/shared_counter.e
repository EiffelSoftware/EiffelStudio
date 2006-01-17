indexing
	description: "Shared access to counters."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Date$"
	
class
	SHARED_COUNTER

inherit
	SHARED_WORKBENCH

feature -- Counters

	Class_counter: CLASS_COUNTER is
			-- Counter of classes
		once
			Result := System.class_counter
		end

	Routine_id_counter: ROUTINE_COUNTER is
			-- Counter for routine ids
		once
			Result := System.routine_id_counter
		end
	
	Static_type_id_counter: TYPE_COUNTER is
			-- Counter of instances of CLASS_TYPE
		once
			Result := System.static_type_id_counter
		end

	Body_index_counter: BODY_INDEX_COUNTER is
			-- Body index counter
		once
			Result := System.body_index_counter
		end

	Real_body_id_counter: REAL_BODY_ID_COUNTER is
			-- Counter for real body id
		once
			Result := System.execution_table.counter
		end

	Invalid_index: INTEGER is 0xFFFFFFFF;
			-- Invalid real body index used to mark
			-- empty invariants (max BODY_INDEX)

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

end -- class SHARED_COUNTER
