indexing

	description: 
		"Object that can be named.";
	date: "$Date$";
	revision: "$Revision$"

deferred class NAMABLE

feature -- Comparison

	illegal_characters (tag, text: STRING): BOOLEAN is
			-- Does Current contain illegal characters?
			-- (By default, check if `text' is an identifier)
		local
			i, c: INTEGER;
			char: CHARACTER
			ended: BOOLEAN
		do

			c := text.count;
			if c /= 0 and then text.item(1).is_alpha then
				from
					Result := True;
					ended := FALSE;
					i := 2;
				until
					i > c or else ended or else not Result
				loop
					char := text.item (i);
					Result := char.is_digit or else
								char.is_alpha or else
								char = '_';
 -- FIXME: Jacques: can't capture '%N' and '%R'

					if char = '%N' or char = '%R' then 
								Result := Result or else char = '%N' or else char = '%R';
								text.prune_all('%N')
								text.prune_all('%R')
								ended:=true;
					end
				
					i := i + 1
				end
			end
			Result := not Result
		end;

feature -- Setting

	--set (namer: NAMER_WINDOW) is
			-- Set information from `namer'.
	--	deferred
	--	end;

	--setup_namer (namer: NAMER_WINDOW) is
			-- Setup `namer' from Current.
	--	deferred
	--	end;

feature -- Output

	title_label: STRING is
			-- Title label for namer window
		local
			st: EC_STONE;
			d: DATA
		do
			st ?= Current;
			if st /= Void then
				d := st.data;
				Result := d.focus
			end
		end;

end -- class NAMABLE
