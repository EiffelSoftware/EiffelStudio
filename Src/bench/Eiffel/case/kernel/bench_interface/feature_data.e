indexing

	description: "Data representing feature information.";
	date: "$Date$";
	revision: "$Revision $"

class FEATURE_DATA

inherit

	NAME_DATA
		redefine
			copy, is_equal, has_elements, 
			update_display, focus,
			free_information,
			request_for_information,
			is_in_class_content
		end;

creation

	make, make_from_storer

feature -- Initialization

	make (default_name: like name; a_class: like class_container) is
			-- Make a default `feature_data'.
		require
			has_name: default_name /= void;
			name_not_empty: not default_name.empty;
			has_class: a_class /= Void
		do
			name := clone (default_name);
			class_container := a_class;
			is_modified_since_last_re := True;
			--!! body.make
		ensure
			name_set: name.is_equal (default_name);
			class_set: a_class = class_container
		end -- make

	make_from_storer (storer: S_FEATURE_DATA) is
			-- Create current from storer	
		require
			storer_exists : storer/= Void	
		local
			a_l: FIXED_LIST [S_ARGUMENT_DATA];
			p_l: FIXED_LIST [S_TAG_DATA];
			argument_data: ARGUMENT_DATA;
			precondition_data: PRECONDITION_DATA;
			postcondition_data: POSTCONDITION_DATA
		do
			name := storer.name;
			is_attribute := storer.is_attribute;
			is_deferred := storer.is_deferred;
			is_constant := storer.is_constant;
			is_expanded := storer.is_expanded
			is_deleted_since_last_re := storer.is_deleted_since_last_re;
			is_effective := storer.is_effective;
			is_new_since_last_re := storer.is_new_since_last_re;
			is_redefined := storer.is_redefined;
			is_once := storer.is_once;
			is_modified_since_last_re := not storer.is_reversed_engineered;
			if is_constant then
				constant_value := storer.constant_value
			end
			if storer.comments /= void then
				!! comments.make_from_storer (storer.comments);
			end;
			a_l := storer.arguments;
			if a_l /= Void then
				!! arguments.make
				from
					a_l.start
				until
					a_l.after
				loop
					!! argument_data.make_from_storer (a_l.item);
					arguments.put_right (argument_data);
					a_l.forth;
					arguments.forth
				end;
			end;
			p_l := storer.preconditions;
			if p_l /= Void then
				!! preconditions.make;
				from
					p_l.start
				until
					p_l.after
				loop
					!! precondition_data.make_from_storer (p_l.item);
					preconditions.put_right (precondition_data);
					p_l.forth;
					preconditions.forth
				end;
			end;
			p_l := storer.postconditions;
			if p_l /= Void then
				!! postconditions.make;
				from
					p_l.start
				until
					p_l.after
				loop
					!! postcondition_data.make_from_storer (p_l.item);
					postconditions.put_right (postcondition_data);
					p_l.forth;
					postconditions.forth
				end;
			end;
			if storer.rename_clause /= Void then
				!! rename_clause.make_from_storer (storer.rename_clause)
			end;
			if storer.result_type /= Void then
				!! result_type.make_from_storer (storer.result_type)
			end
			if not is_deferred and then not is_once and then 
					not is_constant  then
				if storer.body /= Void then
					!! body.make_from_storer (storer.body)
				else
					!! body.make
				end
			else
				!! body.make_empty ( Current )
			end
		end

feature -- Properties

	is_new_since_last_re: BOOLEAN;
			-- Is current feature new since
			-- last reverse engeneering ?

	is_obsolete: BOOLEAN;
			-- Is current feature new since
			-- last reverse engeneering ?

	is_modified_since_last_re: BOOLEAN;
			-- Is current feature been modified since
			-- last reverse engeneering ?

	is_deleted_since_last_re: BOOLEAN;
			-- Has current feature been deleted since
			-- last reverse engineering ?

	name: STRING;
			-- Class name

	class_container: CLASS_DATA;
			-- Class that contains the feature

	arguments: ELEMENT_LIST [ARGUMENT_DATA];
			-- Arguments if routine

	result_type: RESULT_DATA;
			-- Result type if function of attribute

	comments: FEATURE_COMMENT_DATA;
			-- Comment associated to the feature

	preconditions: ELEMENT_LIST [PRECONDITION_DATA];
			-- Pre-conditions

	postconditions: ELEMENT_LIST [POSTCONDITION_DATA];
			-- Post-conditions

	body: FEATURE_BODY_DATA
			-- Body (including locals and rescue) of routine or constant

	constant_value: STRING
		-- Value of the feature, if constant.

	has_arguments: BOOLEAN is
			-- Does Current feature have arguments?
		do
			Result := arguments /= Void and then not arguments.empty
		end;

	has_postconditions: BOOLEAN is
			-- Does Current feature have postconditions?
		do
			Result := postconditions /= Void and then not postconditions.empty
		end;

	has_preconditions: BOOLEAN is
			-- Does Current feature have preconditions?
		do
			Result := preconditions /= Void and then not preconditions.empty
		end;

	has_result: BOOLEAN is
			-- Does Current feature have a result?
		do
			Result := result_type /= Void
		end;

	is_expanded: BOOLEAN;
			-- Is current expanded ?
			-- Consistency with result 

	is_frozen: BOOLEAN;
			-- Is current expanded ?
			-- Consistency with result 

	is_attribute: BOOLEAN;
			-- Is Current feature an attribute?
			-- Consistency with `is_result' must be ensured by clients.

	is_constant: BOOLEAN;
			-- Is Current feature a constant attribute?

	is_deferred: BOOLEAN;
			-- Is Current feature deferred?
			-- Consistency with `is_effective', `is_redefined' and 
			-- `is_attribute' must be ensured by clients.

	is_effective: BOOLEAN;
			-- Is Current feature effecting an inherited feature?
			-- Consistency with `is_deferred' and `is_redefined' must
			-- be ensured by clients.

	is_once: BOOLEAN;
			-- Is Current feature a once?
			-- Consistency with `is_effective' and `is_deferred'
			-- must be ensured by clients.

	is_redefined: BOOLEAN;
			-- Is Current feature redefine?
			-- Consistency with `is_effective' and `is_effective must
			-- be ensured by clients.

	is_unique: BOOLEAN;
			-- Is Current feature redefine?
			-- Consistency with `is_effective' and `is_effective must
			-- be ensured by clients.

	rename_clause: RENAME_DATA;
			-- String representing where feature comes from

        rescue_clause: STRING

	is_renamed: BOOLEAN is
			-- Is Current feature renamed?
		do
			Result := rename_clause /= Void
		end;

	is_in_class_content: BOOLEAN is
		do
			Result := True
		end;

	is_private: BOOLEAN is
			-- Is current feature private?
		require
			class_container_exists : class_container/= Void	
		local
			f_clause: FEATURE_CLAUSE_DATA
		do
			if class_container/= Void then
				-- if added in case of ...	
			--	f_clause := class_container.find_clause (Current);
			--	Result := f_clause.export_i.is_none		
			end	
		end

	has_elements: BOOLEAN is True;

	has_body: BOOLEAN is
			-- Body (including locals, instructions ans rescue clause)
		do
			Result := body /= Void
		end

	has_comments: BOOLEAN is
		do
			Result := comments /= Void and then not comments.empty
		end;

	is_in_system: BOOLEAN is do end;
			-- Is current entity in system ?

	--editor: FEATURE_WINDOW is
			-- Editor for Current (Void if Current
			-- not being edited).
	--	do
	--		Result := Windows.feature_window (Current);
	--	ensure
	--		editor_exists : Result /= Void	
	--	end

	stone: EXP_FEATURE_STONE is
			-- associated stone	
		do
			!! Result.make (Current);
		end;

	stone_type: INTEGER is
			-- Stone type of Current
		do
			Result := Stone_types.feature_type
		end;

