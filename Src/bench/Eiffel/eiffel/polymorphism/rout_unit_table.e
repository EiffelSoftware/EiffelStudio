-- Table of polymorphic routine units

class ROUT_UNIT_TABLE

inherit
	POLY_UNIT_TABLE [ROUT_UNIT]

creation

	make

feature

	new_poly_table: ROUT_TABLE is
			-- New polymorphic table
		do
			!! Result.make
			Result.set_rout_id (rout_id)
		end;

end
