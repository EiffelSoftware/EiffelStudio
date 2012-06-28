indexing

	description:

		"Database for simple mapping to title case"

	generator: "geuc"

	library: "Gobo Eiffel Kernel Library"
	copyright: "Copyright (c) 2005, Colin Adams and others"
	license: "MIT License"
	date: "$Date$"
	revision: "$Revision$"

class UC_V500_CTYPE_TITLECASE

inherit

	ANY

	KL_IMPORTED_INTEGER_ROUTINES
		export {NONE} all end


feature -- Access

	major_version: INTEGER is
			-- Major version number of Unicode
		once
			Result := 5
		end

	minor_version: INTEGER is
			-- Minor version number of Unicode
		once
			Result := 0
		end

	update_version: INTEGER is
			-- Update version number of Unicode
		once
			Result := 0
		end

feature {NONE} -- Implementation

	title_code_plane_0_segment_0: ARRAY [INTEGER] is
			-- Generated array segment
		once
			Result := <<
			INTEGER_.to_integer (-1),
			-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,
			-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,
			-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,
			-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,
			-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,
			-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,
			-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,
			-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,
			-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,
			-1,-1,-1,-1,-1,-1,65,66,67,68,
			69,70,71,72,73,74,75,76,77,78,
			79,80,81,82,83,84,85,86,87,88,
			89,90,-1,-1,-1,-1,-1,-1,-1,-1,
			-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,
			-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,
			-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,
			-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,
			-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,
			924,-1,-1,-1,-1,-1,-1,-1,-1,-1,
			-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,
			-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,
			-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,
			-1,-1,-1,192,193,194,195,196,197,198,
			199,200,201,202,203,204,205,206,207,208,
			209,210,211,212,213,214,-1,216,217,218,
			219,220,221,222,376>>
		ensure
			result_not_void: Result /= Void
		end

	title_code_plane_0_segment_1: ARRAY [INTEGER] is
			-- Generated array segment
		once
			Result := <<
			INTEGER_.to_integer (-1),
			256,-1,258,-1,260,-1,262,-1,264,-1,
			266,-1,268,-1,270,-1,272,-1,274,-1,
			276,-1,278,-1,280,-1,282,-1,284,-1,
			286,-1,288,-1,290,-1,292,-1,294,-1,
			296,-1,298,-1,300,-1,302,-1,73,-1,
			306,-1,308,-1,310,-1,-1,313,-1,315,
			-1,317,-1,319,-1,321,-1,323,-1,325,
			-1,327,-1,-1,330,-1,332,-1,334,-1,
			336,-1,338,-1,340,-1,342,-1,344,-1,
			346,-1,348,-1,350,-1,352,-1,354,-1,
			356,-1,358,-1,360,-1,362,-1,364,-1,
			366,-1,368,-1,370,-1,372,-1,374,-1,
			-1,377,-1,379,-1,381,83,579,-1,-1,
			386,-1,388,-1,-1,391,-1,-1,-1,395,
			-1,-1,-1,-1,-1,401,-1,-1,502,-1,
			-1,-1,408,573,-1,-1,-1,544,-1,-1,
			416,-1,418,-1,420,-1,-1,423,-1,-1,
			-1,-1,428,-1,-1,431,-1,-1,-1,435,
			-1,437,-1,-1,440,-1,-1,-1,444,-1,
			503,-1,-1,-1,-1,453,453,453,456,456,
			456,459,459,459,-1,461,-1,463,-1,465,
			-1,467,-1,469,-1,471,-1,473,-1,475,
			398,-1,478,-1,480,-1,482,-1,484,-1,
			486,-1,488,-1,490,-1,492,-1,494,-1,
			498,498,498,-1,500,-1,-1,-1,504,-1,
			506,-1,508,-1,510>>
		ensure
			result_not_void: Result /= Void
		end

	title_code_plane_0_segment_2: ARRAY [INTEGER] is
			-- Generated array segment
		once
			Result := <<
			INTEGER_.to_integer (-1),
			512,-1,514,-1,516,-1,518,-1,520,-1,
			522,-1,524,-1,526,-1,528,-1,530,-1,
			532,-1,534,-1,536,-1,538,-1,540,-1,
			542,-1,-1,-1,546,-1,548,-1,550,-1,
			552,-1,554,-1,556,-1,558,-1,560,-1,
			562,-1,-1,-1,-1,-1,-1,-1,-1,571,
			-1,-1,-1,-1,-1,577,-1,-1,-1,-1,
			582,-1,584,-1,586,-1,588,-1,590,-1,
			-1,-1,385,390,-1,393,394,-1,399,-1,
			400,-1,-1,-1,-1,403,-1,-1,404,-1,
			-1,-1,-1,407,406,-1,11362,-1,-1,-1,
			412,-1,-1,413,-1,-1,415,-1,-1,-1,
			-1,-1,-1,-1,11364,-1,-1,422,-1,-1,
			425,-1,-1,-1,-1,430,580,433,434,581,
			-1,-1,-1,-1,-1,439,-1,-1,-1,-1,
			-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,
			-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,
			-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,
			-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,
			-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,
			-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,
			-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,
			-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,
			-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,
			-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,
			-1,-1,-1,-1,-1>>
		ensure
			result_not_void: Result /= Void
		end

	title_code_plane_0_segment_3: ARRAY [INTEGER] is
			-- Generated array segment
		once
			Result := <<
			INTEGER_.to_integer (-1),
			-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,
			-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,
			-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,
			-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,
			-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,
			-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,
			-1,-1,-1,-1,-1,-1,-1,-1,921,-1,
			-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,
			-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,
			-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,
			-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,
			-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,
			-1,-1,1021,1022,1023,-1,-1,-1,-1,-1,
			-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,
			-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,
			-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,
			-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,
			-1,902,904,905,906,-1,913,914,915,916,
			917,918,919,920,921,922,923,924,925,926,
			927,928,929,931,931,932,933,934,935,936,
			937,938,939,908,910,911,-1,914,920,-1,
			-1,-1,934,928,-1,-1,984,-1,986,-1,
			988,-1,990,-1,992,-1,994,-1,996,-1,
			998,-1,1000,-1,1002,-1,1004,-1,1006,922,
			929,1017,-1,-1,917,-1,-1,1015,-1,-1,
			1018,-1,-1,-1,-1>>
		ensure
			result_not_void: Result /= Void
		end

	title_code_plane_0_segment_4: ARRAY [INTEGER] is
			-- Generated array segment
		once
			Result := <<
			INTEGER_.to_integer (-1),
			-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,
			-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,
			-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,
			-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,
			-1,-1,-1,-1,-1,-1,-1,1040,1041,1042,
			1043,1044,1045,1046,1047,1048,1049,1050,1051,1052,
			1053,1054,1055,1056,1057,1058,1059,1060,1061,1062,
			1063,1064,1065,1066,1067,1068,1069,1070,1071,1024,
			1025,1026,1027,1028,1029,1030,1031,1032,1033,1034,
			1035,1036,1037,1038,1039,-1,1120,-1,1122,-1,
			1124,-1,1126,-1,1128,-1,1130,-1,1132,-1,
			1134,-1,1136,-1,1138,-1,1140,-1,1142,-1,
			1144,-1,1146,-1,1148,-1,1150,-1,1152,-1,
			-1,-1,-1,-1,-1,-1,-1,-1,1162,-1,
			1164,-1,1166,-1,1168,-1,1170,-1,1172,-1,
			1174,-1,1176,-1,1178,-1,1180,-1,1182,-1,
			1184,-1,1186,-1,1188,-1,1190,-1,1192,-1,
			1194,-1,1196,-1,1198,-1,1200,-1,1202,-1,
			1204,-1,1206,-1,1208,-1,1210,-1,1212,-1,
			1214,-1,-1,1217,-1,1219,-1,1221,-1,1223,
			-1,1225,-1,1227,-1,1229,1216,-1,1232,-1,
			1234,-1,1236,-1,1238,-1,1240,-1,1242,-1,
			1244,-1,1246,-1,1248,-1,1250,-1,1252,-1,
			1254,-1,1256,-1,1258,-1,1260,-1,1262,-1,
			1264,-1,1266,-1,1268,-1,1270,-1,1272,-1,
			1274,-1,1276,-1,1278>>
		ensure
			result_not_void: Result /= Void
		end

	title_code_plane_0_segment_5: ARRAY [INTEGER] is
			-- Generated array segment
		once
			Result := <<
			INTEGER_.to_integer (-1),
			1280,-1,1282,-1,1284,-1,1286,-1,1288,-1,
			1290,-1,1292,-1,1294,-1,1296,-1,1298,-1,
			-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,
			-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,
			-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,
			-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,
			-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,
			-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,
			-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,
			-1,-1,-1,-1,-1,-1,1329,1330,1331,1332,
			1333,1334,1335,1336,1337,1338,1339,1340,1341,1342,
			1343,1344,1345,1346,1347,1348,1349,1350,1351,1352,
			1353,1354,1355,1356,1357,1358,1359,1360,1361,1362,
			1363,1364,1365,1366,-1,-1,-1,-1,-1,-1,
			-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,
			-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,
			-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,
			-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,
			-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,
			-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,
			-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,
			-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,
			-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,
			-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,
			-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,
			-1,-1,-1,-1,-1>>
		ensure
			result_not_void: Result /= Void
		end

	empty_title_code_segment: ARRAY [INTEGER] is
			-- Generated array segment
		once
			Result := <<
			INTEGER_.to_integer (-1),
			-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,
			-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,
			-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,
			-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,
			-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,
			-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,
			-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,
			-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,
			-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,
			-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,
			-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,
			-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,
			-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,
			-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,
			-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,
			-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,
			-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,
			-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,
			-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,
			-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,
			-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,
			-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,
			-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,
			-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,
			-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,
			-1,-1,-1,-1,-1>>
		ensure
			result_not_void: Result /= Void
		end

	title_code_plane_0_segment_29: ARRAY [INTEGER] is
			-- Generated array segment
		once
			Result := <<
			INTEGER_.to_integer (-1),
			-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,
			-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,
			-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,
			-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,
			-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,
			-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,
			-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,
			-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,
			-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,
			-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,
			-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,
			-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,
			-1,-1,-1,-1,11363,-1,-1,-1,-1,-1,
			-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,
			-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,
			-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,
			-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,
			-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,
			-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,
			-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,
			-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,
			-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,
			-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,
			-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,
			-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,
			-1,-1,-1,-1,-1>>
		ensure
			result_not_void: Result /= Void
		end

	title_code_plane_0_segment_30: ARRAY [INTEGER] is
			-- Generated array segment
		once
			Result := <<
			INTEGER_.to_integer (-1),
			7680,-1,7682,-1,7684,-1,7686,-1,7688,-1,
			7690,-1,7692,-1,7694,-1,7696,-1,7698,-1,
			7700,-1,7702,-1,7704,-1,7706,-1,7708,-1,
			7710,-1,7712,-1,7714,-1,7716,-1,7718,-1,
			7720,-1,7722,-1,7724,-1,7726,-1,7728,-1,
			7730,-1,7732,-1,7734,-1,7736,-1,7738,-1,
			7740,-1,7742,-1,7744,-1,7746,-1,7748,-1,
			7750,-1,7752,-1,7754,-1,7756,-1,7758,-1,
			7760,-1,7762,-1,7764,-1,7766,-1,7768,-1,
			7770,-1,7772,-1,7774,-1,7776,-1,7778,-1,
			7780,-1,7782,-1,7784,-1,7786,-1,7788,-1,
			7790,-1,7792,-1,7794,-1,7796,-1,7798,-1,
			7800,-1,7802,-1,7804,-1,7806,-1,7808,-1,
			7810,-1,7812,-1,7814,-1,7816,-1,7818,-1,
			7820,-1,7822,-1,7824,-1,7826,-1,7828,-1,
			-1,-1,-1,-1,7776,-1,-1,-1,-1,-1,
			7840,-1,7842,-1,7844,-1,7846,-1,7848,-1,
			7850,-1,7852,-1,7854,-1,7856,-1,7858,-1,
			7860,-1,7862,-1,7864,-1,7866,-1,7868,-1,
			7870,-1,7872,-1,7874,-1,7876,-1,7878,-1,
			7880,-1,7882,-1,7884,-1,7886,-1,7888,-1,
			7890,-1,7892,-1,7894,-1,7896,-1,7898,-1,
			7900,-1,7902,-1,7904,-1,7906,-1,7908,-1,
			7910,-1,7912,-1,7914,-1,7916,-1,7918,-1,
			7920,-1,7922,-1,7924,-1,7926,-1,7928,-1,
			-1,-1,-1,-1,-1>>
		ensure
			result_not_void: Result /= Void
		end

	title_code_plane_0_segment_31: ARRAY [INTEGER] is
			-- Generated array segment
		once
			Result := <<
			INTEGER_.to_integer (7944),
			7945,7946,7947,7948,7949,7950,7951,-1,-1,-1,
			-1,-1,-1,-1,-1,7960,7961,7962,7963,7964,
			7965,-1,-1,-1,-1,-1,-1,-1,-1,-1,
			-1,7976,7977,7978,7979,7980,7981,7982,7983,-1,
			-1,-1,-1,-1,-1,-1,-1,7992,7993,7994,
			7995,7996,7997,7998,7999,-1,-1,-1,-1,-1,
			-1,-1,-1,8008,8009,8010,8011,8012,8013,-1,
			-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,
			8025,-1,8027,-1,8029,-1,8031,-1,-1,-1,
			-1,-1,-1,-1,-1,8040,8041,8042,8043,8044,
			8045,8046,8047,-1,-1,-1,-1,-1,-1,-1,
			-1,8122,8123,8136,8137,8138,8139,8154,8155,8184,
			8185,8170,8171,8186,8187,-1,-1,8072,8073,8074,
			8075,8076,8077,8078,8079,-1,-1,-1,-1,-1,
			-1,-1,-1,8088,8089,8090,8091,8092,8093,8094,
			8095,-1,-1,-1,-1,-1,-1,-1,-1,8104,
			8105,8106,8107,8108,8109,8110,8111,-1,-1,-1,
			-1,-1,-1,-1,-1,8120,8121,-1,8124,-1,
			-1,-1,-1,-1,-1,-1,-1,-1,-1,921,
			-1,-1,-1,-1,8140,-1,-1,-1,-1,-1,
			-1,-1,-1,-1,-1,-1,-1,8152,8153,-1,
			-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,
			-1,-1,-1,8168,8169,-1,-1,-1,8172,-1,
			-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,
			-1,-1,8188,-1,-1,-1,-1,-1,-1,-1,
			-1,-1,-1,-1,-1>>
		ensure
			result_not_void: Result /= Void
		end

	title_code_plane_0_segment_33: ARRAY [INTEGER] is
			-- Generated array segment
		once
			Result := <<
			INTEGER_.to_integer (-1),
			-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,
			-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,
			-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,
			-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,
			-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,
			-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,
			-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,
			-1,-1,-1,-1,-1,-1,-1,8498,-1,-1,
			-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,
			-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,
			-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,
			-1,8544,8545,8546,8547,8548,8549,8550,8551,8552,
			8553,8554,8555,8556,8557,8558,8559,-1,-1,-1,
			-1,8579,-1,-1,-1,-1,-1,-1,-1,-1,
			-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,
			-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,
			-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,
			-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,
			-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,
			-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,
			-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,
			-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,
			-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,
			-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,
			-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,
			-1,-1,-1,-1,-1>>
		ensure
			result_not_void: Result /= Void
		end

	title_code_plane_0_segment_36: ARRAY [INTEGER] is
			-- Generated array segment
		once
			Result := <<
			INTEGER_.to_integer (-1),
			-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,
			-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,
			-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,
			-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,
			-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,
			-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,
			-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,
			-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,
			-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,
			-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,
			-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,
			-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,
			-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,
			-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,
			-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,
			-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,
			-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,
			-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,
			-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,
			-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,
			-1,-1,-1,-1,-1,-1,-1,9398,9399,9400,
			9401,9402,9403,9404,9405,9406,9407,9408,9409,9410,
			9411,9412,9413,9414,9415,9416,9417,9418,9419,9420,
			9421,9422,9423,-1,-1,-1,-1,-1,-1,-1,
			-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,
			-1,-1,-1,-1,-1>>
		ensure
			result_not_void: Result /= Void
		end

	title_code_plane_0_segment_44: ARRAY [INTEGER] is
			-- Generated array segment
		once
			Result := <<
			INTEGER_.to_integer (-1),
			-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,
			-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,
			-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,
			-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,
			-1,-1,-1,-1,-1,-1,-1,11264,11265,11266,
			11267,11268,11269,11270,11271,11272,11273,11274,11275,11276,
			11277,11278,11279,11280,11281,11282,11283,11284,11285,11286,
			11287,11288,11289,11290,11291,11292,11293,11294,11295,11296,
			11297,11298,11299,11300,11301,11302,11303,11304,11305,11306,
			11307,11308,11309,11310,-1,-1,11360,-1,-1,-1,
			570,574,-1,11367,-1,11369,-1,11371,-1,-1,
			-1,-1,-1,-1,-1,-1,-1,11381,-1,-1,
			-1,-1,-1,-1,-1,-1,-1,-1,11392,-1,
			11394,-1,11396,-1,11398,-1,11400,-1,11402,-1,
			11404,-1,11406,-1,11408,-1,11410,-1,11412,-1,
			11414,-1,11416,-1,11418,-1,11420,-1,11422,-1,
			11424,-1,11426,-1,11428,-1,11430,-1,11432,-1,
			11434,-1,11436,-1,11438,-1,11440,-1,11442,-1,
			11444,-1,11446,-1,11448,-1,11450,-1,11452,-1,
			11454,-1,11456,-1,11458,-1,11460,-1,11462,-1,
			11464,-1,11466,-1,11468,-1,11470,-1,11472,-1,
			11474,-1,11476,-1,11478,-1,11480,-1,11482,-1,
			11484,-1,11486,-1,11488,-1,11490,-1,-1,-1,
			-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,
			-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,
			-1,-1,-1,-1,-1>>
		ensure
			result_not_void: Result /= Void
		end

	title_code_plane_0_segment_45: ARRAY [INTEGER] is
			-- Generated array segment
		once
			Result := <<
			INTEGER_.to_integer (4256),
			4257,4258,4259,4260,4261,4262,4263,4264,4265,4266,
			4267,4268,4269,4270,4271,4272,4273,4274,4275,4276,
			4277,4278,4279,4280,4281,4282,4283,4284,4285,4286,
			4287,4288,4289,4290,4291,4292,4293,-1,-1,-1,
			-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,
			-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,
			-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,
			-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,
			-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,
			-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,
			-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,
			-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,
			-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,
			-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,
			-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,
			-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,
			-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,
			-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,
			-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,
			-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,
			-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,
			-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,
			-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,
			-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,
			-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,
			-1,-1,-1,-1,-1>>
		ensure
			result_not_void: Result /= Void
		end

	title_code_plane_0_segment_255: ARRAY [INTEGER] is
			-- Generated array segment
		once
			Result := <<
			INTEGER_.to_integer (-1),
			-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,
			-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,
			-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,
			-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,
			-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,
			-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,
			-1,-1,-1,-1,65313,65314,65315,65316,65317,65318,
			65319,65320,65321,65322,65323,65324,65325,65326,65327,65328,
			65329,65330,65331,65332,65333,65334,65335,65336,65337,65338,
			-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,
			-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,
			-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,
			-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,
			-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,
			-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,
			-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,
			-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,
			-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,
			-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,
			-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,
			-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,
			-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,
			-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,
			-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,
			-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,
			-1,-1,-1,-1,-1>>
		ensure
			result_not_void: Result /= Void
		end

	title_code_plane_0: SPECIAL [ARRAY [INTEGER]] is
			-- Generated array plane
		once
			create Result.make (256)
			Result.put (title_code_plane_0_segment_0, 0)
			Result.put (title_code_plane_0_segment_1, 1)
			Result.put (title_code_plane_0_segment_2, 2)
			Result.put (title_code_plane_0_segment_3, 3)
			Result.put (title_code_plane_0_segment_4, 4)
			Result.put (title_code_plane_0_segment_5, 5)
			Result.put (empty_title_code_segment, 6)
			Result.put (empty_title_code_segment, 7)
			Result.put (empty_title_code_segment, 8)
			Result.put (empty_title_code_segment, 9)
			Result.put (empty_title_code_segment, 10)
			Result.put (empty_title_code_segment, 11)
			Result.put (empty_title_code_segment, 12)
			Result.put (empty_title_code_segment, 13)
			Result.put (empty_title_code_segment, 14)
			Result.put (empty_title_code_segment, 15)
			Result.put (empty_title_code_segment, 16)
			Result.put (empty_title_code_segment, 17)
			Result.put (empty_title_code_segment, 18)
			Result.put (empty_title_code_segment, 19)
			Result.put (empty_title_code_segment, 20)
			Result.put (empty_title_code_segment, 21)
			Result.put (empty_title_code_segment, 22)
			Result.put (empty_title_code_segment, 23)
			Result.put (empty_title_code_segment, 24)
			Result.put (empty_title_code_segment, 25)
			Result.put (empty_title_code_segment, 26)
			Result.put (empty_title_code_segment, 27)
			Result.put (empty_title_code_segment, 28)
			Result.put (title_code_plane_0_segment_29, 29)
			Result.put (title_code_plane_0_segment_30, 30)
			Result.put (title_code_plane_0_segment_31, 31)
			Result.put (empty_title_code_segment, 32)
			Result.put (title_code_plane_0_segment_33, 33)
			Result.put (empty_title_code_segment, 34)
			Result.put (empty_title_code_segment, 35)
			Result.put (title_code_plane_0_segment_36, 36)
			Result.put (empty_title_code_segment, 37)
			Result.put (empty_title_code_segment, 38)
			Result.put (empty_title_code_segment, 39)
			Result.put (empty_title_code_segment, 40)
			Result.put (empty_title_code_segment, 41)
			Result.put (empty_title_code_segment, 42)
			Result.put (empty_title_code_segment, 43)
			Result.put (title_code_plane_0_segment_44, 44)
			Result.put (title_code_plane_0_segment_45, 45)
			Result.put (empty_title_code_segment, 46)
			Result.put (empty_title_code_segment, 47)
			Result.put (empty_title_code_segment, 48)
			Result.put (empty_title_code_segment, 49)
			Result.put (empty_title_code_segment, 50)
			Result.put (empty_title_code_segment, 51)
			Result.put (empty_title_code_segment, 52)
			Result.put (empty_title_code_segment, 53)
			Result.put (empty_title_code_segment, 54)
			Result.put (empty_title_code_segment, 55)
			Result.put (empty_title_code_segment, 56)
			Result.put (empty_title_code_segment, 57)
			Result.put (empty_title_code_segment, 58)
			Result.put (empty_title_code_segment, 59)
			Result.put (empty_title_code_segment, 60)
			Result.put (empty_title_code_segment, 61)
			Result.put (empty_title_code_segment, 62)
			Result.put (empty_title_code_segment, 63)
			Result.put (empty_title_code_segment, 64)
			Result.put (empty_title_code_segment, 65)
			Result.put (empty_title_code_segment, 66)
			Result.put (empty_title_code_segment, 67)
			Result.put (empty_title_code_segment, 68)
			Result.put (empty_title_code_segment, 69)
			Result.put (empty_title_code_segment, 70)
			Result.put (empty_title_code_segment, 71)
			Result.put (empty_title_code_segment, 72)
			Result.put (empty_title_code_segment, 73)
			Result.put (empty_title_code_segment, 74)
			Result.put (empty_title_code_segment, 75)
			Result.put (empty_title_code_segment, 76)
			Result.put (empty_title_code_segment, 77)
			Result.put (empty_title_code_segment, 78)
			Result.put (empty_title_code_segment, 79)
			Result.put (empty_title_code_segment, 80)
			Result.put (empty_title_code_segment, 81)
			Result.put (empty_title_code_segment, 82)
			Result.put (empty_title_code_segment, 83)
			Result.put (empty_title_code_segment, 84)
			Result.put (empty_title_code_segment, 85)
			Result.put (empty_title_code_segment, 86)
			Result.put (empty_title_code_segment, 87)
			Result.put (empty_title_code_segment, 88)
			Result.put (empty_title_code_segment, 89)
			Result.put (empty_title_code_segment, 90)
			Result.put (empty_title_code_segment, 91)
			Result.put (empty_title_code_segment, 92)
			Result.put (empty_title_code_segment, 93)
			Result.put (empty_title_code_segment, 94)
			Result.put (empty_title_code_segment, 95)
			Result.put (empty_title_code_segment, 96)
			Result.put (empty_title_code_segment, 97)
			Result.put (empty_title_code_segment, 98)
			Result.put (empty_title_code_segment, 99)
			Result.put (empty_title_code_segment, 100)
			Result.put (empty_title_code_segment, 101)
			Result.put (empty_title_code_segment, 102)
			Result.put (empty_title_code_segment, 103)
			Result.put (empty_title_code_segment, 104)
			Result.put (empty_title_code_segment, 105)
			Result.put (empty_title_code_segment, 106)
			Result.put (empty_title_code_segment, 107)
			Result.put (empty_title_code_segment, 108)
			Result.put (empty_title_code_segment, 109)
			Result.put (empty_title_code_segment, 110)
			Result.put (empty_title_code_segment, 111)
			Result.put (empty_title_code_segment, 112)
			Result.put (empty_title_code_segment, 113)
			Result.put (empty_title_code_segment, 114)
			Result.put (empty_title_code_segment, 115)
			Result.put (empty_title_code_segment, 116)
			Result.put (empty_title_code_segment, 117)
			Result.put (empty_title_code_segment, 118)
			Result.put (empty_title_code_segment, 119)
			Result.put (empty_title_code_segment, 120)
			Result.put (empty_title_code_segment, 121)
			Result.put (empty_title_code_segment, 122)
			Result.put (empty_title_code_segment, 123)
			Result.put (empty_title_code_segment, 124)
			Result.put (empty_title_code_segment, 125)
			Result.put (empty_title_code_segment, 126)
			Result.put (empty_title_code_segment, 127)
			Result.put (empty_title_code_segment, 128)
			Result.put (empty_title_code_segment, 129)
			Result.put (empty_title_code_segment, 130)
			Result.put (empty_title_code_segment, 131)
			Result.put (empty_title_code_segment, 132)
			Result.put (empty_title_code_segment, 133)
			Result.put (empty_title_code_segment, 134)
			Result.put (empty_title_code_segment, 135)
			Result.put (empty_title_code_segment, 136)
			Result.put (empty_title_code_segment, 137)
			Result.put (empty_title_code_segment, 138)
			Result.put (empty_title_code_segment, 139)
			Result.put (empty_title_code_segment, 140)
			Result.put (empty_title_code_segment, 141)
			Result.put (empty_title_code_segment, 142)
			Result.put (empty_title_code_segment, 143)
			Result.put (empty_title_code_segment, 144)
			Result.put (empty_title_code_segment, 145)
			Result.put (empty_title_code_segment, 146)
			Result.put (empty_title_code_segment, 147)
			Result.put (empty_title_code_segment, 148)
			Result.put (empty_title_code_segment, 149)
			Result.put (empty_title_code_segment, 150)
			Result.put (empty_title_code_segment, 151)
			Result.put (empty_title_code_segment, 152)
			Result.put (empty_title_code_segment, 153)
			Result.put (empty_title_code_segment, 154)
			Result.put (empty_title_code_segment, 155)
			Result.put (empty_title_code_segment, 156)
			Result.put (empty_title_code_segment, 157)
			Result.put (empty_title_code_segment, 158)
			Result.put (empty_title_code_segment, 159)
			Result.put (empty_title_code_segment, 160)
			Result.put (empty_title_code_segment, 161)
			Result.put (empty_title_code_segment, 162)
			Result.put (empty_title_code_segment, 163)
			Result.put (empty_title_code_segment, 164)
			Result.put (empty_title_code_segment, 165)
			Result.put (empty_title_code_segment, 166)
			Result.put (empty_title_code_segment, 167)
			Result.put (empty_title_code_segment, 168)
			Result.put (empty_title_code_segment, 169)
			Result.put (empty_title_code_segment, 170)
			Result.put (empty_title_code_segment, 171)
			Result.put (empty_title_code_segment, 172)
			Result.put (empty_title_code_segment, 173)
			Result.put (empty_title_code_segment, 174)
			Result.put (empty_title_code_segment, 175)
			Result.put (empty_title_code_segment, 176)
			Result.put (empty_title_code_segment, 177)
			Result.put (empty_title_code_segment, 178)
			Result.put (empty_title_code_segment, 179)
			Result.put (empty_title_code_segment, 180)
			Result.put (empty_title_code_segment, 181)
			Result.put (empty_title_code_segment, 182)
			Result.put (empty_title_code_segment, 183)
			Result.put (empty_title_code_segment, 184)
			Result.put (empty_title_code_segment, 185)
			Result.put (empty_title_code_segment, 186)
			Result.put (empty_title_code_segment, 187)
			Result.put (empty_title_code_segment, 188)
			Result.put (empty_title_code_segment, 189)
			Result.put (empty_title_code_segment, 190)
			Result.put (empty_title_code_segment, 191)
			Result.put (empty_title_code_segment, 192)
			Result.put (empty_title_code_segment, 193)
			Result.put (empty_title_code_segment, 194)
			Result.put (empty_title_code_segment, 195)
			Result.put (empty_title_code_segment, 196)
			Result.put (empty_title_code_segment, 197)
			Result.put (empty_title_code_segment, 198)
			Result.put (empty_title_code_segment, 199)
			Result.put (empty_title_code_segment, 200)
			Result.put (empty_title_code_segment, 201)
			Result.put (empty_title_code_segment, 202)
			Result.put (empty_title_code_segment, 203)
			Result.put (empty_title_code_segment, 204)
			Result.put (empty_title_code_segment, 205)
			Result.put (empty_title_code_segment, 206)
			Result.put (empty_title_code_segment, 207)
			Result.put (empty_title_code_segment, 208)
			Result.put (empty_title_code_segment, 209)
			Result.put (empty_title_code_segment, 210)
			Result.put (empty_title_code_segment, 211)
			Result.put (empty_title_code_segment, 212)
			Result.put (empty_title_code_segment, 213)
			Result.put (empty_title_code_segment, 214)
			Result.put (empty_title_code_segment, 215)
			Result.put (empty_title_code_segment, 216)
			Result.put (empty_title_code_segment, 217)
			Result.put (empty_title_code_segment, 218)
			Result.put (empty_title_code_segment, 219)
			Result.put (empty_title_code_segment, 220)
			Result.put (empty_title_code_segment, 221)
			Result.put (empty_title_code_segment, 222)
			Result.put (empty_title_code_segment, 223)
			Result.put (empty_title_code_segment, 224)
			Result.put (empty_title_code_segment, 225)
			Result.put (empty_title_code_segment, 226)
			Result.put (empty_title_code_segment, 227)
			Result.put (empty_title_code_segment, 228)
			Result.put (empty_title_code_segment, 229)
			Result.put (empty_title_code_segment, 230)
			Result.put (empty_title_code_segment, 231)
			Result.put (empty_title_code_segment, 232)
			Result.put (empty_title_code_segment, 233)
			Result.put (empty_title_code_segment, 234)
			Result.put (empty_title_code_segment, 235)
			Result.put (empty_title_code_segment, 236)
			Result.put (empty_title_code_segment, 237)
			Result.put (empty_title_code_segment, 238)
			Result.put (empty_title_code_segment, 239)
			Result.put (empty_title_code_segment, 240)
			Result.put (empty_title_code_segment, 241)
			Result.put (empty_title_code_segment, 242)
			Result.put (empty_title_code_segment, 243)
			Result.put (empty_title_code_segment, 244)
			Result.put (empty_title_code_segment, 245)
			Result.put (empty_title_code_segment, 246)
			Result.put (empty_title_code_segment, 247)
			Result.put (empty_title_code_segment, 248)
			Result.put (empty_title_code_segment, 249)
			Result.put (empty_title_code_segment, 250)
			Result.put (empty_title_code_segment, 251)
			Result.put (empty_title_code_segment, 252)
			Result.put (empty_title_code_segment, 253)
			Result.put (empty_title_code_segment, 254)
			Result.put (title_code_plane_0_segment_255, 255)
		ensure
			result_not_void: Result /= Void
			sub_arrays_not_void: True --not Result.has (Void)
		end

	title_code_plane_1_segment_4: ARRAY [INTEGER] is
			-- Generated array segment
		once
			Result := <<
			INTEGER_.to_integer (-1),
			-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,
			-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,
			-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,
			-1,-1,-1,-1,-1,-1,-1,-1,-1,66560,
			66561,66562,66563,66564,66565,66566,66567,66568,66569,66570,
			66571,66572,66573,66574,66575,66576,66577,66578,66579,66580,
			66581,66582,66583,66584,66585,66586,66587,66588,66589,66590,
			66591,66592,66593,66594,66595,66596,66597,66598,66599,-1,
			-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,
			-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,
			-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,
			-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,
			-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,
			-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,
			-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,
			-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,
			-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,
			-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,
			-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,
			-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,
			-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,
			-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,
			-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,
			-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,
			-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,
			-1,-1,-1,-1,-1>>
		ensure
			result_not_void: Result /= Void
		end

	title_code_plane_1: SPECIAL [ARRAY [INTEGER]] is
			-- Generated array plane
		once
			create Result.make (256)
			Result.put (empty_title_code_segment, 0)
			Result.put (empty_title_code_segment, 1)
			Result.put (empty_title_code_segment, 2)
			Result.put (empty_title_code_segment, 3)
			Result.put (title_code_plane_1_segment_4, 4)
			Result.put (empty_title_code_segment, 5)
			Result.put (empty_title_code_segment, 6)
			Result.put (empty_title_code_segment, 7)
			Result.put (empty_title_code_segment, 8)
			Result.put (empty_title_code_segment, 9)
			Result.put (empty_title_code_segment, 10)
			Result.put (empty_title_code_segment, 11)
			Result.put (empty_title_code_segment, 12)
			Result.put (empty_title_code_segment, 13)
			Result.put (empty_title_code_segment, 14)
			Result.put (empty_title_code_segment, 15)
			Result.put (empty_title_code_segment, 16)
			Result.put (empty_title_code_segment, 17)
			Result.put (empty_title_code_segment, 18)
			Result.put (empty_title_code_segment, 19)
			Result.put (empty_title_code_segment, 20)
			Result.put (empty_title_code_segment, 21)
			Result.put (empty_title_code_segment, 22)
			Result.put (empty_title_code_segment, 23)
			Result.put (empty_title_code_segment, 24)
			Result.put (empty_title_code_segment, 25)
			Result.put (empty_title_code_segment, 26)
			Result.put (empty_title_code_segment, 27)
			Result.put (empty_title_code_segment, 28)
			Result.put (empty_title_code_segment, 29)
			Result.put (empty_title_code_segment, 30)
			Result.put (empty_title_code_segment, 31)
			Result.put (empty_title_code_segment, 32)
			Result.put (empty_title_code_segment, 33)
			Result.put (empty_title_code_segment, 34)
			Result.put (empty_title_code_segment, 35)
			Result.put (empty_title_code_segment, 36)
			Result.put (empty_title_code_segment, 37)
			Result.put (empty_title_code_segment, 38)
			Result.put (empty_title_code_segment, 39)
			Result.put (empty_title_code_segment, 40)
			Result.put (empty_title_code_segment, 41)
			Result.put (empty_title_code_segment, 42)
			Result.put (empty_title_code_segment, 43)
			Result.put (empty_title_code_segment, 44)
			Result.put (empty_title_code_segment, 45)
			Result.put (empty_title_code_segment, 46)
			Result.put (empty_title_code_segment, 47)
			Result.put (empty_title_code_segment, 48)
			Result.put (empty_title_code_segment, 49)
			Result.put (empty_title_code_segment, 50)
			Result.put (empty_title_code_segment, 51)
			Result.put (empty_title_code_segment, 52)
			Result.put (empty_title_code_segment, 53)
			Result.put (empty_title_code_segment, 54)
			Result.put (empty_title_code_segment, 55)
			Result.put (empty_title_code_segment, 56)
			Result.put (empty_title_code_segment, 57)
			Result.put (empty_title_code_segment, 58)
			Result.put (empty_title_code_segment, 59)
			Result.put (empty_title_code_segment, 60)
			Result.put (empty_title_code_segment, 61)
			Result.put (empty_title_code_segment, 62)
			Result.put (empty_title_code_segment, 63)
			Result.put (empty_title_code_segment, 64)
			Result.put (empty_title_code_segment, 65)
			Result.put (empty_title_code_segment, 66)
			Result.put (empty_title_code_segment, 67)
			Result.put (empty_title_code_segment, 68)
			Result.put (empty_title_code_segment, 69)
			Result.put (empty_title_code_segment, 70)
			Result.put (empty_title_code_segment, 71)
			Result.put (empty_title_code_segment, 72)
			Result.put (empty_title_code_segment, 73)
			Result.put (empty_title_code_segment, 74)
			Result.put (empty_title_code_segment, 75)
			Result.put (empty_title_code_segment, 76)
			Result.put (empty_title_code_segment, 77)
			Result.put (empty_title_code_segment, 78)
			Result.put (empty_title_code_segment, 79)
			Result.put (empty_title_code_segment, 80)
			Result.put (empty_title_code_segment, 81)
			Result.put (empty_title_code_segment, 82)
			Result.put (empty_title_code_segment, 83)
			Result.put (empty_title_code_segment, 84)
			Result.put (empty_title_code_segment, 85)
			Result.put (empty_title_code_segment, 86)
			Result.put (empty_title_code_segment, 87)
			Result.put (empty_title_code_segment, 88)
			Result.put (empty_title_code_segment, 89)
			Result.put (empty_title_code_segment, 90)
			Result.put (empty_title_code_segment, 91)
			Result.put (empty_title_code_segment, 92)
			Result.put (empty_title_code_segment, 93)
			Result.put (empty_title_code_segment, 94)
			Result.put (empty_title_code_segment, 95)
			Result.put (empty_title_code_segment, 96)
			Result.put (empty_title_code_segment, 97)
			Result.put (empty_title_code_segment, 98)
			Result.put (empty_title_code_segment, 99)
			Result.put (empty_title_code_segment, 100)
			Result.put (empty_title_code_segment, 101)
			Result.put (empty_title_code_segment, 102)
			Result.put (empty_title_code_segment, 103)
			Result.put (empty_title_code_segment, 104)
			Result.put (empty_title_code_segment, 105)
			Result.put (empty_title_code_segment, 106)
			Result.put (empty_title_code_segment, 107)
			Result.put (empty_title_code_segment, 108)
			Result.put (empty_title_code_segment, 109)
			Result.put (empty_title_code_segment, 110)
			Result.put (empty_title_code_segment, 111)
			Result.put (empty_title_code_segment, 112)
			Result.put (empty_title_code_segment, 113)
			Result.put (empty_title_code_segment, 114)
			Result.put (empty_title_code_segment, 115)
			Result.put (empty_title_code_segment, 116)
			Result.put (empty_title_code_segment, 117)
			Result.put (empty_title_code_segment, 118)
			Result.put (empty_title_code_segment, 119)
			Result.put (empty_title_code_segment, 120)
			Result.put (empty_title_code_segment, 121)
			Result.put (empty_title_code_segment, 122)
			Result.put (empty_title_code_segment, 123)
			Result.put (empty_title_code_segment, 124)
			Result.put (empty_title_code_segment, 125)
			Result.put (empty_title_code_segment, 126)
			Result.put (empty_title_code_segment, 127)
			Result.put (empty_title_code_segment, 128)
			Result.put (empty_title_code_segment, 129)
			Result.put (empty_title_code_segment, 130)
			Result.put (empty_title_code_segment, 131)
			Result.put (empty_title_code_segment, 132)
			Result.put (empty_title_code_segment, 133)
			Result.put (empty_title_code_segment, 134)
			Result.put (empty_title_code_segment, 135)
			Result.put (empty_title_code_segment, 136)
			Result.put (empty_title_code_segment, 137)
			Result.put (empty_title_code_segment, 138)
			Result.put (empty_title_code_segment, 139)
			Result.put (empty_title_code_segment, 140)
			Result.put (empty_title_code_segment, 141)
			Result.put (empty_title_code_segment, 142)
			Result.put (empty_title_code_segment, 143)
			Result.put (empty_title_code_segment, 144)
			Result.put (empty_title_code_segment, 145)
			Result.put (empty_title_code_segment, 146)
			Result.put (empty_title_code_segment, 147)
			Result.put (empty_title_code_segment, 148)
			Result.put (empty_title_code_segment, 149)
			Result.put (empty_title_code_segment, 150)
			Result.put (empty_title_code_segment, 151)
			Result.put (empty_title_code_segment, 152)
			Result.put (empty_title_code_segment, 153)
			Result.put (empty_title_code_segment, 154)
			Result.put (empty_title_code_segment, 155)
			Result.put (empty_title_code_segment, 156)
			Result.put (empty_title_code_segment, 157)
			Result.put (empty_title_code_segment, 158)
			Result.put (empty_title_code_segment, 159)
			Result.put (empty_title_code_segment, 160)
			Result.put (empty_title_code_segment, 161)
			Result.put (empty_title_code_segment, 162)
			Result.put (empty_title_code_segment, 163)
			Result.put (empty_title_code_segment, 164)
			Result.put (empty_title_code_segment, 165)
			Result.put (empty_title_code_segment, 166)
			Result.put (empty_title_code_segment, 167)
			Result.put (empty_title_code_segment, 168)
			Result.put (empty_title_code_segment, 169)
			Result.put (empty_title_code_segment, 170)
			Result.put (empty_title_code_segment, 171)
			Result.put (empty_title_code_segment, 172)
			Result.put (empty_title_code_segment, 173)
			Result.put (empty_title_code_segment, 174)
			Result.put (empty_title_code_segment, 175)
			Result.put (empty_title_code_segment, 176)
			Result.put (empty_title_code_segment, 177)
			Result.put (empty_title_code_segment, 178)
			Result.put (empty_title_code_segment, 179)
			Result.put (empty_title_code_segment, 180)
			Result.put (empty_title_code_segment, 181)
			Result.put (empty_title_code_segment, 182)
			Result.put (empty_title_code_segment, 183)
			Result.put (empty_title_code_segment, 184)
			Result.put (empty_title_code_segment, 185)
			Result.put (empty_title_code_segment, 186)
			Result.put (empty_title_code_segment, 187)
			Result.put (empty_title_code_segment, 188)
			Result.put (empty_title_code_segment, 189)
			Result.put (empty_title_code_segment, 190)
			Result.put (empty_title_code_segment, 191)
			Result.put (empty_title_code_segment, 192)
			Result.put (empty_title_code_segment, 193)
			Result.put (empty_title_code_segment, 194)
			Result.put (empty_title_code_segment, 195)
			Result.put (empty_title_code_segment, 196)
			Result.put (empty_title_code_segment, 197)
			Result.put (empty_title_code_segment, 198)
			Result.put (empty_title_code_segment, 199)
			Result.put (empty_title_code_segment, 200)
			Result.put (empty_title_code_segment, 201)
			Result.put (empty_title_code_segment, 202)
			Result.put (empty_title_code_segment, 203)
			Result.put (empty_title_code_segment, 204)
			Result.put (empty_title_code_segment, 205)
			Result.put (empty_title_code_segment, 206)
			Result.put (empty_title_code_segment, 207)
			Result.put (empty_title_code_segment, 208)
			Result.put (empty_title_code_segment, 209)
			Result.put (empty_title_code_segment, 210)
			Result.put (empty_title_code_segment, 211)
			Result.put (empty_title_code_segment, 212)
			Result.put (empty_title_code_segment, 213)
			Result.put (empty_title_code_segment, 214)
			Result.put (empty_title_code_segment, 215)
			Result.put (empty_title_code_segment, 216)
			Result.put (empty_title_code_segment, 217)
			Result.put (empty_title_code_segment, 218)
			Result.put (empty_title_code_segment, 219)
			Result.put (empty_title_code_segment, 220)
			Result.put (empty_title_code_segment, 221)
			Result.put (empty_title_code_segment, 222)
			Result.put (empty_title_code_segment, 223)
			Result.put (empty_title_code_segment, 224)
			Result.put (empty_title_code_segment, 225)
			Result.put (empty_title_code_segment, 226)
			Result.put (empty_title_code_segment, 227)
			Result.put (empty_title_code_segment, 228)
			Result.put (empty_title_code_segment, 229)
			Result.put (empty_title_code_segment, 230)
			Result.put (empty_title_code_segment, 231)
			Result.put (empty_title_code_segment, 232)
			Result.put (empty_title_code_segment, 233)
			Result.put (empty_title_code_segment, 234)
			Result.put (empty_title_code_segment, 235)
			Result.put (empty_title_code_segment, 236)
			Result.put (empty_title_code_segment, 237)
			Result.put (empty_title_code_segment, 238)
			Result.put (empty_title_code_segment, 239)
			Result.put (empty_title_code_segment, 240)
			Result.put (empty_title_code_segment, 241)
			Result.put (empty_title_code_segment, 242)
			Result.put (empty_title_code_segment, 243)
			Result.put (empty_title_code_segment, 244)
			Result.put (empty_title_code_segment, 245)
			Result.put (empty_title_code_segment, 246)
			Result.put (empty_title_code_segment, 247)
			Result.put (empty_title_code_segment, 248)
			Result.put (empty_title_code_segment, 249)
			Result.put (empty_title_code_segment, 250)
			Result.put (empty_title_code_segment, 251)
			Result.put (empty_title_code_segment, 252)
			Result.put (empty_title_code_segment, 253)
			Result.put (empty_title_code_segment, 254)
			Result.put (empty_title_code_segment, 255)
		ensure
			result_not_void: Result /= Void
			sub_arrays_not_void: True --not Result.has (Void)
		end

	empty_title_code_plane: SPECIAL [ARRAY [INTEGER]] is
			-- Generated array plane
		once
			create Result.make (256)
			Result.put (empty_title_code_segment, 0)
			Result.put (empty_title_code_segment, 1)
			Result.put (empty_title_code_segment, 2)
			Result.put (empty_title_code_segment, 3)
			Result.put (empty_title_code_segment, 4)
			Result.put (empty_title_code_segment, 5)
			Result.put (empty_title_code_segment, 6)
			Result.put (empty_title_code_segment, 7)
			Result.put (empty_title_code_segment, 8)
			Result.put (empty_title_code_segment, 9)
			Result.put (empty_title_code_segment, 10)
			Result.put (empty_title_code_segment, 11)
			Result.put (empty_title_code_segment, 12)
			Result.put (empty_title_code_segment, 13)
			Result.put (empty_title_code_segment, 14)
			Result.put (empty_title_code_segment, 15)
			Result.put (empty_title_code_segment, 16)
			Result.put (empty_title_code_segment, 17)
			Result.put (empty_title_code_segment, 18)
			Result.put (empty_title_code_segment, 19)
			Result.put (empty_title_code_segment, 20)
			Result.put (empty_title_code_segment, 21)
			Result.put (empty_title_code_segment, 22)
			Result.put (empty_title_code_segment, 23)
			Result.put (empty_title_code_segment, 24)
			Result.put (empty_title_code_segment, 25)
			Result.put (empty_title_code_segment, 26)
			Result.put (empty_title_code_segment, 27)
			Result.put (empty_title_code_segment, 28)
			Result.put (empty_title_code_segment, 29)
			Result.put (empty_title_code_segment, 30)
			Result.put (empty_title_code_segment, 31)
			Result.put (empty_title_code_segment, 32)
			Result.put (empty_title_code_segment, 33)
			Result.put (empty_title_code_segment, 34)
			Result.put (empty_title_code_segment, 35)
			Result.put (empty_title_code_segment, 36)
			Result.put (empty_title_code_segment, 37)
			Result.put (empty_title_code_segment, 38)
			Result.put (empty_title_code_segment, 39)
			Result.put (empty_title_code_segment, 40)
			Result.put (empty_title_code_segment, 41)
			Result.put (empty_title_code_segment, 42)
			Result.put (empty_title_code_segment, 43)
			Result.put (empty_title_code_segment, 44)
			Result.put (empty_title_code_segment, 45)
			Result.put (empty_title_code_segment, 46)
			Result.put (empty_title_code_segment, 47)
			Result.put (empty_title_code_segment, 48)
			Result.put (empty_title_code_segment, 49)
			Result.put (empty_title_code_segment, 50)
			Result.put (empty_title_code_segment, 51)
			Result.put (empty_title_code_segment, 52)
			Result.put (empty_title_code_segment, 53)
			Result.put (empty_title_code_segment, 54)
			Result.put (empty_title_code_segment, 55)
			Result.put (empty_title_code_segment, 56)
			Result.put (empty_title_code_segment, 57)
			Result.put (empty_title_code_segment, 58)
			Result.put (empty_title_code_segment, 59)
			Result.put (empty_title_code_segment, 60)
			Result.put (empty_title_code_segment, 61)
			Result.put (empty_title_code_segment, 62)
			Result.put (empty_title_code_segment, 63)
			Result.put (empty_title_code_segment, 64)
			Result.put (empty_title_code_segment, 65)
			Result.put (empty_title_code_segment, 66)
			Result.put (empty_title_code_segment, 67)
			Result.put (empty_title_code_segment, 68)
			Result.put (empty_title_code_segment, 69)
			Result.put (empty_title_code_segment, 70)
			Result.put (empty_title_code_segment, 71)
			Result.put (empty_title_code_segment, 72)
			Result.put (empty_title_code_segment, 73)
			Result.put (empty_title_code_segment, 74)
			Result.put (empty_title_code_segment, 75)
			Result.put (empty_title_code_segment, 76)
			Result.put (empty_title_code_segment, 77)
			Result.put (empty_title_code_segment, 78)
			Result.put (empty_title_code_segment, 79)
			Result.put (empty_title_code_segment, 80)
			Result.put (empty_title_code_segment, 81)
			Result.put (empty_title_code_segment, 82)
			Result.put (empty_title_code_segment, 83)
			Result.put (empty_title_code_segment, 84)
			Result.put (empty_title_code_segment, 85)
			Result.put (empty_title_code_segment, 86)
			Result.put (empty_title_code_segment, 87)
			Result.put (empty_title_code_segment, 88)
			Result.put (empty_title_code_segment, 89)
			Result.put (empty_title_code_segment, 90)
			Result.put (empty_title_code_segment, 91)
			Result.put (empty_title_code_segment, 92)
			Result.put (empty_title_code_segment, 93)
			Result.put (empty_title_code_segment, 94)
			Result.put (empty_title_code_segment, 95)
			Result.put (empty_title_code_segment, 96)
			Result.put (empty_title_code_segment, 97)
			Result.put (empty_title_code_segment, 98)
			Result.put (empty_title_code_segment, 99)
			Result.put (empty_title_code_segment, 100)
			Result.put (empty_title_code_segment, 101)
			Result.put (empty_title_code_segment, 102)
			Result.put (empty_title_code_segment, 103)
			Result.put (empty_title_code_segment, 104)
			Result.put (empty_title_code_segment, 105)
			Result.put (empty_title_code_segment, 106)
			Result.put (empty_title_code_segment, 107)
			Result.put (empty_title_code_segment, 108)
			Result.put (empty_title_code_segment, 109)
			Result.put (empty_title_code_segment, 110)
			Result.put (empty_title_code_segment, 111)
			Result.put (empty_title_code_segment, 112)
			Result.put (empty_title_code_segment, 113)
			Result.put (empty_title_code_segment, 114)
			Result.put (empty_title_code_segment, 115)
			Result.put (empty_title_code_segment, 116)
			Result.put (empty_title_code_segment, 117)
			Result.put (empty_title_code_segment, 118)
			Result.put (empty_title_code_segment, 119)
			Result.put (empty_title_code_segment, 120)
			Result.put (empty_title_code_segment, 121)
			Result.put (empty_title_code_segment, 122)
			Result.put (empty_title_code_segment, 123)
			Result.put (empty_title_code_segment, 124)
			Result.put (empty_title_code_segment, 125)
			Result.put (empty_title_code_segment, 126)
			Result.put (empty_title_code_segment, 127)
			Result.put (empty_title_code_segment, 128)
			Result.put (empty_title_code_segment, 129)
			Result.put (empty_title_code_segment, 130)
			Result.put (empty_title_code_segment, 131)
			Result.put (empty_title_code_segment, 132)
			Result.put (empty_title_code_segment, 133)
			Result.put (empty_title_code_segment, 134)
			Result.put (empty_title_code_segment, 135)
			Result.put (empty_title_code_segment, 136)
			Result.put (empty_title_code_segment, 137)
			Result.put (empty_title_code_segment, 138)
			Result.put (empty_title_code_segment, 139)
			Result.put (empty_title_code_segment, 140)
			Result.put (empty_title_code_segment, 141)
			Result.put (empty_title_code_segment, 142)
			Result.put (empty_title_code_segment, 143)
			Result.put (empty_title_code_segment, 144)
			Result.put (empty_title_code_segment, 145)
			Result.put (empty_title_code_segment, 146)
			Result.put (empty_title_code_segment, 147)
			Result.put (empty_title_code_segment, 148)
			Result.put (empty_title_code_segment, 149)
			Result.put (empty_title_code_segment, 150)
			Result.put (empty_title_code_segment, 151)
			Result.put (empty_title_code_segment, 152)
			Result.put (empty_title_code_segment, 153)
			Result.put (empty_title_code_segment, 154)
			Result.put (empty_title_code_segment, 155)
			Result.put (empty_title_code_segment, 156)
			Result.put (empty_title_code_segment, 157)
			Result.put (empty_title_code_segment, 158)
			Result.put (empty_title_code_segment, 159)
			Result.put (empty_title_code_segment, 160)
			Result.put (empty_title_code_segment, 161)
			Result.put (empty_title_code_segment, 162)
			Result.put (empty_title_code_segment, 163)
			Result.put (empty_title_code_segment, 164)
			Result.put (empty_title_code_segment, 165)
			Result.put (empty_title_code_segment, 166)
			Result.put (empty_title_code_segment, 167)
			Result.put (empty_title_code_segment, 168)
			Result.put (empty_title_code_segment, 169)
			Result.put (empty_title_code_segment, 170)
			Result.put (empty_title_code_segment, 171)
			Result.put (empty_title_code_segment, 172)
			Result.put (empty_title_code_segment, 173)
			Result.put (empty_title_code_segment, 174)
			Result.put (empty_title_code_segment, 175)
			Result.put (empty_title_code_segment, 176)
			Result.put (empty_title_code_segment, 177)
			Result.put (empty_title_code_segment, 178)
			Result.put (empty_title_code_segment, 179)
			Result.put (empty_title_code_segment, 180)
			Result.put (empty_title_code_segment, 181)
			Result.put (empty_title_code_segment, 182)
			Result.put (empty_title_code_segment, 183)
			Result.put (empty_title_code_segment, 184)
			Result.put (empty_title_code_segment, 185)
			Result.put (empty_title_code_segment, 186)
			Result.put (empty_title_code_segment, 187)
			Result.put (empty_title_code_segment, 188)
			Result.put (empty_title_code_segment, 189)
			Result.put (empty_title_code_segment, 190)
			Result.put (empty_title_code_segment, 191)
			Result.put (empty_title_code_segment, 192)
			Result.put (empty_title_code_segment, 193)
			Result.put (empty_title_code_segment, 194)
			Result.put (empty_title_code_segment, 195)
			Result.put (empty_title_code_segment, 196)
			Result.put (empty_title_code_segment, 197)
			Result.put (empty_title_code_segment, 198)
			Result.put (empty_title_code_segment, 199)
			Result.put (empty_title_code_segment, 200)
			Result.put (empty_title_code_segment, 201)
			Result.put (empty_title_code_segment, 202)
			Result.put (empty_title_code_segment, 203)
			Result.put (empty_title_code_segment, 204)
			Result.put (empty_title_code_segment, 205)
			Result.put (empty_title_code_segment, 206)
			Result.put (empty_title_code_segment, 207)
			Result.put (empty_title_code_segment, 208)
			Result.put (empty_title_code_segment, 209)
			Result.put (empty_title_code_segment, 210)
			Result.put (empty_title_code_segment, 211)
			Result.put (empty_title_code_segment, 212)
			Result.put (empty_title_code_segment, 213)
			Result.put (empty_title_code_segment, 214)
			Result.put (empty_title_code_segment, 215)
			Result.put (empty_title_code_segment, 216)
			Result.put (empty_title_code_segment, 217)
			Result.put (empty_title_code_segment, 218)
			Result.put (empty_title_code_segment, 219)
			Result.put (empty_title_code_segment, 220)
			Result.put (empty_title_code_segment, 221)
			Result.put (empty_title_code_segment, 222)
			Result.put (empty_title_code_segment, 223)
			Result.put (empty_title_code_segment, 224)
			Result.put (empty_title_code_segment, 225)
			Result.put (empty_title_code_segment, 226)
			Result.put (empty_title_code_segment, 227)
			Result.put (empty_title_code_segment, 228)
			Result.put (empty_title_code_segment, 229)
			Result.put (empty_title_code_segment, 230)
			Result.put (empty_title_code_segment, 231)
			Result.put (empty_title_code_segment, 232)
			Result.put (empty_title_code_segment, 233)
			Result.put (empty_title_code_segment, 234)
			Result.put (empty_title_code_segment, 235)
			Result.put (empty_title_code_segment, 236)
			Result.put (empty_title_code_segment, 237)
			Result.put (empty_title_code_segment, 238)
			Result.put (empty_title_code_segment, 239)
			Result.put (empty_title_code_segment, 240)
			Result.put (empty_title_code_segment, 241)
			Result.put (empty_title_code_segment, 242)
			Result.put (empty_title_code_segment, 243)
			Result.put (empty_title_code_segment, 244)
			Result.put (empty_title_code_segment, 245)
			Result.put (empty_title_code_segment, 246)
			Result.put (empty_title_code_segment, 247)
			Result.put (empty_title_code_segment, 248)
			Result.put (empty_title_code_segment, 249)
			Result.put (empty_title_code_segment, 250)
			Result.put (empty_title_code_segment, 251)
			Result.put (empty_title_code_segment, 252)
			Result.put (empty_title_code_segment, 253)
			Result.put (empty_title_code_segment, 254)
			Result.put (empty_title_code_segment, 255)
		ensure
			result_not_void: Result /= Void
			sub_arrays_not_void: True --not Result.has (Void)
		end

	title_codes: SPECIAL [SPECIAL [ARRAY [INTEGER]]] is
			-- Title case code points for each code point
		once
			create Result.make (17)
			Result.put (title_code_plane_0, 0)
			Result.put (title_code_plane_1, 1)
			Result.put (empty_title_code_plane, 2)
			Result.put (empty_title_code_plane, 3)
			Result.put (empty_title_code_plane, 4)
			Result.put (empty_title_code_plane, 5)
			Result.put (empty_title_code_plane, 6)
			Result.put (empty_title_code_plane, 7)
			Result.put (empty_title_code_plane, 8)
			Result.put (empty_title_code_plane, 9)
			Result.put (empty_title_code_plane, 10)
			Result.put (empty_title_code_plane, 11)
			Result.put (empty_title_code_plane, 12)
			Result.put (empty_title_code_plane, 13)
			Result.put (empty_title_code_plane, 14)
			Result.put (empty_title_code_plane, 15)
			Result.put (empty_title_code_plane, 16)
		end

end
