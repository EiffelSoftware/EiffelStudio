deferred class DATA

inherit

	HELPABLE

feature

	label: STRING is
			-- Text representing
			-- current data
		deferred
		ensure
			valid_label_result: Result /= Void;
		end;

	symbol: PIXMAP is
			-- Picture symbol representing
			-- current data
		deferred
		end;

end