feature -- Setting

	set_class_container (a_class: CLASS_DATA) is
			-- Set the attribute class_container to a_class	
		require
			has_class: a_class /= void
		do
			class_container := a_class;
		end

	set_is_new_since_last_re (is_new: BOOLEAN) is
			-- Set current feature to be new since last re
			-- Obsolete use	
		do
			is_new_since_last_re := is_new;
			if is_new then
				is_deleted_since_last_re := False;
			end
		end

	set_is_obsolete (b: like is_obsolete) is
			-- Set current feature to be new since last re
			-- Obsolete use	
		do
			is_obsolete := b
		end

	set_is_unique (b: like is_unique) is
			-- Set current feature to be new since last re
			-- Obsolete use	
		do
			is_unique := b
		end

	set_is_deleted_since_last_re (is_deleted: BOOLEAN) is
			-- Set current feature to be deleted since last re
			-- Obsolete use	
		do
			is_deleted_since_last_re := is_deleted;
			if is_deleted then
				is_new_since_last_re := False;
			end;
		end

	set_name (s: STRING) is
			-- Update `name'.
		do
			name := clone (s);
		ensure then
			name_set:equal (name, s)
		end;

	set_arguments (new_arguments: like arguments) is
			-- Set `arguments' for the feature.
		require
			valid_arguments: new_arguments /= Void
		do
			arguments := new_arguments;
		ensure
			arguments_set: arguments = new_arguments
		end

	set_attribute (b: BOOLEAN) is
			-- Set `is_attribute' to `b'.
			-- Does NOT update `result'.
		do
			is_attribute := b
		ensure
			is_attribute_set: is_attribute = b
		end;

	set_body (new_body: like body) is
			-- Set `body' for the feature.
		require
			valid_body: new_body /= Void
		do
			body := new_body;
		ensure
			body_set: body = new_body
		end

	set_constant (b: BOOLEAN) is
			-- Set `is_constant' to `b'.
		do
			is_constant := b
		ensure
			is_constant_set: is_constant = b
		end;

	set_constant_value (s: like constant_value) is
			-- Set `is_constant' to `b'.
		do
			constant_value := s
		end;

	set_deferred (b: BOOLEAN) is
			-- Set `is_deferred' to `b'.
			-- Do NOT update `body' nor other flags.
		do
			is_deferred := b
		ensure
			is_deferred_set: is_deferred = b
		end;

	set_expanded ( b: BOOLEAN) is
			-- Set 'is expanded' to 'b'
		do
			is_expanded := b
		ensure
			is_expanded_set: is_expanded = b
		end;

	set_effective (b: BOOLEAN) is
			-- Set `is_effective' to `b'.
			-- Do NOT update `body' nor other flags.
		do
			is_effective := b
		ensure
			is_effective_set: is_effective = b
		end;

	set_once (b: BOOLEAN) is
			-- Set `is_once' to `b'.
			-- Do NOT update `body' nor other flags.
		do
			is_once := b
		ensure
			is_once_set: is_once = b
		end;

	set_postconditions (new_postconditions: like postconditions) is
			-- Set `postconditions' for the feature.
		require
			valid_postconditions: new_postconditions /= Void
		do
			postconditions := new_postconditions;
		ensure
			postconditions_set: postconditions = new_postconditions
		end

	set_preconditions (new_preconditions: like preconditions) is
			-- Set `preconditions' for the feature.
		require
			valid_preconditions: new_preconditions /= Void
		do
			preconditions := new_preconditions;
		ensure
			preconditions_set: preconditions = new_preconditions
		end

	set_redefined (b: BOOLEAN) is
			-- Set `is_redefined' to `b'.
			-- Do NOT update `is_deferred and `is_effective'.
		do
			is_redefined := b
		ensure
			is_redefined_set: is_redefined = b
		end

	set_result (new_result: like result_type) is
			-- Set `result_type' for the feature.
			-- Do NOT update `is_attribute'.
		require
			new_result_exists: new_result /= void;
		do
			result_type := new_result;
		ensure
			result_set: result_type = new_result
		end

	set_comments (new_coms: like comments) is
			-- Set result_type for the feature.
		require
			valid_coms: new_coms /= Void
		do
			comments := new_coms;
		ensure
			comment_set: comments = new_coms
		end

	set_rename_clause (ren: RENAME_DATA) is
			-- Set rename_clause to `s'.
		require
			valid_ren: ren /= Void 
		do
			rename_clause := ren
		end;

        set_rescue_clause (s: like rescue_clause) is
                do
                        rescue_clause := s
                end

	update_body is
			-- Update body according to flags
		require
			has_body: has_body
		do
			if is_deferred then
				body.set_deferred
			elseif is_once then
				body.set_once
			elseif not is_constant then
				body.set_do
			end
		end

feature -- Comparison

	is_equal (other: like Current): BOOLEAN is
			-- Function which indicates wether a feature is equal to current or not	
		do
			Result :=	equal (arguments, other.arguments) and then
						equal (comments, other.comments) and then
						equal (preconditions, other.preconditions) and then
						equal (postconditions, other.postconditions) and then
						equal (rename_clause, other.rename_clause) and then
						equal (result_type, other.result_type) and then
						equal (name, other.name) and then
						class_container = other.class_container and then
						is_deferred = other.is_deferred and then
						is_effective = other.is_effective and then
						is_redefined = other.is_redefined and then
						is_once = other.is_once and then
						is_constant = other.is_constant and then
						is_attribute = other.is_attribute
		end

feature -- Duplication

	copy (other: like Current) is
			-- Duplicate Current in other	
		require else
			other_exists : other/= Void	
		local
			args: like arguments;
			comms: like comments;
			precs: like preconditions;
			posts: like postconditions;	
			obody: like body
		do
			name := clone (other.name);
			class_container := other.class_container;
			args := other.arguments;
			if args /= Void then
				arguments := args.duplicate; 
			else
				arguments := Void;
			end;
			comms := other.comments;
			if comms /= Void then
				comments := comms.duplicate
			else
				comments := Void
			end;
			is_attribute := other.is_attribute;
			is_constant := other.is_constant;
			constant_value := other.constant_value
			is_deferred := other.is_deferred;
			is_effective := other.is_effective;
			is_once := other.is_once;
			is_redefined := other.is_redefined;
			posts := other.postconditions;
			if posts /= Void then
				postconditions := posts.duplicate
			else
				postconditions := Void
			end;
			precs := other.preconditions;
			if precs /= Void then
				preconditions := precs.duplicate
			else
				preconditions := Void
			end;
			obody := other.body
			if obody /= Void then
				body := clone (obody)
			else
				body := Void
			end
			rename_clause := clone (other.rename_clause);
			result_type := clone (other.result_type);
		end;

feature -- Update

	update_display (a_data: DATA) is
			-- Update relevant details after a change
			-- using stone type `st_type'.
		require else
			a_data_exists : a_data/= Void	
		--local
		--	ed: FEATURE_WINDOW;
		--	f_l: EDITOR_LIST [FEATURE_WINDOW];
		do
		--	is_modified_since_last_re := True;
		--	class_container.set_is_modified
		--	class_container.update_display (a_data);
		--	f_l := Windows.feature_windows;
		--	from
		--		f_l.start
