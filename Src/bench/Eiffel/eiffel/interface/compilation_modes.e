indexing

	description: 
		"Status of current compilation.";
	date: "$Date$";
	revision: "$Revision $"

class COMPILATION_MODES

feature -- Properties

	is_freezing, is_finalizing,
	is_extendible, is_extending, 
	is_precompiling, is_quick_melt: BOOLEAN;

	set_is_freezing (b: BOOLEAN) is
			-- Set `is_freezing' to `b'
		do
			is_freezing := b
		end;

	set_is_quick_melt (b: BOOLEAN) is
			-- Set `is_freezing' to `b'
		do
			is_quick_melt := b
		end;

	set_is_finalizing (b: BOOLEAN) is
			-- Set `is_finalizing' to `b'
		do
			is_finalizing := b
		end;

	set_is_extendible (b: BOOLEAN) is
			-- Set `is_extendible' to `b'
		do
			is_extendible := b
		end;

	set_is_extending (b: BOOLEAN) is
			-- Set `is_extending' to `b'
		do
			is_extending := b
		end;

	set_is_precompiling (b: BOOLEAN) is
			-- Set `is_precompiling' to `b'
		do
			is_precompiling := b
		end;

feature -- Setting

	reset_modes is
		do
			is_quick_melt := False;
			is_freezing := False;
			is_finalizing := False;
			is_extendible := False;
			is_extending := False;
			is_precompiling := False
		end;

end -- class COMPILATION_MODES
