-- Binary expression byte code for a comparable expression

deferred class COMP_BINARY_B 

inherit

	NUM_BINARY_B
		rename
			is_built_in as num_is_built_in
		end;
	NUM_BINARY_B
		redefine
			is_built_in
		select 
			is_built_in
		end;

feature

	is_built_in: BOOLEAN is
			-- Is the current binary operator a built-in one ?
		do
			Result := 	num_is_built_in
						or
						context.real_type (left.type).is_char
		end;

end
