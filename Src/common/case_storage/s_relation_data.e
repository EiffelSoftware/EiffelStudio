indexing

	description: 
		"Abstraction of relationships between entities.";
	date: "$Date$";
	revision: "$Revision $"

class S_RELATION_DATA

feature -- Properties

	f_rom: INTEGER;
			-- Partition from which the link originates.

	t_o: INTEGER;
			-- Partition to which the link destinates.

	generics: LINKED_LIST [S_GENERIC_DATA]
			-- List of generic parameters

feature -- Setting 

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

	set_generics (gg: LINKED_LIST [S_GENERIC_DATA]) is
			-- Set the list of generics ...
		require 
			gg /= Void
		do
			generics := gg
		end

feature -- special for the reverse

	handles_reverse : S_HANDLES_FOR_REVERSE

	create_handles is 
		do
			!! handles_reverse.make
		end


end -- class S_RELATION_DATA
