class EXTERNAL_LANG_AS

inherit

	AST_EIFFEL;
	EXTERNAL_CONSTANTS

feature -- Attributes

	language_name: STRING_AS;
			-- Language name
			-- might be replaced by external_declaration or external_definition

	ext_language_name: STRING;
			-- Name of external language

	special_type: STRING;
			-- Type of special external 

	special_file_name: STRING;
			-- File name including the macro definition

	arg_list: EXTERNALS_LIST;
			-- List of arguments for the signature

	return_type: STRING;
			-- Result type of signature

	include_list: EXTERNALS_LIST;
			-- List of include files

feature -- Routines

	is_special: BOOLEAN is
			-- Does the external declaration include a "macro"/"dll16"/"dll32" ?
		do
			Result := special_file_name /= Void;
		end;

	has_signature: BOOLEAN is
			-- Does the external declaration include a signature ?
		do
			Result := has_arg_list or else has_return_type;
		end;

	has_arg_list: BOOLEAN is
			-- Does the signature include arguments ?
		do
			Result := (arg_list /= Void) and then (arg_list.count > 0);
		end;

	has_return_type: BOOLEAN is
			-- Does the signature include a result type ?
		do
			Result := return_type /= Void;
		end;

	has_include_list: BOOLEAN is
			-- Does the external declaration include a list of include files ?
		do
			Result := (include_list /= Void) and then (include_list.count > 0);
		end;

	special_id: INTEGER is
			-- Id of special external
		local
			lower_copy: STRING;
		do
			if special_type /= Void then
				lower_copy := special_type;
				lower_copy.to_lower;
				if lower_copy.is_equal (macro_type) then
					Result := macro_id;
				elseif lower_copy.is_equal (dll16_type) then
					Result := dll16_id;
				elseif lower_copy.is_equal (dll32_type) then
					Result := dll32_id;
				end;
			end;
		end;

feature -- Initialization

	set is
			-- Yacc initialization
		do
			language_name ?= yacc_arg (0);
			parse;
		ensure then
			language_name /= Void;
		end;

