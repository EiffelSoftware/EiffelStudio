-- Dependance unit for replicated features

class REP_DEPEND_UNIT 

inherit

	COMPILER_EXPORTER

creation

	make

feature 

	id: CLASS_ID;
			-- Class id of where feature was "conceptually"
			-- replicated

	feature_name: STRING;
			-- Feature name

	rout_id_set: ROUT_ID_SET;
			-- Feature name

	make (i: CLASS_ID; s: STRING; r: ROUT_ID_SET) is
			-- Initialization
		require
			valid_i: i /= Void;
			valid_s: s /= Void;
			valid_r: r /= Void
		do
			id := i;
			feature_name := s;
			rout_id_set := r
		end;

feature -- Debug

	trace is
		do
			io.error.putstring ("Class id: ");
			id.trace;
			io.error.putstring (" feature name: ");
			io.error.putstring (feature_name);
			io.error.new_line;
		end;

end
