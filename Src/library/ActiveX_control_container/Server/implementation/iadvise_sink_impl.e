indexing
	description: "Implemented `IAdviseSink' Interface."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	IADVISE_SINK_IMPL

inherit
	IADVISE_SINK_INTERFACE

	OLE_CONTROL_PROXY
	
feature -- Basic Operations

	on_data_change (p_formatetc: TAG_FORMATETC_RECORD; p_stgmed: CELL [WIRE_ASYNC_STGMEDIUM_ALIAS]) is
			-- No description available.
			-- `p_formatetc' [in].  
			-- `p_stgmed' [in].  
		do
			-- Put Implementation here.
		end

	on_view_change (dw_aspect: INTEGER; lindex: INTEGER) is
			-- No description available.
			-- `dw_aspect' [in].  
			-- `lindex' [in].  
		do
			-- Put Implementation here.
		end

	on_rename (pmk: IMONIKER_INTERFACE) is
			-- No description available.
			-- `pmk' [in].  
		do
			-- Put Implementation here.
		end

	on_save is
			-- No description available.
		do
			-- Put Implementation here.
		end

	on_close is
			-- No description available.
		do
			-- Put Implementation here.
		end


end -- IADVISE_SINK_IMPL

