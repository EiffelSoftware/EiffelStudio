deferred class STONE 

inherit

	INTERFACE_W;
	SHARED_ERROR_HANDLER;
	STONE_TYPES
	
feature 

	help_text: STRING is
			-- Explaination of what current element means,
			-- "No help available" by default
		do
			Result := l_No_help_available
		end;

	stone_name: STRING is deferred end;
			-- Name of the Current stone for the UI.

	stone_type: INTEGER is deferred end;
			-- Type determining compatibility and cursor shape

	click_list: ARRAY [CLICK_STONE] is deferred end;
			-- Structure to make clickable the display of `origin_text'

	origin_text: STRING is deferred end;
			-- What's shown by default usually. The others representations are
			-- callled `formats' or `displays' ...
			-- All stones have a textual representation that defines them
			-- unambiguously: ace text, class text, feature text, tagged_out...
			-- well, this is it!

	signature: STRING is deferred end;
			-- Short string to explain Current

	header: STRING is do Result := signature end;
			-- Short string to explain Current

	clickable: BOOLEAN is
			-- Is Current an element with recorded structures information?
			-- A CLASSI_STONE is not clickable, but a CLASSC_STONE is.
		deferred
		end

end
