
class CONTROL_STR

inherit 
	ASCII
		export
			{NONE} all
		end;

creation

	make

feature

	make (code: INTEGER) is
		do
			control_code := code;
		end;

	control_code: INTEGER;

	lock_on: BOOLEAN;

	set_lock (f: BOOLEAN) is
		do
			lock_on := f;
		end;

	cntrl_str: STRING is
		do
			if lock_on then
				inspect control_code
					when Ctrl_a then
						Result := "Ctrl<Key>A";
					when Ctrl_b then
						Result := "Ctrl<Key>B";
					when Ctrl_c then
						Result := "Ctrl<Key>C";
					when Ctrl_d then
						Result := "Ctrl<Key>D";
					when Ctrl_e then
						Result := "Ctrl<Key>E";
					when Ctrl_f then
						Result := "Ctrl<Key>F";
					when Ctrl_g then
						Result := "Ctrl<Key>G";
					when Ctrl_h then
						Result := "Ctrl<Key>H";
					when Ctrl_i then
						Result := "Ctrl<Key>I";
					when Ctrl_j then
						Result := "Ctrl<Key>J";
					when Ctrl_k then
						Result := "Ctrl<Key>K";
					when Ctrl_l then
						Result := "Ctrl<Key>L";
					when Ctrl_m then
						Result := "Ctrl<Key>M";
					when Ctrl_n then
						Result := "Ctrl<Key>N";
					when Ctrl_o then
						Result := "Ctrl<Key>O";
					when Ctrl_p then
						Result := "Ctrl<Key>P";
					when Ctrl_q then
						Result := "Ctrl<Key>Q";
					when Ctrl_r then
						Result := "Ctrl<Key>R";
					when Ctrl_s then
						Result := "Ctrl<Key>S";
					when Ctrl_t then
						Result := "Ctrl<Key>T";
					when Ctrl_u then
						Result := "Ctrl<Key>U";
					when Ctrl_v then
						Result := "Ctrl<Key>V";
					when Ctrl_w then
						Result := "Ctrl<Key>W";
					when Ctrl_x then
						Result := "Ctrl<Key>X";
					when Ctrl_y then
						Result := "Ctrl<Key>Y";
					when Ctrl_z then
						Result := "Ctrl<Key>Z";
					else
						Result := "Ctrl";
				end;
			else
				inspect control_code
					when Ctrl_a then
						Result := "Ctrl<Key>a";
					when Ctrl_b then
						Result := "Ctrl<Key>b";
					when Ctrl_c then
						Result := "Ctrl<Key>c";
					when Ctrl_d then
						Result := "Ctrl<Key>d";
					when Ctrl_e then
						Result := "Ctrl<Key>e";
					when Ctrl_f then
						Result := "Ctrl<Key>f";
					when Ctrl_g then
						Result := "Ctrl<Key>g";
					when Ctrl_h then
						Result := "Ctrl<Key>h";
					when Ctrl_i then
						Result := "Ctrl<Key>i";
					when Ctrl_j then
						Result := "Ctrl<Key>j";
					when Ctrl_k then
						Result := "Ctrl<Key>k";
					when Ctrl_l then
						Result := "Ctrl<Key>l";
					when Ctrl_m then
						Result := "Ctrl<Key>m";
					when Ctrl_n then
						Result := "Ctrl<Key>n";
					when Ctrl_o then
						Result := "Ctrl<Key>o";
					when Ctrl_p then
						Result := "Ctrl<Key>p";
					when Ctrl_q then
						Result := "Ctrl<Key>q";
					when Ctrl_r then
						Result := "Ctrl<Key>r";
					when Ctrl_s then
						Result := "Ctrl<Key>s";
					when Ctrl_t then
						Result := "Ctrl<Key>t";
					when Ctrl_u then
						Result := "Ctrl<Key>u";
					when Ctrl_v then
						Result := "Ctrl<Key>v";
					when Ctrl_w then
						Result := "Ctrl<Key>w";
					when Ctrl_x then
						Result := "Ctrl<Key>x";
					when Ctrl_y then
						Result := "Ctrl<Key>y";
					when Ctrl_z then
						Result := "Ctrl<Key>z";
					else
						Result := "Ctrl";
				end;
			end;
		end;

end
				
