class EXTERNAL_LANG_AS

inherit

	AST_EIFFEL

feature -- Attributes

	language_name: STRING_AS;
			-- Language name
			-- might be replaced by external_declaration or external_definition

	ext_language_name: STRING;
			-- Name of external language

	has_macro: BOOLEAN;
			-- Does the external declaration include a macro ("macro", "dll16", "dll32") ?

	has_signature: BOOLEAN;
			-- Does the external declaration include a signature ?

	has_argument_list: BOOLEAN;
			-- Does the signature include arguments ?

	has_result_type: BOOLEAN;
			-- Does the signature include a result type ?

	has_include_list: BOOLEAN;
			-- Does the external declaration include a list of include files ?

	macro_type: STRING;
			-- Type of macro 

	macro_file_name: STRING;
			-- File name including the macro definition

	arg_list: ARRAY[STRING];
			-- List of arguments for the signature

	result_type: STRING;
			-- Result type of signature

	include_list: ARRAY[STRING];
			-- List of include files

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
			has_valid_macro: BOOLEAN;
			stop: BOOLEAN;
			pos: INTEGER;
			nb: INTEGER;
			image: STRING;
			segment: STRING;
			i: INTEGER;
			argument: STRING;
			place: INTEGER;
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
			if ext_language_name /= Void and then ext_language_name.is_equal ("C") then
				valid_language_name := True;
			end;
			-- no need to go on if invalid language name
			if valid_language_name then
				offset := source.count - 1;
				-- cleaning string for next operation
				image.tail (image.count - pos + 1);
				image.left_adjust;
				-- looking for a macro
				-- if there's a macro, it's now or never
				if image.count /= 0 and then image.item (1) = '[' then
					pos := image.index_of (']',1);	-- look for ]
					if pos > 2 then	-- there's something between [ and ]
						segment := image.substring (2, pos - 1);
						-- get rid of extra blanks
						segment.left_adjust;
						segment.right_adjust;
						place := segment.index_of (' ',1);
						if place > 0 then	-- place = 0 or place >=2; can't be 1
							macro_type := segment.substring (1,place - 1);
							-- add dll16 and dll32 later
							if macro_type.is_equal ("macro") then
								macro_file_name := segment.substring (place + 1, segment.count);
								macro_file_name.left_adjust;
								inspect
									macro_file_name.item (1)
								when '<' then
									i := macro_file_name.index_of ('>',1);
								when '%"' then
									i := macro_file_name.index_of ('%"',2);
								else
									-- if no spaces then OK
									i := macro_file_name.count - macro_file_name.index_of (' ',1);
									macro_file_name.precede ('%"');
									macro_file_name.append_character ('%"');
								end;
								if i = macro_file_name.count then
									has_macro := True
								else
									loc_begin := source.substring_index (macro_file_name, 1);
									loc_end := loc_begin + macro_file_name.count - 1;
									-- file name including macro is not valid (> or %" missing)
									raise_external_error ("Illegal file name for macro specification%N%
															%(a %" or > may be missing)%N",loc_begin,loc_end);
								end;
							else
								loc_begin := source.substring_index (macro_type, 1);
								loc_end := loc_begin + macro_type.count - 1;
								-- macro_type is not "macro"
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
							-- obvious
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
							!!arg_list.make (1,1);
							i := 1;
							stop := False;
						until
							stop or else segment.count = 0
						loop
							place := segment.index_of (',',1);
							if place = segment.count then
								loc_begin := source.substring_index (segment, 1) + place - 1;
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
	                                   has_signature := True;
	                                   has_argument_list := True;
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
							-- obvious
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
						result_type := segment;
						has_signature := True;
						has_result_type := True;
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
							!!include_list.make (1,1);
							i := 1;
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
									has_include_list := True;
									i := i + 1;
								else
									loc_begin := source.substring_index (segment,1);
									loc_end := loc_begin + segment.count - 1;
									-- obvious
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
									has_include_list := True;
									i := i + 1;
								else
									loc_begin := source.substring_index (segment, 1);
									loc_end := loc_begin + segment.count - 1;
									-- obvious
									raise_external_error ("Missing %" in include file name%N", loc_begin, loc_end);
									stop := True;
								end;
							else
								-- blank can't be at the beginning
								place := segment.index_of (' ',1);
								has_include_list := True;
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
debug
			display_results;
end; -- debug
		end;

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
				if has_macro then
					io.putstring ("Macro: ");
					io.putstring (macro_type);
					io.new_line;
					io.putstring ("Macro file: ");
					io.putstring (macro_file_name);
					io.new_line;
				else
					io.putstring ("No macro%N");
				end;
				if has_signature then
					io.putstring ("Signature:%N");
					if has_argument_list then
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
					if has_result_type then
						io.putstring ("    Result type: ");
						io.putstring ("|");
						io.putstring (result_type);
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
