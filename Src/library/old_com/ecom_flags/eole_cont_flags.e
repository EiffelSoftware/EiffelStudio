indexing

	description: "CONTF flags"
	status: "See notice at end of class";
	date: "$Date$";
	revision: "$Revision$"

class
	EOLE_CONT_FLAGS

inherit
	EOLE_FLAGS
	
feature -- Access

	Olecontf_embeddings: INTEGER is
			-- Enumerate embedded objects in container
		external
			"C [macro <oleidl.h>]"
		alias
			"OLECONTF_EMBEDDINGS"
		end

	Olecontf_links: INTEGER is
			-- Enumerate linked objects in container
		external
			"C [macro <oleidl.h>]"
		alias
			"OLECONTF_LINKS"
		end

	Olecontf_others: INTEGER is
			-- Enumerate all objects in container that
			-- are not OLE compound document objects 
		external
			"C [macro <oleidl.h>]"
		alias
			"OLECONTF_OTHERS"
		end

	Olecontf_onlyuser: INTEGER is
			-- Enumerate only objects user is aware of
		external
			"C [macro <oleidl.h>]"
		alias
			"OLECONTF_ONLYUSER"
		end

	Olecontf_onlyifrunning: INTEGER is
			-- Enumerates only linked or embedded objects that
			-- are currently in running state for container
		external
			"C [macro <oleidl.h>]"
		alias
			"OLECONTF_ONLYIFRUNNING"
		end
	
	is_valid_cont_flags (flags: INTEGER): BOOLEAN is
			-- Is `flags' a valid combination of container flags?
		do
			Result := c_and (Olecontf_embeddings + Olecontf_links
						+ Olecontf_others + Olecontf_onlyuser
						+ Olecontf_onlyifrunning, flags)
						= Olecontf_embeddings + Olecontf_links
						+ Olecontf_others + Olecontf_onlyuser
						+ Olecontf_onlyifrunning
		end
		
end -- class EOLE_CONT_FLAGS

--|----------------------------------------------------------------
--| EiffelCOM: library of reusable components for ISE Eiffel.
--| All rights reserved. Duplication and distribution prohibited.
--| May be used only with ISE Eiffel, under terms of user license. 
--| Contact ISE for any other use.
--| Based on WINE library, copyright (C) Object Tools, 1996-1998.
--| Modifications and extensions: copyright (C) ISE, 1998.
--|
--| Interactive Software Engineering Inc.
--| ISE Building, 2nd floor
--| 270 Storke Road, Goleta, CA 93117 USA
--| Telephone 805-685-1006, Fax 805-685-6869
--| Electronic mail <info@eiffel.com>
--| Customer support e-mail <support@eiffel.com>
--| For latest info see award-winning pages: http://www.eiffel.com
--|----------------------------------------------------------------

