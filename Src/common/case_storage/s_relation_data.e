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

	f_rom_name : STRING
			-- name of the entity where the link originates

	t_o_name : STRING 
			-- name of the entity where the link destinates

	generics : LINKED_LIST [ S_GENERIC_DATA ]

feature -- Setting 

	set_class_links (f: like f_rom; t: like t_o ) is
			-- Set f_rom to `f' and set t_o to `t'.
		require
			valid_f: f /= 0;
			valid_t: t /= 0
		do
			f_rom := f
			t_o := t
		ensure
			links_set: f_rom = f and then t_o = t
		end;
   
	set_class_names ( f : like f_rom_name; t: like t_o_name ) is
            require
                valid_f : f/= Void           
                valid_t : t /= Void
            do
                f_rom_name := f
                t_o_name := t
            end

feature -- allow the addition of generics ... pascalf

	create_list_of_generic_parameters ( gg: LINKED_LIST [GENERIC_DATA ] )is
		-- set the list of generics ...
		require 
			gg /= Void
		local
			gene_data : S_GENERIC_DATA
			s_type :S_TYPE_INFO
		do
			!! generics.make
			from 
				gg.start
			until
				gg.after
			loop
				
				!! gene_data.make(gg.item.name, Void )
				generics.extend (gene_data)
				gg.forth
			end
		end	

 	set_generics (gg: LINKED_LIST [S_GENERIC_DATA]) is
            -- Set the list of generics ...
        require
            gg /= Void
        do
            generics := gg
        end

feature -- feature for the reverse 
		-- Warning : this has to be only used in a context of retrieving a Reverse Project ...

	handles_reverse: S_HANDLES_FOR_REVERSE


	     create_handles is 
             do
                      !! handles_reverse.make
             end
	
end -- class S_RELATION_DATA
