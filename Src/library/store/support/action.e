indexing

	status: "See notice at end of class.";
	Date: "$Date$"
	Revision: "$Revision$"
	Product: EiffelStore
	Database: All_Bases

class ACTION

feature -- Basic operations

	start is
			-- Execute something whenever 
			-- routine `load_result' of DB_SELECTION is
			-- called with Current set as `stop_condition',
			-- before iterating on query result.
			-- (Default: do nothing)
		do
		end

	execute is
			-- Execute something whenever 
			-- routine `load_result' of DB_SELECTION is
			-- called with Current set as `stop_condition',
			-- before iterating on query result.
			-- (Default: do nothing)
		do
		end

	found: BOOLEAN is
			-- Is there any exit condition found
			-- while iterating on selection results in
			-- `load_result' of DB_SELECTION?
			-- (Default: do nothing)
		do
		end

feature -- Obsolete

	init is obsolete "Use ``start''"
		do
			start
		end

	status: BOOLEAN is obsolete "Use ``found''"
		do
			Result := found
		end

indexing
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- class ACTION



