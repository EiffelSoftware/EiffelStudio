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
			Result := clone (Poly_table_template);
			Result.set_rout_id (rout_id)
		end;

feature {NONE}

	Poly_table_template: ROUT_TABLE is
			-- Polymorphic table template
		once
			if System.is_dynamic then
				!DYN_ROUT_TABLE! Result.make
			elseif System.extendible then
				!STAT_ROUT_TABLE! Result.make
			else
				!! Result.make
			end
		end;

end
