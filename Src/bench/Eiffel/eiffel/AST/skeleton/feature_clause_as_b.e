class FEATURE_CLAUSE_AS_B

inherit

	FEATURE_CLAUSE_AS
		redefine
			clients, features
		end;

	AST_EIFFEL_B
		undefine
			position
		end;

	SHARED_EXPORT_STATUS;

feature -- Attributes

	clients: CLIENT_AS_B;
			-- Client list

	features: EIFFEL_LIST_B [FEATURE_AS_B];
			-- Features

feature -- Export status computing

	export_status: EXPORT_I is
			-- Export status of the clause
		do
			if clients /= Void then
				Result := clients.export_status;
			else
				Result := Export_all;
			end;
		end;

feature {CLASS_AS_B} -- Implementation

	register_features (ast_reg: AST_REGISTRATION) is
			-- Register features in `ast_reg'.
		require
			valid_arg: ast_reg /= Void
		local
			f: like features;
			feat, next_feat: FEATURE_AS_B;
			i, l_count: INTEGER;
			e_file: EIFFEL_FILE
		do
			f := features;
			i := 1;
			l_count := f.count;
			if ast_reg.already_extracted_comments then
					-- This means that the comments are already 
					-- extracted so there is no record additional 
					-- information to extract comments.
				from
				until
					i > l_count
				loop
					ast_reg.register_feature (f.i_th (i));
					i := i + 1;
				end
			else
				e_file := ast_reg.eiffel_file;
					-- This means we are registering non precompiled
					-- features for an eiffel project or we are
					-- current precompiling features.
				from
					if l_count > 0 then
						feat := f.i_th (1);
					end
				until
					i > l_count
				loop
					i := i + 1;
					if i > l_count then
						e_file.set_next_feature (Void);
					else
						next_feat := f.i_th (i);
						e_file.set_next_feature (next_feat);
					end;
					e_file.set_current_feature (feat);
					ast_reg.register_feature (feat);
					feat := next_feat;
				end;
			end;
		end;

feature -- Formatting

	storage_info: LINKED_LIST [S_FEATURE_DATA] is
			-- Storage information of Current
		do
			from
				!! Result.make;
				features.start
			until
				features.after
			loop
				Result.put_right (features.item.storage_info);
				Result.forth;	
				features.forth
			end;
		end;

feature -- Update

	assign_unique_values (counter: COUNTER; values: HASH_TABLE [INTEGER, STRING]) is
			-- Assign values to Unique features defined in the current class
		do
			from
				features.start
			until
				features.after
			loop
				features.item.assign_unique_values (counter, values)
				features.forth
			end
		end

end -- class FEATURE_CLAUSE_AS_B
