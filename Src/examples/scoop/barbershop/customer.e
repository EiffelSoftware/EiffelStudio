note
	description	: "Objects that model barbershop customers"
	author		: "Robin Stoll"
	date		: "2009/5/16"
	reviewer	: "Mohammad Seyed Alavi"
	revision	: "1.0.1"

class
	CUSTOMER

create
	make

feature -- Initialization

	make (a_id: INTEGER; a_barber: separate BARBER; a_shop: separate SHOP; a_haircuts: INTEGER)
			-- Creation procedure
		require
			valid_customer_id: a_id >= 0
			valid_needed_haircuts: a_haircuts >= 0
		do
			id := a_id
			needed_haircuts := a_haircuts
			shop := a_shop
			barber := a_barber
		ensure
			id_set: id = a_id
			haircut_count_set: needed_haircuts = a_haircuts
			shop_set: shop = a_shop
			barber_set: barber = a_barber
		end

feature -- Basic operations

	live
			-- Lifecycle.
		do
			from
			until
				over
			loop
				step
			end
		end

feature {BARBER} -- Access

	id: INTEGER
			-- Current's unique identifier

feature {NONE} -- Implementation

	step
			-- One cycle of life.
		do
			print ("Customer-" + id.out + " needs haircut%N")
			if entered (shop) then
				get_hair_cut (barber)
				print ("Customer-" + id.out + " hair cut is finished.%N")
				leave (shop)
			else
				print ("Customer-" + id.out + " will come back later.%N")
					-- Sleep 10 sec.
				(create {EXECUTION_ENVIRONMENT}).sleep ({INTEGER_64} 10_000_000_000)
			end
		end

	over: BOOLEAN
			-- Is life over?
		do
			Result := needed_haircuts = 0
		end

	entered (a_shop: separate SHOP): BOOLEAN
			-- Chair available and shop entered?
		do
			print ("Customer-" + id.out + " checking waiting area...%N")
			if a_shop.free_chairs > 0 then
				print ("Customer-" + id.out + " free chair found...%N")
				a_shop.enter
				print ("Customer-" + id.out + " waiting for barber...%N")
				Result := True
			else
				print ("Customer-"+ id.out + " no free chair found...%N")
				Result := False
			end
		end

	leave (a_shop: separate SHOP)
			-- Leave `a_shop'
		do
			print ("Customer-" + id.out + " leaving shop...%N")
			a_shop.leave
		end

	get_hair_cut (a_barber: separate BARBER)
			-- Get hair cut by `a_barber'.
		do
			print ("Customer-" + id.out + " getting hair cut.%N")
			a_barber.cut_hair (Current)
			needed_haircuts := needed_haircuts - 1
		ensure
			needed_haircuts = old needed_haircuts - 1
		end

	needed_haircuts: INTEGER
			-- Haircut count over life.

	shop: separate SHOP
			-- Shop

	barber: separate BARBER
			-- Barber

invariant
	valid_customer_identifier: id >= 0
	valid_number_of_haircuts_needed: needed_haircuts >= 0

end
