indexing

class
	IL_KEY_GENERATOR

create
	make
	
feature -- Initialization

	make (a_filename: STRING) is
			-- Generate a new key pair with 'a_filename' as filename
		do
			check
				False
			end
		end
		
feature -- Access		
		
	public_key: POINTER
		-- Pointer to public key
		
	key_size: INTEGER
		-- Size of public key in bytes	


end -- class IL_KEY_GENERATOR
