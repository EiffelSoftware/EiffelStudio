indexing

	description: 
		"Stone representing an eiffel feature stone.";
	date: "$Date$";
	revision: "$Revision $"

class FEATURE_STONE 

inherit

	FILED_STONE
		rename
			origin_text as normal_origin_text,
			is_valid as fs_valid
		redefine
			synchronized_stone, invalid_stone_message, same_as,
			history_name
		end;
	FILED_STONE
		redefine
			origin_text, is_valid, synchronized_stone, invalid_stone_message,
			history_name, same_as
		select
			origin_text, is_valid
		end;
	SHARED_EIFFEL_PROJECT;
	HASHABLE_STONE
		redefine
			origin_text, is_valid, synchronized_stone, header, 
			invalid_stone_message, history_name, same_as
		end;
	INTERFACE_W;
	WARNING_MESSAGES;
	WINDOWS

creation

	make

feature {NONE} -- Initialization

	make (a_feature: E_FEATURE; a_class: E_CLASS) is
		do
			start_position := -1;
			end_position := -1;
			e_feature := a_feature;
			e_class := a_class
		end;

feature -- Properties
 
	e_feature: E_FEATURE;
	e_class: E_CLASS;

	start_position: INTEGER;
			-- Start position of the feature in
			-- the origin file

	end_position: INTEGER;
			-- End position of the feature in
			-- the origin file

feature -- Access

	icon_name: STRING is
		local
			temp: STRING
		do
			!!Result.make (0);
			Result.append (e_feature.name);
			Result.append (" (");
			temp := clone (e_class.name)
			temp.to_upper;
			Result.append (temp);
			Result.append (")");
		end;

	header: STRING is
		do
			!!Result.make (0);
			Result.append ("Feature: ");
			Result.append (e_feature.name);
			Result.append (" Class: ");
			Result.append (e_class.signature);
		end;

	history_name: STRING is
			-- Name used in the history list
		do
			!! Result.make (0);
			Result.append (e_feature.name);
			Result.append (" from ");
			Result.append (e_class.name_in_upper)
		end;
 
	same_as (other: like Current): BOOLEAN is
			-- Is `other' the same stone?
			-- Ie: does `other' represent the same feature?
		local
			fns: FEATURE_NAME_STONE
		do
			if e_feature /= Void then
				fns ?= other;
				if fns /= Void then
					Result := e_feature.name.is_equal (fns.feature_name)
				else
					if other /= void and then other.e_feature /= Void then
						Result := e_feature.name.is_equal (other.e_feature.name)
					end
				end
			end;
			Result := Result and then
				e_class = other.e_class and then
				start_position = other.start_position and then
				end_position = other.end_position
		end

feature -- dragging

	origin_text: STRING is
			-- Text of the feature
		local
			temp: STRING;
			cn: STRING;
		do
			temp := normal_origin_text;
			if temp /= Void then
				Result := "-- Version from class: ";
				cn := clone (e_feature.written_class.name)
				cn.to_upper;
				Result.append (cn);
				Result.append ("%N%N%T");
				if 
					temp.count >= end_position and 
					start_position < end_position 
				then
					temp := temp.substring (start_position + 1, end_position);
					Result.append (temp)
				end;
				Result.append ("%N");
			end
		end;

	click_list: ARRAY [CLICK_STONE] is
			-- Structure to make clickable the display of Current, nothing yet
			-- Now yeah
		local
			cs: CLICK_STONE;
			sp, ep: INTEGER;
			temp: STRING;
			classc_stone: CLASSC_STONE
		do 
			!! Result.make (1, 2);
				temp := "-- Version from class: ";
				sp := temp.count;
				ep := e_feature.written_class.name.count;
				ep := ep + sp;
			!! classc_stone.make (e_feature.written_class);
			!! cs.make (classc_stone, sp, ep);
			Result.put (cs, 1);
				sp := ep + 3;
				ep := sp + end_position - start_position;
			!! cs.make (Current, sp, ep);
			Result.put (cs, 2);
		end;
 
	file_name: STRING is
			-- The one from class origin of `e_feature'
		do
			if e_feature /= Void and then 
				e_feature.written_class /= Void and then
				e_class /= Void
			then
				Result := e_feature.written_class.file_name
			end;
		end;
 
	set_file_name (s: STRING) is do end;

	signature: STRING is
			-- Signature of Current feature
		do
			Result := e_feature.signature
		end;

	stone_type: INTEGER is do Result := Routine_type end;

	stone_cursor: SCREEN_CURSOR is
			-- Cursor associated with
			-- Current stone during transport.
		do
			Result := cur_Feature
		end;
 
	stone_name: STRING is do Result := l_Routine end;
 
	clickable: BOOLEAN is
		do
			Result := True
		end;

	invalid_stone_message: STRING is
			-- Message displayed for an invalid_stone
		do
			Result := w_Feature_not_compiled
		end;

	line_number: INTEGER is
			-- Line number of feature text.
		require
			valid_start_position: start_position > 0;
			valid_feature: e_feature /= Void 
		local
			file: RAW_FILE;
			start_line_pos: INTEGER;
		do
			!!file.make_open_read (file_name);
			from
			until
				file.position > start_position + 1 or else file.end_of_file
			loop
				start_line_pos := file.position;
				Result := Result + 1;
				file.readline;
			end;
			file.close;
		end;

	is_valid: BOOLEAN is
			-- Is `Current' a valid stone?
		do
				-- Don't like side effects but it is
				-- useful here.
			check_validity;
			if start_position = 0 then
					-- Body as cannot be found
				Result := False
			else
				Result := fs_valid and then e_class /= Void 
						and then e_feature /= Void
			end
		end;

	check_validity is
			-- Check the validity of feature stone.
		local
			body_as: FEATURE_AS
		do
			if start_position = -1 then
					-- Position has not been initialized
				body_as := e_feature.ast;
				if body_as /= Void then
					start_position := body_as.start_position
					end_position := body_as.end_position
				else
					start_position := 0
					end_position := 0
				end	
			end
		end;

	synchronized_stone: FEATURE_STONE is
			-- Clone of `Current' after a recompilation
			-- (May be Void if not valid anymore)
		local
			new_e_feature: like e_feature
		do
			if e_class /= Void and e_feature /= Void then
				if Eiffel_system.class_of_id (e_class.id) = e_class then
					new_e_feature := e_class.feature_with_name (e_feature.name);
					if new_e_feature /= Void then
						!! Result.make (new_e_feature, e_class)
					end
				end
			end
		end;

feature -- Hashable

	hash_code: INTEGER is
			-- Hash code value
		do
			Result := e_class.name.hash_code
		end;

feature {NONE} -- Implementation

	private_start_position: INTEGER;
			-- Start position for feature

	private_end_position: INTEGER;
			-- End position for feature

feature -- Update

	process (hole: HOLE) is
			-- Process Current stone dropped in hole `hole'.
		do
			if is_valid then
				hole.process_feature (Current)
			else
				warner (hole.target.top).gotcha_call (invalid_stone_message)
			end
		end;

end -- class FEATURE_STONE
