-- Error when a creation procedure is not a procedure or a once procedure

class VGCP21 

inherit

	VGCP
		redefine
			subcode, build_explain
		end;

feature

	subcode: INTEGER is
		do
			Result := 2;
		end;

	creation_feature: STRING;
			-- Feature involved

	set_feature_name (s: STRING) is
			-- Assign `f' to `creation_feature'.
		do
			creation_feature := s;
		end;

	build_explain (ow: OUTPUT_WINDOW) is
		do
			ow.put_string ("Creation procedure name: ");
			ow.put_string (creation_feature);
			ow.new_line;
		end;

end
