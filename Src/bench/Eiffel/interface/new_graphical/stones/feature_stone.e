indexing
	description	: "Stone representing an eiffel feature stone."
	date		: "$Date$"
	revision	: "$Revision $"

class 
	FEATURE_STONE 

inherit
	CLASSC_STONE
		rename
			make as class_stone_make
		redefine
			is_valid, synchronized_stone, 
			history_name, same_as, origin_text, header, stone_signature,
			file_name, stone_cursor, x_stone_cursor
		end

	SHARED_EIFFEL_PROJECT

creation
	make

feature {NONE} -- Initialization

	make (a_feature: E_FEATURE) is
			-- Initialize feature stone.
		require
			a_feature_not_void: a_feature /= Void
		do
			class_stone_make (a_feature.written_class)
			e_feature := a_feature
			internal_start_position := -1
			internal_end_position := -1
		end

feature -- Properties
 
	e_feature: E_FEATURE
		-- Feature associated with stone

	start_position: INTEGER is
			-- Start position of the feature in
			-- the origin file
		local
			fast: FEATURE_AS
		do
			if internal_start_position < 0 then
				fast := e_feature.ast
				if fast /= Void then
					internal_start_position := fast.start_position
					internal_end_position := fast.end_position
				else
					internal_start_position := 0
					internal_end_position := 0
				end
			end
			Result := internal_start_position
		end

	end_position: INTEGER is
			-- End position of the feature in
			-- the origin file
		local
			fast: FEATURE_AS
		do
			if internal_start_position < 0 then
				fast := e_feature.ast
				if fast /= Void then
					internal_start_position := fast.start_position
					internal_end_position := fast.end_position
				else
					internal_start_position := -1
					internal_end_position := -1
				end
			end
			Result := internal_end_position
		end

feature -- Access

	feature_name: STRING is
			-- Feature name of feature
		do
			Result := e_feature.name
		end

	origin_name: STRING is
			-- Name of the feature in its written class.
		do
			if e_feature.written_class.has_feature_table then
				Result := e_feature.written_class.feature_with_body_index (e_feature.body_index).name
			else
				Result := e_feature.name
			end
		end

	history_name: STRING is
			-- Name used in the history list
		do
			create Result.make (0)
			Result.append (Interface_names.s_Feature_stone)
			Result.append (e_feature.name)
			Result.append (" from ")
			Result.append (e_class.class_signature)
		end
 
	same_as (other: STONE): BOOLEAN is
			-- Is `other' the same stone?
			-- Ie: does `other' represent the same feature?
		local
			fns: FEATURE_STONE
		do
			fns ?= other
			Result := fns /= Void and then
					e_feature.feature_id = fns.e_feature.feature_id and then
					e_feature.associated_class = fns.e_feature.associated_class
		end

feature -- dragging

	origin_text: STRING is
			-- Text of the feature
		local
			temp: STRING
		do
			Result := "-- Version from class: "
			Result.append (e_feature.written_class.name_in_upper)
			Result.append ("%N%N%T")

			temp := Precursor
			if temp /= Void then
				if 
					temp.count >= end_position and 
					start_position < end_position 
				then
					temp := temp.substring (start_position + 1, end_position)
					Result.append (temp)
				end
			end
			Result.append ("%N")
		end

	file_name: FILE_NAME is
			-- The one from class origin of `e_feature'
		do
			if e_feature /= Void and then 
				e_feature.written_class /= Void and then
				e_class /= Void
			then
				create Result.make_from_string (e_feature.written_class.file_name)
			end
		end
 
	stone_signature: STRING is
			-- Signature of Current feature
		do
			Result := e_feature.feature_signature
		end

	header: STRING is
			-- Name for the stone.
		local
			a_base_name: STRING
		do
			create Result.make (20)
			Result.append ("{")
			Result.append (e_class.name_in_upper)
			Result.append ("}.")
			Result.append (e_feature.name)
			if class_i /= Void then
				a_base_name := class_i.file_name
				if a_base_name /= Void then
					Result.append (" (located in ")
					Result.append (a_base_name)
					Result.append (")")
				end
			end
		end

	stone_cursor: EV_CURSOR is
			-- Cursor representing `Current' when dropping is allowed.
		once
			Result := Cursors.cur_Feature
		end
 
	x_stone_cursor: EV_CURSOR is
			-- Cursor representing `Current' when dropping is forbidden.
		once
			Result := Cursors.cur_X_feature
		end
 
	line_number: INTEGER is
			-- Line number of feature text
		require
			valid_start_position: start_position > 0
			valid_file_name: file_name /= Void 
		local
			file: RAW_FILE
			start_line_pos: INTEGER
		do
			create file.make (file_name)
			if file.is_readable then
				file.open_read
				from
				until
					file.position > start_position + 1 or else file.end_of_file
				loop
					start_line_pos := file.position
					Result := Result + 1
					file.readline
				end
			end
			file.close
		end

	is_valid: BOOLEAN is
			-- Is `Current' a valid stone?
		do
				-- Don't like side effects but it is
				-- useful here.
			check_validity
			if start_position = 0 then
					-- Body as cannot be found
				Result := False
			else
				Result := {CLASSC_STONE} Precursor and then e_class /= Void and then e_feature /= Void
			end
		end

	check_validity is
			-- Check the validity of feature stone.
		local
			body_as: FEATURE_AS
			retried: BOOLEAN
		do
			if not retried then
				if internal_start_position = -1 and then e_feature /= Void then
						-- Position has not been initialized
					body_as := e_feature.ast
					if body_as /= Void then
						internal_start_position := body_as.start_position
						internal_end_position := body_as.end_position
					else
						internal_start_position := 0
						internal_end_position := 0
					end	
				end
			else
				internal_start_position := 0
				internal_end_position := 0
			end
		rescue
			retried := True
			retry
		end

	synchronized_stone: CLASSI_STONE is
			-- Clone of `Current' after a recompilation
			-- (May be Void if not valid anymore)
		local
			new_e_feature: like e_feature
			fok: BOOLEAN
		do
			if e_class /= Void then
				if e_feature /= Void then
					new_e_feature := e_feature.updated_version
					if new_e_feature /= Void then
						create {FEATURE_STONE} Result.make (new_e_feature)
						fok := Result.is_valid
					end
				end
					-- Even if the feature has been removed or is now in a class out of the system,
					-- we try to create a valid Result.
				if not fok then
					create {CLASSC_STONE} Result.make (e_class)
					Result := Result.synchronized_stone
				end
			end
		end

feature -- Hashable

	hash_code: INTEGER is
			-- Hash code value
		do
			Result := e_class.name.hash_code
		end

feature {NONE} -- Implementation

	internal_start_position: INTEGER
			-- Start position for feature

	internal_end_position: INTEGER
			-- End position for feature

end -- class FEATURE_STONE
