indexing

	description:
		"Multithreaded option";
	date: "$Date$";
	revision: "$Revision $"

class MULTITHREADED_SD

inherit
	OPTION_SD

	SHARED_OPTION_LEVEL

feature -- Properties

	option_name: STRING is
		once
			Result := "multithreaded"
		end

feature {COMPILER_EXPORTER}

	adapt (value: OPT_VAL_SD;
			classes:EXTEND_TABLE [CLASS_I, STRING];
			list: LACE_LIST [ID_SD]) is
		local
			v: OPTION_I
		do
			if value /= Void then
				if value.is_no then
					v := No_option
					if System.has_multithreaded then
						System.set_freeze (True)
					end
					System.set_has_multithreaded (False)
				elseif value.is_yes or value.is_all then
					v := All_option
					if not System.has_multithreaded then
						System.set_freeze (True)
					end
					System.set_has_multithreaded (True)
				else
					error (value)
				end
			else
				v := No_option
			end
		end

end -- class MULTITHREADED_SD
