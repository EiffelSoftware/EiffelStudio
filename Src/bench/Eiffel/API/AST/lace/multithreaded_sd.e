indexing

	description:
		"Multithreaded option";
	date: "$Date$";
	revision: "$Revision $"

class MULTITHREADED_SD

inherit

	OPTION_SD
		redefine
			is_multithreaded
		end;
	SHARED_OPTION_LEVEL

feature -- Properties

	option_name: STRING is
		once
			Result := "multithreaded"
		end;

	is_multithreaded: BOOLEAN is
			-- Is the option a multithreaded one ?
		do
			Result := True;
		end;

feature {COMPILER_EXPORTER}

	adapt ( value: OPT_VAL_SD;
			classes:EXTEND_TABLE [CLASS_I, STRING];
			list: LACE_LIST [ID_SD]) is
		local
			v: OPTION_I;
		do
			if value /= Void then
				if value.is_no then
					v := No_option;
				elseif value.is_yes or value.is_all then
					v := All_option;
					Lace.ace_options.set_has_multithreaded (True)
				else
					error (value);
				end;
			else
				v := No_option;
			end;
		end;

end -- class MULTITHREADED_SD
