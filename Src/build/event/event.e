
deferred class EVENT 

inherit

	EVENT_STONE;
	SHARED_STORAGE_INFO;
	EB_HASHABLE
	
feature {NONE}

	same (other: like Current): BOOLEAN is
		do
			Result := not (other = Void) and then
				(label.is_equal (other.label))
		end;
 
	hash_code: INTEGER is
		do
			Result := label.hash_code
		end;

	
feature 

	original_stone: EVENT is
		do
			Result := Current
		end;

	source: WIDGET is do end;

	symbol: PIXMAP;

	label: STRING is
		do
			Result := internal_name
		end;

        internal_name: STRING;
	
feature {NONE}

	set_symbol (s: PIXMAP) is
		do
			symbol := s
		end;
	
	set_label (s: STRING) is
		do
			internal_name := s
		end;

	
feature 

	is_valid_for_context (a_context: CONTEXT): BOOLEAN is
			-- Is the current event defined for `a_context'
		do
			Result := True
		end;

end
