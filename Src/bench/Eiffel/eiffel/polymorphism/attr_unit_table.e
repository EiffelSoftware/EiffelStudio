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
			if System.is_dynamic then
				!DYN_ATTR_TABLE! Result.make
			elseif System.extendible then
				!STAT_ATTR_TABLE! Result.make
			else
				!! Result.make
			end
		end;

end
