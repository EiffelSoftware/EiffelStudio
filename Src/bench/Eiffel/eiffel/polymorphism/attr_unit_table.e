-- Table of polymorphic attribute units

class ATTR_UNIT_TABLE

inherit
	POLY_UNIT_TABLE [ATTR_UNIT]

creation
	make

feature

	new_poly_table: ATTR_TABLE is
			-- New polymorphic table
		do
			Result := clone (Poly_table_template);
			Result.set_rout_id (rout_id)
		end;

feature {NONE}

	Poly_table_template: ATTR_TABLE is
			-- Polymorphic table template
		once
			!! Result.make
		end;

end
