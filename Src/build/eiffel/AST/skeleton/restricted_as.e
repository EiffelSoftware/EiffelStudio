-- Abstract description of a restricted export

class RESTRICTED_AS

inherit

	EXPORT_ID_AS
		redefine
			set
		end

feature

	restriction: EIFFEL_LIST [ID_AS];
			-- List of restrictions

	set is
			-- Yacc initialization
		local
			tab: ARRAY [ID_AS];
			i, count: INTEGER;
		do
			feature_name ?= yacc_arg (0);
			restriction ?= yacc_arg (1);
			if restriction /= Void then
				from
						-- Iteration on the restriction list
					tab := restriction;
					i := tab.lower;
					count := tab.upper;
				until
					i > count
				loop
						-- Put i_th id of `restriction' in the sorted set
						-- of ids `suppliers' of the root abstract node
						-- (instance of CLASS_AS).
					check_supplier (tab.item (i));
					i := i + 1
				end;
			end;
		ensure then
			restriction_exists: restriction /= Void;
		end;

	check_supplier (s: ID_AS) is
		external
			"C"
		end;

end
