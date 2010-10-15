indexing
	description	: "Objects that describe the behaviour of a customer"
	author		: "Robin Stoll"
	date		: "2009/5/16"
	reviewer	: "Mohammad Seyed Alavi"
	revision	: "1.0.1"

class
	CUSTOMER

inherit
	PROCESS

create
	make

feature -- Initialization

	make (an_id: INTEGER; a_barber: separate BARBER; a_shop: separate SHOP; haircuts: INTEGER) is
			-- Creation procedure
			require
				an_id >= 0
				haircuts >= 0
				a_shop /= void
				a_barber /= void
			do
				id := an_id
				needed_haircuts := haircuts
				shop := a_shop
				barber := a_barber
			end

feature {NONE} -- Process

	step is
			local hair_cut_result: BOOLEAN
			-- Perform a customers' tasks
			do
				io.put_string ("Customer-"+id.out+" needs haircut%N")
				-- need haircut, so enter the shop
				if enter (shop) then
					io.put_string ("Customer-"+id.out+" is waiting in queue ...%N")
					-- chair is free, wait for barber to cut hair
					hair_cut_result := get_hair_cut (barber)
					if hair_cut_result then
						io.put_string ("Customer-"+id.out+" hair cut finished.%N")
						leave(shop)
					end
				else
					io.put_string ("Customer-"+id.out+" will come back later.%N")
					-- no chair is free, come back later
					(create {EXECUTION_ENVIRONMENT}).sleep(10000*1000000)
				end
			end

	over: BOOLEAN is
			-- When execution will finish
			do
				Result := needed_haircuts = 0
			end


feature {NONE} -- Control Helper

	enter (a_shop: separate SHOP): BOOLEAN is
			-- Enter the shop and return true if it was successful
			require
				a_shop /= void
			do
				io.put_string ("Customer-"+id.out + " entering shop...%N")
				Result := a_shop.enter
			end

	leave (a_shop: separate SHOP) is
			-- Leave the shop
			require
				a_shop /= void
			do
				io.put_string ("Customer-"+id.out + " leaving shop...%N")
				a_shop.leave
			end

feature {NONE}

	get_hair_cut(a_barber: separate BARBER):BOOLEAN is
			-- if the barber is available, cut my hair and decrement my needed haircuts
			require
				a_barber /= void
			do
				if a_barber.do_hair_cut (id) then
						needed_haircuts := needed_haircuts - 1
						result := true
					end
			ensure
				needed_haircuts = old needed_haircuts - 1
			end

feature {NONE} -- Implementation

	id: INTEGER
	needed_haircuts: INTEGER
	shop: separate SHOP
	barber: separate BARBER

invariant

	id >= 0
	needed_haircuts >= 0
	shop /= void
	barber /= void

end
