deferred class STONE 

inherit

	STONE_TYPES
	
feature -- Properties

	clickable: BOOLEAN is
			-- Is Current an element with recorded structures information?
			-- (An uncompiled class  is not clickable, but a compiled class is).
		deferred
		end

	icon_name: STRING is
			-- Icon name for tool when editing Current 
		deferred
		end;

	stone_name: STRING is 
			-- Name of the Current stone for the UI.
		deferred 
		end;

	stone_type: INTEGER is 
			-- Type determining compatibility and cursor shape
		deferred 
		end;

feature  -- Access

	help_text: STRING is
			-- Explaination of what current element means,
			-- "No help available" by default
		once
			Result := "No help available"
		end;

	click_list: ARRAY [CLICK_STONE] is 
			-- Structure to make clickable the display of `origin_text'
		deferred 
		end;

	origin_text: STRING is
			-- What's shown by default usually. The others representations are
			-- callled `formats' or `displays' ...
			-- All stones have a textual representation that defines them
			-- unambiguously: ace text, class text, feature text, tagged_out...
			-- well, this is it!
		require
			valid_stone: is_valid
		deferred
		end;

	signature: STRING is 
			-- Short string to explain Current
		deferred 
		end;

	header: STRING is 
			-- Short string to explain Current
			-- (By default, it is the signature)
		do 
			Result := signature 
		end;

	is_valid: BOOLEAN is
			-- Is `Current' a valid stone?
		do
			Result := True
		end;

	synchronized_stone: STONE is
			-- Clone of `Current' after a recompilation
			-- (May be Void if not valid anymore)
		do
			Result := clone (Current)
		ensure
			valid_stone: Result /= Void implies Result.is_valid
		end;

end -- class STONE
