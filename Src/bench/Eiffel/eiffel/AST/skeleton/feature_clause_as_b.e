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

	register_features (format_reg: FORMAT_REGISTRATION) is
			-- Register features in `format_reg'.
		require
			valid_arg: format_reg /= Void
		local
			f: like features;
			feat: FEATURE_AS_B;
			feat_adapter: FEATURE_ADAPTER
		do
			f := features;
			from
				f.start
			until
				f.after
			loop
				feat := f.item;
				!! feat_adapter;
				feat_adapter.register (feat, format_reg);
				f.forth
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

end -- class FEATURE_CLAUSE_AS_B
