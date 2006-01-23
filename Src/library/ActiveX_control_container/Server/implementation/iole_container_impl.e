indexing
	description: "Implemented `IOleContainer' Interface."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	IOLE_CONTAINER_IMPL

inherit
	IOLE_CONTAINER_INTERFACE

	OLE_CONTROL_PROXY
	
	ECOM_EXCEPTION

feature -- Basic Operations

	parse_display_name (pbc: IBIND_CTX_INTERFACE; psz_display_name: STRING; pch_eaten: INTEGER_REF; ppmk_out: CELL [IMONIKER_INTERFACE]) is
			-- No description available.
			-- `pbc' [in].  
			-- `psz_display_name' [in].  
			-- `pch_eaten' [out].  
			-- `ppmk_out' [out].  
		do
			trigger (E_notimpl)
		end

	enum_objects (grf_flags: INTEGER; ppenum: CELL [IENUM_UNKNOWN_INTERFACE]) is
			-- Enumerates objects in a container.
			-- `grf_flags' [in].  
			-- `ppenum' [out].  
		local
			enumeration: IENUM_UNKNOWN_IMPL_STUB
			list: LINKED_LIST [ECOM_INTERFACE]
		do
			create list.make
			list.put (unknown_control)
			create enumeration.make (list)
			ppenum.put (enumeration)
		end

	lock_container (f_lock: INTEGER) is
			-- Keeps container running until explicitly released.
			-- `f_lock' [in].  
		do
			m_locked := f_lock.to_boolean
		end


feature {NONE} -- Implementation

	m_locked: BOOLEAN;
			-- Is container locked?
			
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




end -- IOLE_CONTAINER_IMPL