--			until
--				f_l.after
--			loop
--				if f_l.item.entity = Current then
--					f_l.item.update_page (stone_type)
--				end;
--				f_l.forth
--			end;
		end;

	update_name is
			-- Update relevant details after a name change.
		require else
			class_container_exists : class_container/= Void	
		local
--			ed: FEATURE_WINDOW;
		do
--			is_modified_since_last_re := True;
--			class_container.set_is_modified
--			class_container.update_display (Current);
--			ed := editor;
--			if ed /= Void then
--				ed.update_title;
--				ed.update;
--			end;
		end;

feature -- Information request

	request_for_information is
			-- If the information is not contained in the RAM,
			-- fetch it from the disk	
		require else
			class_container_exists : class_container/= Void	
		do
			class_container.request_for_information
		end

feature -- Element change

	add_argument (new_arg: ARGUMENT_DATA) is
			-- Set arguments for the feature.
		require
			valid_new_arg: new_arg /= void;
		do
			if arguments = Void then
				!! arguments.make
			end;
			arguments.extend (new_arg);
		ensure
			arguments_set: arguments.has (new_arg)
		end; 


        add_feature_name_clause (s: like name) is
                        -- Set arguments for the feature.
                do
                        if name = Void then
                                !! name.make (0)
			else
				name.append (", ")
                        end;

                        name.append (s);
                end;

	add_precondition (new_prec: PRECONDITION_DATA) is
			-- Add `new_prec' to precondtions.
		require
			has_prec: new_prec /= void;
		do
			if preconditions = Void then
				!! preconditions.make;
			end;
			preconditions.extend (new_prec);
		ensure
			new_pre_added: preconditions.has (new_prec)
		end; 

	add_postcondition (new_post: POSTCONDITION_DATA) is
			-- Add `new_post' to postcondtions.
		require
			has_prec: new_post /= void;
		do
			if postconditions = Void then
				!! postconditions.make;
			end;
			postconditions.extend (new_post);
		ensure
			new_post_added: postconditions.has (new_post)
		end;

	insert_before (a_data: like Current) is
			-- Insert Current before `a_data'
		do
		end;

feature -- Removal

	free_information is
			-- Remove content from the RAM	
			-- obsolete use	
		do
			class_container.free_information
		end;

	remove_argument (arg: ARGUMENT_DATA) is
			-- Remove argument `arg' from `arguments'
		require
			argument_exists: arg /= Void
			has_arguments: has_arguments
		do
			arguments.start
			arguments.prune (arg)
		ensure
			not_in: not arguments.has (arg)
			one_less: arguments.count = old arguments.count - 1
		end

	remove_postcondition (post: POSTCONDITION_DATA) is
			-- Remove postcondition `post' from `postconditions'
		require
			post_exists: post /= Void
			has_postconditions: has_postconditions
		do
			postconditions.start
			postconditions.prune (post)
		ensure
			not_in: not postconditions.has (post)
			one_less: postconditions.count = old postconditions.count - 1
		end

	remove_precondition (pre: PRECONDITION_DATA) is
			-- Remove precondition `pre' from `preconditions'
		require
			pre_exists: pre /= Void
			has_preconditions: has_preconditions
		do
			preconditions.start
			preconditions.prune (pre)
		ensure
			not_in: not preconditions.has (pre)
			one_less: preconditions.count = old preconditions.count - 1
		end

	reset_arguments is
			-- Set `arguments' to `Void'.
		do
			arguments := Void
		ensure
			no_arguments: not has_arguments
		end;

	reset_body is
			-- Set `body' to `Void'.
		do
			body := Void
		ensure
			no_body: not has_body
		end;	

	reset_comments is
			-- Set `comments' to `Void'.
		do
			comments := Void
		ensure
			no_comment: not has_comments
		end;

	reset_postconditions is
			-- Set `postconditions' to `Void'.
		do
			postconditions := Void
		ensure
			no_postconditions: not has_postconditions
		end;

	reset_preconditions is
			-- Set `preconditions' to `Void'.
		do
			preconditions := Void
		ensure
			no_preconditions: not has_preconditions
		end;

	reset_rename_clause is
			-- Set rename_clause to `Void'.
		do
			rename_clause := Void
		ensure
			is_not_renamed: not is_renamed
		end;

	reset_result is
			-- Set result to `Void'.
			-- Remove attribute it it was one.
		do
			result_type := Void
			if is_attribute then
				set_attribute (False)
			end
		ensure
			has_no_result: not has_result
			is_not_attribute: not is_attribute
		end;

	clear_editor is
		-- reset the feature window 
		local