feature -- Parsing

	parse is 
		local
			inc_file: STRING;
			valid_language_name: BOOLEAN;
			stop: BOOLEAN;
			pos: INTEGER;
			nb: INTEGER;
			image: STRING;
			segment: STRING;
			i: INTEGER;
			argument: STRING;
			place: INTEGER;
			lower_copy: STRING;
			rest: STRING;
				-- not to have to use language_name.value
			source: STRING;
				-- positionning errors
			offset: INTEGER;
			loc_begin: INTEGER;
			loc_end: INTEGER;
		do
			!!image.make (0);
			source := language_name.value;
			image.copy (source);
				-- get rid of extra blanks
			image.left_adjust;
			image.right_adjust;
				-- extracting language name
			from
				nb := image.count;
			until
				pos > nb or else stop
			loop
				pos := pos + 1;
				if pos <= nb then
					inspect
						image.item (pos)
					when ' ','[','(',':','|' then
						stop := True;
					else
					end
				end;
			end;
			if pos > 1 then
				if stop then
					ext_language_name := image.substring (1, pos);
				else
					ext_language_name := image.substring (1, pos - 1);
				end;
			end;
				-- if stop then remove the extra characters
			if stop and pos > 1 then
				ext_language_name.remove (ext_language_name.count);
				ext_language_name.right_adjust;
			end;
				-- check if valid language name
				-- for now, only C is supported
			if ext_language_name /= Void then
				ext_language_name.to_upper;
				if ext_language_name.is_equal ("C") then
					valid_language_name := True;
				end;
			end;
				-- no need to go on if invalid language name
			if valid_language_name then
				offset := source.count - 1;
					-- cleaning string for next operation
				image.tail (image.count - pos + 1);
				image.left_adjust;
					-- looking for a macro or a dll
					-- it's now or never
				if image.count /= 0 and then image.item (1) = '[' then
					pos := image.index_of (']',1);	-- look for ]
					if pos > 2 then	-- there's something between [ and ]
						segment := image.substring (2, pos - 1);
							-- get rid of extra blanks
						segment.left_adjust;
						segment.right_adjust;
						place := segment.index_of (' ',1);
						if place > 0 then	-- place = 0 or place >=2; can't be 1
							special_type := segment.substring (1,place - 1);
								-- add dll16 and dll32 later
							lower_copy := special_type;
							lower_copy.to_lower;
							if lower_copy.is_equal (macro_type) then
								special_file_name := segment.substring (place + 1, segment.count);
								special_file_name.left_adjust;
								inspect
									special_file_name.item (1)
								when '<' then
									i := special_file_name.index_of ('>',1);
								when '%"' then
									if special_file_name.count > 1 then
										i := special_file_name.index_of ('%"',2);
									else
										i := 0;
									end;
								else
										-- if no spaces then OK
									special_file_name.precede ('%"');
									special_file_name.append_character ('%"');
									i := special_file_name.count - special_file_name.index_of (' ',1);
								end;
								if not (i = special_file_name.count) then
									loc_begin := source.substring_index (special_file_name, 1);
									loc_end := loc_begin + special_file_name.count - 1;
										-- file name including macro is not valid (> or %" missing)
									raise_external_error ("Illegal file name for macro specification%N%
															%(a %" or > may be missing)%N",loc_begin,loc_end);
								end;
							elseif lower_copy.is_equal (dll16_type) or lower_copy.is_equal (dll32_type) then
									-- get the file name and the extra arg for dll
								rest := segment.substring (place + 1, segment.count);
								rest.left_adjust;
									-- if it starts with a '%"' then look for the next one
									-- else look for the next ' '
								if rest.item (1) = '%"' then
									i := rest.index_of ('%"',2);
									if i >= 2 then 
										special_file_name := rest.substring (1,i);
										rest.tail (rest.count - i);
									else
											-- '%"' not found, raise an error
										loc_begin := source.substring_index (rest,1);
										loc_end := loc_begin + rest.count - 1;
										raise_external_error ("Illegal file name for dll specification%N%
																%(a %" may be missing)%N",loc_begin,loc_end);
									end;
								else
									i := rest.index_of (' ',1);
									if i >= 2 then 
										special_file_name := rest.substring (1, i - 1);
										rest.tail (rest.count - i);
										special_file_name.precede ('%"');
										special_file_name.append_character ('%"');
									else
											-- ' ' not found, which means there's no arg after file name
											-- and one is required for dll after file name
										loc_begin := source.substring_index (rest,1);
										loc_end := loc_begin + rest.count - 1;
										raise_external_error ("Illegal file name for dll specification%N",loc_begin,loc_end);
									end;
								end;
								rest.left_adjust;
								if rest.count /= 0 then
										-- there's an extra argument, raise an error
									loc_begin := source.substring_index (segment, 1);
									loc_end := loc_begin + segment.count - 1;
									raise_external_error ("Illegal dll declaration for external%N%
															%(It must be of the form [dll16/dll32 filename])%N",
															loc_begin,loc_end);
								end;
									-- if we reached this point, everything seems to be OK
									-- Now we can add <windows.h> to the list of include files
								!!include_list.make (1,0);
								include_list.force ("<windows.h>",1);
							else
								loc_begin := source.substring_index (special_type, 1);
								loc_end := loc_begin + special_type.count - 1;
									-- special_type is not "macro"
								raise_external_error ("Illegal type declaration for external file%N%
														%(type must be one of: macro, dll16, dll32%N",loc_begin,loc_end);
							end;
								-- updating image for next operation
							image.tail (image.count - pos);
							image.left_adjust;
						else	-- no blank found
							loc_begin := source.substring_index (segment, 1);
							loc_end := loc_begin + segment.count - 1;
								--  no space found between [ and ]; something's missing
							raise_external_error ("Missing file name: only one word between brackets%N%
													%(file declaration must be of the form [type file],%N%
													%where type is one of: macro, dll16, dll32)%N", loc_begin,
loc_end);
						end;
					else
						if pos = 0 then
							loc_begin := source.index_of ('[', 1);
							loc_end := offset;
							raise_external_error ("Missing closing bracket ']'%N", loc_begin, loc_end);
						else	-- pos =1 and it must be []
							loc_begin := source.index_of ('[', 1);
							loc_end := loc_begin + 1;
								-- situation where []
							raise_external_error ("Empty file declaration: nothing between the brackets%N%
													%(file declaration must be of the form [type file],%N%
													%where type is one of: macro dll16, dll32)%N", loc_begin,
loc_end);
						end;
					end;
				end;
					-- looking for signature
					-- if there are arguments then the string should start wiht '('
				if image.count /= 0 and then image.item (1) = '(' then
						-- look for )
					pos := image.index_of (')',1);
						-- if there's something between ( and )
					if pos > 2 then
						segment := image.substring (2, pos - 1);
							-- get rid of extra blanks
						segment.left_adjust;
						segment.right_adjust;
						from
							!!arg_list.make (1,0);
							i := 1;
							stop := False;
						until
							stop or else segment.count = 0
						loop
							place := segment.index_of (',',1);
							if place = segment.count then
								loc_begin := source.index_of (')', 1) - 1;
								loc_end := loc_begin;
									-- extra ',' at the end of signature
								raise_external_error ("Extra comma at end of signature declaration%N", loc_begin, loc_end);
								stop := True;
							elseif place > 1 then
								argument := segment.substring (1, place - 1);
								argument.right_adjust;
								segment.tail (segment.count - place);
								segment.left_adjust;  
								if argument.count /= 0 then
									arg_list.force (argument,i);
									i := i + 1;
								else
									loc_begin := source.substring_index (segment, 1);
									loc_end := loc_begin + segment.count - 1;
										-- nothing between two ','
									raise_external_error ("Extra comma in signature declaration%N", loc_begin, loc_end);
									stop := True;
								end;
							else
									-- if no more ',', last argument reached
								if place = 0 then
									argument := clone (segment);
									arg_list.force (argument,i);
                                   	segment.wipe_out;
								else	-- place = 1 i.e. "(,"
									loc_begin := source.substring_index (segment, 1);
									loc_end := loc_begin;
										-- case "(,"
									raise_external_error ("Extra comma in signature declaration%N", loc_begin, loc_end);
									stop := True;
								end;
							end;
						end;
					else
							-- ) not found
						if pos = 0 then
							loc_begin := source.index_of ('(', 1);
							loc_end := offset;
							raise_external_error ("Missing closing parenthesis ) at end of signature declaration%N", loc_begin, loc_end);
						end;	-- pos = 1 not handled since () accepted; do nothing
					end;
						-- cleaning image for next operation
					image.tail (image.count - pos);
					image.left_adjust;
				end;
					-- if there's a returned type, the string  should start with ':'
				if image.count /= 0 and then image.item (1) = ':' then
					pos := image.index_of ('|',1);
						-- take the whole string if '|' not found
					if pos = 0 then
						segment := image.substring (1, image.count);
							-- everyting was taken; nothing should remain
						image.wipe_out;
					else
						segment := image.substring (1, pos - 1);
							-- keep '|'
						image.tail (image.count - pos + 1);
					end;
					loc_begin := source.substring_index (segment, 1);
					loc_end := loc_begin + segment.count - 1;
						-- drop ':' at the beginning
					segment.remove (1);
					segment.left_adjust;
					segment.right_adjust;
					if segment.count /= 0 then
						return_type := segment;
					else
							-- nothing after ':'
						raise_external_error ("Missing return type afer colon in signature declaration%N%
												%(If present, the colon : must be followed by the return type)%N",
loc_begin, loc_end);
					end;
				end;
					-- look for include files
				if image.count /= 0 and then image.item (1) = '|' then
					if image.count > 1 then	-- if there's something after |
						segment := image.substring (2, image.count);
						segment.left_adjust;
						from
							if include_list = Void then
								!!include_list.make (1, 0)
								i := 1
							else
								i := include_list.count + 1;
							end
							stop := False;
						until
							stop or else segment.count = 0
						loop
							inspect
									-- item (1) exists since segment.count /= 0
								segment.item (1)
							when '<' then
								place := segment.index_of ('>',1);
									-- if there's something between < and >
								if place > 2 then
									inc_file := segment.substring (1, place);
									segment.tail (segment.count - place);
									segment.left_adjust;
									include_list.force (inc_file,i);
									i := i + 1;
								else
									loc_begin := source.substring_index (segment,1);
									loc_end := loc_begin + segment.count - 1;
									raise_external_error ("Missing > in include file name%N", loc_begin, loc_end);
									stop := True;
								end;
							when '%"' then
								place := segment.index_of ('%"',2);
									-- if there's something between %" and %"
								if place > 2 then
									inc_file := segment.substring (1, place);
									segment.tail (segment.count - place);
									segment.left_adjust;
									include_list.force (inc_file,i);
									i := i + 1;
								else
									loc_begin := source.substring_index (segment, 1);
									loc_end := loc_begin + segment.count - 1;
									raise_external_error ("Missing %" in include file name%N", loc_begin, loc_end);
									stop := True;
								end;
							else
									-- blank can't be at the beginning
								place := segment.index_of (' ',1);
								if place > 1 then
									inc_file := segment.substring (1, place - 1);
									segment.tail (segment.count - place);
									segment.left_adjust;
									inc_file.precede ('%"');
									inc_file.append_character ('%"');
									include_list.force (inc_file,i);
									i := i + 1;
								else
										-- obviously, place = 0
									inc_file := clone (segment);
									inc_file.precede ('%"');
									inc_file.append_character ('%"');
									include_list.force (inc_file,i);
									i := i + 1;
									segment.wipe_out;
								end;
							end;
						end;
					else
						loc_begin := source.index_of ('|',1);
						loc_end := loc_begin;
							-- nothing after '|'
						raise_external_error ("Missing include file declaration%N%
												%(If present, the bar | must be followed by the names%N%
												%of one or more include files)%N", loc_begin, loc_end);
					end;
						-- cleaning image for next operation
					image.wipe_out;	-- nothing must be after include file declaration
				end;

				if image.count > 0 then
					loc_begin := source.substring_index (image,1);
					loc_end := offset;
						-- at this point nothing should remain in the parsed string
						-- if it's not the case, there must be an error
					raise_external_error ("Extra text at end of external language specification%N", loc_begin, loc_end);
				end;
debug ("EXTERNAL_PARSING")
	display_results;
end;
			else
				if ext_language_name = Void then
					loc_begin := 1;
					loc_end := 1;
				else
					loc_begin := source.substring_index (ext_language_name,1);
					loc_end := loc_begin + ext_language_name.count - 1;
				end;
					-- if the language name has not the required form
				raise_external_error ("Unrecognized external language%N%
										%(external language must be C)%N", loc_begin, loc_end);
			end;
		end;

feature -- Debug

	display_results is
		local
			k: INTEGER;
		do
			if ext_language_name /= Void then
				io.putstring ("Language: ");
				io.putstring ("|");
				io.putstring (ext_language_name);
				io.putstring ("|");
				io.new_line;
				if is_special then
					io.putstring ("Special type: ");
					io.putstring (special_type);
					io.new_line;
					io.putstring ("Special id: ");
					io.putint (special_id);
					io.new_line;
					io.putstring ("Special file: ");
					io.putstring (special_file_name);
					io.new_line;
				else
					io.putstring ("No special declaration%N");
				end;
				if has_signature then
					io.putstring ("Signature:%N");
					if has_arg_list then
						io.putstring("    Arguments:%N");
						from
							k := arg_list.lower
						until
							k > arg_list.upper
						loop
							io.putstring ("        ");
							io.putstring ("|");
							io.putstring (arg_list.item (k));
							io.putstring ("|");
							io.new_line;
							k := k + 1;
						end;
					else
						io.putstring ("    No arguments%N");
					end;
					if has_return_type then
						io.putstring ("    Result type: ");
						io.putstring ("|");
						io.putstring (return_type);
						io.putstring ("|");
						io.new_line;
					else
						io.putstring ("    No result type%N");
					end;
				else
					io.putstring ("No signature%N");
				end;
				if has_include_list then
					io.putstring ("Includes:%N");
					from
						k := include_list.lower;
					until
						k > include_list.upper
					loop
						io.putstring ("        ");
						io.putstring ("|");
						io.putstring (include_list.item (k));
						io.putstring ("|");
						io.new_line;
						k := k + 1;
					end;
				else
					io.putstring ("No include list%N");
				end;
			else
				io.putstring ("Can't display results%N");
			end;
		end;

feature -- Error handling

	raise_external_error (msg: STRING; start_p: INTEGER; end_p: INTEGER) is
			-- Raises error occured while parsing
		local
			ext_error: EXTERNAL_SYNTAX_ERROR;
			line_start: INTEGER;
		do
			!!ext_error.init;
			line_start := ext_error.start_position;
			ext_error.set_start_position (line_start + start_p);
			ext_error.set_end_position (line_start + end_p);
			ext_error.set_external_error_message (msg);
			Error_handler.insert_error (ext_error);
			Error_handler.raise_error;
		end;

end
