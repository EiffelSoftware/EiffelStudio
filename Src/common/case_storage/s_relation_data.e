class S_RELATION_DATA

feature

	f_rom: INTEGER;
			-- Partition from which the link originates.

	t_o: INTEGER;
			-- Partition to which the link destinates.

feature -- Setting values

	set_class_links (f: like f_rom; t: like t_o) is
			-- Set f_rom to `f' and set t_o to `t'.
		require
			valid_f: f /= 0;
			valid_t: t /= 0
		do
			f_rom := f;
			t_o := t
		ensure
			links_set: f_rom = f and then t_o = t
		end;

end

	
