indexing
	description: "AST structure in Lace file for profiling eiffel classes.";
	date: "$Date$";
	revision: "$Revision$"

class PROFILE_SD

inherit
	OPTION_SD
		redefine
			is_profile
		end

	SHARED_OPTION_LEVEL

	EIFFEL_ENV

feature -- Properties

	option_name: STRING is "profile"

	is_profile: BOOLEAN is True
			-- Is Current a profile option?

feature {COMPILER_EXPORTER} -- Update

	adapt ( value: OPT_VAL_SD;
			classes:EXTEND_TABLE [CLASS_I, STRING];
			list: LACE_LIST [ID_SD]) is
		local
			error_raised: BOOLEAN
			class_name: STRING
			v: OPTION_I
		do
			if Lace.ace_options.has_external_profile then
				v := No_option
			else
					-- If the current release doesn't have a profiler, we convert the option to No.
				if has_profiler then
					if value /= Void then
						if value.is_no then
							v := No_option
						elseif value.is_yes or value.is_all then
							v := All_option
							Lace.ace_options.set_has_profile (True)
						elseif value.is_name then
							v := No_option
							Lace.ace_options.set_has_external_profile (True)
							Lace.ace_options.set_has_profile (False)
						else
							error (value)
						end
					else
						v := No_option
					end;
				else
					v := No_option
				end
			end

			if not error_raised then
				if list = Void then
					from
						classes.start
					until
						classes.after
					loop
						classes.item_for_iteration.set_profile_level (v)
						classes.forth
					end;
				else
					from
						list.start
					until
						list.after
					loop
						class_name := clone (list.item)
						class_name.to_lower
						classes.item (class_name).set_profile_level (v)
						list.forth
					end
				end
			end
		end

end -- class PROFILE_SD 
