indexing
	Generator: "Eiffel Emitter 2.7b2"
	external_name: "System.ComponentModel.Design.IRootDesigner"

deferred external class
	SYSTEM_COMPONENTMODEL_DESIGN_IROOTDESIGNER

inherit
	SYSTEM_IDISPOSABLE
	SYSTEM_COMPONENTMODEL_DESIGN_IDESIGNER

feature -- Access

	get_supported_technologies: ARRAY [SYSTEM_COMPONENTMODEL_DESIGN_VIEWTECHNOLOGY] is
		external
			"IL deferred signature (): System.ComponentModel.Design.ViewTechnology[] use System.ComponentModel.Design.IRootDesigner"
		alias
			"get_SupportedTechnologies"
		end

feature -- Basic Operations

	get_view (technology: SYSTEM_COMPONENTMODEL_DESIGN_VIEWTECHNOLOGY): ANY is
		external
			"IL deferred signature (System.ComponentModel.Design.ViewTechnology): System.Object use System.ComponentModel.Design.IRootDesigner"
		alias
			"GetView"
		end

end -- class SYSTEM_COMPONENTMODEL_DESIGN_IROOTDESIGNER
