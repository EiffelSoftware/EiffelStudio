indexing
	description: "Implemented `IOleClientSite' Interface."
	date: "$Date$"
	revision: "$Revision$"

class
	IOLE_CLIENT_SITE_IMPL

inherit
	IOLE_CLIENT_SITE_INTERFACE

	OLE_CONTROL_PROXY

feature -- Basic Operations

	save_object is
			-- No description available.
		do
			-- Put Implementation here.
		end

	get_moniker (dw_assign: INTEGER; dw_which_moniker: INTEGER; ppmk: CELL [IMONIKER_INTERFACE]) is
			-- No description available.
			-- `dw_assign' [in].  
			-- `dw_which_moniker' [in].  
			-- `ppmk' [out].  
		do
			-- Put Implementation here.
		end

	get_container (pp_container: CELL [IOLE_CONTAINER_INTERFACE]) is
			-- No description available.
			-- `pp_container' [out].  
		do
			-- Put Implementation here.
		end

	show_object is
			-- No description available.
		do
			-- Put Implementation here.
		end

	on_show_window (f_show: INTEGER) is
			-- No description available.
			-- `f_show' [in].  
		do
			-- Put Implementation here.
		end

	request_new_object_layout is
			-- No description available.
		do
			-- Put Implementation here.
		end


end -- IOLE_CLIENT_SITE_IMPL

