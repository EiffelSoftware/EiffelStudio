class S_CLI_SUP_DATA

inherit

	S_RELATION_DATA
		rename
			f_rom as client, t_o as supplier,
			set_booleans as rel_set_boolens
		end	

feature

	is_aggregation: BOOLEAN;
			-- Is this link an aggregation link ?

	is_reflexive: BOOLEAN;
			-- Is this link an reflexive link ?

	is_reverse_link: BOOLEAN;
			-- Has this link a reverse link ?

	is_reverse_aggregation: BOOLEAN;
			-- Is the reverse link an aggregation ?

	is_reverse_left_position: BOOLEAN;
			-- Is 'reverse_label' on left side of reverse link ?

	is_reverse_vertical_text: BOOLEAN;
			-- Is 'reverse_label' wrote vertically ?

	reverse_label: like label;
			-- Label of the reverse link if it exists

	reverse_shared: INTEGER;
			-- Number of shared features of reverse link

	multiplicity: INTEGER;
			-- Multiplicity of this link

	reverse_multiplicity: INTEGER
			-- Multiplicity of reverse link

	shared: INTEGER;
			-- Number of shared features of this link

feature -- Setting values

	set_booleans (is_agg, is_ref, is_ragg, is_rleft, is_rlink, is_rvert: BOOLEAN) is
			-- Set all the booleans for Current.
		do
			is_aggregation := is_agg;
			is_reflexive := is_ref;
			is_reverse_aggregation := is_ragg;
			is_reverse_left_position := is_rleft;
			is_reverse_link := is_rlink;
			is_reverse_vertical_text := is_rvert
		ensure
			booleans_are_set: is_aggregation = is_agg and then
								is_reflexive = is_ref and then
								is_reverse_aggregation = is_ragg and then
								is_reverse_left_position = is_rleft and then
								is_reverse_link = is_rlink and then
								is_reverse_vertical_text = is_rvert
		end;

	set_reverse_label (l: STRING) is
			-- Set label to `l'.
		require
			valid_l: l /= Void
		do
			reverse_label := l
		ensure
			reverse_label_set: reverse_label = l
		end;

	set_shared (value: like shared) is
			-- Set shared to `value'.
		require
			value >= 0
		do
			shared := value
		ensure
			shared = value
		end;

	set_multiplicities (mult, reverse_mult: INTEGER) is
			-- Set shared to `value'.
		require
			valid_args: mult >= 0 and then reverse_mult >= 0 
		do
			multiplicity := mult;
			reverse_multiplicity := reverse_mult;
		ensure
			values_set: multiplicity = mult and then
							reverse_multiplicity = reverse_mult
		end

end
