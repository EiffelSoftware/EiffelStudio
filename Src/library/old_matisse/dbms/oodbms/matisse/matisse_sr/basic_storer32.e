class BASIC_STORER32 

inherit

	BASIC_STORER
    
creation
    
	make -- create a storer that works like C basic_store

feature --  Access

	Magic_number : CHARACTER is once Result:= '%/02/' end -- Basic Store 3.2

end -- class BASIC_STORER32
