indexing
	description: "Objects that ..."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	LOAD_RECENT_COM

inherit
	EV_COMMAND

creation
	make

feature -- Initialization

	make ( s : STRING) is
			-- Initialize
		require
			path_not_void : s/= Void and then s.count>0
		do
			path := s
		end

feature -- Attributes

	path : STRING

feature --execute

	execute (args: EV_ARGUMENT; data: EV_EVENT_DATA) is
		local
			retrieve_com : RETRIEVE_PROJECT
		do
			!! retrieve_com.make_recent( path )
			--retrieve_com.execute ( Void )
		end
end -- class LOAD_RECENT_COM
