indexing

	description: 
		"Displays short of a class in output_window.";
	date: "$Date$";
	revision: "$Revision $"

class EWB_SHORT 

inherit

	EWB_COMPILED_CLASS
		rename
			make as class_make
		redefine
			help_message, name, abbreviation
		end;

creation

	make, do_nothing

feature -- Initialization

	make (cn, fn: STRING) is
			-- Initialization
		require
			cn_not_void: cn /= Void;
			fn_not_void: fn /= Void
		do
			class_make (cn);
			init (fn);
		ensure
			filter_name_set: filter_name = fn;
			class_name_set: class_name = cn
		end;

feature -- Properties

	name: STRING is
		do
			Result := short_cmd_name;
		end;

	abbreviation: CHARACTER is
		do
			Result := short_abb
		end;

	help_message: STRING is
		do
			Result := short_help
		end;

feature {NONE} -- Execution

	associated_cmd: E_SHOW_SHORT is
		do
			!! Result.do_nothing
		end;

end -- class EWB_SHORT
