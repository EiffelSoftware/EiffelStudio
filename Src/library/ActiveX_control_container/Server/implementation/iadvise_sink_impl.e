indexing
	description: "Implemented `IAdviseSink' Interface."
	date: "$Date$"
	revision: "$Revision$"

deferred class
	IADVISE_SINK_IMPL

inherit
	IADVISE_SINK_INTERFACE
	
feature -- Basic Operations

	on_data_change (p_formatetc: TAG_FORMATETC_RECORD; p_stgmed: CELL [WIRE_STGMEDIUM_ALIAS]) is
			-- Advises that data has changed.
			-- `p_formatetc' [in].  
			-- `p_stgmed' [in].  
		do
			-- No Implementation.
		end

	on_view_change (dw_aspect: INTEGER; lindex: INTEGER) is
			-- Advises that view of object has changed.
			-- `dw_aspect' [in].  
			-- `lindex' [in].  
		do
			-- No Implementation.
		end

	on_rename (pmk: IMONIKER_INTERFACE) is
			-- Advises that name of object has changed.
			-- `pmk' [in].  
		do
			-- No Implementation.
		end

	on_save is
			-- Advises that object has been saved to disk.
		do
			-- No Implementation.
		end

	on_close is
			-- Advises that object has been closed.
		do
			-- No Implementation.
		end


end -- IADVISE_SINK_IMPL

