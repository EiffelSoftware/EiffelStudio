indexing

	description: 
		"Extended AST representation of an Eiffel class. %
		%Adapted to retrieve feature clause and feature comments %
		%and store them, instead of retrieving them each time.";
	date: "$Date$";
	revision: "$Revision$"

class EXT_CLASS_AS

inherit

	CLASS_AS
		redefine
			features, features_simple_format
		end;
	COMPILER_EXPORTER

feature -- Properties

	features: EIFFEL_LIST [EXT_FEATURE_CLAUSE_AS];
			-- List of features

feature {COMPILER_EXPORTER} -- Setting

	extract_comments (e_file: EIFFEL_FILE) is
			-- Extract feature and feature clause comments from source 
			-- file `e_file'.
		local
			i, l_count: INTEGER;
			f: like features;
			fc, next_fc: EXT_FEATURE_CLAUSE_AS;
			feature_list: EIFFEL_LIST [FEATURE_AS];
		do
			f := features;
			if f /= Void then
				from
					i := 1;
					l_count := f.count;
					if l_count > 0 then
						fc := f.i_th (1);
					end;
				until
					i > l_count
				loop
					i := i + 1;
					if i > l_count then
						e_file.set_next_feature_clause (Void);
					else
						next_fc := f.i_th (i);
						e_file.set_next_feature_clause (next_fc);
					end;
					e_file.set_current_feature_clause (fc);
						  -- Need to set next feature if it exists
						  -- for extracting feature clause comments.
					feature_list := fc.features;
					if feature_list.empty then
						e_file.set_next_feature (Void);
					else
						e_file.set_next_feature (feature_list.i_th (1));
					end;
					fc.extract_comments (e_file);
					fc := next_fc;
				end;
			end
		end;

feature {NONE} -- Implementation

	features_simple_format (ctxt :FORMAT_CONTEXT) is
			-- Reconstitute text.
		local
			i, l_count: INTEGER;
			f: like features;
			fc: EXT_FEATURE_CLAUSE_AS;
		do
			f := features;
			ctxt.begin;
			from
				i := 1;
				l_count := f.count;
			until
				i > l_count
			loop
				if i > 1 then
					ctxt.put_separator;
				end;
				ctxt.new_expression;
				ctxt.begin;
				fc := f.i_th (i)
				fc.simple_format (ctxt);
				i := i + 1;
				ctxt.commit;
			end;
			ctxt.commit;
		end;

end -- class EXT_CLASS_AS
