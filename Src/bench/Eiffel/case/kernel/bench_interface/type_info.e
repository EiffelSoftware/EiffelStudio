indexing

	description: "Abstract class of declaration of class type.";
	date: "$Date$";
	revision: "$Revision $"

deferred class TYPE_INFO

inherit

	CONSTANTS;
	ONCES

feature -- Properties

	name: STRING is
			-- Name of Current
		deferred
		end;

	is_instantiated: BOOLEAN is
		deferred
		end;

	has_generics: BOOLEAN is
		do
		end;

feature -- Setting

	set_name (s: STRING) is
		require
			valid_s: s /= Void;
			not_empty: not s.empty
		do
			free_text_name := clone (s);
			free_text_name.to_upper
		end;

feature {TYPE_DECLARATION, GENERIC_DATA} -- Implementation

	update_type (cl: CLASS_DATA) is
			-- Update type to class `cl' and
			-- name to `cl' name.
		require
			valid_cl: cl /= Void
		deferred
		end;

	make_from_storer (storer: S_TYPE_INFO) is
		require
			valid_storer: storer /= Void
		deferred
		end;

	storage_info: S_TYPE_INFO is 
		deferred
		ensure
			valid_result: Result /= Void
		end;

	dummy_stone (a_data: DATA; type_dec: TYPE_DECLARATION): EC_STONE is
		deferred
		end;

	stone (a_data: DATA; type_dec: TYPE_DECLARATION): EC_STONE is
		deferred
		end;

	generate (text_area: TEXT_AREA; data: DATA; type_dec: TYPE_DECLARATION ) is
		local
			n: STRING
			class_type_info	: CLASS_TYPE_INFO
			class_data	: CLASS_DATA
			class_stone	: CLASS_STONE
		do
			if is_instantiated then
				text_area.append_clickable_string	( stone	( data	, type_dec	) , name	);
			else
				n := name;
				if n = Void then	
						-- Just in case something goes wrong, attempt
						-- to retrieve something rather than crashing
					text_area.append_clickable_string	( dummy_stone	( data	, type_dec	) , "ANY"	)
				else
					text_area.append_clickable_string	( dummy_stone	( data	, type_dec	) , n	)
				end
			end
		end;

	generate_c (text_area: TEXT_AREA; data: DATA; type_dec: TYPE_DECLARATION) is
        local
            n: STRING
        do
            if is_instantiated then
                text_area.append_clickable_string (stone (data,
                                    type_dec), name);
            else
                n := name;
                if n = Void then    
                        -- Just in case something goes wrong, attempt
                        -- to retrieve something rather than crashing
                    text_area.append_clickable_string (dummy_stone (data,
                                    type_dec), "Void")
                else
                    if n.is_equal("ANY") then
						text_area.append_clickable_string (dummy_stone (data,type_dec), "Void")
					else
						text_area.append_clickable_string (dummy_stone (data,
                                    type_dec), n)
					end
                end
            end
        end;

feature {TYPE_INFO,CLIENT_ADD_FEATURE_COM,CLIENT_ADD_FUNCTION_COM,CLIENT_ADD_SELECTION} -- Implementation

	free_text_name: STRING;
			-- Name of free text (when actual type is not used)

end -- class TYPE_INFO
