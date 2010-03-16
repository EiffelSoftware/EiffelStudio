note
	description: "Implemented `IOleClientSite' Interface."
	legal: "See notice at end of class."
	status: "See notice at end of class."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	IOLE_CLIENT_SITE_IMPL

inherit
	IOLE_CLIENT_SITE_INTERFACE

	OLE_CONTROL_PROXY
	
	OUTER_SITE_PROXY
	
	DVASPECT_ENUM
		export
			{NONE} all
		end

feature -- Basic Operations

	save_object
			-- Saves the object associated with the client site. 
			-- This function is synchronous; by the time it returns, 
			-- the save will be completed.
		do
			-- No implementation.
		end

	get_moniker (dw_assign: INTEGER; dw_which_moniker: INTEGER; ppmk: CELL [IMONIKER_INTERFACE])
			-- Returns a moniker to an object's client site. 
			-- An object can force the assignment of its own 
			-- or its container's moniker by specifying a value for `dw_assign'.
			-- `dw_assign' [in].  
			-- `dw_which_moniker' [in].  
			-- `ppmk' [out].  
		do
			-- No implementation.
		end

	get_container (pp_container: CELL [IOLE_CONTAINER_INTERFACE])
			-- Returns a pointer to the container's IOleContainer interface.
			-- `pp_container' [out].  
		local
			l_ole_container: IOLE_CONTAINER_IMPL_PROXY
		do
			if 
				unknown_site /= Void and then
				ole_container /= Void 
			then
				pp_container.put (ole_container)
			else
				create l_ole_container.make_from_other (Current)
				pp_container.put (l_ole_container)
			end
		end

	show_object
			-- Tells the container to position the object 
			-- so it is visible to the user. This method 
			-- ensures that the container itself is visible 
			-- and not minimized.
		local
			wel_window: WEL_WINDOW
			l_client_dc: WEL_CLIENT_DC
			rect: X_RECTL_RECORD
		do
			wel_window ?= Current
			if wel_window /= Void then
				create l_client_dc.make (wel_window)
				l_client_dc.get
				
				if view_object /= Void then
					if m_Position /= Void and then m_Position.exists then
						create rect.make_from_pointer (m_Position.item)
					end
					view_object.draw (Dvaspect_content, 
										-1, 
										0, 
										Void, 
										0, 
										l_client_dc.to_integer, 
										rect, 
										rect)
				end
				l_client_dc.release
			end
		end

	on_show_window (f_show: INTEGER)
			-- Notifies a container when an embedded object's 
			-- window is about to become visible or invisible. 
			-- This method does not apply to an object that is 
			-- activated in place and therefore has no window 
			-- separate from that of its container.
			-- `f_show' [in].  
		do
			-- No implementation.
		end

	request_new_object_layout
			-- Asks container to allocate more or less space 
			-- for displaying an embedded object.
		do
			-- No implementation.
		end

feature {NONE}  -- Implementation

	m_Position: TAG_RECT_RECORD
			-- Client rectangle.
		deferred
		end

note
	copyright:	"Copyright (c) 1984-2006, Eiffel Software and others"
	license:	"Eiffel Forum License v2 (see http://www.eiffel.com/licensing/forum.txt)"
	source: "[
			 Eiffel Software
			 356 Storke Road, Goleta, CA 93117 USA
			 Telephone 805-685-1006, Fax 805-685-6869
			 Website http://www.eiffel.com
			 Customer support http://support.eiffel.com
		]"




end -- IOLE_CLIENT_SITE_IMPL

