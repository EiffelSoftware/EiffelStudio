indexing

	description: "List of features for a given export policy.";
	date: "$Date$";
	revision: "$Revision $"

class FEATURE_CLAUSE_DATA

inherit

	CLASS_ELEMENT_DATA
		rename
			generate as generate_data
		end

creation

	make, make_default, make_from_storer

feature {NONE} -- Initialization

	make (cd: like class_data; exp: like export_i; com: like comment) is
		require
			cd_exists: cd /= Void
			exp_exists: exp /= Void
			com_exists: com /= Void
		local
			esi: EXPORT_SET_I
		do
			class_data := cd
			esi ?= exp
			if esi = Void then
				if exp.is_all then
					!! esi.make_any
				else
					check
						is_none: exp.is_none
					end
					!! esi.make_none
				end
			end
			export_i := esi
			comment := com
			!! features.make
		end

	make_default (cd: like class_data) is
			-- Make a default feature clause (default export "{ANY}",
			-- and no comment)
		require
			cd_exists: cd /= Void
		do
			class_data := cd
			!EXPORT_SET_I!export_i.make_default
			!! comment.make
			!! features.make
		end

	make_from_storer (s: S_FEATURE_CLAUSE; cd: CLASS_DATA) is
		require
			valid_s: s /= Void
		do
			class_data := cd
			!EXPORT_SET_I! export_i.make_from_storer (s.export_i)
			!! features.make_from_storer (s.features, cd);
			if s.comment = Void then
					--| for old versions.
				!! comment.make
			else
				!! comment.make_from_storer (s.comment)
			end			
		end;

feature -- Properties

	class_data: CLASS_DATA
			-- Class to which Current belongs

	destroy_command (a_data: CLASS_DATA): DESTROY_LIST_ELEMENT is
			-- Destroy command for Current data
		do
		--	!! Result.make (a_data, a_data.feature_clause_list, Current)
		end

	export_i: EXPORT_I;  
			-- Export status of Current feature clause
			--| in fact, in 3.4.0 and above, may only be a EXPORT_SET_I

	comment: FEATURE_CLAUSE_COMMENT_DATA;
			-- Comment associated to Current feature clause

	features: FEATURE_LIST;
			-- List of featrures in the Current feature clause
	
	is_current: BOOLEAN
			-- Is Current the feature clause to which features 
			-- will be added?

	is_valid_for (data: DATA): BOOLEAN is
		local
			cd: CLASS_DATA
		do
		--	cd ?= data
		--	Result := cd /= Void and then 
		--		cd.feature_clause_list.has (Current)
		end

	--stone_cursor: SCREEN_CURSOR is
	--		-- Cursor associated to Current data
	--	do
		--	Result := Cursors.feature_clause_cursor
	--	end

	stone_type: INTEGER is
			-- Stone type of Current
		do
			Result := Stone_types.feature_clause_type
		end

feature -- Comparison

	is_equal (other: like Current): BOOLEAN is
			-- Is `other' equal to Current, ie. have they
			-- the same declaration (export and comment),
			-- and is attached to the same class?
		do
			Result := (class_data = other.class_data) and then
					same_export (other.export_i) and then
					comment.is_equal (other.comment)
		end
	
	same_export (other_exp: EXPORT_I): BOOLEAN is
			-- Is other export same as Current?
		require
			valid_other: other_exp /= Void
		do
			Result := export_i.same_as (other_exp)
		end;

feature -- Settings

	set_is_current is
			-- Set `is_current' to True
		do
			is_current := True
		end

	unset_is_current is
			-- Set `is_current' to False
		do
			is_current := False
		end

feature -- Element change

	add_feature (f: FEATURE_DATA) is
			-- Add feature `f' to Current feature clause
		require
			f_exists: f /= Void
		do
			features.extend (f)
		ensure
			added: features.has (f)
		end

	insert_before (data_cont: CLASS_DATA; a_data: like Current) is
			-- Insert Current before `a_data'
		local
			swap: SWAP_ELEMENT_U
		do
			!! swap.make (data_cont, data_cont.generics, Current, a_data)
		end

	set_comment (com: like comment) is
			-- Set `comment' to  `com'
		require
			com_exists: com /= Void
		do
			comment := com
		end

	set_export (exp: like export_i) is
			-- Set `export_i' to  `exp'
		require
			exp_exists: exp /= Void
		do
			export_i := exp
		end

        add_client (s: STRING) is
		local
		export_set_i: EXPORT_SET_I
                do
			export_set_i ?= export_i

                        if export_set_i = Void then
                                !! export_set_i.make_any
                        end

                        export_set_i.extend (s)
			export_i := export_set_i
                end

