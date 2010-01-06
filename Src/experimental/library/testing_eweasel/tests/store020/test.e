class
	TEST

inherit
	ARGUMENTS

create
	make

feature {NONE} -- Initialization

	make
		local
			file : RAW_FILE
			stored_object : STORABLE
		do
			create file.make("data")
			if file.exists then
				if not file.is_closed then
					file.close
				end
				create stored_object
				movement_cost_list ?= stored_object.retrieve_by_name("data")
			end
		end

	movement_cost_list : GAME_LIST[INTEGER]

end