--			ed: FEATURE_WINDOW
		do
--			ed := editor;
--			if ed /= Void then
--				ed.clear
--			end
		end

feature -- Output

	focus: STRING is
		-- used for the title of the window
		require else 
			name_exists : name/= Void and then name.count>0	
		do
			!! Result.make (name.count);
			Result.append (name);
		end

	generate_specification (text_area: TEXT_AREA ) is
			-- Generate specificaton for Current.
		do
			generate (text_area, True );
		end;

	generate_code (text_area: TEXT_AREA ) is
			-- Generate code for Current.
		do
			generate (text_area, False );
		end;

	generate (text_area: TEXT_AREA; is_spec: BOOLEAN ) is
		do
			generate_name (text_area, is_spec );
			if is_attribute then
				generate_attribute	( text_area	, is_spec );
			else
				generate_routine	( text_area	, is_spec );
			end
		end

	generate_c (text_area: TEXT_AREA; is_spec: BOOLEAN) is
        do
         
            generate_name_c (text_area, is_spec)
			if is_attribute then
                generate_attribute_c (text_area, is_spec);
            else
                generate_routine_c (text_area, is_spec);
            end		
        end

                   
    generate_attribute_c (text_area: TEXT_AREA; is_spec: BOOLEAN) is
            -- Generate code or specification according to `is_spec'.
		require
			text_exists : text_area/= Void 
		do
                text_area.new_line
                text_area.append_string ("{")
                text_area.append_space
                if body /= Void then 
					body.generate_c (text_area, Current)		 
          	  end

            	text_area.indent;
            	if comments /= void then
                	text_area.indent;
                	comments.generate_c (text_area, Current);
               	 text_area.exdent;
            	end;
                    
            	if not is_spec or else not System.show_bon then
                	if is_redefined then
                    	text_area.indent;
                    	text_area.append_string ("// (redefined");
                	end;
                    
                	if is_renamed then
                    	if not is_redefined then
                        	text_area.indent;
                        	text_area.append_string ("// (renamed)");                 
                    end;
                    text_area.new_line;
                    text_area.exdent;
                end;
            end;
			if has_result then
				text_area.new_line
				text_area.append_string("}")
			end
            text_area.exdent;
        end 


 generate_routine_c (text_area: TEXT_AREA; is_spec: BOOLEAN) is
            -- Generate code or specification according to `is_spec'.
		require
			text_exists : text_area/= Void	
		local
            print_end: BOOLEAN
        do
            if not is_spec then             
                text_area.append_string("{")
            end
            text_area.new_line;
            text_area.indent;
            if comments /= void then
                text_area.indent;
                comments.generate_c (text_area, Current);
                text_area.exdent;
            end;
            if not is_spec or else not System.show_bon then
                if is_redefined then
                    text_area.indent;
                    text_area.append_string ("   // (redefined");
                    if not is_renamed then
                        text_area.append_string (")");
                        text_area.new_line;
                        text_area.exdent;
                    end;
                end;
                if is_renamed then
                    if not is_redefined then
                        text_area.indent;
                        text_area.append_string ("  // (renamed)"); 
                    end;
                    text_area.new_line;
                    text_area.exdent;
                end;
            end;
            if preconditions /= void then
                if not preconditions.empty then
                    print_end := True;
                    text_area.append_keyword ("require");
                    text_area.new_line;
                    text_area.indent;
                    preconditions.generate (text_area, Current );
                    text_area.exdent;
                end;
            end;
            if is_spec then
                if not System.show_bon and then is_deferred then
                    text_area.append_keyword ("deferred")
                    text_area.new_line
                end
            else
                body.generate (text_area, Current )
            end
            if postconditions /= void then
                if not postconditions.empty then
                    print_end := True;
                    text_area.append_keyword ("ensure");
                    text_area.new_line;
                    text_area.indent;
                    postconditions.generate (text_area, Current	);
                    text_area.exdent;
                end
            end;
            if (not is_spec) or else
                (print_end and then System.show_bon)
            then
                text_area.append_string ("}");
                text_area.new_line;
            end;
            text_area.exdent;
        end      
	
	generate_attribute (text_area: TEXT_AREA; is_spec: BOOLEAN ) is
			-- Generate code or specification according to `is_spec'.
		require
			text_exists : text_area/= Void	
		do
			if not is_spec and then is_constant then
				text_area.append_space
				text_area.append_keyword ("is")
				text_area.append_space
				body.generate (text_area, Current )
			else
				text_area.new_line;
			end			
			text_area.indent;
			if comments /= void then
				text_area.indent;
				comments.generate (text_area, Current );
				text_area.exdent;
			end;
			if not is_spec or else not System.show_bon then
				if is_redefined then
					text_area.indent;
					text_area.append_string ("-- (redefined");
					if not is_renamed then
						text_area.append_string (")");
						text_area.new_line;
						text_area.exdent;
					end;
				end;
				if is_renamed then
					if not is_redefined then
						text_area.indent;
						text_area.append_string ("-- (renamed)");
					else
						text_area.append_string (", renamed)");
					end;
					text_area.new_line;
					text_area.exdent;
				end;
			end;
			text_area.exdent;
		end 

	formated_constant_value: STRING is
		-- Format constant value for output ...
		local
			s: STRING
		do
			
			!! Result.make(20)
			if Result_type/= Void then 
				!! s.make(20)
				if Result_type.text/= Void then
					s.append(Result_type.text) 
				elseif Result_type.type/= Void and then Result_type.type.name /= Void then
					s.append(Result_type.type.name)
				end
			end
			s.to_upper
			if s.is_equal("CHARACTER") then
				Result.append("'")
				Result.append(constant_value)
				Result.append("'")
			elseif s.is_equal("STRING") then
				Result.append("%"")
				Result.append(constant_value)
				Result.append("%"")
			else 
				Result.append(constant_value)
			end		
		end
 
	generate_routine (text_area: TEXT_AREA; is_spec: BOOLEAN ) is
			-- Generate code or specification according to `is_spec'.
		require
			text_exists : text_area/= Void	
		local
			print_end: BOOLEAN
		do
			if not is_spec then
				text_area.append_space;
				text_area.append_keyword ("is");
			end			
			if is_constant then
				-- To be complete when Bench will give us the valor of the constant
				text_area.append_space
				if constant_value/= Void then
					text_area.append_keyword (formated_constant_value)
				else
					text_area.append_keyword("UNDEFINED_VALUE")
					text_area.new_line
				end
			else
				text_area.new_line;
			end
			text_area.indent;
			if comments /= void then
				text_area.indent;
					comments.generate (text_area, Current );
				text_area.exdent;
			end;
			if not is_spec or else not System.show_bon then
				if is_redefined then
					text_area.indent;
					text_area.append_string ("-- (redefined");
					if not is_renamed then
						text_area.append_string (")");
						text_area.new_line;
						text_area.exdent;
					end;
				end;
				if is_renamed then
					if not is_redefined then
						text_area.indent;
						text_area.append_string ("-- (renamed)");
					else
						text_area.append_string (", renamed)");
					end;
					text_area.new_line;
					text_area.exdent;
				end;
			end;
			if preconditions /= void then
				if not preconditions.empty then
					print_end := True;
					text_area.append_keyword ("require");
					text_area.new_line;
					text_area.indent;
					preconditions.generate (text_area, Current );
					text_area.exdent;
				end;
			end;

			if is_deferred then
				text_area.append_keyword ("deferred")
				text_area.new_line
			else
				if not is_constant and then
				 not is_spec then
					body.generate (text_area, Current )
				end
			end

			if postconditions /= void then
				if not postconditions.empty then
					print_end := True;
					text_area.append_keyword ("ensure");
					text_area.new_line;
					text_area.indent;
					postconditions.generate (text_area, Current );
					text_area.exdent;
				end
			end;
			if	not is_constant	and
				(	not is_spec	or else 
					(	print_end	and then
						System.show_bon
					) 
				)
			then
				text_area.append_string ("end");
				text_area.new_line;
			end;
			text_area.exdent;
		end 


	generate_name (text_area: TEXT_AREA; is_spec: BOOLEAN ) is
			-- Append the name of the feature in `a_clickable'.
		require
			text_exists : text_area/= Void	
		local
			s,t: STRING
		do
			if is_spec and then System.show_bon then 
				if is_deferred then
					text_area.append_keyword ("deferred");
					text_area.append_space;
				elseif is_effective then
					text_area.append_keyword ("effective");
					text_area.append_space;
				elseif is_redefined then
					text_area.append_keyword ("redefined");
					text_area.append_space;
				end
			end;
			!! s.make(20)
			s.append(name)
			s.to_upper
			!! t.make(20)
			if s.count>=7 and then s.substring(1,7).is_equal("_INFIX_") then
				t.append("infix")
				if 
					s.is_equal("_INFIX_POWER") then t.append(" %"^%" ")
				elseif
					s.is_equal("_INFIX_#") then t.append(" %"#%" ")
				elseif 
					s.is_equal("_INFIX_LT") then t.append(" %"<%" ")
				elseif 
					s.is_equal("_INFIX_GT") then t.append(" %">%" ")
				elseif 
					s.is_equal("_INFIX_GE") then t.append(" %">=%" ")
				elseif 
					s.is_equal("_INFIX_LE") then t.append(" %"<=%" ")
				elseif 
					s.is_equal("_INFIX_PLUS") then t.append(" %"+%" ")
				elseif
					s.is_equal("_INFIX_MINUS") then t.append(" %"-%" ")
				elseif
					s.is_equal("_INFIX_STAR") then t.append(" %"*%" ")
				elseif
					s.is_equal("_INFIX_SLASH") then t.append(" %"/%" ")
				elseif
					s.is_equal("_INFIX_MOD") then t.append(" %"//%" ")
				elseif
					s.is_equal("_INFIX_LT") then t.append(" %"<%" ")
				elseif
					s.is_equal("_INFIX_DIV") then t.append(" %"/%" ")
				elseif 
					s.is_equal("INFIX_AND_THEN") then t.append(" %"AND THEN%" ")
				elseif 
					s.is_equal("INFIX_OR_ELSE") then t.append(" %"OR ELSE%" ")
				else
					if s.count>7 then
						s := clone ( s.substring(8,s.count) )
						t.append(" %"")
						t.append(s)
						t.append("%" ")
					else
						t := clone (name)
					end
				end
			elseif
				s.count>=8 and then s.substring(1,8).is_equal("_PREFIX_") then
				t.append("prefix")
				if
					s.is_equal("_PREFIX_NOT") then t.append(" %"NOT%" ")
				elseif 
					s.is_equal("_PREFIX_PLUS") then t.append(" %"+%" ")
				elseif 
					s.is_equal("_PREFIX_MINUS") then t.append(" %"-%" ")
				else
						s := clone ( s.substring(9,s.count) )
						t.append(" %"")
						t.append(s)
						t.append("%" ")
				end
			else
				t := clone ( name )
			end		
			-- before text_area.append_clickable_string (stone, name);
			text_area.append_clickable_string (stone, t)
			generate_argument_and_result (text_area, is_spec )
		end;

	generate_name_c (text_area: TEXT_AREA; is_spec: BOOLEAN) is
            -- Append the name of the feature in `a_clickable'.
		require
			text_exists : text_area /= Void		
		do
            generate_argument_and_result_c (text_area, is_spec)
			text_area.append_clickable_string (stone, name)
			if is_spec and then System.show_bon then 
                if is_deferred then
                    text_area.append_keyword (" // deferred");
                    text_area.append_space;
                elseif is_effective then
                    text_area.append_keyword (" // effective");
                    text_area.append_space;
                elseif is_redefined then
                    text_area.append_keyword (" //redefined");
                    text_area.append_space;
                end
            end;
           
        end;

	  generate_argument_and_result_c (text_area: TEXT_AREA; is_spec: BOOLEAN) is
            -- Generate the argument and result of Current.
		require
			text_exists : text_area/= Void	
		do
            if is_spec and then is_renamed and then
                System.show_bon
            then
                text_area.append_string (" { ");
                rename_clause.generate (text_area, Current );
                text_area.append_string (" }");
            end;
            if arguments /= void and not arguments.empty then
                if not is_spec or else not System.show_bon then
                    text_area.append_string (" (");
                else
                    text_area.indent;
                end;
                from
                    arguments.start
                until
                    arguments.after
                loop
                    if is_spec and then System.show_bon then
                        text_area.new_line;
                        text_area.append_string ("-> ");
                    end;
                    arguments.item.generate (text_area, Current	);
                    arguments.forth;
                    if (not is_spec or else
                        not System.show_bon) and then
                        not arguments.after
                    then
                        text_area.append_string ("; ")
                    end;
                end;
                if not is_spec or else not System.show_bon then
                    text_area.append_string (")")
                else
                    text_area.exdent;
                end;
            end;
            if (not is_spec or else
                not System.show_bon) and then
                result_type /= void
            then
                result_type.generate_c (text_area, Current	)	
            end;
                    
        end;        

	generate_argument_and_result (text_area: TEXT_AREA; is_spec: BOOLEAN ) is
			-- Generate the argument and result of Current.
		require
			text_exists : text_area/= Void	
		do
			if is_spec and then 
				System.show_bon and then 
				result_type /= void 
			then
				result_type.generate (text_area, Current )			end;
			if is_spec and then is_renamed and then
				System.show_bon 
			then 
				text_area.append_string (" { ");
				rename_clause.generate (text_area, Current );
				text_area.append_string (" }");
			end;
			if arguments /= void and not arguments.empty then
				if not is_spec or else not System.show_bon then
					text_area.append_string (" (");
				else
					text_area.indent;
				end;
				from
					arguments.start
				until
					arguments.after
				loop
					if is_spec and then System.show_bon then 
						text_area.new_line;
						text_area.append_string ("-> ");
					end;
					arguments.item.generate (text_area, Current );
					arguments.forth;
					if (not is_spec or else 
						not System.show_bon) and then 
						not arguments.after 
					then
						text_area.append_string ("; ")
					end;
				end;
				if not is_spec or else not System.show_bon then
					text_area.append_string (")")
				else
					text_area.exdent;
				end;
			end;
			if (not is_spec or else 
				not System.show_bon) and then 
				result_type /= void 
			then
				result_type.generate (text_area, Current )
			end;
		end;

	append_clickable_string (text_area: TEXT_AREA) is
			-- routine which appends a clickable string	
		do
			text_area.append_clickable_string (stone, name);
			if is_deferred then
				text_area.append_string ("*");
			elseif is_effective then
				text_area.append_string ("+");
			elseif is_redefined then
				text_area.append_string ("++");
			end;
			generate_argument_and_result (text_area, False );
			if is_renamed then
				text_area.append_string (" { ");
				rename_clause.generate (text_area, Current );
				text_area.append_string (" }");
			end;
		end

