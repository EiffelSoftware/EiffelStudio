class REP_CONTEXT

creation

	make

feature


	make (new_name: like replicated_name; 
			pairs: like conversion_list;
			adapter: like starting_adapter) is
		do
			replicated_name := new_name;
			conversion_list := pairs;
			starting_adapter := adapter;
			current_adapter := clone (adapter);
			is_new_expression := True;
		end;	

	is_new_expression: BOOLEAN;
	
	replicated_name: FEATURE_NAME;

	
	adapt_result is
		do
		--	current_adapter := 
		end;

	adapt_current is
		do
			reset_adapter;
		end;


	adapt_name (name: STRING) is
		local
			new_name: STRING;
		do
			if current_adapter = void then
				new_name := name;
			elseif is_new_expression then
				parent_clause_adaptation (name);
				if not adaptation_from_clause then
				--	current_adapter := 
						--current_adapter.adapt_feature (name)
				end;
				--new_name := current_adapter.internal_name
			else
				--current_adapter := current_adapter.adapt_feature (name);
				--new_name := current_adapter.internal_name;
			end;
			if new_name = Void then
				new_name := name
			end;
			!!adapted_name.make (new_name.count);
			adapted_name.append (new_name);
			is_new_expression := False;
		end;

	adapted_name: ID_AS;
		

	new_ctxt: like Current is
		do
			Result := clone (Current);
			Result.reset_adapter;
		end;

	stop_adaptation is
		do
			current_adapter := void;
		end;


feature

	starting_adapter: LOCAL_FEAT_ADAPTATION;

	current_adapter: LOCAL_FEAT_ADAPTATION;

	conversion_list: S_REP_NAME_LIST;

	reset_adapter is
		do
			Current_adapter := clone (starting_adapter);
			is_new_expression := True;
		end;

	parent_clause_adaptation (name: STRING) is
		local
			pair: S_REP_NAME;
			old_feat: FEATURE_I;
		do
			from
				adaptation_from_clause := false;
				conversion_list.start
			until
				conversion_list.after or adaptation_from_clause
			loop
				pair := conversion_list.item;
				old_feat := pair.old_feature;
				if old_feat /= Void and then old_feat.feature_name.is_equal (name) then
					--current_adapter.set_new_base (pair.old_feature, pair.new_feature);
					adaptation_from_clause := true;
				end;
				conversion_list.forth
			end
		end;

	adaptation_from_clause: BOOLEAN;
end