feature -- Duplication

	copy (other: like Current) is
            -- Update current object using fields of object attached
            -- to `other', so as to yield equal objects.
		do
			class_data := other.class_data
			export_i := clone (other.export_i)
			comment := clone (other.comment)
			!! features.make
		end

feature -- Output

	clickable_string, focus: STRING is
			-- String displayed in clickable text
		do
			Result := "feature"
			Result.append (export_i.export_string)
			Result.append (comment.comment_string)
		end

	generate (text_area: TEXT_AREA; is_spec: BOOLEAN ) is
			-- Generate Current into `text_area', keeping position 
			-- information.
		require
			valid_text_area: text_area /= Void
		do
			text_area.generate_feature_clause	( Current	, is_spec )
		end

	generate_feature_names (text_area: TEXT_AREA) is
			-- Generate feature names into `text_area'.
		require
			valid_text_area: text_area /= Void
		do
			text_area.generate_feature_names (Current)
		end

	generate_modified_feature_names (text_area: TEXT_AREA) is
			-- Generate names of modified features into `text_area', 
			-- recording positions if relevant
		require
			valid_text_area: text_area /= Void
		do
			text_area.generate_modified_feature_names (Current)
		end

	generate_feature_list (text_area: TEXT_AREA; feat_list: LINKED_LIST [FEATURE_DATA]) is
			-- Generate the feature names from 'feat_list' to 'text_area'
		local
			feat: FEATURE_DATA;
		do
			text_area.indent;
			from
				feat_list.start
			until
				feat_list.after
			loop
				feat := feat_list.item;
				feat.append_clickable_string (text_area);
				text_area.new_line;
				feat_list.forth
			end;
			text_area.exdent;
			text_area.new_line;
		end;
	
feature -- Storage

	storage_info: S_FEATURE_CLAUSE is
		do
			!! Result.make (features.storage_info, export_i.storage_info, comment.storage_info)
		end;

feature	{TEXT_AREA,CLASS_C_PLUS} -- Text/code genration

	actual_generate (text_area: TEXT_AREA; is_spec: BOOLEAN ) is
			-- Generate text corresponding to Current into `text_area'.
		do
			generate_declaration (text_area	)
			if not features.empty then
				features.generate (text_area, is_spec )
			end
		end

	generate_c (text_area: TEXT_AREA; is_spec: BOOLEAN) is
            -- Generate text corresponding to Current into `text_area'.
        do
            generate_declaration_c (text_area)
            if not features.empty then
                features.generate_c (text_area, is_spec)
            end
        end

	actual_generate_feature_names (text_area: TEXT_AREA) is
			-- Generate Current's feature names into `text_area'
		do
			generate_declaration (text_area	);
			if not features.empty then
				text_area.indent;
				from
					features.start
				until
					features.after
				loop
					features.item.append_clickable_string (text_area);
					text_area.new_line;
					features.forth
				end;
				text_area.exdent;
				text_area.new_line
			end
		end;

	actual_generate_modified_feature_names (text_area: TEXT_AREA) is
			-- Generate feature names of modified features into `text_area'.
		require
			valid_text_area: text_area /= Void
		local
			feat: FEATURE_DATA;
			mod_feat_list: LINKED_LIST [FEATURE_DATA]
			new_feat_list: LINKED_LIST [FEATURE_DATA]
		do
			if not features.empty then
				!! mod_feat_list.make;
				!! new_feat_list.make;
				from
					features.start
				until
					features.after
				loop
					feat := features.item;
					if feat.is_new_since_last_re then
						new_feat_list.extend (feat);
					elseif feat.is_modified_since_last_re then
						mod_feat_list.extend (feat);
					end;
					features.forth
				end;
				if not new_feat_list.empty then
					generate_declaration (text_area	);
					text_area.append_string (" -- New features:");
					text_area.new_line;
					generate_feature_list (text_area, new_feat_list);
				end;
				if not mod_feat_list.empty then
				 	generate_declaration (text_area	);
					text_area.append_string (" -- Modified features:");
					text_area.new_line;
					generate_feature_list (text_area, mod_feat_list);
				end;
			end
		end;

feature {NONE} -- Implementation

	generate_declaration (text_area: TEXT_AREA ) is
			-- Generate the feature clause "declaration", ie
			-- "feature {X, Y, Z} -- Comment"
		local
			feature_string: STRING
		do
			if is_current then
				feature_string := text_area.special_string ("=> ")
				--!!feature_string.make(10)
			else
				!! feature_string.make (10)
			end
			feature_string.append ("feature")
			text_area.append_clickable_string (stone (class_data), feature_string)
			export_i.generate (text_area);
			comment.generate (text_area, Current );
			text_area.new_line;
			text_area.new_line;	
		end

		generate_declaration_c (text_area: TEXT_AREA) is
            -- Generate the feature clause "declaration", ie
            -- "feature {X, Y, Z} -- Comment"
        local
            feature_string: STRING
        do
            if is_current then
                feature_string := text_area.special_string ("> ")
                --!!feature_string.make(10)
            else
                !! feature_string.make (10)
            end  
            text_area.append_clickable_string (stone (class_data), feature_string)
            if export_i.is_all then
				text_area.append_string("public ")
			else
				if export_i.is_none then
					text_area.append_string("protected ")
				else
					text_area.append_string("friend ")
				end
			end
			 
			export_i.generate_c (text_area);
            --comment.generate (text_area, Current);
            text_area.new_line;
            text_area.new_line;    
        end
feature {NONE} -- Inapplicable

	illegal_characters (tag, text: STRING): BOOLEAN is
			-- No tag or text to check
		do
			check
				not_called: False
			end			
		end

	--setup_namer (namer: NAMER_WINDOW) is
	--		-- The namer window is not used to modified feature clauses
	--	do
	--		check
	--			not_called: False
	--		end			
	--	end

	--update_from_namer (namer: NAMER_WINDOW) is
	--		-- The namer window is not used to modified feature clauses
	--	do
	--		check
	--			not_called: False
	--		end
	--	end

invariant

	class_data_exists: class_data /= Void
	comment_exists: comment /= Void
	export_i_exists: export_i /= Void
	features_exist: features /= Void;

end -- class FEATURE_CLAUSE_DATA
