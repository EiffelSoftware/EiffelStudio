
class WINDOW_PAGE 

inherit

	CONTEXT_CAT_PAGE

creation
	make
	
feature 

	perm_wind_type: CONTEXT_TYPE;

	temp_wind_type: CONTEXT_TYPE;

	
feature {NONE}

	build is
		local
			perm_wind_c: PERM_WIND_C;
			temp_wind_c: TEMP_WIND_C;
		do
			!!perm_wind_c;
			perm_wind_type := create_type (Context_const.perm_wind_name, 
					perm_wind_c, Cat_perm_wind_pixmap);

			!!temp_wind_c;
			temp_wind_type := create_type (Context_const.temp_wind_name, 
					temp_wind_c, Cat_temp_wind_pixmap);

			attach_left (perm_wind_type.source, 1);
			attach_left_widget (perm_wind_type.source, 
					temp_wind_type.source, 10);

			attach_top (perm_wind_type.source, 1);
			attach_top (temp_wind_type.source, 1);
		end;

end
