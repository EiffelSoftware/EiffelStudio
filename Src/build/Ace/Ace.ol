system ebuild

root

	ebuild (root_cluster): "make"

cluster

	root_cluster: 	"/develop/EiffelBuild/3.0/Src/Main";

	kernel:			"$EIFFELBASE/kernel";
	support:		"$EIFFELBASE/support";
	access:			"$EIFFELBASE/structures/access";
	cursors:		"$EIFFELBASE/structures/cursors";
	dispenser:		"$EIFFELBASE/structures/dispenser";
	list:			"$EIFFELBASE/structures/list";
	sort:			"$EIFFELBASE/structures/sort";
	storage:		"$EIFFELBASE/structures/storage";
	traversing:		"$EIFFELBASE/structures/traversing";

	abs_kernel:		"$EV3/oui/kernel";
	abs_commands:	"$EV3/oui/commands";
	abs_widgets:	"$EV3/oui/widgets";
	tools:			"$EV3/tools";
	x:				"$EV3/implement/X";
	toolkit:		"$EV3/implement/toolkit";
	open_res:		"$EV3/implement/openlook/Resources";
	open_widgets:	"$EV3/implement/openlook/widgets";
	figures: 		"$EV3/figures";

	c1:				"$EIFFELBUILD/Catalog";
	c2:				"$EIFFELBUILD/Catalog/Commands";
	c3:				"$EIFFELBUILD/Utility";
	c4:				"$EIFFELBUILD/Constants";
	c5:				"$EIFFELBUILD/Icon";
	c6:				"$EIFFELBUILD/Structures";
	c7:				"$EIFFELBUILD/Windows";
	c8:				"$EIFFELBUILD/WindowMgr";

	c9:				"$EIFFELBUILD/Storage/Command";
	c10:			"$EIFFELBUILD/Storage/Context";
	c11:			"$EIFFELBUILD/Storage/Control";
	c12:			"$EIFFELBUILD/Storage/Function";
	c13:			"$EIFFELBUILD/Storage/Application";


	c14:			"$EIFFELBUILD/Generation";

	c15:			"$EIFFELBUILD/Transport";

	c16:			"$EIFFELBUILD/Context/Commands";
	c17:			"$EIFFELBUILD/Context/Editor";
	c18:			"$EIFFELBUILD/Context/Catalog";
	c20:			"$EIFFELBUILD/Context/Widgets";
	c21:			"$EIFFELBUILD/Context/NewWidgets";
	c22:			"$EIFFELBUILD/Context/Tree";


	c23:			"$EIFFELBUILD/Application/Control";
	c24:			"$EIFFELBUILD/Application/Commands";


	c25:			"$EIFFELBUILD/Event";


	c26:			"$EIFFELBUILD/Function/Commands";
	c27:			"$EIFFELBUILD/Function/Editor";
	c28:			"$EIFFELBUILD/Function/Functions";
	c29:			"$EIFFELBUILD/Function/Holes";
	c30:			"$EIFFELBUILD/Function/Stones";
	c31:			"$EIFFELBUILD/Function/IconBox";


	c32:			"$EIFFELBUILD/Command/Catalog";
	c33:			"$EIFFELBUILD/Command/Commands";
	c34:			"$EIFFELBUILD/Command/Editor";
	c35:			"$EIFFELBUILD/Command/Predef";
	c36:			"$EIFFELBUILD/Command/Stones";
	c37:			"$EIFFELBUILD/Command/Instance";

end
