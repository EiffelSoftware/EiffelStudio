-- Eiffelcase commands for class information
deferred class CASE_CLASS_COMMAND

feature

	execute is
		deferred
		end

feature {NONE}

	make (c: like classc; s_c: like s_class_data) is
		require
			valid_class_c: c /= Void;
			valid_class_s_c: s_c /= Void
		do
			classc := c;
			s_class_data := s_c
		end;

feature {NONE}

	s_class_data: S_CLASS_DATA;
			-- Class data for EiffelCase

	classc: CLASS_C;
			-- Class to be used for case information

end