feature -- Storage

	storage_key: S_FEATURE_KEY is
			-- key elaborated from corresponding id of the class container	
		do
			!! Result.make (name, class_container.id)
		end;

	storage_info: S_FEATURE_DATA_R40 is
			-- construction of the storer associated with current	
		local
			a_l: FIXED_LIST [S_ARGUMENT_DATA];
			p_l: FIXED_LIST [S_TAG_DATA];
			status: INTEGER
			status_handler: FEATURE_STATUS_HANDLER
			s_l	: S_FEATURE_BODY
				-- Horrible trick to keep backward compatibility and
				-- low disk occupancy without using Eiffel bits...
		do
			!S_FEATURE_DATA_R40! Result.make (name)
			status_handler := Result.status_handler
			if is_new_since_last_re then
				status := status_handler.set_is_new_since_last_re (status)
			elseif is_deleted_since_last_re then
				status := status_handler.set_is_deleted_since_last_re (status)
			end
			if is_once then
				status := status_handler.set_is_once (status)
			end
			if is_constant then
				status := status_handler.set_is_constant (status)
				if constant_value /= Void then
					Result.set_constant_value(constant_value)
				end
			end
			Result.set_booleans (is_deferred, is_effective, 
					is_redefined, is_attribute, is_expanded);
			if comments /= void then
				Result.set_comments (comments.storage_info);
			end;
			if arguments /= Void and then not arguments.empty then
				!! a_l.make_filled (arguments.count);
				from
					arguments.start;
					a_l.start
				until
					arguments.after
				loop
					a_l.replace (arguments.item.storage_info);
					a_l.forth;
					arguments.forth
				end;
				Result.set_arguments (a_l);
			end;
			if preconditions /= Void and then not preconditions.empty then
				!! p_l.make_filled (preconditions.count);
				from
					preconditions.start;
					p_l.start
				until
					preconditions.after
				loop
					p_l.replace (preconditions.item.storage_info);
					p_l.forth;
					preconditions.forth
				end;
				Result.set_preconditions (p_l);
			end;
			if postconditions /= Void and then not postconditions.empty then
				!! p_l.make_filled (postconditions.count);
				from
					postconditions.start;
					p_l.start
				until
					postconditions.after
				loop
					p_l.replace (postconditions.item.storage_info);
					p_l.forth;
					postconditions.forth
				end;
				Result.set_postconditions (p_l);
			end;
			if rename_clause /= Void then
				Result.set_rename_clause (rename_clause.storage_info)
			end;
			if result_type /= Void then
				Result.set_result_type (result_type.storage_info)
			end
			if	body /= Void	and then 
				not body.empty 
			then
				!! s_l.make	( 0	)
				from
					body.start
				until
					body.after
				loop
					s_l.extend	( body.item	)	
					body.forth
				end
				Result.set_body (s_l);
			end;
			Result.set_status (status)
		end;

invariant
	has_name: name /= void

end -- class FEATURE_DATA
