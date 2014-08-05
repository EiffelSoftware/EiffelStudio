note
	description: "Summary description for {SHARED_EMBEDED_WEB_SERVICE_INFORMATION}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	SHARED_EMBEDED_WEB_SERVICE_INFORMATION

feature	-- Access

	port_number: INTEGER
		do
			Result := port_number_cell.item
		end

	set_port_number (a_port: like port_number)
		do
			port_number_cell.replace (a_port)
		end

	port_number_cell: CELL [INTEGER]
		once ("process")
			create Result.put (0)
		end

end
