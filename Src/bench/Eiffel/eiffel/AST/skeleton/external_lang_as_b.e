class EXTERNAL_LANG_AS_B

inherit

	EXTERNAL_LANG_AS
		redefine
			language_name, display_results
		end;

	AST_EIFFEL_B;

	EXTERNAL_CONSTANTS

feature -- Attributes

	language_name: STRING_AS_B;
			-- Language name
			-- might be replaced by external_declaration or external_definition

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
						io.putstring("	Arguments:%N");
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
						io.putstring ("	No arguments%N");
					end;
					if has_return_type then
						io.putstring ("	Result type: ");
						io.putstring ("|");
						io.putstring (return_type);
						io.putstring ("|");
						io.new_line;
					else
						io.putstring ("	No result type%N");
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

end -- class EXTERNAL_LANG_AS_B
